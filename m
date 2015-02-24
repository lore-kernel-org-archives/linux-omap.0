From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/4] Enhancements to twl4030 phy to support better charging.
Date: Tue, 24 Feb 2015 14:40:36 +1100
Message-ID: <20150224033730.31400.78200.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,
 the following 4 patches make some improvements to the twl4030
 phy.  Together with some other patches I have for twl4030_charger,
 they allow for better automatic control of charging.

 In particular, the status of the ID pin is assessed and the
 result in communicated to the charger drivers.
 There is also support for conveying the max current negotiated by a
 host to the charger.

Comments most welcome.

thanks,
NeilBrown


---

NeilBrown (4):
      usb: phy: twl4030: make runtime pm more reliable.
      usb: phy: twl4030: allow charger to see usb current draw limits.
      usb: phy: twl4030: add support for reading restore on ID pin.
      usb: phy: twl4030: test ID resistance to see if charger is present.


 drivers/phy/phy-twl4030-usb.c |  138 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 13 deletions(-)

--
Signature
