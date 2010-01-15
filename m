From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] Add minimal support for DEVKIT8000
Date: Fri, 15 Jan 2010 12:52:11 +0200
Message-ID: <20100115105211.GQ19526@nokia.com>
References: <75653cbc7d7ba7c6cfc501db7c0373d3@djdvant.com>
 <20091112104032.GB32578@nokia.com>
 <4B4F3167.3080300@corscience.de>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22124 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab0AOKzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:55:35 -0500
Content-Disposition: inline
In-Reply-To: <4B4F3167.3080300@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Thomas Weber <weber@corscience.de>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Kim Botherway <kbotherway@djdvant.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Jan 14, 2010 at 03:59:51PM +0100, ext Thomas Weber wrote:
>I use Kims patches and I have done some work on it over the time and
>after the comments from Felipe, so I want to submit them one more time.

and you resent the same patch without my comments sorted out

>diff --git a/arch/arm/mach-omap2/board-omap3devkit8000.c
>b/arch/arm/mach-omap2/board-omap3devkit8000.c
>new file mode 100644
>index 0000000..5f85dc6
>--- /dev/null
>+++ b/arch/arm/mach-omap2/board-omap3devkit8000.c
>@@ -0,0 +1,616 @@
>+/*
>+ * linux/arch/arm/mach-omap2/board-omap3devkit8000.c
>+ *
>+ * Copyright (C) 2008 Texas Instruments

still this part wasn't addressed.

>+static struct platform_device omap3devkit8000_nand_device = {
>+    .name        = "omap2-nand",
>+    .id        = -1,
>+    .dev        = {
>+        .platform_data    = &omap3devkit8000_nand_data,
>+    },
>+    .num_resources    = 1,
>+    .resource    = &omap3devkit8000_nand_resource,

neither this...

>+static struct gpio_led gpio_leds[] = {
>+    {
>+        .name            = "led1",
>+        .default_trigger    = "heartbeat",
>+        .gpio            = 186,
>+        .active_low        = true,
>+    },
>+    {
>+        .name            = "led2",
>+        .default_trigger    = "mmc0",
>+        .gpio            = 163,
>+        .active_low        = true,
>+    },
>+    {
>+        .name            = "ledB",
>+        .default_trigger    = "none",
>+        .gpio            = 153,
>+        .active_low             = true,
>+    },
>+    {
>+        .name            = "led3",
>+        .default_trigger    = "none",
>+        .gpio            = 164,    /* gets replaced */

nor this.

>+static struct spi_board_info omap3devkit8000_spi_board_info[]
>__initdata = {
>+    {
>+        .modalias        = "ads7846",
>+        .bus_num        = 2,
>+        .chip_select        = 0,
>+        .max_speed_hz        = 1500000,
>+        .controller_data    = &ads7846_mcspi_config,
>+        .irq            = OMAP_GPIO_IRQ(OMAP3_DEVKIT_TS_GPIO),
>+        .platform_data        = &ads7846_config,
>+    }
>+};
>+
>+

nor this.

-- 
balbi
