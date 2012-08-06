From: "Mohammed, Afzal" <afzal@ti.com>
Subject: gpmc generic retime function (subject was RE: [PATCH v5 3/3] ARM:
 OMAP2+: onenand: prepare for gpmc driver migration)
Date: Mon, 6 Aug 2012 13:38:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9B150D@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
 <20120710094538.GT1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com>
 <20120710131734.GV1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A669D@DBDE01.ent.ti.com>
 <4FFC6330.1040409@ti.com> <20120711064724.GA1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43318 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895Ab2HFNiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 09:38:52 -0400
In-Reply-To: <20120711064724.GA1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony, Jon,

On Wed, Jul 11, 2012 at 12:17:25, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120710 10:20]:

> > The DT node should simply have the information required by the retime
> > function or gpmc timings themselves if available. In the case of OneNAND

> > These can be stored in the DT and then translated to gpmc timings at
> > runtime. DT should only store static timing or clock information known

> Yup. And the format of the timing data in DT should be standardized so
> the only differences for each connected peripheral is the retime function.

If we are able to achieve a generic retime function applicable to all
peripherals then we don't need wrapper layer for retime handling or two
linux devices and drivers (one the existing and the other to handle retime)
to represent a single physical gpmc peripheral device (for DT conversion).
Then handling core frequency scaling and DT conversion would be easier.
We were trying to create such a retime function that would be generic so
as to handle different types of gpmc peripherals.

And we have been able to create such a function. Below is an implementation
that has been made for handling asynchronous timings. It has been tested for
OneNAND & SMSC on OMAP3EVM (rev G & C) with [1-4]. OneNAND was tested using
[5] (OMAP3EVM OneNAND works in async mode) & SMSC using [6] (mainline does
not have a timing calculation for smsc911x)

It was difficult to squeeze tusb6010 timing calculation into generic timing
calculation, hence a boolean "tusb" has been used. This is what I could
achieve based on existing retime for tusb6010 and for lack of tusb6010
timing specifications.

----8<-----------------------------------------------------------------------

/* Device timings in picoseconds */
struct gpmc_device_timings {
        u32     cs_setup;       /* CS setup time */
        u32     adv_setup;      /* ADV setup time */
        u32     adv_rd_off;     /* ADV read off time */
        u32     adv_add_hold;   /* address hold time */
        u32     oe_setup;       /* OE setup time */
        u32     adv_access;     /* access time from ADV assertion */
        u32     rd_access;      /* read access time */
        u32     oe_access;      /* access time from OE assertion */
        u32     cs_access;      /* access time from CS asertion */
        u32     rd_cycle;       /* read cycle time */
        u32     cs_highz;       /* CS deassertion to high Z */
        u32     oe_highz;       /* OE deassertion to high Z */
        u32     adv_wr_off;     /* ADV write off time */
        u32     we_setup;       /* WE setup time */
        u32     wr_pulse;       /* write assertion time */
        u32     wr_data_setup;  /* data setup time from write assertion */
        u32     wr_high;        /* write deassertion time */
        u32     we_highz;       /* WE deassertion to high Z */
        u32     wr_cycle;       /* write cycle time */

        bool    mux;            /* address & data muxed */
        bool    tusb;           /* peripheral is tusb6010 */
};

struct gpmc_timings gpmc_calc_timings(struct gpmc_device_timings *dev_t)
{
        struct gpmc_timings gpmc_t;
        bool mux = dev_t->mux;
        bool tusb = dev_t->tusb;
        u32 temp;

        memset(&gpmc_t, 0, sizeof(gpmc_t));

        /* cs_on */
        gpmc_t.cs_on = gpmc_round_ns_to_ticks(dev_t->cs_setup / 1000);

        /* adv_on */
        temp = dev_t->adv_setup;
        if (tusb)
                temp = max_t(u32,
                        (gpmc_t.cs_on + gpmc_ticks_to_ns(1)) * 1000, temp);
        gpmc_t.adv_on = gpmc_round_ns_to_ticks(temp / 1000);

