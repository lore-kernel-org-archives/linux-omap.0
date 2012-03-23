From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Fri, 23 Mar 2012 10:20:38 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317A6A83@DBDE01.ent.ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6C445A.3040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38324 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab2CWKUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 06:20:47 -0400
In-Reply-To: <4F6C445A.3040103@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Benoit,

On Fri, Mar 23, 2012 at 15:07:30, Cousson, Benoit wrote:
> > Final destination aimed for this driver is MFD.
> 
> Why? Are you sure this is appropriate? This is not really a 
> multifunction device but rather a bus device that can manage multiple 
> kind of devices.


Agree, this not an MFD, but can we call this a bus?, as there is
nothing like GPMC protocol. We considered it logically as MFD &
proceeded and there was a similar attempt for davinci EMIF [1,2].
   

> >   arch/arm/mach-omap2/gpmc.c             | 1083 +++++++++++++++++++-------------
> 
> You should probably find the proper location first, move the code and 
> convert to driver.
> I will let Tony comment but this is the strategy today for all this 
> pseudo driver that should not be in OMAP arch directory anymore.

Please let me know whether you have any suggestions on where GPMC driver
should live.

> > +		printk(KERN_DEBUG "GPMC CS%d: %-10s* %3d ns, %3d ticks>= %d\n",
> 
> Nit, but since you are cleaning extensively this code, you should use 
> pr_ macros instead or even dev_ macros since you do have a real driver 
> now with real devices now.

Sure, this was overlooked

> > +struct gpmc_cs_config {
> > +	u32 config1;
> > +	u32 config2;
> > +	u32 config3;
> > +	u32 config4;
> > +	u32 config5;
> > +	u32 config6;
> > +	u32 config7;
> > +	int is_valid;
> > +};
> 
> OK, so this code was just moved and not removed. Becasue of these big 
> code move, the patch is not super readable. We cannot really see what 
> part is new and what was changed.
> 
> Maybe you should try to split that in sevarl patches or minized the move.

Yes, I was really in two minds before the coding started. Lot of code in
this patch has been moved from one place to other, this was done to put
codes that handle similar things together, so that trees can be made
visible easily in the forest. And once the patch is applied, as similar
sections are together, it may be easy to make further changes

If an initial patch just to rearrange the code to have similar section
together & then new changes in a another patch, would that be fine?

> +static int __init gpmc_clk_init(void)
> > +{
> > +	char *ck = NULL;
> > +
> > +	if (cpu_is_omap24xx())
> > +		ck = "core_l3_ck";
> > +	else if (cpu_is_omap34xx())
> > +		ck = "gpmc_fck";
> > +	else if (cpu_is_omap44xx())
> > +		ck = "gpmc_ck";
> 
> Please don't do that anymore. The CLKDEV array is done to create alias 
> and avoid this kind of hacks. Moreover you should rely on hwmod for 
> device creation and thus main clock alias will already be populated for 
> free.

There are not added, they are existing code, result of rearranging the
code. These sections were given not given much importance as these won't
go into driver. But noted the point you are making.

Thanks for your quick comments.

Regards
Afzal

[1] http://lkml.indiana.edu/hypermail/linux/kernel/1202.2/03228.html
[2] http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-arm-davinci-configure-davinci-aemif-chipselects-through-OF-tt7059739.html#none

