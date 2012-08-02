From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap_device: query on "fck" clk alias created
Date: Thu, 2 Aug 2012 12:55:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7DF32@DBDE01.ent.ti.com>
References: <50191F00.1040501@ti.com> <50193263.8070907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47304 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab2HBMzv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 08:55:51 -0400
In-Reply-To: <50193263.8070907@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Wed, Aug 01, 2012 at 19:12:59, Cousson, Benoit wrote:
> Hi Vaibhav,
> 
> On 08/01/2012 02:20 PM, Vaibhav Hiremath wrote:
> > Hi,
> > 
> > In OMAP world, we have omap_device layer, which exports api's like
> > omap_device_build() to create and register platform_device to the
> > kernel. This layer understands hwmod infrastructure and parses all the
> > platform specific information from it.
> > Now with DT migration, the same thing is achieved using a notifier,
> > which in turn omap_device_build_from_dt(), which in turn does same thing.
> > 
> > One of the thing which is happening in both execution path is, creating
> > alias for functional clock (hwmod_data->main_clk) for each device
> > getting created with the con_id = "fck".
> > 
> > Now the problem with this is,
> > 
> > The clk_get() api will not work, unless we pass both the arguments (dev,
> > con_id) properly. Now expecting driver to always label con_id with "fck"
> > is undesirable, as the same driver can be reused on multiple platforms,
> > which can be non-omap and/or non-ti platforms.
> > Also we have multiple examples where driver simply calls (which is right)
> > 
> > clk = clk_get(&pdev->dev, NULL);
> 
> Mmm, I don't know, but even if this is right, shouldn't we avoid such
> usage. It might be better to be explicit than assuming that the IP will
> always have an unique clock.

Isn't this IP specific and driver must know how many clocks he has to 
address? So I believe it will not be assumption, the driver is written
considering clocksources and in some cases IP is designed and meant to
receive only one clock input.

Let me bring a real example which I am dealing with now,

DCAN IP integrated in AM335X device, this IP is not from TI. This is Bosch
IP and doesn't follow any of the TI standards, like HighLander spec. Even it doesn't have SYSCONF register for that matter. The driver is generic, 
obviously used across non-ti devices already and driver is implemented with
Clk_get(dev, NULL);


> Some IP does have several inputs that might or not be connected
> depending or the integration or on the version. So even if only one
> clock is useful at some point it will not always be true.
> We had similar issue with the IRQ lines in the past.
> 
> > This would fail on OMAP platforms, unless you modify clockxxx_data.c
> > file with,
> > 
> > CLK("<device>",  NULL,           &xxx_fck,    CK_34XX),
> > 
> > 
> > Devices specially with only one clock source always prefer not to
> > specify con_id.
> 
> How many devices do you have with only one clock source? Could you
> provide the list of drivers that assume that?
>

I did simple grep on drivers/ directory and here is the output of it -


# grep -r clk_get drivers/* | grep -r ", NULL"

