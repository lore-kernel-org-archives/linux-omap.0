From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 05/18] ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__
 macros in header files
Date: Wed, 9 Jan 2013 05:31:45 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD026@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-6-git-send-email-vaibhav.bedia@ti.com>
 <50EC34D8.5010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48635 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab3AIFb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:31:56 -0500
In-Reply-To: <50EC34D8.5010105@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Tue, Jan 08, 2013 at 20:31:44, Shilimkar, Santosh wrote:
[...]
> > +#endif /* ASSEMBLER */
> > +
> Drop that extra line.

Ok.

> >   #endif
> > diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
> > index 3f25c56..2f2eaa0 100644
> > --- a/arch/arm/mach-omap2/prm33xx.h
> > +++ b/arch/arm/mach-omap2/prm33xx.h
> > @@ -117,6 +117,7 @@
> >   #define AM33XX_PM_CEFUSE_PWRSTST_OFFSET		0x0004
> >   #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
> >
> > +#ifndef __ASSEMBLER__
> >   extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
> >   extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
> >   extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
> > @@ -126,4 +127,6 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
> >   extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
> >   extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
> >   		u16 rstctrl_offs, u16 rstst_offs);
> > +#endif /* ASSEMBLER */
> > +
> ditto
> 

Ok.
> Otherwise looks fine.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 

Thanks,
Vaibhav
