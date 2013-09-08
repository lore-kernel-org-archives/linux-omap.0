From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/4] Add support for charging battery in Nokia RX-51
Date: Sun,  8 Sep 2013 10:50:35 +0200
Message-ID: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>
Cc: Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch series finally bringing support for charging battery on
Nokia N900 (RX-51) without any proprietary Nokia bits in userspace.

Pali Roh=C3=A1r (4):
  usb: musb: Call atomic_notifier_call_chain when status is changed
  power: isp1704_charger: Fix driver to work with changes introduced in
    v3.5
  power: isp1704_charger: Add callback function set_current
  RX-51: Add platform function and data for bq24150a charger

 arch/arm/mach-omap2/board-rx51-peripherals.c |   56 +++++++++++++-
 drivers/power/isp1704_charger.c              |  107 ++++++++++++++----=
--------
 drivers/usb/musb/omap2430.c                  |    3 +
 drivers/usb/phy/phy-twl4030-usb.c            |    2 +
 include/linux/power/isp1704_charger.h        |    1 +
 5 files changed, 117 insertions(+), 52 deletions(-)

--=20
1.7.10.4
