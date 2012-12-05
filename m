From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Wed, 5 Dec 2012 09:19:50 -0800
Message-ID: <20121205171950.GF21682@atomide.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
 <1354204892-22762-5-git-send-email-zonque@gmail.com>
 <50B7BE9C.6040506@ti.com>
 <50B7C677.7090504@ti.com>
 <50B7C8BE.7050002@gmail.com>
 <50B7CCB1.6000506@ti.com>
 <50BF4670.8070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19238 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753687Ab2LERT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 12:19:57 -0500
Content-Disposition: inline
In-Reply-To: <50BF4670.8070602@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, avinashphilip@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Daniel Mack <zonque@gmail.com> [121205 05:07]:
> On 29.11.2012 21:59, Jon Hunter wrote:
> > On 11/29/2012 02:42 PM, Daniel Mack wrote:
> >> On 29.11.2012 21:32, Jon Hunter wrote:
> >>>
> >>> On 11/29/2012 01:59 PM, Jon Hunter wrote:
> >>>>
> >>>> On 11/29/2012 10:01 AM, Daniel Mack wrote:
> >>>>> The am33xx is capable of handling bch error correction modes, so
> >>>>> enable that feature in the driver.
> >>>>>
> >>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >>>>> ---
> >>>>>  arch/arm/mach-omap2/gpmc-nand.c | 9 +++++----
> >>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> >>>>> index f9f23a2..c8a72ba 100644
> >>>>> --- a/arch/arm/mach-omap2/gpmc-nand.c
> >>>>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> >>>>> @@ -92,17 +92,18 @@ static int omap2_nand_gpmc_retime(
> >>>>>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
> >>>>>  {
> >>>>>  	/* support only OMAP3 class */
> >>>>> -	if (!cpu_is_omap34xx()) {
> >>>>> +	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
> >>>>>  		pr_err("BCH ecc is not supported on this CPU\n");
> >>>>>  		return 0;
> >>>>>  	}
> >>>>>  
> >>>>>  	/*
> >>>>> -	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
> >>>>> -	 * Other chips may be added if confirmed to work.
> >>>>> +	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
> >>>>> +	 * and AM33xx derivates. Other chips may be added if confirmed to work.
> >>>>>  	 */
> >>>>>  	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
> >>>>> -	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
> >>>>> +	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
> >>>>> +	    (!soc_is_am33xx())) {
> >>>>>  		pr_err("BCH 4-bit mode is not supported on this CPU\n");
> >>>>>  		return 0;
> >>>>>  	}
> >>>>
> >>>> Sorry I should have seen this earlier. Ideally, this type of thing
> >>>> should be reflected by the device-tree/platform-data and we should get
> >>>> away from these cpu_is_xxxx macros for hardware features (where we can).
> >>>> Furthermore, we need to avoid including plat-omap/gpmc.h in drivers for
> >>>> the single zImage work (I see the omap nand driver is including gpmc.h).
> >>>>
> >>>> Tony, should this be addressed now or can we live this for the minute
> >>>> and fix-up later?
> >>>
> >>> Actually, I see that you do read the ecc mode from DT, so is this really
> >>> needed? It would be good to eliminate this.
> >>
> >> The ecc mode is read from DT, right. But the gpmc bindings can be used
> >> for many OMAP derivates in the future, and this check is there to make
> >> sure the configured settings are supported by the hardware after all,
> >> just like if the ecc mode would have been passed as static platform
> >> data. So what is it exactly that you want to get rid of?
> > 
> > The above function.
> > 
> > If there is a hardware bug that prevents us from using the hw-ecc mode
> > that is supported (which is the case for omap3630 es1.0), then we should
> > have a GPMC_ERRATA_xxx flag somewhere to indicate this and these errata
> > flags should be populated at probe.
> > 
> >> I agree though that we could solve this with via the of_device_id's data
> >> pointer of the matching driver. But as you said yourself, this can well
> >> be done later, and the problem here is that we still need the
> >> cpu_is_xxx() macros for older platforms, right?
> > 
> > Yes, but we cannot/shouldn't use these cpu_is_xxx macros from within
> > driver code. Ok, here we can calling a platform function that is calling
> > the macro, but for single zImage we cannot do that either. We cannot
> > include platform headers in drivers for single zImage. We have to get
> > away from that. Therefore, such information needs to be passed by
> > platform data, device tree, etc.
> > 
> > I will let Tony decide on how he wants us to handle this.
> 
> Any idea yet about this detail? The other small Documentation changes
> you brought up are fixed in my tree and ready for resubmission.

The plat/cpu.h file will disappear after the merge window, which means
omap2+ related drivers cannot use cpu_is_omap macros.

For legacy booting systems, this flag should be just passed in the
platform_data from the platform init code. Then device tree can
deal with it based on the compatible flag.

Regards,

Tony
