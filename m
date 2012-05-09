From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 4/4] ARM: OMAP2+: CLEANUP: Add new config option for
 different DPLL features
Date: Wed, 9 May 2012 09:06:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1BF47@DBDE01.ent.ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-5-git-send-email-hvaibhav@ti.com> <87ehqui8yp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41787 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2EIJIB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 05:08:01 -0400
In-Reply-To: <87ehqui8yp.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 09, 2012 at 04:20:06, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > This patch cleans up dpll_data structure, making structure
> > fields definition based on feature availability for given SoC,
> > managed using Kconfig rules.
> >
> > SOC_HAS_OMAP3_DPLL_IDLE: idle state
> > SOC_HAS_OMAP3_DPLL_RECAL: recalibration capability
> > SOC_HAS_OMAP3_DPLL_DCO_SEL: dco selection
> > SOC_HAS_OMAP3_DPLL_SDDIV: sigma-delta div factor
> > SOC_HAS_OMAP3_DPLL_FREQSEL: frequency selection
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> Paul is the one to make the call here, but personally I'd much prefer to
> just see the existing ifdefs go away[1] instead of adding a bunch of new
> ones.  
> 
> Yes, doing so would add a few fields to a struct that may be unused, but
> IMO, the improvement in readabilitly and maintainability is improved.
> 
> Note that the users of these fields are not changed and are still based
> on Kconfig/Makefile values as before (e.g. CONFIG_ARCH_OMAP3), so to me
> this creates another layer of obfuscation.
> 

This will bring in difference on omap2 alone build OR omap4, am33xx alone 
builds.
But again, how much it makes sense, and how much benefits we bring-in by 
adding config options for every bit-fields (like this) needs to be looked at.
And that's the reason, I submitted first version as a RFC.


> 
> [1]
> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index d0ef57c..656b986 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -156,7 +156,6 @@ struct dpll_data {
>  	u8			min_divider;
>  	u16			max_divider;
>  	u8			modes;
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  	void __iomem		*autoidle_reg;
>  	void __iomem		*idlest_reg;
>  	u32			autoidle_mask;
> @@ -167,7 +166,6 @@ struct dpll_data {
>  	u8			auto_recal_bit;
>  	u8			recal_en_bit;
>  	u8			recal_st_bit;
> -#  endif
>  	u8			flags;
>  };
>  

Honestly, I wanted to propose this first. 
I am OK, as long as we all agree on this.

Paul, can you conform on this?

Thanks,
Vaibhav
