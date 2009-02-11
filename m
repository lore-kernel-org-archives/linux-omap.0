From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/2] TWL: USB: Start using twl4030/5030 regulator driver
Date: Wed, 11 Feb 2009 09:06:40 +0200
Message-ID: <1234336002-26372-1-git-send-email-kalle.jokiniemi@digia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from harmaja.edelkey.net ([213.138.147.141]:51304 "EHLO
	harmaja.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbZBKHHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 02:07:14 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net
Cc: lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, jouni.hogander@nokia.com, broonie@sirena.org.uk

These couple of patches enable dynamic swithcing of the
regulators used by twl4030 usb tranceiver.

This set replaces the single patch "USB: disable twl4030
USB regulators when cable unplugged" sent previously.
The change to previous version is that possible errors
in regulator_get are now handled and the twl4030 usb
driver requires TWL_REGULATOR support to be compiled.

Thanks to Aaro Koskinen for reporing these problems. 
Original patch by Kalle Jokiniemi, fixes by Jouni
Hogander.

Jouni Hogander (2):
      TWL: USB: disable VUSB regulators when cable unplugged
      USB: OTG: Twl4030 depends on REGULATOR_TWL4030

 drivers/usb/otg/Kconfig       |    2 +-
 drivers/usb/otg/twl4030-usb.c |   45 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 7 deletions(-)



