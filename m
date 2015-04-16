From: NeilBrown <neil@brown.name>
Subject: [PATCH 0/6] Enhancements to twl4030 phy to support better charging.
Date: Thu, 16 Apr 2015 18:03:04 +1000
Message-ID: <20150416075945.23307.24424.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41521 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882AbbDPIEq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 04:04:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hi Kishon,
 this is a slightly modified version of the series I sent earlier.

 I've removed that patches which use the old 'notifier chain' and will
 solve the issue of communicating current available separately.

 I've added a couple of patches which fix some pm_runtime issues.

 In particular:
     phy: twl4030-usb: remove incorrect pm_runtime_get_sync() in probe function.

 Fixes a bug which causes the usb phy to remain permanently powered
 on, hence the Cc to Tony.

 If these could be queued for some future merge window, I would really
 appreciate it.

Thanks,
NeilBrown


---

NeilBrown (6):
      phy: twl4030-usb: make runtime pm more reliable.
      phy: twl4030-usb: remove pointless 'suspended' test in 'suspend' callback.
      phy: twl4030-usb: remove incorrect pm_runtime_get_sync() in probe function.
      phy: twl4030-usb: add ABI documentation
      phy: twl4030-usb: add support for reading resistor on ID pin.
      phy: twl4030-usb: add extcon to report cable connections.


 .../ABI/testing/sysfs-platform-twl4030-usb         |   30 ++++
 drivers/phy/phy-twl4030-usb.c                      |  164 ++++++++++++++++++--
 2 files changed, 180 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-twl4030-usb

--
Signature

