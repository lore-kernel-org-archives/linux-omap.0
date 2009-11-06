From: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Subject: RE: [PATCH] AM35xx: Clock table updates for AM3505/17
Date: Fri, 6 Nov 2009 14:52:29 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB92EEBC@dbde02.ent.ti.com>
References: <1257417540-21120-1-git-send-email-ranjithl@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AFCC9D8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZKFJWa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 04:22:30 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AFCC9D8@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>



> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, November 05, 2009 9:55 PM
> To: Lohithakshan, Ranjith; linux-omap@vger.kernel.org
> Cc: Lohithakshan, Ranjith
> Subject: RE: [PATCH] AM35xx: Clock table updates for AM3505/17
> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Ranjith Lohithakshan
> > Sent: Thursday, November 05, 2009 2:39 AM
> [...]
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> > omap2/clock34xx.c
> > index c258f87..9ac5c0e 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -93,140 +93,143 @@ struct omap_clk {
> >  #define CK_343X		(1 << 0)
> >  #define CK_3430ES1	(1 << 1)
> >  #define CK_3430ES2	(1 << 2)
> > +#define CK_3517 	(1 << 3)
> > +#define CK_3505 	(1 << 4)
> > +#define CK_35XX 	(CK_3517 | CK_3505)
> >
> >  static struct omap_clk omap34xx_clks[] = {
> > -	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
> > -	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
> > -	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
> > -	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
> > -	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
> > -	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X),
> > -	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
> > -	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_343X),
> > -	CLK(NULL,	"sys_ck",	&sys_ck,	CK_343X),
> > -	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_343X),
> > -	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_343X),
> > -	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_343X),
> > -	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_343X),
> > -	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_343X),
> > -	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
> > +	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X | CK_35XX),
> > +	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X | CK_35XX),
> > +	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X | CK_35XX),
> > +	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2 | CK_35XX),
> > +	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X | CK_35XX),
> > +	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X | CK_35XX),
> [...]
> Could we have CK_3XXX? I mean this would probably happen when 36/37xx gets
> introduced also.. does that make sense?
> 
Yes, it would help to have a CK_3XXX defined to cover all common OMAP3 clocks. 
The tables would look simpler going forward.

Paul, what do you think?
