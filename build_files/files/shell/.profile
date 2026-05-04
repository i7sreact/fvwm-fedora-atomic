#
# .profile - Bourne Shell startup script for login shells
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$HOME/.local/bin:$HOME/.bin;
export PATH

EDITOR=vim; export EDITOR
# PAGER=less;  	export PAGER

# set ENV to a file invoked each time sh is started for interactive use.
ENV=$HOME/.bashrc; export ENV

GTK_CONFIG=$HOME/.gtkrc-2.0
FREETYPE_PROPERTIES="truetype:interpreter-version=35"
QT_QPA_PLATFORMTHEME=gtk2
GTK_OVERLAY_SCROLLING=0
GTK_BACKDROP=1
GTKM_INSERT_EMOJI=1
GTK_USE_IEC_UNITS=1
GTK_FOCUS_VISIBLE=1
GTK_PROGRESS_TEXT_INSIDE=1
GTK_TREEVIEW_LINES=0
GTK_ENLARGE_SCROLLBAR=1
SAL_USE_VCLPLUGIN=qt5
