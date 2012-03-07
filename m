From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer
 to prcm-common header
Date: Wed, 7 Mar 2012 09:49:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83180A024@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-3-git-send-email-hvaibhav@ti.com>
 <20120305225640.GK12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab2CGJtx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 04:49:53 -0500
In-Reply-To: <20120305225640.GK12083@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Mar 06, 2012 at 04:26:40, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120119 06:01]:
> > Add missing idle_st bit for 32k-sync timer into the prcm-common
> > header file, required for hwmod data.
> 
> These should be queued by Paul when the related hwmod changes
> are done.
> 

Paul,

Can you queue this up into your next-branch?

Thanks,
Vaibhav


> Regards,
> 
> Tony
>  
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/prcm-common.h |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> > index 5aa5435..29955d5 100644
> > --- a/arch/arm/mach-omap2/prcm-common.h
> > +++ b/arch/arm/mach-omap2/prcm-common.h
> > @@ -177,6 +177,8 @@
> >  /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
> >  #define OMAP24XX_ST_GPIOS_SHIFT				2
> >  #define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
> > +#define OMAP24XX_ST_32KSYNC_SHIFT			1
> > +#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
> >  #define OMAP24XX_ST_GPT1_SHIFT				0
> >  #define OMAP24XX_ST_GPT1_MASK				(1 << 0)
> >  
> > @@ -307,6 +309,8 @@
> >  #define OMAP3430_ST_SR1_MASK				(1 << 6)
> >  #define OMAP3430_ST_GPIO1_SHIFT				3
> >  #define OMAP3430_ST_GPIO1_MASK				(1 << 3)
> > +#define OMAP3430_ST_32KSYNC_SHIFT			2
> > +#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
> >  #define OMAP3430_ST_GPT12_SHIFT				1
> >  #define OMAP3430_ST_GPT12_MASK				(1 << 1)
> >  #define OMAP3430_ST_GPT1_SHIFT				0
> > -- 
> > 1.7.0.4
> > 
> 

