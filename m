From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
Date: Fri, 8 Feb 2013 16:56:19 -0600
Message-ID: <51158293.8010101@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-2-git-send-email-jon-hunter@ti.com> <20130201220804.GZ22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42544 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab3BHW4X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 17:56:23 -0500
In-Reply-To: <20130201220804.GZ22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/01/2013 04:08 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
>> If the GPMC probe fails, devices that use the GPMC (such as ethernet
>> chips, flash memories, etc) can still allocate a GPMC chip-select and
>> register the device. On the OMAP2420 H4 board, this was causing the
>> kernel to crash after the gpmc probe failed and the board attempted
>> to start networking. Prevent this by marking all the chip-selects as
>> reserved by default and only make them available for devices to request
>> if the GPMC probe succeeds.
> 
> Thanks applying into omap-for-v3.9/gpmc.

Hi Tony, this one appears to be merged incorrectly. The unreserve ended 
up in the gpmc_calc_timings() function. Here is a patch to fix.

Cheers
Jon

>From ebc0613fb5a70f36fcb119cbe58724f9b442903a Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Fri, 8 Feb 2013 16:48:25 -0600
Subject: [PATCH] ARM: OMAP2+: Fix-up gpmc merge error

Commit "ARM: OMAP2+: Prevent potential crash if GPMC probe fails" added
code to ensure that GPMC chip-selects could not be requested until the
device probe was successful. The chip-selects should have been
unreserved at the end of the probe function, but the code to unreserve
them appears to have ended up in the gpmc_calc_timings() function and
hence, this is causing problems requesting chip-selects. Fix this merge
error by unreserving the chip-selects at the end of the probe, but
before we call the gpmc child probe functions (for device-tree) which
request a chip-select.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1adb2d4..1e8bcb4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1125,9 +1125,6 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 	/* TODO: remove, see function definition */
 	gpmc_convert_ps_to_ns(gpmc_t);
 
-	/* Now the GPMC is initialised, unreserve the chip-selects */
-	gpmc_cs_map = 0;
-
 	return 0;
 }
 
@@ -1388,6 +1385,9 @@ static int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
+	/* Now the GPMC is initialised, unreserve the chip-selects */
+	gpmc_cs_map = 0;
+
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
 		clk_disable_unprepare(gpmc_l3_clk);
-- 
1.7.10.4

