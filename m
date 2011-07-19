From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 4/6] omap3: pmic: add API to get common SMPS regulators
Date: Tue, 19 Jul 2011 11:07:16 +0300
Message-ID: <1311062836.10230.30.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-5-git-send-email-t-kristo@ti.com> <20110718182347.GK25081@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab1GSIHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 04:07:24 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110718182347.GK25081@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-18 at 20:23 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Jul 18, 2011 at 08:35:20PM +0300, Tero Kristo wrote:
> > diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
> > index 5e83a5b..fde8467 100644
> > --- a/arch/arm/mach-omap2/twl-common.h
> > +++ b/arch/arm/mach-omap2/twl-common.h
> > @@ -25,6 +25,11 @@
> >  #define TWL_COMMON_REGULATOR_VPLL1	(1 << 4)
> >  #define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
> >  
> > +/* TWLxxxx SMPS regulators */
> > +#define SMPS_COMMON_REGULATOR_MPU	(1 << 0)
> > +#define SMPS_COMMON_REGULATOR_CORE	(1 << 1)
> > +#define SMPS_COMMON_REGULATOR_IVA	(1 << 2)
> > +#define SMPS_COMMON_REGULATOR_MPU_IVA	(1 << 3)
> >  
> >  struct twl4030_platform_data;
> >  
> > @@ -56,4 +61,13 @@ void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> >  void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
> >  			   u32 pdata_flags, u32 regulators_flags);
> >  
> > +void omap_pmic_get_smps_config(struct platform_device *smps_dev,
> > +				u32 smps_flags);
> > +
> > +static inline void omap3_pmic_get_smps_config(struct platform_device *smps_dev)
> > +{
> > +	omap_pmic_get_smps_config(smps_dev, SMPS_COMMON_REGULATOR_MPU_IVA |
> > +		SMPS_COMMON_REGULATOR_CORE);
> > +}
> 
> if these are specific to OMAP SoC, why do they come on twl-common.h
> header ?
> 

I was wondering about this myself too and was almost certain that
someone will ask about it. I decided to follow the easy path for this
version though for comments. Anyway, which would be the best option for
this:
1) just add them into twl-common
2) rename twl-common to something else and add these
3) add a completely new file + header for the smps regulator support


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

