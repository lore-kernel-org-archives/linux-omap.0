From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] omap: use smc91x_platdata to setup smc91x
Date: Tue, 8 Dec 2009 18:13:29 -0800
Message-ID: <20091209021329.GK24013@atomide.com>
References: <20091209004630.5944.40334.stgit@localhost>
 <20091209004958.5944.81769.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZJcv+A0YCCLh2VIg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59746 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbZLICN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 21:13:27 -0500
Content-Disposition: inline
In-Reply-To: <20091209004958.5944.81769.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091208 16:48]:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> Use smc91x_platdata to setup smc91x, so we can get rid of OMAP specific stuff
> in smc91x driver
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/board-fsample.c   |   10 ++++++++++
>  arch/arm/mach-omap1/board-h2.c        |   10 ++++++++++
>  arch/arm/mach-omap1/board-h3.c        |   10 ++++++++++
>  arch/arm/mach-omap1/board-innovator.c |   13 +++++++++++++
>  arch/arm/mach-omap1/board-osk.c       |   10 ++++++++++
>  arch/arm/mach-omap1/board-perseus2.c  |   10 ++++++++++
>  arch/arm/mach-omap1/board-voiceblue.c |   10 ++++++++++
>  arch/arm/mach-omap2/board-apollon.c   |   10 ++++++++++
>  arch/arm/mach-omap2/gpmc-smc91x.c     |    8 +++++---
>  arch/arm/plat-omap/debug-devices.c    |   10 ++++++++++
>  10 files changed, 98 insertions(+), 3 deletions(-)

Looks like this needs a minor change to build for innovator 1610.
Will merge in the following fix as otherwise the smc91x_platdata
is not defined for 1610.

Tony

--ZJcv+A0YCCLh2VIg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="smc91x-innovator1610.patch"

>From e23309bc7d76cc06d7df2659120410398f50b039 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 8 Dec 2009 18:11:12 -0800
Subject: [PATCH] Fix compile on Innovator 1610 for smc91x

Fix compile on Innovator 1610 for smc91x

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 91b3b8e..2133b00 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -143,6 +143,11 @@ static struct platform_device innovator_kp_device = {
 	.resource	= innovator_kp_resources,
 };
 
+static struct smc91x_platdata innovator_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
 
 #ifdef CONFIG_ARCH_OMAP15XX
 
@@ -160,12 +165,6 @@ static struct map_desc innovator1510_io_desc[] __initdata = {
 	}
 };
 
-static struct smc91x_platdata innovator_smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
 static struct resource innovator1510_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP1510_FPGA_ETHR_START,	/* Physical */

--ZJcv+A0YCCLh2VIg--
