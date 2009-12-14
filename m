From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Mon, 14 Dec 2009 12:30:50 +0200
Message-ID: <1260786654-13294-1-git-send-email-felipe.balbi@nokia.com>
References: <20091212183410.GF3092@sirena.org.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752528AbZLNKcG@vger.kernel.org>
In-Reply-To: <20091212183410.GF3092@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, David Brownell <david-b@pacbell.net>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

move twl4030 children to threaded irq.

Felipe Balbi (4):
  input: keyboard: twl4030: move to request_threaded_irq
  input: misc: twl4030: move to request_threaded_irq
  rtc: twl4030: move to request_threaded_irq
  usb: otg: twl4030: move to request_threaded_irq

 drivers/input/keyboard/twl4030_keypad.c |   11 ++---------
 drivers/input/misc/twl4030-pwrbutton.c  |   12 +-----------
 drivers/rtc/rtc-twl4030.c               |   10 +---------
 drivers/usb/otg/twl4030-usb.c           |   10 +---------
 4 files changed, 5 insertions(+), 38 deletions(-)