drivers/ata/pata_arasan_cf.c:   acdev->clk = clk_get(&pdev->dev, NULL);
drivers/ata/sata_mv.c:  hpriv->clk = clk_get(&pdev->dev, NULL);
drivers/ata/pata_imx.c: priv->clk = clk_get(&pdev->dev, NULL);
drivers/char/hw_random/nomadik-rng.c:   rng_clk = clk_get(&dev->dev, NULL);
drivers/char/hw_random/picoxcell-rng.c: rng_clk = clk_get(&pdev->dev, NULL);
drivers/char/hw_random/atmel-rng.c:     trng->clk = clk_get(&pdev->dev, NULL);
drivers/crypto/ux500/cryp/cryp_core.c:  device_data->clk = clk_get(&pdev->dev, NULL);
drivers/crypto/ux500/hash/hash_core.c:  device_data->clk = clk_get(dev, NULL);
drivers/crypto/mv_cesa.c:       cp->clk = clk_get(&pdev->dev, NULL);
drivers/dma/ipu/ipu_idmac.c:    ipu_data.ipu_clk = clk_get(&pdev->dev, NULL);
drivers/dma/mv_xor.c:   msp->clk = clk_get(&pdev->dev, NULL);
drivers/dma/mxs-dma.c:  mxs_dma->clk = clk_get(&pdev->dev, NULL);
drivers/dma/ste_dma40.c:        clk = clk_get(&pdev->dev, NULL);
drivers/gpio/gpio-pxa.c:        clk = clk_get(&pdev->dev, NULL);
drivers/gpio/gpio-stp-xway.c:   clk = clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-davinci.c:       dev->clk = clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-sirf.c:  clk = clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-designware-platdrv.c:    dev->clk = clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-nomadik.c:       dev->clk = clk_get(&adev->dev, NULL);
drivers/i2c/busses/i2c-nuc900.c:        i2c->clk = clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-tegra.c: clk = devm_clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-pxa.c:   i2c->clk = clk_get(&dev->dev, NULL);
drivers/i2c/busses/i2c-sh_mobile.c:     pd->clk = clk_get(&dev->dev, NULL);
drivers/i2c/busses/i2c-imx.c:   i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
drivers/i2c/busses/i2c-pnx.c:   alg_data->clk = clk_get(&pdev->dev, NULL);
drivers/ide/palm_bk3710.c:      clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/nomadik-ske-keypad.c:    keypad->clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/tnetv107x-keypad.c:      kp->clk = clk_get(dev, NULL);
drivers/input/keyboard/pxa27x_keypad.c: keypad->clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/tegra-kbc.c:     kbc->clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/spear-keyboard.c:        kbd->clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/ep93xx_keypad.c: keypad->clk = clk_get(&pdev->dev, NULL);
drivers/input/keyboard/w90p910_keypad.c:        keypad->clk = clk_get(&pdev->dev, NULL);
drivers/input/touchscreen/lpc32xx_ts.c: tsc->clk = clk_get(&pdev->dev, NULL);
drivers/input/touchscreen/w90p910_ts.c: w90p910_ts->clk = clk_get(&pdev->dev, NULL);
drivers/input/touchscreen/tnetv107x-ts.c:       ts->clk = clk_get(dev, NULL);
drivers/leds/leds-renesas-tpu.c:        p->clk = clk_get(&pdev->dev, NULL);
drivers/media/video/mx3_camera.c:       mx3_cam->clk = clk_get(&pdev->dev, NULL);
drivers/media/video/pxa_camera.c:       pcdev->clk = clk_get(&pdev->dev, NULL);
drivers/media/video/mx2_camera.c:       pcdev->clk_csi = clk_get(&pdev->dev, NULL);
drivers/media/video/mx2_emmaprp.c:      pcdev->clk_emma = clk_get(&pdev->dev, NULL);
drivers/mfd/davinci_voicecodec.c:       davinci_vc->clk = clk_get(&pdev->dev, NULL);
drivers/mfd/ti-ssp.c:   ssp->clk = clk_get(dev, NULL);
drivers/misc/spear13xx_pcie_gadget.c:           clk = clk_get_sys("pcie1", NULL);
drivers/misc/spear13xx_pcie_gadget.c:           clk = clk_get_sys("pcie2", NULL);
drivers/mmc/host/mxs-mmc.c:     host->clk = clk_get(&pdev->dev, NULL);
drivers/mmc/host/mvsdio.c:      host->clk = clk_get(&pdev->dev, NULL);
drivers/mmc/host/pxamci.c:      host->clk = clk_get(&pdev->dev, NULL);
drivers/mmc/host/sdhci-spear.c: sdhci->clk = clk_get(&pdev->dev, NULL);
drivers/mmc/host/sdhci-tegra.c: clk = clk_get(mmc_dev(host->mmc), NULL);
drivers/mmc/host/mmci.c:        host->clk = clk_get(&dev->dev, NULL);
drivers/mtd/devices/spear_smi.c:        dev->clk = clk_get(&pdev->dev, NULL);
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: res->clock = clk_get(&this->pdev->dev, NULL);
drivers/mtd/nand/fsmc_nand.c:   host->clk = clk_get(&pdev->dev, NULL);
drivers/mtd/nand/nuc900_nand.c: nuc900_nand->clk = clk_get(&pdev->dev, NULL);
drivers/mtd/nand/orion_nand.c:  clk = clk_get(&pdev->dev, NULL);
drivers/mtd/nand/orion_nand.c:  clk = clk_get(&pdev->dev, NULL);
drivers/mtd/nand/pxa3xx_nand.c: info->clk = clk_get(&pdev->dev, NULL);
drivers/net/can/c_can/c_can_platform.c: clk = clk_get(&pdev->dev, NULL);
drivers/net/can/flexcan.c:              clk = clk_get(&pdev->dev, NULL);



 
> Most IPs in OMAP does have a fck and an ick so that does not seems nice
> or even consistent to me to do a clk_get(&pdev->dev, NULL) for "fck" and
> clk_get(&pdev->dev, "ick") for the ick.
> 

I completely agree from OMAP device perspective, but it may not be 
applicable for other architectures or devices, right?


> > And it seems wrong thing, as across platforms IP integration can be very
> > different and you can not expect to change the clock-tree table always.
> 
> FWIW, that table is done for that exact purpose. And we introduced the
> automatic "fck" alias creation mainly to make things easier, but that
> method is still very valid, and if the default alias is not good enough
> for the driver nothing should prevent you to create a new one.
> 
> > So the option here we have is,
> > 
> > 1. Instead of creating alias with "fck", create an alias only with dev
> > pointer, that means con_id = NULL.
> > I have already tested this and it works on AM33xx platform.
> 
> Do you mean assuming that the fck is always the clock with a NULL
> con_id? And any other clocks for that device will have thus to use a
> explicit name?
> 

Yes.

> > 2. Add a new flag inside hwmod or omap_device, so that it can be read at
> > omap_device layer and based on that we can decide whether to add con_id
> > or not while invoking clkdev_alloc().
> 
> hwmod is supposed to contain only HW related information. In that case
> it will be Linux driver dependent and not really HW dependent.
> That one is thus not really acceptable.
> 

Agreed, that was one of the options. What about omap_device???

> > This may be required to support legacy drivers which are not migrated to
> > runtime_pm and still calls clk_get() for both "fck" and "ick", so here
> > we need "fck" clk alias.
> 
> We can use "fck" even with runtime_pm. Just because sometime you need to
> get the clock rate of the main clock.
> 
> > Any comments or opinion on this? Based on the feedback I can create the
> > changes and submit it to the list.
> 
> Well, a #3 suggestion might be to enforce the usage of fck alias in the
> drivers instead of assuming that the "NULL" entry is the proper one.
> 

Can we??? Not sure whether we can really force this.

> And a #4 will be to create a extra entry in the clkdev like you have done.
> 

If nothing works out from above options, then this is the only option we 
have.
But the issue here is, how can we fix dev_id? With DT support I have to 
Really make use of "of_dev_auxdata" to fix dev id.


> For my point of view, the #4 seems to be the one that will minimize the
> overall change in the drivers and is probably the best one.
> 
> That being said, since the DT clock binding is merged now, the whole
> automatic alias creation might disappear as soon as we will have DT boot
> on all the platforms... OK, we are not really there still :-)
> 

Yeah, I know and understand. This is another issue we have. So we should not consider automatic aliases here.


Thanks,
Vaibhav

