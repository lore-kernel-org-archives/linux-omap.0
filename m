From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 0/3] OMAP pinmux driver
Date: Mon, 14 Nov 2011 18:10:06 +0530
Message-ID: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43180 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab1KNMk1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 07:40:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@stericsson.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Hi Linus, Tony,

This RFC series adds pinmux support for OMAP using
the pinctrl framework. Though it adds a pinmux-omap.c
driver file, it currently only supports OMAP4 and also
has very few function/pin-groups defined.

I have also retained the existing muxing done from
board files using the OMAP-mux framework since this
series does not handle configuring pull up/downs for
pins, and only looks at pin-muxing.

These are still early patches, but I wanted to get
some feedback on if I am heading in the right direction.
Hence sharing these in the current form.

regards,
Rajendra

Rajendra Nayak (3):
  pinctrl: add a driver for the OMAP pinmux
  ARM: omap4: Add omap4 pinmux devices for core and wkup
  ARM: omap4: Add pinmux map in SDP and PANDA board files

 arch/arm/mach-omap2/board-4430sdp.c    |   10 +
 arch/arm/mach-omap2/board-omap4panda.c |   11 +
 arch/arm/mach-omap2/devices.c          |   43 ++
 drivers/pinctrl/Kconfig                |    7 +
 drivers/pinctrl/Makefile               |    1 +
 drivers/pinctrl/pinmux-omap.c          |  735 ++++++++++++++++++++++++++++++++
 6 files changed, 807 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pinctrl/pinmux-omap.c

