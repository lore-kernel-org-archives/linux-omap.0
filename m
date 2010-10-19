From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] usb: generic Kconfig fixes
Date: Tue, 19 Oct 2010 13:03:25 +0300
Message-ID: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

This gets rid of some warnings, makes defconfigs smarter by having more proper
dependencies, and general cleanups.

BTW, this is the reason USB_GADGET_MUSB_HDRC sometimes is not selected:
http://article.gmane.org/gmane.linux.kbuild.devel/5480

v2: comments by Felipe Balbi

Felipe Contreras (3):
  usb: fix Kconfig warning
  usb: trivial Kconfig cleanups
  drivers: cleanup Kconfig stuff

 drivers/mfd/Kconfig        |    3 ++-
 drivers/regulator/Kconfig  |    1 +
 drivers/usb/core/Kconfig   |    3 ---
 drivers/usb/gadget/Kconfig |   16 ++--------------
 drivers/usb/musb/Kconfig   |   23 ++++++-----------------
 drivers/usb/otg/Kconfig    |    2 ++
 6 files changed, 13 insertions(+), 35 deletions(-)

-- 
1.7.3.1.2.g7fe2b
