From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 14:02:37 +0200
Message-ID: <1366372957.3928.104.camel@mars>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com>
	 <1366316595.4085.113.camel@mars>  <5170738F.8050305@ti.com>
	 <1366325282.4232.6.camel@lovely> <51708097.6070102@ti.com>
	 <51708131.2040208@ti.com>  <1366362081.3928.18.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:52953 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968123Ab3DSMCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 08:02:43 -0400
Received: by mail-bk0-f54.google.com with SMTP id q16so1720754bkw.27
        for <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 05:02:41 -0700 (PDT)
In-Reply-To: <1366362081.3928.18.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org

On Fri, 2013-04-19 at 11:01 +0200, Christoph Fritz wrote:

> This is how u-boot GPMC config differs from final kernel configuration:
> 
> 
> 	u-boot: GPMC_CONFIG1: 0x6e000060: 0x00001800
> 	kernel:                           0x00001800
> 
> 	u-boot: GPMC_CONFIG2: 0x6e000064: 0x00141400
> 	kernel:                           0x00040400
> 
> 	u-boot: GPMC_CONFIG3: 0x6e000068: 0x00141400
> 	kernel:                           0x00040400
> 
> 	u-boot: GPMC_CONFIG4: 0x6e00006c: 0x0f010f01
> 	kernel:                           0x03000300
> 
> 	u-boot: GPMC_CONFIG5: 0x6e000070: 0x010c1414
> 	kernel:                           0x00030404
> 
> 	u-boot: GPMC_CONFIG6: 0x6e000074: 0x1f0f0a80
> 	kernel:                           0x07030000
> 
> 	u-boot: GPMC_CONFIG7: 0x6e000078: 0x00000870
> 	kernel:                           0x00000f70

This differs because of wrong timings in my dt, this is my current one:

&gpmc {
	ranges = <0 0 0x30000000 0x1000000>;
	nand@0,0 {
		reg = <0 0 0x1000000>;
		nand-bus-width = <16>;
		ti,nand-ecc-opt = "hw"; /* <- here I'm not sure, in current u-boot it's just 'hw' */
		/* no elm on omap3 */

		gpmc,mux-add-data = <0>;
		gpmc,device-nand;
		gpmc,device-width = <2>;
		gpmc,wait-pin = <0>;
		gpmc,wait-monitoring-ns = <0>;
		gpmc,burst-length= <4>;
		gpmc,cs-on-ns = <0>;
		gpmc,cs-rd-off-ns = <100>;
		gpmc,cs-wr-off-ns = <100>;
		gpmc,adv-on-ns = <0>;
		gpmc,adv-rd-off-ns = <100>;
		gpmc,adv-wr-off-ns = <100>;
		gpmc,oe-on-ns = <5>;
		gpmc,oe-off-ns = <75>;
		gpmc,we-on-ns = <5>;
		gpmc,we-off-ns = <75>;
		gpmc,rd-cycle-ns = <100>;
		gpmc,wr-cycle-ns = <100>;
		gpmc,access-ns = <60>;
		gpmc,page-burst-access-ns = <5>;
		gpmc,bus-turnaround-ns = <0>;
		gpmc,cycle2cycle-samecsen;
		gpmc,cycle2cycle-delay-ns = <50>;
		gpmc,wr-data-mux-bus-ns = <75>;
		gpmc,wr-access-ns = <155>;
	};
};

and now NAND gets detected:

[    0.267913] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.269012] GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
[    0.269134] GPMC CS0: cs_rd_off :  20 ticks, 100 ns (was  20 ticks) 100 ns

[    0.269256] GPMC CS0: cs_wr_off :  20 ticks, 100 ns (was  20 ticks) 100 ns
[    0.269287] GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
[    0.269317] GPMC CS0: adv_rd_off:  20 ticks, 100 ns (was  20 ticks) 100 ns
[    0.269378] GPMC CS0: adv_wr_off:  20 ticks, 100 ns (was  20 ticks) 100 ns
[    0.269409] GPMC CS0: oe_on     :   0 ticks,   0 ns (was   1 ticks)   0 ns
[    0.269439] GPMC CS0: oe_off    :  15 ticks,  75 ns (was  15 ticks)  75 ns
[    0.269439] GPMC CS0: we_on     :   0 ticks,   0 ns (was   1 ticks)   0 ns
[    0.269470] GPMC CS0: we_off    :  15 ticks,  75 ns (was  15 ticks)  75 ns
[    0.269500] GPMC CS0: rd_cycle  :  20 ticks, 100 ns (was  20 ticks) 100 ns
[    0.269531] GPMC CS0: wr_cycle  :  20 ticks, 100 ns (was  20 ticks) 100 ns
[    0.269531] GPMC CS0: access    :  12 ticks,  60 ns (was  12 ticks)  60 ns
[    0.269561] GPMC CS0: page_burst_access:   0 ticks,   0 ns (was   1 ticks)   0 ns
[    0.269592] GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
[    0.269592] gpmc_cs_set_timings, 404, t->cycle2cycle_delay: 0x00000000
[    0.269622] GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was  10 ticks)   0 ns
[    0.269653] GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
[    0.269653] GPMC CS0: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
[    0.269683] GPMC CS0: wr_data_mux_bus:  15 ticks,  75 ns (was  15 ticks)  75 ns
[    0.269714] GPMC CS0: wr_access :  31 ticks, 155 ns (was  31 ticks) 155 ns
[    0.270416] gpmc_read_settings_dt: page/burst-length set but not used!
[    0.270446] gpmc_read_settings_dt: read/write wait monitoring not enabled!
[    0.276519] No ATAGs?
[    0.276550] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.279205] OMAP DMA hardware revision 5.0
<SNIP>
[    2.021575] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.029907] Trying ONFI probe in 16 bits mode, aborting !
[    2.035644] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1,8V 16-bit), 256MiB, page size: 2048, OOB size: 64


