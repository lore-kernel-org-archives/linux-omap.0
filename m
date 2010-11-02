From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/2] usb: generic Kconfig fixes
Date: Tue,  2 Nov 2010 02:14:11 +0200
Message-ID: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This gets rid of some warnings, makes defconfigs smarter by having more proper
dependencies, and general cleanups.

v3: comments by Roger Quadros, rebased to v2.6.37-rc1

Felipe Contreras (2):
  usb: trivial Kconfig cleanups
  drivers: cleanup Kconfig stuff

 drivers/mfd/Kconfig        |    2 +-
 drivers/regulator/Kconfig  |    1 +
 drivers/usb/core/Kconfig   |    3 ---
 drivers/usb/gadget/Kconfig |    7 +++----
 drivers/usb/musb/Kconfig   |   24 ++++++------------------
 drivers/usb/otg/Kconfig    |    2 ++
 6 files changed, 13 insertions(+), 26 deletions(-)

-- 
1.7.3.2.2.g0dc5c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
