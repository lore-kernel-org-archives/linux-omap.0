From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC] gpio controlled clock
Date: Fri, 1 Nov 2013 16:01:19 +0200
Message-ID: <cover.1383312867.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46159 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab3KAOBu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Nov 2013 10:01:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: mturquette@linaro.org, Jyri Sarha <jsarha@ti.com>

The patch implements a basic clock that can be enabled and disabled
trough a gpio output. There is such a clock at least on
Beaglebone-Black and I need such a clock to implement HDMI audio
support for the board. I just thought this simple driver could be
useful for wider audience.

Best regards,
Jyri

Jyri Sarha (1):
  clk: add gpio controlled clock

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  154 ++++++++++++++++++++
 include/linux/clk-provider.h                       |   25 ++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5