but kernel GPMC config still differs from u-boot gpmc config:


u-boot: GPMC_CONFIG1: 0x6e000060: 0x00001800
kernel:                           0x00001800 OK
u-boot: GPMC_CONFIG2: 0x6e000064: 0x00141400
kernel:                           0x00141400 OK
u-boot: GPMC_CONFIG3: 0x6e000068: 0x00141400
kernel:                           0x00141400 OK
u-boot: GPMC_CONFIG4: 0x6e00006c: 0x0f010f01
kernel:                           0x0f000f00 DIFF
u-boot: GPMC_CONFIG5: 0x6e000070: 0x010c1414
kernel:                           0x000c1414 DIFF
u-boot: GPMC_CONFIG6: 0x6e000074: 0x1f0f0a80
kernel:                           0x1f0f0000 DIFF
u-boot: GPMC_CONFIG7: 0x6e000078: 0x00000870
kernel:                           0x00000f70 doesn't harm

so I hacked the missing values to omap2_nand_gpmc_retime():

>From 8868823925441a824fe0d3143614482f25fb379b Mon Sep 17 00:00:00 2001
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Fri, 19 Apr 2013 12:41:11 +0200
Subject: [PATCH] [RFC] ARM: OMAP2+: nand: add missing gpmc timing values

This patch adds missing gpmc timing values to omap2_nand_gpmc_retime().
---
 arch/arm/mach-omap2/gpmc-nand.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d9c2719..d8bb241 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -58,6 +58,9 @@ static int omap2_nand_gpmc_retime(
 	/* Read */
 	t.adv_rd_off = gpmc_t->adv_rd_off;
 	t.oe_on  = t.adv_on;
+	if (cpu_is_omap34xx()) {
+		t.oe_on = gpmc_t->oe_on;
+	}
 	t.access = gpmc_t->access;
 	t.oe_off = gpmc_t->oe_off;
 	t.cs_rd_off = gpmc_t->cs_rd_off;
@@ -69,11 +72,18 @@ static int omap2_nand_gpmc_retime(
 	if (cpu_is_omap34xx()) {
 		t.wr_data_mux_bus = gpmc_t->wr_data_mux_bus;
 		t.wr_access = gpmc_t->wr_access;
+		t.we_on = gpmc_t->we_on;
 	}
 	t.we_off = gpmc_t->we_off;
 	t.cs_wr_off = gpmc_t->cs_wr_off;
 	t.wr_cycle = gpmc_t->wr_cycle;
 
+	if (cpu_is_omap34xx()) {
+		t.bool_timings = gpmc_t->bool_timings;
+		t.cycle2cycle_delay = gpmc_t->cycle2cycle_delay;
+		t.page_burst_access = gpmc_t->page_burst_access;
+	}
+
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
 	if (err)
 		return err;
-- 
1.7.10.4

now the GPMC config is the same as in u-boot:

u-boot: GPMC_CONFIG1: 0x6e000060: 0x00001800
kernel:                           0x00001800 OK
u-boot: GPMC_CONFIG2: 0x6e000064: 0x00141400
kernel:                           0x00141400 OK
u-boot: GPMC_CONFIG3: 0x6e000068: 0x00141400
kernel:                           0x00141400 OK
u-boot: GPMC_CONFIG4: 0x6e00006c: 0x0f010f01
kernel:                           0x0f010f01 OK
u-boot: GPMC_CONFIG5: 0x6e000070: 0x010c1414
kernel:                           0x010c1414 OK
u-boot: GPMC_CONFIG6: 0x6e000074: 0x1f0f0a80
kernel:                           0x1f0f0a80 OK
u-boot: GPMC_CONFIG7: 0x6e000078: 0x00000870
kernel:                           0x00000f70 doesn't harm

Thanks
 -- Christoph

