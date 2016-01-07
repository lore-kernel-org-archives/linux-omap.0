From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Thu, 7 Jan 2016 10:07:01 -0800
Message-ID: <20160107180700.GN12777@atomide.com>
References: <20160104174001.GD12777@atomide.com> <568AC0F9.2010304@gmail.com>
 <20160105041356.GE12777@atomide.com> <20160105084947.GG22661@pali>
 <20160105224929.GF12777@atomide.com> <20160106174039.GA14271@earth>
 <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568D5F54.7040900@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160106 10:39]:
> Hi,
> 
> On  6.01.2016 20:26, Tony Lindgren wrote:
> 
> >
> >Hmm. Care to verify that your onenand really gets detected at 83 MHz like
> >your earlier logs show? Below is a patch that should show it.
> 
> before the corruption appeared, I looked a couple of times in syslog and the
> freq there was 83MHz. Including after I disabled CONFIG_OMAP_GPMC_DEBUG.

OK well at least that part of the bug is fixed then.

> >Also, do things now work reliably for you with CONFIG_OMAP_GPMC_DEBUG
> >enabled? Or does that also produce corruption after few reboots?
> 
> CONFIG_OMAP_GPMC_DEBUG is disabled, shall I enable it?

Yes please.

> Where am I supposed to get the output from ^^^ if rootfs become corrupted?
> The problem appears after poweroff/restart when it is already too late to
> get the syslog.

Hmm good point. Can you boot with root on MMC? So far no luck here
reproducing the corruption here with my fix applied.

> BTW, did you compare all the GPMC registers with and without
> HWMOD_INIT_NO_RESET?

Well the timings now for me both with and without GPMC reset are:

cs0 GPMC_CS_CONFIG1: 0xfb001201
cs0 GPMC_CS_CONFIG2: 0x00101000
cs0 GPMC_CS_CONFIG3: 0x00020200
cs0 GPMC_CS_CONFIG4: 0x10001003
cs0 GPMC_CS_CONFIG5: 0x020f1313
cs0 GPMC_CS_CONFIG6: 0x8f050000

These timings also match the current mainline timings without the
fix I posted when CONFIG_OMAP_GPMC_DEBUG is enabled.

The nolo set timings I have are:
cs0 GPMC_CS_CONFIG1: 0xfb001201
cs0 GPMC_CS_CONFIG2: 0x00101000
cs0 GPMC_CS_CONFIG3: 0x00020200
cs0 GPMC_CS_CONFIG4: 0x10001002 <- OEONTIME is still different in nolo
cs0 GPMC_CS_CONFIG5: 0x020f1313
cs0 GPMC_CS_CONFIG6: 0x8f050000

So there seems to be OEONTIME difference. Once the legacy boot is
gone, we can probably remove the OEONTIME calculations and rely
on the dts provide values as it seems that currently the dts value
is ignored in gpmc_calc_sync_read_timings().

To dump your nolo provided timings, you can add the following
line to gpmc_probe_onenand_child() before gpmc_onenand_init:

	gpmc_cs_show_timings(gpmc_onenand_data->cs,
		"before gpmc_cs_program_settings");

Note that will show the wrong GPMC default values after reset
unless you have CONFIG_OMAP_GPMC_DEBUG enabled.

Then below is a better debug patch to dump out the values after
reset. Note that in that case the above "before" timings must
be ignored.

Regards,

Tony

8< --------------------
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -153,6 +153,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 		freq = 0;
 	}
 
+	gpmc_cs_show_timings(cs, "before gpmc_cs_program_settings");
+
 	return freq;
 }
 
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2150,8 +2150,7 @@ static struct omap_hwmod omap3xxx_gpmc_hwmod = {
 	.clkdm_name	= "core_l3_clkdm",
 	.mpu_irqs	= omap3xxx_gpmc_irqs,
 	.main_clk	= "gpmc_fck",
-	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
-	.flags		= HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /*
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1987,7 +1987,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	if (ret < 0)
 		goto err;
 
-	gpmc_cs_show_timings(cs, "before gpmc_cs_program_settings");
+	dev_info(&pdev->dev, "GPMC reset, not showing default timings\n");
 	ret = gpmc_cs_program_settings(cs, &gpmc_s);
 	if (ret < 0)
 		goto err;
