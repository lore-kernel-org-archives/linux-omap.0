From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH] OMAP: Exporting functions doing common
	register access
Date: Mon, 11 Jan 2010 10:11:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D703E@dbde02.ent.ti.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
	<alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com>
	<20091118163314.d0325283.jhnikula@gmail.com>
	<alpine.DEB.2.00.0911181220560.9248@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031E0A39D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E0A39D8@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Walmsley <paul@pwsan.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Lohithakshan,
	Ranjith" <ranjithl@ti.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aggarwal, Anuj
> Sent: Thursday, January 07, 2010 7:40 PM
> To: Paul Walmsley; Jarkko Nikula
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org; Lohithakshan,
> Ranjith
> Subject: RE: [PATCH] OMAP: Exporting functions doing common register
> access
> 
> > > > In the interim, I would suggest that you remove the the clock source
> > and
> > > > receiver source change functions from omap-mcbsp.c, split them into
> > OMAP1
> > > > and OMAP2/3 variants, and place them into arch/arm/mach-
> omap*/mcbsp.c.
> > > > Expand struct omap_mcbsp_ops to add function pointers to those
> > functions.
> > > > Call those from soc/omap-mcbsp.c via mcbsp->pdata->ops. That way you
> > won't
> > > > need those exports.
> > > >
> > > Paul: What's your opinnion, would it be possible or would it be wise
> to
> > > handle these McBSP clock route setups with the clock framework
> instead?
> > >
> > > Functions omap_mcbsp_dai_set_clks_src and omap_mcbsp_dai_set_rcvr_src
> > > are basically just setting up the input clock for McBSP SRG or McBSP1
> > > receiver.
> >
> > Sure.  There already should be some support for it in clock34xx.h, but I
> > doubt anyone's tested it:
> >
> > static struct clk mcbsp1_fck = {
> >         .name           = "mcbsp_fck",
> >         .ops            = &clkops_omap2_dflt_wait,
> >         .id             = 1,
> >         .init           = &omap2_init_clksel_parent,
> >         .enable_reg     = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
> >         .enable_bit     = OMAP3430_EN_MCBSP1_SHIFT,
> >         .clksel_reg     = OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
> >         .clksel_mask    = OMAP2_MCBSP1_CLKS_MASK,
> >         .clksel         = mcbsp_15_clksel,
> >         .clkdm_name     = "core_l4_clkdm",
> >         .recalc         = &omap2_clksel_recalc,
> > };
> >
> > etc.  Some similar entries would need to be added to the clock24xx.h
> file.
> [Aggarwal, Anuj] One problem which I found in trying the above discussed
> approach is that I am not able to get mcbsp clock handles in omap-mcbsp.c
> file. To call clk_set_parent() with the new parent clock as "mcbsp_clks"
> (in case of an external clock), I need the mcbsp_fck clock handle. But
> this
> handle is not shared with the omap_mcbsp_dai[].
> 
> What should be the right method of getting this handle in
> omap_mcbsp_dai_set_dai_sysclk(), in case I understood the concept
> properly.
> Basically, we want to get rid of the low level stuff in this function
> and instead use standard clock framework APIs?

Paul / Jarkko,

Any comments/pointers please?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
