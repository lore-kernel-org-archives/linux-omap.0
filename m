From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 4/7] OMAP2/3: GPMC: put sync_clk value in picoseconds
 instead of nanoseconds
Date: Wed, 15 Dec 2010 08:54:45 +0200
Message-ID: <4D086635.2010109@nokia.com>
References: <20101213122042.20685.52929.sendpatchset@ahunter-work.research.nokia.com> <20101213122108.20685.1920.sendpatchset@ahunter-work.research.nokia.com> <20101215012914.GE3190@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:63540 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab0LOG4P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 01:56:15 -0500
In-Reply-To: <20101215012914.GE3190@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Artem Bityutskiy <dedekind1@gmail.com>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, "Balbi, Felipe" <balbi@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>From c52e0cdeedffb7a0f9818ad3d6296d1f51b8669d Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 9 Dec 2010 10:48:27 +0200
Subject: [PATCH 4/7] OMAP2/3: GPMC: put sync_clk value in picoseconds instead of nanoseconds

The calculations done with sync_clk are anyway in picoseconds
and switching to picoseconds allows sync_clk values that are
not a whole number of nanoseconds - which is sometimes the
case.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
  arch/arm/mach-omap2/gpmc-nand.c        |    2 +-
  arch/arm/mach-omap2/gpmc-onenand.c     |   10 +++++-----
  arch/arm/mach-omap2/gpmc.c             |   12 +++++++++++-
  arch/arm/mach-omap2/usb-tusb6010.c     |    4 ++--
  arch/arm/plat-omap/include/plat/gpmc.h |    9 +++++----
  5 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 7222096..2bb29c1 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -41,7 +41,7 @@ static int omap2_nand_gpmc_retime(void)
  		return 0;
  
  	memset(&t, 0, sizeof(t));
-	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
+	t.sync_clk = gpmc_nand_data->gpmc_t->sync_clk;
  	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
  	t.adv_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->adv_on);
  
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 7bb6922..1db606c 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -174,7 +174,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
  
  	switch (freq) {
  	case 83:
-		min_gpmc_clk_period = 12; /* 83 MHz */
+		min_gpmc_clk_period = 12000; /* 83 MHz */
  		t_ces   = 5;
  		t_avds  = 4;
  		t_avdh  = 2;
@@ -183,7 +183,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
  		t_rdyo  = 9;
  		break;
  	case 66:
-		min_gpmc_clk_period = 15; /* 66 MHz */
+		min_gpmc_clk_period = 15000; /* 66 MHz */
  		t_ces   = 6;
  		t_avds  = 5;
  		t_avdh  = 2;
@@ -192,7 +192,7 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
  		t_rdyo  = 11;
  		break;
  	default:
-		min_gpmc_clk_period = 18; /* 54 MHz */
+		min_gpmc_clk_period = 18500; /* 54 MHz */
  		t_ces   = 7;
  		t_avds  = 7;
  		t_avdh  = 7;
@@ -271,8 +271,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
  		t.wr_cycle  = t.rd_cycle;
  		if (cpu_is_omap34xx()) {
  			t.wr_data_mux_bus = gpmc_ticks_to_ns(fclk_offset +
-					gpmc_ns_to_ticks(min_gpmc_clk_period +
-					t_rdyo));
+					gpmc_ps_to_ticks(min_gpmc_clk_period +
+					t_rdyo * 1000));
  			t.wr_access = t.access;
  		}
  	} else {
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f46933b..1b7b3e7 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -168,6 +168,16 @@ unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
  	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
  }
  
+unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
+{
+	unsigned long tick_ps;
+
+	/* Calculate in picosecs to yield more exact results */
+	tick_ps = gpmc_get_fclk_period();
+
+	return (time_ps + tick_ps - 1) / tick_ps;
+}
+
  unsigned int gpmc_ticks_to_ns(unsigned int ticks)
  {
  	return ticks * gpmc_get_fclk_period() / 1000;
@@ -235,7 +245,7 @@ int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
  	int div;
  	u32 l;
  
-	l = sync_clk * 1000 + (gpmc_get_fclk_period() - 1);
+	l = sync_clk + (gpmc_get_fclk_period() - 1);
  	div = l / gpmc_get_fclk_period();
  	if (div > 4)
  		return -1;
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 64a0112..1e998ea 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -120,8 +120,8 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
  	t.adv_on = next_clk(t.cs_on, t_scsnh_advnh - 7000, fclk_ps);
  
  	/* GPMC_CLK rate = fclk rate / div */
-	t.sync_clk = 12 /* 11.1 nsec */;
-	tmp = (t.sync_clk * 1000 + fclk_ps - 1) / fclk_ps;
+	t.sync_clk = 11100 /* 11.1 nsec */;
+	tmp = (t.sync_clk + fclk_ps - 1) / fclk_ps;
  	if (tmp > 4)
  		return -ERANGE;
  	if (tmp <= 0)
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 9fd99b9..85ded59 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -80,12 +80,12 @@
  #define GPMC_PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
  
  /*
- * Note that all values in this struct are in nanoseconds, while
- * the register values are in gpmc_fck cycles.
+ * Note that all values in this struct are in nanoseconds except sync_clk
+ * (which is in picoseconds), while the register values are in gpmc_fck cycles.
   */
  struct gpmc_timings {
-	/* Minimum clock period for synchronous mode */
-	u16 sync_clk;
+	/* Minimum clock period for synchronous mode (in picoseconds) */
+	u32 sync_clk;
  
  	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
  	u16 cs_on;		/* Assertion time */
@@ -117,6 +117,7 @@ struct gpmc_timings {
  };
  
  extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
+extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
  extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
  extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
  extern unsigned long gpmc_get_fclk_period(void);
-- 1.7.0.4
