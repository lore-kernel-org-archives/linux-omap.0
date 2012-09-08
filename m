From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to
 am335x-bone.dts
Date: Sat, 8 Sep 2012 06:38:21 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2A13B@DBDE01.ent.ti.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-5-git-send-email-anilkumar@ti.com>
 <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA1F1D7@DBDE01.ent.ti.com>
 <583C0877-1C4C-46B6-A5D0-BDD34D6BB7C8@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA1F3B0@DBDE01.ent.ti.com>
 <6C2AC14D-1CAC-4B93-910C-B7E52D3355FD@dominion.thruhere.net>
 <45D5714B-BB2C-49BB-8C5D-F69749EC324A@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA20AA6@DBDE01.ent.ti.com>
 <E6F8A61B-A1E9-4B69-88CD-4ECFDC779079@dominion.thruhere.net>
 <20120905142433.GG27758@beef>
 <532D5EFF-8D0C-48E4-B35D-40BE89D5CD15@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32936 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2IHGig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Sep 2012 02:38:36 -0400
In-Reply-To: <532D5EFF-8D0C-48E4-B35D-40BE89D5CD15@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "Porter, Matt" <mporter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com Brown" <broonie@opensource.wolfsonmicro.com>

On Wed, Sep 05, 2012 at 19:59:54, Koen Kooi wrote:
> 
> Op 5 sep. 2012, om 16:24 heeft Matt Porter <mporter@ti.com> het volgende geschreven:
> 
> > On Wed, Sep 05, 2012 at 03:29:30PM +0200, Koen Kooi wrote:
> >> 
> >> Op 28 aug. 2012, om 07:34 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
> >> 
> >>> Hi Koen,
> >>> 
> >>> On Fri, Aug 24, 2012 at 13:32:17, Koen Kooi wrote:
> >>>> 
> >>>> Op 24 aug. 2012, om 09:56 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:
> >>>> 
> >>>>> 
> >>>>> Op 24 aug. 2012, om 09:26 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
> >>>>> 
> >>>>>> Hi Koen,
> >>>>>> 
> >>>>>> On Fri, Aug 24, 2012 at 11:58:34, Koen Kooi wrote:
> >>>>>>> 
> >>>>>>> Op 24 aug. 2012, om 07:50 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
> >>>>>>> 
> >>>>>>>> Hi Koen,
> >>>>>>>> 
> >>>>>>>> On Thu, Aug 23, 2012 at 19:43:48, Koen Kooi wrote:
> >>>>>>>>> 
> >>>>>>>>> Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
> >>>>>>>>> 
> >>>>>>>>>> Add tps65217 regulator device tree data to AM335x-Bone by adding
> >>>>>>>>>> regulator consumers with tightened constraints and regulator-name.
> >>>>>>>>>> TPS65217 regulator handle can be obtained by using this regulator
> >>>>>>>>>> name.
> >>>>>>>>>> 
> >>>>>>>>>> This patch also add I2C node with I2C frequency and tps65217 PMIC
> >>>>>>>>>> I2C slave address.
> >>>>>>>>>> 
> >>>>>>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >>>>>>>>> 
> >>>>>>>>> I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?
> >>>>>>>> 
> >>>>>>>> Use this repo to test on beaglebone
> >>>>>>>> https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging-pinctrl
> >>>>>>>> 
> >>>>>>>> This wiki talks about how to build and use?
> >>>>>>>> https://github.com/hvaibhav/am335x-linux/wiki/How-To-Use-Upstream-Tree
> >>>>>>>> 
> >>>>>>>> Note: Enable tps65217 regulator in kernel config.
> >>>>>>> 
> >>>>>>> I used that repo and as a seperate test I rebased that to latest mainline, same thing: as soon as I turn on the TPS in the .config it crashes on boot. Is the pinctrl repo the *exact* repo you used to test the patches on beaglebone?
> >>>>>> 
> >>>>>> I tested on latest mainline after merging to
> >>>>>> am335x-upstream-staging-pinctrl (voltage also changing)
> >>>>>> 
> >>>>>> Can you share your .config and uImage?
> >>>>> 
> >>>>> Config: https://github.com/beagleboard/kernel/blob/beaglebone-3.6/patches/configs/beaglebone
> >>>>> 
> >>>>>> My config details:- (After merge)
> >>>>>> 1. omap2plus_defconfig
> >>>>>> 2. Enable tps65217 MFD driver
> >>>>>> 3. Enable tps65217 regulator driver
> >>>>> 
> >>>>> 
> >>>>> I rebased onto latest mainline and refreshed the base patches from Vaibhav and I now get: 
> >>>>> 
> >>>>> [    0.246796] tps65217 0-0024: TPS65217 ID 0xf version 1.1
> >>>>> 
> >>>>> So it boots! I don't know what made it break before, but it's working now :)
> >>>> 
> >>>> *sigh* I'm an idiot:
> >>>> 
> >>>> root@beaglebone:~# uname -a
> >>>> Linux beaglebone 3.6.0-rc3-00103-gfd02083 #86 SMP Fri Aug 24 09:45:54 CEST 2012 armv7l GNU/Linux
> >>>> root@beaglebone:~# zcat /proc/config.gz | grep 217
> >>>> CONFIG_MFD_TPS65217=y
> >>>> # CONFIG_REGULATOR_TPS65217 is not set
> >>>> 
> >>>> Will retry with regulator driver actually turned on in a bit.
> >>> 
> >>> Is it working after enabling the regulator?
> >> 
> >> It took me a while to get back to this problem, but it still isn't working for me. I did manage to get more info on the error:
> >> 
> >> root@bone-mainline:~# insmod tps65217-regulator.ko
> >> [   32.754419] Unable to handle kernel NULL pointer dereference at virtual address 000000c8
> >> [   32.763087] pgd = cea60000
> >> [   32.765969] [000000c8] *pgd=8fbed831, *pte=00000000, *ppte=00000000
> >> [   32.772617] Internal error: Oops: 17 [#1] SMP THUMB2
> >> [   32.777827] Modules linked in: tps65217_regulator(+) ip_tables x_tables snd_soc_omap snd_soc_core regmap_spi snd_pcm snd_timer snd soundcore snd_page_alloc ipv6
> >> [   32.792976] CPU: 0    Not tainted  (3.6.0-rc4 #109)
> >> [   32.798106] PC is at regmap_read+0x8/0x38
> >> [   32.802315] LR is at regulator_get_voltage_sel_regmap+0x15/0x38
> > 
> > I just got to this same point last night as I needed this working to
> > test omap_hsmmc with edma dmaengine...
> > 
> > The problem is that the tps65217-regulator driver is handing the wrong
> > device to regulator_register() and it contains a null regmap. This patch
> > passes in the the parent dev to fix it. Maybe I missed another patch
> > that addresses this in a different way, such as the regulator devices
> > being stuffed with the regmap devres?
> > 
> > -Matt
> > 
> > From 40d118bebc5eaf2a8df4f8b5e113b892a3210f96 Mon Sep 17 00:00:00 2001
> > From: Matt Porter <mporter@ti.com>
> > Date: Wed, 5 Sep 2012 10:09:50 -0400
> > Subject: [PATCH] regulator: tps65217: fix crash during registration
> > 
> > The struct device for each platform device bound to this
> > driver is a child to the parent mfd device. The parent device
> > is the one that actually contains the regmap devres so fix the
> > null pointer dereference during the first regmap access in
> > registration by passing in the parent device.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> > drivers/regulator/tps65217-regulator.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
> > index 6caa222..af4916c 100644
> > --- a/drivers/regulator/tps65217-regulator.c
> > +++ b/drivers/regulator/tps65217-regulator.c
> > @@ -292,7 +292,7 @@ static int __devinit tps65217_regulator_probe(struct platform_device *pdev)
> > 	tps = dev_to_tps65217(pdev->dev.parent);
> > 	tps->info[pdev->id] = info;
> > 
> > -	config.dev = &pdev->dev;
> > +	config.dev = pdev->dev.parent;
> > 	config.of_node = pdev->dev.of_node;
> > 	config.init_data = pdev->dev.platform_data;
> > 	config.driver_data = tps;
> > -- 
> > 1.7.9.5
> 
> That patch fixes it for me:

This patch is not required, added a new feature to core.c file to address
this. https://lkml.org/lkml/2012/9/7/390

Thanks
AnilKumar
