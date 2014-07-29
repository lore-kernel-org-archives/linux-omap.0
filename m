From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: dma support for 8250-omap serial driver
Date: Tue, 29 Jul 2014 20:58:57 +0200
Message-ID: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

this series is on top of "[PATCH v4] 8250-core based serial driver for OMAP".
I will refresh it once I fixed the runtime-pm issue.
Patches 1-3 are independent of the series and just bug fixes. Patches 4+ are
RFC only for now. Its been tested on dra7, am33xx won't work as-is (even with
patch 5 providing dts nodes).

The complete series ontop of of v3.16-rc5 is also available at
	git://git.breakpoint.cc/bigeasy/linux.git uart_v5_dma

Sebastian