        /* adv_rd_off */
        temp = dev_t->adv_rd_off;
        if (tusb)
                temp = max_t(u32,
                        (gpmc_t.adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
        gpmc_t.adv_rd_off = gpmc_round_ns_to_ticks(temp / 1000);

        /* oe_on */
        if (mux)
                temp = gpmc_t.adv_rd_off * 1000 + dev_t->adv_add_hold;
        else
                temp = dev_t->oe_setup;
        if (tusb)
                temp = max_t(u32,
                        (gpmc_t.adv_rd_off + gpmc_ticks_to_ns(1)) * 1000, temp);
        gpmc_t.oe_on = gpmc_round_ns_to_ticks(temp / 1000);

        /* access */
        temp = max_t(u32, dev_t->rd_access,
                                gpmc_t.oe_on * 1000 + dev_t->oe_access);
        temp = max_t(u32, temp,
                                gpmc_t.cs_on * 1000 + dev_t->cs_access);
        temp = max_t(u32, temp,
                                gpmc_t.adv_on * 1000 + dev_t->adv_access);
        if (tusb) {
                temp = max_t(u32, temp,
                                (gpmc_t.oe_on + gpmc_ticks_to_ns(1)) * 1000);
                temp = max_t(u32, temp, gpmc_t.oe_on * 1000 + 300);
        }
        gpmc_t.access = gpmc_round_ns_to_ticks(temp / 1000);

        gpmc_t.oe_off = gpmc_t.access + gpmc_ticks_to_ns(1);
        gpmc_t.cs_rd_off = gpmc_t.oe_off;

        /* rd_cycle */
        temp = max_t(u32, dev_t->rd_cycle,
                        gpmc_t.cs_rd_off * 1000 + dev_t->cs_highz);
        temp = max_t(u32, temp,
                        gpmc_t.oe_off * 1000 + dev_t->oe_highz);
        if (tusb) {
                temp = max_t(u32, temp,
                        (gpmc_t.cs_rd_off + gpmc_ticks_to_ns(1)) * 1000);
                temp = max_t(u32, temp, gpmc_t.cs_rd_off * 1000 + 7000);
        }
        gpmc_t.rd_cycle = gpmc_round_ns_to_ticks(temp / 1000);

        /* adv_wr_off */
        temp = dev_t->adv_wr_off;
        if (tusb)
                temp = max_t(u32,
                        (gpmc_t.adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
        gpmc_t.adv_wr_off = gpmc_round_ns_to_ticks(temp / 1000);

        /* we_on */
        if (mux)
                temp = gpmc_t.adv_wr_off * 1000 + dev_t->adv_add_hold;
        else
                temp = dev_t->we_setup;
        if (tusb)
                temp = max_t(u32,
                        (gpmc_t.adv_wr_off + gpmc_ticks_to_ns(1)) * 1000, temp);
        gpmc_t.we_on = gpmc_round_ns_to_ticks(temp / 1000);

        gpmc_t.wr_data_mux_bus = gpmc_t.we_on;

        /* we_off */
        temp = max_t(u32, gpmc_t.we_on * 1000 + dev_t->wr_pulse,
                        gpmc_t.we_on * 1000 + dev_t->wr_data_setup);
        if (tusb) {
                temp = max_t(u32, temp,
                                (gpmc_t.we_on + gpmc_ticks_to_ns(1)) * 1000);
                temp = max_t(u32, temp, gpmc_t.we_on * 1000 + 300);
        }
        gpmc_t.we_off = gpmc_round_ns_to_ticks(temp / 1000);

        gpmc_t.cs_wr_off = gpmc_round_ns_to_ticks((gpmc_t.we_off * 1000 +
                                dev_t->wr_high) / 1000);

        /* wr_cycle */
        temp = max_t(u32, dev_t->wr_cycle,
                        gpmc_t.cs_wr_off * 1000 + dev_t->cs_highz);
        temp = max_t(u32, temp,
                        gpmc_t.we_off * 1000 + dev_t->we_highz);
        if (tusb) {
                temp = max_t(u32, temp,
                        (gpmc_t.cs_wr_off + gpmc_ticks_to_ns(1)) * 1000);
                temp = max_t(u32, temp, gpmc_t.cs_wr_off * 1000 + 7000);
        }
        gpmc_t.wr_cycle = gpmc_round_ns_to_ticks(temp / 1000);

        return gpmc_t;
}

> > From a high-level I think that the goal should be ...
> > 
> > gpmc_probe
> > 	--> request CS
> > 	--> calls retime function to calculate gpmc timing (optional)
> > 	--> configures CS
> > 	--> registers peripheral device
> 
> Yes with few additions.. Connected peripheral probe requests CS from
> gpmc with the optional retime function pointer passed as a parameter.
> After gpmc code has determined the CS is available, it calls the optional
> retime function before returning back to the connected peripheral probe.
> 
> So how about the following with a bit more details:
> 
> gpmc_probe
> 	--> just sets up gpmc resources then idles itself
> 
> connected peripheral probe
> 	--> calls gpmc_cs_request() with gpmc timings from DT and an
> 	    optional retime function as a parameter
> 	--> gpmc_cs_request() allocates the CS
> 	--> gpmc_cs_request() calls the optional retime function and
> 	    if not specified, just sets the DT timings and disables
> 	    L3 DFS
> 	--> gpmc_cs_request() returns to connected peripheral probe

Once we are able to use the generic retime function as mentioned above,
instead of requiring additional driver for each peripheral that has
retime and its effect on complicating DT conversion,  we can have the
gpmc driver organization similar to the one that was posted
earlier[4].

With DT, we can pass peripheral timings that has been generalized as in 
gpmc_device_timings structure. In addition to timings, we would need
to have fields for specifying whether multiplexed or not ("mux" in
struct gpmc_device_timings), asynchronous or synchronous.

With the generic retime function, driver could do as follows,

gpmc_probe
  -> setup_device
    -> setup_cs
      ->setup_cs_config_timing
		if (gpmc_timings)
			gpmc_cs_set_timings(gpmc_t);
		else if (gpmc_device_timings) {
			gpmc_t = gpmc_calc_timings();
			gpmc_cs_set_timings(cs, &gpmc_t);
		}


In the above, addition to already posted driver series [4] would
be the "else if" portions.

For core DFS, we could register a notifier that would invoke,
	gpmc_t = gpmc_calc_timings(); /* defined above */
	gpmc_cs_set-timings(cs, &gpmc_t);
enabling us to have the gpmc timings adjusted.


Please let me know your comments on the above. Currently I am working
on achieving generalized timing for synchronous operations too so
that gpmc timings can be calculated at runtime using a single generic
retime function for all kinds of operations like mux, sync/async etc.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70096.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg71027.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html
[4] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70753.html

[5]
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index bbae674..fab21a1 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -50,6 +50,7 @@ static struct platform_device gpmc_onenand_device = {
 static struct gpmc_timings omap2_onenand_calc_async_timings(void)
 {
        struct gpmc_timings t;
+       struct gpmc_device_timings dev_t;
 
        const int t_cer = 15;
        const int t_avdp = 12;
@@ -63,6 +64,24 @@ static struct gpmc_timings omap2_onenand_calc_async_timings(void)
        const int t_wph = 30;
 
        memset(&t, 0, sizeof(t));
+
+       memset(&dev_t, 0, sizeof(dev_t));
+       dev_t.cs_setup = 0;
+       dev_t.adv_setup = 0;
+       dev_t.adv_rd_off = 15 * 1000;
+       dev_t.adv_add_hold = 7 * 1000;
+       dev_t.adv_access = 76 * 1000;
+       dev_t.oe_access = 20 * 1000;
+       dev_t.cs_access = 76 * 1000;
+       dev_t.cs_highz = 20 * 1000;
+       dev_t.adv_wr_off = 15 * 1000;
+       dev_t.wr_pulse = 40 * 1000;
+       dev_t.wr_high = 30 * 1000;
+
+       dev_t.mux = true;
+
+       return gpmc_calc_timings(&dev_t);
+
        t.sync_clk = 0;
        t.cs_on = 0;
        t.adv_on = 0;

[6]

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index b6c77be..53c7958 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -39,6 +39,50 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
        .irq_type       = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
 };
 
+static void gpmc_smsc911x_timing(struct omap_smsc911x_platform_data *gpmc_cfg)
+{
+       struct gpmc_timings t;
+       /* SMSC 9220 timings */
+       unsigned tcycle_r = 165;
+       unsigned tcsl_r = 32;
+       unsigned tcsh_r = 133;
+       unsigned tcsdv_r = 30;
+       unsigned tdoff_r = 9;
+       unsigned tcycle_w = 165;
+       unsigned tcsl_w = 32;
+       unsigned tcsh_w = 133;
+       unsigned tdsu_w = 7;
+       struct gpmc_device_timings dev_t;
+
+       memset(&t, sizeof(t), 0);
+
+       memset(&dev_t, sizeof(dev_t), 0);
+       dev_t.rd_access = tcsdv_r * 1000;
+       dev_t.rd_cycle = tcycle_r * 1000;
+       dev_t.wr_data_setup = tdsu_w * 1000;
+       dev_t.wr_pulse = tcsl_w * 1000;
+       dev_t.wr_cycle = tcycle_w * 1000;
+
+       t = gpmc_calc_timings(&dev_t);
+       gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+       return;
+
+       t.cs_on = 0;
+       t.oe_on = 0;
+       t.access = tcsdv_r;
+       t.oe_off = max_t(unsigned, t.access + gpmc_ticks_to_ns(1), tcsl_r);
+       t.cs_rd_off = t.oe_off;
+       t.rd_cycle = tcsl_r + max(tcsh_r, tdoff_r);
+       t.rd_cycle = max_t(unsigned, tcycle_r, t.rd_cycle);
+
+       t.we_on = 0;
+       t.we_off = max(tcsl_w, tdsu_w);
+       t.cs_wr_off = t.we_off;
+       t.wr_cycle = max_t(unsigned, t.we_off + gpmc_ticks_to_ns(1), tcycle_w);
+
+       gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+}
+
/*
  * Initialize smsc911x device connected to the GPMC. Note that we
  * assume that pin multiplexing is done in the board-*.c file,
@@ -81,6 +125,8 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 
        gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
 
+       gpmc_smsc911x_timing(gpmc_cfg);
+
        pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
                 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
                 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));

