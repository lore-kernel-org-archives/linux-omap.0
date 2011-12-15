From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] musb fixes and cleanups
Date: Fri, 16 Dec 2011 01:05:07 +0200
Message-ID: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a few cleanups and a possible fix. Nothing major.

Felipe Contreras (3):
  usb: musb: fix pm_runtime mismatches
  usb: musb: trivial cleanup
  usb: musb: remove a bit of indentation

 drivers/usb/musb/musb_gadget.c |    1 +
 drivers/usb/musb/omap2430.c    |   36 +++++++++++++++---------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

-- 
1.7.8.rc1.14.g248db
