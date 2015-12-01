From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Two phy-twl4030-usb fixes for unloading the module
Date: Mon, 30 Nov 2015 21:39:52 -0800
Message-ID: <1448948394-32078-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are two fixes for rmmod and PM. These can be merged separately after
the review from the MUSB related changes.

Regards,

Tony


Tony Lindgren (2):
  phy: twl4030-usb: Relase usb phy on unload
  phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload

 drivers/phy/phy-twl4030-usb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.6.2
