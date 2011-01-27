From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [RFC 1/3] OMAP: clocks: Use clk names instead of clk pointers
Date: Thu, 27 Jan 2011 08:12:05 +0530
Message-ID: <d68f40fdf6a6cb15bdd5b2c87b2e87ca@mail.gmail.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com><1295446466-23655-2-git-send-email-rnayak@ti.com><87ei826jl3.fsf@ti.com><9a93b37118b41d65ee482023254393e8@mail.gmail.com>
 <874o8x2cxy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45059 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752504Ab1A0CmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jan 2011 21:42:09 -0500
Received: by fxm16 with SMTP id 16so1666581fxm.41
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 18:42:06 -0800 (PST)
In-Reply-To: <874o8x2cxy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, January 25, 2011 9:28 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com
> Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk
pointers
>
> Hi Rajendra,
>
> Rajendra Nayak <rnayak@ti.com> writes:
>
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@ti.com]
> >> Sent: Tuesday, January 25, 2011 3:38 AM
> >> To: Rajendra Nayak
> >> Cc: linux-omap@vger.kernel.org; paul@pwsan.com
> >> Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk
> > pointers
> >>
> >> Rajendra Nayak <rnayak@ti.com> writes:
> >>
> >> > There are various instances of clk pointers being
> >> > embedded within structures in the clock framework
> >> > to refer to clk parents, reference clocks, bypass
> >> > clocks etc.
> >> > The right way to reference these is by their name
> >> > and not by embedding direct pointers to these clks.
> >> >
> >> > Hence make provision to be able to provide clock
> >> > names to refer to parents and bypass/ref clks and
> >> > populate the clk pointers at runtime.
> >> >
> >> > This requires the const qualifier to be dropped for
> >> > struct clksel within struct clk and hence needs
> >> > clksel struct definitions to be changed in all
> >> > clock*_data.c files.
> >> >
> >> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >>
> >> I think the changelog needs a little more description about when the
> >> names are used instead of the pointers.  It looks like the names are
> >> only used at init time to select the right pointers, but the rest of
the
> >> framework continues to use pointers as before, right?  This isnt'
very
> >> clear from the changelog.
> >
> > Right, the basic idea was to prevent the binding of clk pointers at
> > compile time and instead do it at runtime. The rest of the code which
> > uses pointers would still go ahead and use them.
> > This is similar to what happens in other frameworks like hwmod
> > (which has the main_clk name populated and runtime maps to
> > the relevant clk pointer) or clock framework itself (to identify
> > the clockdomains associated with the clks)
> >
> > Also the patch leaves all the existing clk pointer associations at
> > compile time as is and only uses this reference by name for a
> > few nodes that get added in the later patches in the series.
> >
> > If the approach seems ok, then a patch to replace all the
> > existing pointer based referencing with the name based
> > referencing can also be pushed.
>
> The approach seems OK to me.  I just think the changelog needs to be a
> bit clearer since on first read, it sounded (to me) like names were
> going to replace pointers for more than just init time.

I will update the changelog with the additional details.

Thanks,
Rajendra

>
> Kevin
>
> > Regards,
> > Rajendra
> >
> >>
> >> Kevin
> >>
> >>
> >> > ---
> >> >  arch/arm/mach-omap2/clock2420_data.c    |   86 +++++++++---------
> >> >  arch/arm/mach-omap2/clock2430_data.c    |   88
++++++++++----------
> >> >  arch/arm/mach-omap2/clock3xxx_data.c    |  144
> > +++++++++++++++---------------
> >> >  arch/arm/mach-omap2/clock44xx_data.c    |  136
> > +++++++++++++++---------------
> >> >  arch/arm/plat-omap/clock.c              |   48 +++++++++--
> >> >  arch/arm/plat-omap/include/plat/clock.h |   11 ++-
> >> >  6 files changed, 277 insertions(+), 236 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/clock2420_data.c
> > b/arch/arm/mach-omap2/clock2420_data.c
> >> > index 0a992bc..5662e51 100644
> >> > --- a/arch/arm/mach-omap2/clock2420_data.c
> >> > +++ b/arch/arm/mach-omap2/clock2420_data.c
> >> > @@ -161,17 +161,17 @@ static struct clk apll54_ck = {
> >> >
> >> >  /* func_54m_ck */
> >> >
> >> > -static const struct clksel_rate func_54m_apll54_rates[] = {
> >> > +static struct clksel_rate func_54m_apll54_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate func_54m_alt_rates[] = {
> >> > +static struct clksel_rate func_54m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_54m_clksel[] = {
> >> > +static struct clksel func_54m_clksel[] = {
> >> >  	{ .parent = &apll54_ck, .rates = func_54m_apll54_rates, },
> >> >  	{ .parent = &alt_ck,	.rates = func_54m_alt_rates, },
> >> >  	{ .parent = NULL },
> >> > @@ -207,17 +207,17 @@ static struct clk func_96m_ck = {
> >> >
> >> >  /* func_48m_ck */
> >> >
> >> > -static const struct clksel_rate func_48m_apll96_rates[] = {
> >> > +static struct clksel_rate func_48m_apll96_rates[] = {
> >> >  	{ .div = 2, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate func_48m_alt_rates[] = {
> >> > +static struct clksel_rate func_48m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_48m_clksel[] = {
> >> > +static struct clksel func_48m_clksel[] = {
> >> >  	{ .parent = &apll96_ck,	.rates = func_48m_apll96_rates },
> >> >  	{ .parent = &alt_ck, .rates = func_48m_alt_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -262,27 +262,27 @@ static struct clk wdt1_osc_ck = {
> >> >   * harmless since access to those clocks are gated by the struct
clk
> >> >   * flags fields, which mark them as 2420-only.
> >> >   */
> >> > -static const struct clksel_rate common_clkout_src_core_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_core_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_sys_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_sys_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_96m_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_96m_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_54m_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_54m_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel common_clkout_src_clksel[] = {
> >> > +static struct clksel common_clkout_src_clksel[] = {
> >> >  	{ .parent = &core_ck,	  .rates =
common_clkout_src_core_rates },
> >> >  	{ .parent = &sys_ck,	  .rates =
common_clkout_src_sys_rates },
> >> >  	{ .parent = &func_96m_ck, .rates =
common_clkout_src_96m_rates },
> >> > @@ -306,7 +306,7 @@ static struct clk sys_clkout_src = {
> >> >  	.set_rate	= &omap2_clksel_set_rate
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_rates[] = {
> >> > +static struct clksel_rate common_clkout_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
> >> > @@ -315,7 +315,7 @@ static const struct clksel_rate
> > common_clkout_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel sys_clkout_clksel[] = {
> >> > +static struct clksel sys_clkout_clksel[] = {
> >> >  	{ .parent = &sys_clkout_src, .rates = common_clkout_rates
},
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -350,7 +350,7 @@ static struct clk sys_clkout2_src = {
> >> >  	.set_rate	= &omap2_clksel_set_rate
> >> >  };
> >> >
> >> > -static const struct clksel sys_clkout2_clksel[] = {
> >> > +static struct clksel sys_clkout2_clksel[] = {
> >> >  	{ .parent = &sys_clkout2_src, .rates = common_clkout_rates
},
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -390,7 +390,7 @@ static struct clk emul_ck = {
> >> >   * - Base divider comes from: CM_CLKSEL_MPU
> >> >   *
> >> >   */
> >> > -static const struct clksel_rate mpu_core_rates[] = {
> >> > +static struct clksel_rate mpu_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
> >> > @@ -399,7 +399,7 @@ static const struct clksel_rate
mpu_core_rates[] =
> > {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel mpu_clksel[] = {
> >> > +static struct clksel mpu_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = mpu_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -426,7 +426,7 @@ static struct clk mpu_ck = {	/* Control cpu */
> >> >   * controls. The other branch gets further divided by 2 then
possibly
> >> >   * routed into a synchronizer and out of clocks abc.
> >> >   */
> >> > -static const struct clksel_rate dsp_fck_core_rates[] = {
> >> > +static struct clksel_rate dsp_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -437,7 +437,7 @@ static const struct clksel_rate
> > dsp_fck_core_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel dsp_fck_clksel[] = {
> >> > +static struct clksel dsp_fck_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = dsp_fck_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -456,13 +456,13 @@ static struct clk dsp_fck = {
> >> >  };
> >> >
> >> >  /* DSP interface clock */
> >> > -static const struct clksel_rate dsp_irate_ick_rates[] = {
> >> > +static struct clksel_rate dsp_irate_ick_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel dsp_irate_ick_clksel[] = {
> >> > +static struct clksel dsp_irate_ick_clksel[] = {
> >> >  	{ .parent = &dsp_fck, .rates = dsp_irate_ick_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -536,7 +536,7 @@ static struct clk iva1_mpu_int_ifck = {
> >> >   * may very well need notification when the clock changes.
Currently
> > for low
> >> >   * operating points, these are taken care of in sleep.S.
> >> >   */
> >> > -static const struct clksel_rate core_l3_core_rates[] = {
> >> > +static struct clksel_rate core_l3_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
> >> > @@ -547,7 +547,7 @@ static const struct clksel_rate
> > core_l3_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel core_l3_clksel[] = {
> >> > +static struct clksel core_l3_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = core_l3_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -564,14 +564,14 @@ static struct clk core_l3_ck = {	/* Used
> > for ick and fck, interconnect */
> >> >  };
> >> >
> >> >  /* usb_l4_ick */
> >> > -static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
> >> > +static struct clksel_rate usb_l4_ick_core_l3_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel usb_l4_ick_clksel[] = {
> >> > +static struct clksel usb_l4_ick_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = usb_l4_ick_core_l3_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -597,13 +597,13 @@ static struct clk usb_l4_ick = {	/* FS-USB
> > interface clock */
> >> >   * functional clocks.	Fixed APLL functional source clocks are
> > managed in
> >> >   * this domain.
> >> >   */
> >> > -static const struct clksel_rate l4_core_l3_rates[] = {
> >> > +static struct clksel_rate l4_core_l3_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel l4_clksel[] = {
> >> > +static struct clksel l4_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = l4_core_l3_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -627,7 +627,7 @@ static struct clk l4_ck = {		/* used
> > both as an ick and fck */
> >> >   *
> >> >   * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
> >> >   */
> >> > -static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
> >> > +static struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -637,7 +637,7 @@ static const struct clksel_rate
> > ssi_ssr_sst_fck_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel ssi_ssr_sst_fck_clksel[] = {
> >> > +static struct clksel ssi_ssr_sst_fck_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = ssi_ssr_sst_fck_core_rates
},
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -683,7 +683,7 @@ static struct clk ssi_l4_ick = {
> >> >   */
> >> >
> >> >  /* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck
*/
> >> > -static const struct clksel gfx_fck_clksel[] = {
> >> > +static struct clksel gfx_fck_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = gfx_l3_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -736,12 +736,12 @@ static struct clk gfx_ick = {
> >> >   */
> >> >  /* XXX Add RATE_NOT_VALIDATED */
> >> >
> >> > -static const struct clksel_rate dss1_fck_sys_rates[] = {
> >> > +static struct clksel_rate dss1_fck_sys_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss1_fck_core_rates[] = {
> >> > +static struct clksel_rate dss1_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -755,7 +755,7 @@ static const struct clksel_rate
> > dss1_fck_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel dss1_fck_clksel[] = {
> >> > +static struct clksel dss1_fck_clksel[] = {
> >> >  	{ .parent = &sys_ck,  .rates = dss1_fck_sys_rates },
> >> >  	{ .parent = &core_ck, .rates = dss1_fck_core_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -785,17 +785,17 @@ static struct clk dss1_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss2_fck_sys_rates[] = {
> >> > +static struct clksel_rate dss2_fck_sys_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss2_fck_48m_rates[] = {
> >> > +static struct clksel_rate dss2_fck_48m_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel dss2_fck_clksel[] = {
> >> > +static struct clksel dss2_fck_clksel[] = {
> >> >  	{ .parent = &sys_ck,	  .rates = dss2_fck_sys_rates },
> >> >  	{ .parent = &func_48m_ck, .rates = dss2_fck_48m_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -831,12 +831,12 @@ static struct clk dss_54m_fck = {	/* Alt clk
> > used in power management */
> >> >   * here will likely have an L4 interface parent, and may have
> > multiple
> >> >   * functional clock parents.
> >> >   */
> >> > -static const struct clksel_rate gpt_alt_rates[] = {
> >> > +static struct clksel_rate gpt_alt_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel omap24xx_gpt_clksel[] = {
> >> > +static struct clksel omap24xx_gpt_clksel[] = {
> >> >  	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
> >> >  	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
> >> >  	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
> >> > @@ -1142,17 +1142,17 @@ static struct clk mcbsp1_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_mcbsp_96m_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_96m_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel mcbsp_fck_clksel[] = {
> >> > +static struct clksel mcbsp_fck_clksel[] = {
> >> >  	{ .parent = &func_96m_ck,  .rates = common_mcbsp_96m_rates
},
> >> >  	{ .parent = &mcbsp_clks,   .rates =
common_mcbsp_mcbsp_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -1618,12 +1618,12 @@ static struct clk vlynq_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate vlynq_fck_96m_rates[] = {
> >> > +static struct clksel_rate vlynq_fck_96m_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_242X },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate vlynq_fck_core_rates[] = {
> >> > +static struct clksel_rate vlynq_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_242X },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
> >> > @@ -1637,7 +1637,7 @@ static const struct clksel_rate
> > vlynq_fck_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel vlynq_fck_clksel[] = {
> >> > +static struct clksel vlynq_fck_clksel[] = {
> >> >  	{ .parent = &func_96m_ck, .rates = vlynq_fck_96m_rates },
> >> >  	{ .parent = &core_ck,	  .rates = vlynq_fck_core_rates },
> >> >  	{ .parent = NULL }
> >> > diff --git a/arch/arm/mach-omap2/clock2430_data.c
> > b/arch/arm/mach-omap2/clock2430_data.c
> >> > index c047dcd..6f08a57 100644
> >> > --- a/arch/arm/mach-omap2/clock2430_data.c
> >> > +++ b/arch/arm/mach-omap2/clock2430_data.c
> >> > @@ -161,17 +161,17 @@ static struct clk apll54_ck = {
> >> >
> >> >  /* func_54m_ck */
> >> >
> >> > -static const struct clksel_rate func_54m_apll54_rates[] = {
> >> > +static struct clksel_rate func_54m_apll54_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate func_54m_alt_rates[] = {
> >> > +static struct clksel_rate func_54m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_54m_clksel[] = {
> >> > +static struct clksel func_54m_clksel[] = {
> >> >  	{ .parent = &apll54_ck, .rates = func_54m_apll54_rates, },
> >> >  	{ .parent = &alt_ck,	.rates = func_54m_alt_rates, },
> >> >  	{ .parent = NULL },
> >> > @@ -198,17 +198,17 @@ static struct clk core_ck = {
> >> >  };
> >> >
> >> >  /* func_96m_ck */
> >> > -static const struct clksel_rate func_96m_apll96_rates[] = {
> >> > +static struct clksel_rate func_96m_apll96_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate func_96m_alt_rates[] = {
> >> > +static struct clksel_rate func_96m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_96m_clksel[] = {
> >> > +static struct clksel func_96m_clksel[] = {
> >> >  	{ .parent = &apll96_ck,	.rates = func_96m_apll96_rates },
> >> >  	{ .parent = &alt_ck,	.rates = func_96m_alt_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -228,17 +228,17 @@ static struct clk func_96m_ck = {
> >> >
> >> >  /* func_48m_ck */
> >> >
> >> > -static const struct clksel_rate func_48m_apll96_rates[] = {
> >> > +static struct clksel_rate func_48m_apll96_rates[] = {
> >> >  	{ .div = 2, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate func_48m_alt_rates[] = {
> >> > +static struct clksel_rate func_48m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_48m_clksel[] = {
> >> > +static struct clksel func_48m_clksel[] = {
> >> >  	{ .parent = &apll96_ck,	.rates = func_48m_apll96_rates },
> >> >  	{ .parent = &alt_ck, .rates = func_48m_alt_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -283,27 +283,27 @@ static struct clk wdt1_osc_ck = {
> >> >   * harmless since access to those clocks are gated by the struct
clk
> >> >   * flags fields, which mark them as 2420-only.
> >> >   */
> >> > -static const struct clksel_rate common_clkout_src_core_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_core_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_sys_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_sys_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_96m_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_96m_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_src_54m_rates[] = {
> >> > +static struct clksel_rate common_clkout_src_54m_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel common_clkout_src_clksel[] = {
> >> > +static struct clksel common_clkout_src_clksel[] = {
> >> >  	{ .parent = &core_ck,	  .rates =
common_clkout_src_core_rates },
> >> >  	{ .parent = &sys_ck,	  .rates =
common_clkout_src_sys_rates },
> >> >  	{ .parent = &func_96m_ck, .rates =
common_clkout_src_96m_rates },
> >> > @@ -327,7 +327,7 @@ static struct clk sys_clkout_src = {
> >> >  	.set_rate	= &omap2_clksel_set_rate
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_clkout_rates[] = {
> >> > +static struct clksel_rate common_clkout_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
> >> > @@ -336,7 +336,7 @@ static const struct clksel_rate
> > common_clkout_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel sys_clkout_clksel[] = {
> >> > +static struct clksel sys_clkout_clksel[] = {
> >> >  	{ .parent = &sys_clkout_src, .rates = common_clkout_rates
},
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -375,13 +375,13 @@ static struct clk emul_ck = {
> >> >   * - Base divider comes from: CM_CLKSEL_MPU
> >> >   *
> >> >   */
> >> > -static const struct clksel_rate mpu_core_rates[] = {
> >> > +static struct clksel_rate mpu_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel mpu_clksel[] = {
> >> > +static struct clksel mpu_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = mpu_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -408,7 +408,7 @@ static struct clk mpu_ck = {	/* Control cpu */
> >> >   * controls. The other branch gets further divided by 2 then
possibly
> >> >   * routed into a synchronizer and out of clocks abc.
> >> >   */
> >> > -static const struct clksel_rate dsp_fck_core_rates[] = {
> >> > +static struct clksel_rate dsp_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -416,7 +416,7 @@ static const struct clksel_rate
> > dsp_fck_core_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel dsp_fck_clksel[] = {
> >> > +static struct clksel dsp_fck_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = dsp_fck_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -435,14 +435,14 @@ static struct clk dsp_fck = {
> >> >  };
> >> >
> >> >  /* DSP interface clock */
> >> > -static const struct clksel_rate dsp_irate_ick_rates[] = {
> >> > +static struct clksel_rate dsp_irate_ick_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel dsp_irate_ick_clksel[] = {
> >> > +static struct clksel dsp_irate_ick_clksel[] = {
> >> >  	{ .parent = &dsp_fck, .rates = dsp_irate_ick_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -486,14 +486,14 @@ static struct clk iva2_1_ick = {
> >> >   * may very well need notification when the clock changes.
Currently
> > for low
> >> >   * operating points, these are taken care of in sleep.S.
> >> >   */
> >> > -static const struct clksel_rate core_l3_core_rates[] = {
> >> > +static struct clksel_rate core_l3_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
> >> >  	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel core_l3_clksel[] = {
> >> > +static struct clksel core_l3_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = core_l3_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -510,14 +510,14 @@ static struct clk core_l3_ck = {	/* Used
> > for ick and fck, interconnect */
> >> >  };
> >> >
> >> >  /* usb_l4_ick */
> >> > -static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
> >> > +static struct clksel_rate usb_l4_ick_core_l3_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel usb_l4_ick_clksel[] = {
> >> > +static struct clksel usb_l4_ick_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = usb_l4_ick_core_l3_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -543,13 +543,13 @@ static struct clk usb_l4_ick = {	/* FS-USB
> > interface clock */
> >> >   * functional clocks.	Fixed APLL functional source clocks are
> > managed in
> >> >   * this domain.
> >> >   */
> >> > -static const struct clksel_rate l4_core_l3_rates[] = {
> >> > +static struct clksel_rate l4_core_l3_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel l4_clksel[] = {
> >> > +static struct clksel l4_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = l4_core_l3_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -573,7 +573,7 @@ static struct clk l4_ck = {		/* used
> > both as an ick and fck */
> >> >   *
> >> >   * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
> >> >   */
> >> > -static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
> >> > +static struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -582,7 +582,7 @@ static const struct clksel_rate
> > ssi_ssr_sst_fck_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel ssi_ssr_sst_fck_clksel[] = {
> >> > +static struct clksel ssi_ssr_sst_fck_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = ssi_ssr_sst_fck_core_rates
},
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -628,7 +628,7 @@ static struct clk ssi_l4_ick = {
> >> >   */
> >> >
> >> >  /* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck
*/
> >> > -static const struct clksel gfx_fck_clksel[] = {
> >> > +static struct clksel gfx_fck_clksel[] = {
> >> >  	{ .parent = &core_l3_ck, .rates = gfx_l3_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -678,7 +678,7 @@ static struct clk gfx_ick = {
> >> >   *		MDM_ICLK
> >> >   * These clocks are usable in chassis mode only.
> >> >   */
> >> > -static const struct clksel_rate mdm_ick_core_rates[] = {
> >> > +static struct clksel_rate mdm_ick_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_243X },
> >> >  	{ .div = 6, .val = 6, .flags = RATE_IN_243X },
> >> > @@ -686,7 +686,7 @@ static const struct clksel_rate
> > mdm_ick_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel mdm_ick_clksel[] = {
> >> > +static struct clksel mdm_ick_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = mdm_ick_core_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -724,12 +724,12 @@ static struct clk mdm_osc_ck = {
> >> >   */
> >> >  /* XXX Add RATE_NOT_VALIDATED */
> >> >
> >> > -static const struct clksel_rate dss1_fck_sys_rates[] = {
> >> > +static struct clksel_rate dss1_fck_sys_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss1_fck_core_rates[] = {
> >> > +static struct clksel_rate dss1_fck_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
> >> > @@ -743,7 +743,7 @@ static const struct clksel_rate
> > dss1_fck_core_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel dss1_fck_clksel[] = {
> >> > +static struct clksel dss1_fck_clksel[] = {
> >> >  	{ .parent = &sys_ck,  .rates = dss1_fck_sys_rates },
> >> >  	{ .parent = &core_ck, .rates = dss1_fck_core_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -773,17 +773,17 @@ static struct clk dss1_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss2_fck_sys_rates[] = {
> >> > +static struct clksel_rate dss2_fck_sys_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate dss2_fck_48m_rates[] = {
> >> > +static struct clksel_rate dss2_fck_48m_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel dss2_fck_clksel[] = {
> >> > +static struct clksel dss2_fck_clksel[] = {
> >> >  	{ .parent = &sys_ck,	  .rates = dss2_fck_sys_rates },
> >> >  	{ .parent = &func_48m_ck, .rates = dss2_fck_48m_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -819,12 +819,12 @@ static struct clk dss_54m_fck = {	/* Alt clk
> > used in power management */
> >> >   * here will likely have an L4 interface parent, and may have
> > multiple
> >> >   * functional clock parents.
> >> >   */
> >> > -static const struct clksel_rate gpt_alt_rates[] = {
> >> > +static struct clksel_rate gpt_alt_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel omap24xx_gpt_clksel[] = {
> >> > +static struct clksel omap24xx_gpt_clksel[] = {
> >> >  	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
> >> >  	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
> >> >  	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
> >> > @@ -1130,17 +1130,17 @@ static struct clk mcbsp1_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_mcbsp_96m_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_96m_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel mcbsp_fck_clksel[] = {
> >> > +static struct clksel mcbsp_fck_clksel[] = {
> >> >  	{ .parent = &func_96m_ck,  .rates = common_mcbsp_96m_rates
},
> >> >  	{ .parent = &mcbsp_clks,   .rates =
common_mcbsp_mcbsp_rates },
> >> >  	{ .parent = NULL }
> >> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
> > b/arch/arm/mach-omap2/clock3xxx_data.c
> >> > index 403a4a1..9c87adb 100644
> >> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> >> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> >> > @@ -109,37 +109,37 @@ static struct clk virt_38_4m_ck = {
> >> >  	.rate		= 38400000,
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_12m_rates[] = {
> >> > +static struct clksel_rate osc_sys_12m_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_13m_rates[] = {
> >> > +static struct clksel_rate osc_sys_13m_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_16_8m_rates[] = {
> >> > +static struct clksel_rate osc_sys_16_8m_rates[] = {
> >> >  	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2PLUS_36XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_19_2m_rates[] = {
> >> > +static struct clksel_rate osc_sys_19_2m_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_26m_rates[] = {
> >> > +static struct clksel_rate osc_sys_26m_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate osc_sys_38_4m_rates[] = {
> >> > +static struct clksel_rate osc_sys_38_4m_rates[] = {
> >> >  	{ .div = 1, .val = 4, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel osc_sys_clksel[] = {
> >> > +static struct clksel osc_sys_clksel[] = {
> >> >  	{ .parent = &virt_12m_ck,   .rates = osc_sys_12m_rates },
> >> >  	{ .parent = &virt_13m_ck,   .rates = osc_sys_13m_rates },
> >> >  	{ .parent = &virt_16_8m_ck, .rates = osc_sys_16_8m_rates
},
> >> > @@ -162,13 +162,13 @@ static struct clk osc_sys_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_rates[] = {
> >> > +static struct clksel_rate div2_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel sys_clksel[] = {
> >> > +static struct clksel sys_clksel[] = {
> >> >  	{ .parent = &osc_sys_ck, .rates = div2_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -212,7 +212,7 @@ static struct clk sys_clkout1 = {
> >> >
> >> >  /* CM CLOCKS */
> >> >
> >> > -static const struct clksel_rate div16_dpll_rates[] = {
> >> > +static struct clksel_rate div16_dpll_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> >> > @@ -232,7 +232,7 @@ static const struct clksel_rate
div16_dpll_rates[]
> > = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate dpll4_rates[] = {
> >> > +static struct clksel_rate dpll4_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> >> > @@ -318,7 +318,7 @@ static struct clk dpll1_x2_ck = {
> >> >  };
> >> >
> >> >  /* On DPLL1, unlike other DPLLs, the divider is downstream from
> > CLKOUTX2 */
> >> > -static const struct clksel div16_dpll1_x2m2_clksel[] = {
> >> > +static struct clksel div16_dpll1_x2m2_clksel[] = {
> >> >  	{ .parent = &dpll1_x2_ck, .rates = div16_dpll_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -378,7 +378,7 @@ static struct clk dpll2_ck = {
> >> >  	.recalc		= &omap3_dpll_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel div16_dpll2_m2x2_clksel[] = {
> >> > +static struct clksel div16_dpll2_m2x2_clksel[] = {
> >> >  	{ .parent = &dpll2_ck, .rates = div16_dpll_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -449,7 +449,7 @@ static struct clk dpll3_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div31_dpll3_rates[] = {
> >> > +static struct clksel_rate div31_dpll3_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2PLUS_36XX },
> >> > @@ -484,7 +484,7 @@ static const struct clksel_rate
> > div31_dpll3_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel div31_dpll3m2_clksel[] = {
> >> > +static struct clksel div31_dpll3m2_clksel[] = {
> >> >  	{ .parent = &dpll3_ck, .rates = div31_dpll3_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -520,7 +520,7 @@ static struct clk dpll3_m2x2_ck = {
> >> >  };
> >> >
> >> >  /* The PWRDN bit is apparently only available on 3430ES2 and above
*/
> >> > -static const struct clksel div16_dpll3_clksel[] = {
> >> > +static struct clksel div16_dpll3_clksel[] = {
> >> >  	{ .parent = &dpll3_ck, .rates = div16_dpll_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -635,7 +635,7 @@ static struct clk dpll4_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll4_clksel[] = {
> >> > +static struct clksel dpll4_clksel[] = {
> >> >  	{ .parent = &dpll4_ck, .rates = dpll4_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -680,23 +680,23 @@ static struct clk omap_192m_alwon_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_96m_alwon_fck_rates[] = {
> >> > +static struct clksel_rate omap_96m_alwon_fck_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_36XX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_36XX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel omap_96m_alwon_fck_clksel[] = {
> >> > +static struct clksel omap_96m_alwon_fck_clksel[] = {
> >> >  	{ .parent = &omap_192m_alwon_fck, .rates =
> > omap_96m_alwon_fck_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_96m_dpll_rates[] = {
> >> > +static struct clksel_rate omap_96m_dpll_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_96m_sys_rates[] = {
> >> > +static struct clksel_rate omap_96m_sys_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> > @@ -726,7 +726,7 @@ static struct clk cm_96m_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel omap_96m_fck_clksel[] = {
> >> > +static struct clksel omap_96m_fck_clksel[] = {
> >> >  	{ .parent = &cm_96m_fck, .rates = omap_96m_dpll_rates },
> >> >  	{ .parent = &sys_ck,	 .rates = omap_96m_sys_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -768,17 +768,17 @@ static struct clk dpll4_m3x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
> >> > +static struct clksel_rate omap_54m_d4m3x2_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_54m_alt_rates[] = {
> >> > +static struct clksel_rate omap_54m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel omap_54m_clksel[] = {
> >> > +static struct clksel omap_54m_clksel[] = {
> >> >  	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates
},
> >> >  	{ .parent = &sys_altclk,    .rates = omap_54m_alt_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -794,17 +794,17 @@ static struct clk omap_54m_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_48m_cm96m_rates[] = {
> >> > +static struct clksel_rate omap_48m_cm96m_rates[] = {
> >> >  	{ .div = 2, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate omap_48m_alt_rates[] = {
> >> > +static struct clksel_rate omap_48m_alt_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel omap_48m_clksel[] = {
> >> > +static struct clksel omap_48m_clksel[] = {
> >> >  	{ .parent = &cm_96m_fck, .rates = omap_48m_cm96m_rates },
> >> >  	{ .parent = &sys_altclk, .rates = omap_48m_alt_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -953,7 +953,7 @@ static struct clk dpll5_ck = {
> >> >  	.recalc		= &omap3_dpll_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel div16_dpll5_clksel[] = {
> >> > +static struct clksel div16_dpll5_clksel[] = {
> >> >  	{ .parent = &dpll5_ck, .rates = div16_dpll_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -972,27 +972,27 @@ static struct clk dpll5_m2_ck = {
> >> >
> >> >  /* CM EXTERNAL CLOCK OUTPUTS */
> >> >
> >> > -static const struct clksel_rate clkout2_src_core_rates[] = {
> >> > +static struct clksel_rate clkout2_src_core_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate clkout2_src_sys_rates[] = {
> >> > +static struct clksel_rate clkout2_src_sys_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate clkout2_src_96m_rates[] = {
> >> > +static struct clksel_rate clkout2_src_96m_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate clkout2_src_54m_rates[] = {
> >> > +static struct clksel_rate clkout2_src_54m_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel clkout2_src_clksel[] = {
> >> > +static struct clksel clkout2_src_clksel[] = {
> >> >  	{ .parent = &core_ck,		.rates =
clkout2_src_core_rates },
> >> >  	{ .parent = &sys_ck,		.rates =
clkout2_src_sys_rates },
> >> >  	{ .parent = &cm_96m_fck,	.rates =
clkout2_src_96m_rates },
> >> > @@ -1013,7 +1013,7 @@ static struct clk clkout2_src_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate sys_clkout2_rates[] = {
> >> > +static struct clksel_rate sys_clkout2_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4, .val = 2, .flags = RATE_IN_3XXX },
> >> > @@ -1022,7 +1022,7 @@ static const struct clksel_rate
> > sys_clkout2_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel sys_clkout2_clksel[] = {
> >> > +static struct clksel sys_clkout2_clksel[] = {
> >> >  	{ .parent = &clkout2_src_ck, .rates = sys_clkout2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1050,14 +1050,14 @@ static struct clk corex2_fck = {
> >> >
> >> >  /* DPLL power domain clock controls */
> >> >
> >> > -static const struct clksel_rate div4_rates[] = {
> >> > +static struct clksel_rate div4_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel div4_core_clksel[] = {
> >> > +static struct clksel div4_core_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = div4_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1086,13 +1086,13 @@ static struct clk mpu_ck = {
> >> >  };
> >> >
> >> >  /* arm_fck is divided by two when DPLL1 locked; otherwise,
> > passthrough mpu_ck */
> >> > -static const struct clksel_rate arm_fck_rates[] = {
> >> > +static struct clksel_rate arm_fck_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel arm_fck_clksel[] = {
> >> > +static struct clksel arm_fck_clksel[] = {
> >> >  	{ .parent = &mpu_ck, .rates = arm_fck_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1145,7 +1145,7 @@ static struct clk iva2_ck = {
> >> >
> >> >  /* Common interface clocks */
> >> >
> >> > -static const struct clksel div2_core_clksel[] = {
> >> > +static struct clksel div2_core_clksel[] = {
> >> >  	{ .parent = &core_ck, .rates = div2_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1162,7 +1162,7 @@ static struct clk l3_ick = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel div2_l3_clksel[] = {
> >> > +static struct clksel div2_l3_clksel[] = {
> >> >  	{ .parent = &l3_ick, .rates = div2_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1180,7 +1180,7 @@ static struct clk l4_ick = {
> >> >
> >> >  };
> >> >
> >> > -static const struct clksel div2_l4_clksel[] = {
> >> > +static struct clksel div2_l4_clksel[] = {
> >> >  	{ .parent = &l4_ick, .rates = div2_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1200,7 +1200,7 @@ static struct clk rm_ick = {
> >> >
> >> >  /* GFX clocks are in 3430ES1 only. 3430ES2 and later uses the SGX
> > instead */
> >> >
> >> > -static const struct clksel gfx_l3_clksel[] = {
> >> > +static struct clksel gfx_l3_clksel[] = {
> >> >  	{ .parent = &l3_ick, .rates = gfx_l3_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -1257,7 +1257,7 @@ static struct clk gfx_cg2_ck = {
> >> >
> >> >  /* SGX power domain - 3430ES2 only */
> >> >
> >> > -static const struct clksel_rate sgx_core_rates[] = {
> >> > +static struct clksel_rate sgx_core_rates[] = {
> >> >  	{ .div = 2, .val = 5, .flags = RATE_IN_36XX },
> >> >  	{ .div = 3, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4, .val = 1, .flags = RATE_IN_3XXX },
> >> > @@ -1265,23 +1265,23 @@ static const struct clksel_rate
> > sgx_core_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate sgx_192m_rates[] = {
> >> > +static struct clksel_rate sgx_192m_rates[] = {
> >> >  	{ .div = 1,  .val = 4, .flags = RATE_IN_36XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate sgx_corex2_rates[] = {
> >> > +static struct clksel_rate sgx_corex2_rates[] = {
> >> >  	{ .div = 3, .val = 6, .flags = RATE_IN_36XX },
> >> >  	{ .div = 5, .val = 7, .flags = RATE_IN_36XX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate sgx_96m_rates[] = {
> >> > +static struct clksel_rate sgx_96m_rates[] = {
> >> >  	{ .div = 1,  .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel sgx_clksel[] = {
> >> > +static struct clksel sgx_clksel[] = {
> >> >  	{ .parent = &core_ck,	 .rates = sgx_core_rates },
> >> >  	{ .parent = &cm_96m_fck, .rates = sgx_96m_rates },
> >> >  	{ .parent = &omap_192m_alwon_fck, .rates = sgx_192m_rates
},
> >> > @@ -1356,7 +1356,7 @@ static struct clk mad2d_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel omap343x_gpt_clksel[] = {
> >> > +static struct clksel omap343x_gpt_clksel[] = {
> >> >  	{ .parent = &omap_32k_fck, .rates = gpt_32k_rates },
> >> >  	{ .parent = &sys_ck,	   .rates = gpt_sys_rates },
> >> >  	{ .parent = NULL}
> >> > @@ -1501,17 +1501,17 @@ static struct clk i2c1_fck = {
> >> >   * MCBSP 1 & 5 get their 96MHz clock from core_96m_fck;
> >> >   * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
> >> >   */
> >> > -static const struct clksel_rate common_mcbsp_96m_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_96m_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> > +static struct clksel_rate common_mcbsp_mcbsp_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel mcbsp_15_clksel[] = {
> >> > +static struct clksel mcbsp_15_clksel[] = {
> >> >  	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates
},
> >> >  	{ .parent = &mcbsp_clks,   .rates =
common_mcbsp_mcbsp_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -1643,7 +1643,7 @@ static struct clk hdq_fck = {
> >> >
> >> >  /* DPLL3-derived clock */
> >> >
> >> > -static const struct clksel_rate ssi_ssr_corex2_rates[] = {
> >> > +static struct clksel_rate ssi_ssr_corex2_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> >> > @@ -1653,7 +1653,7 @@ static const struct clksel_rate
> > ssi_ssr_corex2_rates[] = {
> >> >  	{ .div = 0 }
> >> >  };
> >> >
> >> > -static const struct clksel ssi_ssr_clksel[] = {
> >> > +static struct clksel ssi_ssr_clksel[] = {
> >> >  	{ .parent = &corex2_fck, .rates = ssi_ssr_corex2_rates },
> >> >  	{ .parent = NULL }
> >> >  };
> >> > @@ -2078,7 +2078,7 @@ static struct clk ssi_ick_3430es2 = {
> >> >  /* REVISIT: Technically the TRM claims that this is CORE_CLK
based,
> >> >   * but l4_ick makes more sense to me */
> >> >
> >> > -static const struct clksel usb_l4_clksel[] = {
> >> > +static struct clksel usb_l4_clksel[] = {
> >> >  	{ .parent = &l4_ick, .rates = div2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2282,7 +2282,7 @@ static struct clk usbhost_ick = {
> >> >
> >> >  /* WKUP */
> >> >
> >> > -static const struct clksel_rate usim_96m_rates[] = {
> >> > +static struct clksel_rate usim_96m_rates[] = {
> >> >  	{ .div = 2,  .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4,  .val = 4, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 8,  .val = 5, .flags = RATE_IN_3XXX },
> >> > @@ -2290,7 +2290,7 @@ static const struct clksel_rate
usim_96m_rates[]
> > = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate usim_120m_rates[] = {
> >> > +static struct clksel_rate usim_120m_rates[] = {
> >> >  	{ .div = 4,  .val = 7,	.flags = RATE_IN_3XXX },
> >> >  	{ .div = 8,  .val = 8,	.flags = RATE_IN_3XXX },
> >> >  	{ .div = 16, .val = 9,	.flags = RATE_IN_3XXX },
> >> > @@ -2298,7 +2298,7 @@ static const struct clksel_rate
> > usim_120m_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel usim_clksel[] = {
> >> > +static struct clksel usim_clksel[] = {
> >> >  	{ .parent = &omap_96m_fck,	.rates = usim_96m_rates },
> >> >  	{ .parent = &dpll5_m2_ck,	.rates = usim_120m_rates
},
> >> >  	{ .parent = &sys_ck,		.rates = div2_rates },
> >> > @@ -2851,7 +2851,7 @@ static struct clk mcbsp4_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel mcbsp_234_clksel[] = {
> >> > +static struct clksel mcbsp_234_clksel[] = {
> >> >  	{ .parent = &per_96m_fck,  .rates = common_mcbsp_96m_rates
},
> >> >  	{ .parent = &mcbsp_clks,   .rates =
common_mcbsp_mcbsp_rates },
> >> >  	{ .parent = NULL }
> >> > @@ -2900,27 +2900,27 @@ static struct clk mcbsp4_fck = {
> >> >
> >> >  /* More information: ARM Cortex-A8 Technical Reference Manual,
sect
> > 10.1 */
> >> >
> >> > -static const struct clksel_rate emu_src_sys_rates[] = {
> >> > +static struct clksel_rate emu_src_sys_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate emu_src_core_rates[] = {
> >> > +static struct clksel_rate emu_src_core_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate emu_src_per_rates[] = {
> >> > +static struct clksel_rate emu_src_per_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate emu_src_mpu_rates[] = {
> >> > +static struct clksel_rate emu_src_mpu_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel emu_src_clksel[] = {
> >> > +static struct clksel emu_src_clksel[] = {
> >> >  	{ .parent = &sys_ck,		.rates = emu_src_sys_rates
},
> >> >  	{ .parent = &emu_core_alwon_ck, .rates =
emu_src_core_rates },
> >> >  	{ .parent = &emu_per_alwon_ck,	.rates = emu_src_per_rates
},
> >> > @@ -2944,7 +2944,7 @@ static struct clk emu_src_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate pclk_emu_rates[] = {
> >> > +static struct clksel_rate pclk_emu_rates[] = {
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
> >> > @@ -2952,7 +2952,7 @@ static const struct clksel_rate
pclk_emu_rates[]
> > = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel pclk_emu_clksel[] = {
> >> > +static struct clksel pclk_emu_clksel[] = {
> >> >  	{ .parent = &emu_src_ck, .rates = pclk_emu_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2968,14 +2968,14 @@ static struct clk pclk_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate pclkx2_emu_rates[] = {
> >> > +static struct clksel_rate pclkx2_emu_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel pclkx2_emu_clksel[] = {
> >> > +static struct clksel pclkx2_emu_clksel[] = {
> >> >  	{ .parent = &emu_src_ck, .rates = pclkx2_emu_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2991,7 +2991,7 @@ static struct clk pclkx2_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel atclk_emu_clksel[] = {
> >> > +static struct clksel atclk_emu_clksel[] = {
> >> >  	{ .parent = &emu_src_ck, .rates = div2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -3018,14 +3018,14 @@ static struct clk traceclk_src_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate traceclk_rates[] = {
> >> > +static struct clksel_rate traceclk_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel traceclk_clksel[] = {
> >> > +static struct clksel traceclk_clksel[] = {
> >> >  	{ .parent = &traceclk_src_fck, .rates = traceclk_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > diff --git a/arch/arm/mach-omap2/clock44xx_data.c
> > b/arch/arm/mach-omap2/clock44xx_data.c
> >> > index e8cb32f..b02bfae 100644
> >> > --- a/arch/arm/mach-omap2/clock44xx_data.c
> >> > +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >> > @@ -127,47 +127,47 @@ static struct clk virt_38400000_ck = {
> >> >  	.rate		= 38400000,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_0_rates[] = {
> >> > +static struct clksel_rate div_1_0_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_1_rates[] = {
> >> > +static struct clksel_rate div_1_1_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_2_rates[] = {
> >> > +static struct clksel_rate div_1_2_rates[] = {
> >> >  	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_3_rates[] = {
> >> > +static struct clksel_rate div_1_3_rates[] = {
> >> >  	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_4_rates[] = {
> >> > +static struct clksel_rate div_1_4_rates[] = {
> >> >  	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_5_rates[] = {
> >> > +static struct clksel_rate div_1_5_rates[] = {
> >> >  	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_6_rates[] = {
> >> > +static struct clksel_rate div_1_6_rates[] = {
> >> >  	{ .div = 1, .val = 6, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel_rate div_1_7_rates[] = {
> >> > +static struct clksel_rate div_1_7_rates[] = {
> >> >  	{ .div = 1, .val = 7, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel sys_clkin_sel[] = {
> >> > +static struct clksel sys_clkin_sel[] = {
> >> >  	{ .parent = &virt_12000000_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &virt_13000000_ck, .rates = div_1_2_rates },
> >> >  	{ .parent = &virt_16800000_ck, .rates = div_1_3_rates },
> >> > @@ -221,7 +221,7 @@ static struct clk xclk60motg_ck = {
> >> >
> >> >  /* Module clocks and DPLL outputs */
> >> >
> >> > -static const struct clksel abe_dpll_bypass_clk_mux_sel[] = {
> >> > +static struct clksel abe_dpll_bypass_clk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -283,7 +283,7 @@ static struct clk dpll_abe_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div31_1to31_rates[] = {
> >> > +static struct clksel_rate div31_1to31_rates[] = {
> >> >  	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 2, .val = 2, .flags = RATE_IN_4430 },
> >> >  	{ .div = 3, .val = 3, .flags = RATE_IN_4430 },
> >> > @@ -318,7 +318,7 @@ static const struct clksel_rate
> > div31_1to31_rates[] = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel dpll_abe_m2x2_div[] = {
> >> > +static struct clksel dpll_abe_m2x2_div[] = {
> >> >  	{ .parent = &dpll_abe_x2_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -343,14 +343,14 @@ static struct clk abe_24m_fclk = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div3_1to4_rates[] = {
> >> > +static struct clksel_rate div3_1to4_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 4, .val = 2, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel abe_clk_div[] = {
> >> > +static struct clksel abe_clk_div[] = {
> >> >  	{ .parent = &dpll_abe_m2x2_ck, .rates = div3_1to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -367,13 +367,13 @@ static struct clk abe_clk = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_1to2_rates[] = {
> >> > +static struct clksel_rate div2_1to2_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel aess_fclk_div[] = {
> >> > +static struct clksel aess_fclk_div[] = {
> >> >  	{ .parent = &abe_clk, .rates = div2_1to2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -402,7 +402,7 @@ static struct clk dpll_abe_m3x2_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel core_hsd_byp_clk_mux_sel[] = {
> >> > +static struct clksel core_hsd_byp_clk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_abe_m3x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -455,7 +455,7 @@ static struct clk dpll_core_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_core_m6x2_div[] = {
> >> > +static struct clksel dpll_core_m6x2_div[] = {
> >> >  	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -472,7 +472,7 @@ static struct clk dpll_core_m6x2_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel dbgclk_mux_sel[] = {
> >> > +static struct clksel dbgclk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_core_m6x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -485,7 +485,7 @@ static struct clk dbgclk_mux_ck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_core_m2_div[] = {
> >> > +static struct clksel dpll_core_m2_div[] = {
> >> >  	{ .parent = &dpll_core_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -522,7 +522,7 @@ static struct clk dpll_core_m5x2_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel div_core_div[] = {
> >> > +static struct clksel div_core_div[] = {
> >> >  	{ .parent = &dpll_core_m5x2_ck, .rates = div2_1to2_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -539,7 +539,7 @@ static struct clk div_core_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div4_1to8_rates[] = {
> >> > +static struct clksel_rate div4_1to8_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 4, .val = 2, .flags = RATE_IN_4430 },
> >> > @@ -547,7 +547,7 @@ static const struct clksel_rate
div4_1to8_rates[]
> > = {
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel div_iva_hs_clk_div[] = {
> >> > +static struct clksel div_iva_hs_clk_div[] = {
> >> >  	{ .parent = &dpll_core_m5x2_ck, .rates = div4_1to8_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -596,7 +596,7 @@ static struct clk dll_clk_div_ck = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_abe_m2_div[] = {
> >> > +static struct clksel dpll_abe_m2_div[] = {
> >> >  	{ .parent = &dpll_abe_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -639,7 +639,7 @@ static struct clk dpll_core_m7x2_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
> >> > +static struct clksel iva_hsd_byp_clk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &div_iva_hs_clk, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -694,7 +694,7 @@ static struct clk dpll_iva_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_iva_m4x2_div[] = {
> >> > +static struct clksel dpll_iva_m4x2_div[] = {
> >> >  	{ .parent = &dpll_iva_x2_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -754,7 +754,7 @@ static struct clk dpll_mpu_ck = {
> >> >  	.set_rate	= &omap3_noncore_dpll_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_mpu_m2_div[] = {
> >> > +static struct clksel dpll_mpu_m2_div[] = {
> >> >  	{ .parent = &dpll_mpu_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -779,7 +779,7 @@ static struct clk per_hs_clk_div_ck = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel per_hsd_byp_clk_mux_sel[] = {
> >> > +static struct clksel per_hsd_byp_clk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &per_hs_clk_div_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -827,7 +827,7 @@ static struct clk dpll_per_ck = {
> >> >  	.set_rate	= &omap3_noncore_dpll_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_per_m2_div[] = {
> >> > +static struct clksel dpll_per_m2_div[] = {
> >> >  	{ .parent = &dpll_per_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -851,7 +851,7 @@ static struct clk dpll_per_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_per_m2x2_div[] = {
> >> > +static struct clksel dpll_per_m2x2_div[] = {
> >> >  	{ .parent = &dpll_per_x2_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -969,7 +969,7 @@ static struct clk dpll_unipro_x2_ck = {
> >> >  	.recalc		= &omap3_clkoutx2_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_unipro_m2x2_div[] = {
> >> > +static struct clksel dpll_unipro_m2x2_div[] = {
> >> >  	{ .parent = &dpll_unipro_x2_ck, .rates = div31_1to31_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1033,7 +1033,7 @@ static struct clk dpll_usb_clkdcoldo_ck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dpll_usb_m2_div[] = {
> >> > +static struct clksel dpll_usb_m2_div[] = {
> >> >  	{ .parent = &dpll_usb_ck, .rates = div31_1to31_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1050,7 +1050,7 @@ static struct clk dpll_usb_m2_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel ducati_clk_mux_sel[] = {
> >> > +static struct clksel ducati_clk_mux_sel[] = {
> >> >  	{ .parent = &div_core_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_per_m6x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -1091,13 +1091,13 @@ static struct clk func_24mc_fclk = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_4to8_rates[] = {
> >> > +static struct clksel_rate div2_4to8_rates[] = {
> >> >  	{ .div = 4, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 8, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_48m_fclk_div[] = {
> >> > +static struct clksel func_48m_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m2x2_ck, .rates = div2_4to8_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1122,13 +1122,13 @@ static struct clk func_48mc_fclk = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_2to4_rates[] = {
> >> > +static struct clksel_rate div2_2to4_rates[] = {
> >> >  	{ .div = 2, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 4, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel func_64m_fclk_div[] = {
> >> > +static struct clksel func_64m_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m4x2_ck, .rates = div2_2to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1145,7 +1145,7 @@ static struct clk func_64m_fclk = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel func_96m_fclk_div[] = {
> >> > +static struct clksel func_96m_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m2x2_ck, .rates = div2_2to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1162,7 +1162,7 @@ static struct clk func_96m_fclk = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel hsmmc6_fclk_sel[] = {
> >> > +static struct clksel hsmmc6_fclk_sel[] = {
> >> >  	{ .parent = &func_64m_fclk, .rates = div_1_0_rates },
> >> >  	{ .parent = &func_96m_fclk, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -1175,13 +1175,13 @@ static struct clk hsmmc6_fclk = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_1to8_rates[] = {
> >> > +static struct clksel_rate div2_1to8_rates[] = {
> >> >  	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 8, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel init_60m_fclk_div[] = {
> >> > +static struct clksel init_60m_fclk_div[] = {
> >> >  	{ .parent = &dpll_usb_m2_ck, .rates = div2_1to8_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1198,7 +1198,7 @@ static struct clk init_60m_fclk = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel l3_div_div[] = {
> >> > +static struct clksel l3_div_div[] = {
> >> >  	{ .parent = &div_core_ck, .rates = div2_1to2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1215,7 +1215,7 @@ static struct clk l3_div_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel l4_div_div[] = {
> >> > +static struct clksel l4_div_div[] = {
> >> >  	{ .parent = &l3_div_ck, .rates = div2_1to2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1240,7 +1240,7 @@ static struct clk lp_clk_div_ck = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel l4_wkup_clk_mux_sel[] = {
> >> > +static struct clksel l4_wkup_clk_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &lp_clk_div_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -1257,7 +1257,7 @@ static struct clk l4_wkup_clk_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel per_abe_nc_fclk_div[] = {
> >> > +static struct clksel per_abe_nc_fclk_div[] = {
> >> >  	{ .parent = &dpll_abe_m2_ck, .rates = div2_1to2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1274,7 +1274,7 @@ static struct clk per_abe_nc_fclk = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel mcasp2_fclk_sel[] = {
> >> > +static struct clksel mcasp2_fclk_sel[] = {
> >> >  	{ .parent = &func_96m_fclk, .rates = div_1_0_rates },
> >> >  	{ .parent = &per_abe_nc_fclk, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -1309,7 +1309,7 @@ static struct clk per_abe_24m_fclk = {
> >> >  	.recalc		= &omap_fixed_divisor_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel pmd_stm_clock_mux_sel[] = {
> >> > +static struct clksel pmd_stm_clock_mux_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_core_m6x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &tie_low_clock_ck, .rates = div_1_2_rates },
> >> > @@ -1330,7 +1330,7 @@ static struct clk pmd_trace_clk_mux_ck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel syc_clk_div_div[] = {
> >> > +static struct clksel syc_clk_div_div[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div2_1to2_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1399,7 +1399,7 @@ static struct clk des3des_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel dmic_sync_mux_sel[] = {
> >> > +static struct clksel dmic_sync_mux_sel[] = {
> >> >  	{ .parent = &abe_24m_fclk, .rates = div_1_0_rates },
> >> >  	{ .parent = &syc_clk_div_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &func_24m_clk, .rates = div_1_2_rates },
> >> > @@ -1417,7 +1417,7 @@ static struct clk dmic_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel func_dmic_abe_gfclk_sel[] = {
> >> > +static struct clksel func_dmic_abe_gfclk_sel[] = {
> >> >  	{ .parent = &dmic_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
> >> > @@ -1531,7 +1531,7 @@ static struct clk emif2_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel fdif_fclk_div[] = {
> >> > +static struct clksel fdif_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m4x2_ck, .rates = div3_1to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1692,7 +1692,7 @@ static struct clk gpmc_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel sgx_clk_mux_sel[] = {
> >> > +static struct clksel sgx_clk_mux_sel[] = {
> >> >  	{ .parent = &dpll_core_m7x2_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_per_m7x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -1723,7 +1723,7 @@ static struct clk hdq1w_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel hsi_fclk_div[] = {
> >> > +static struct clksel hsi_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -1867,7 +1867,7 @@ static struct clk mcasp_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel func_mcasp_abe_gfclk_sel[] = {
> >> > +static struct clksel func_mcasp_abe_gfclk_sel[] = {
> >> >  	{ .parent = &mcasp_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
> >> > @@ -1900,7 +1900,7 @@ static struct clk mcbsp1_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel func_mcbsp1_gfclk_sel[] = {
> >> > +static struct clksel func_mcbsp1_gfclk_sel[] = {
> >> >  	{ .parent = &mcbsp1_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
> >> > @@ -1933,7 +1933,7 @@ static struct clk mcbsp2_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel func_mcbsp2_gfclk_sel[] = {
> >> > +static struct clksel func_mcbsp2_gfclk_sel[] = {
> >> >  	{ .parent = &mcbsp2_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
> >> > @@ -1966,7 +1966,7 @@ static struct clk mcbsp3_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel func_mcbsp3_gfclk_sel[] = {
> >> > +static struct clksel func_mcbsp3_gfclk_sel[] = {
> >> >  	{ .parent = &mcbsp3_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &slimbus_clk, .rates = div_1_2_rates },
> >> > @@ -1999,7 +1999,7 @@ static struct clk mcbsp4_sync_mux_ck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel per_mcbsp4_gfclk_sel[] = {
> >> > +static struct clksel per_mcbsp4_gfclk_sel[] = {
> >> >  	{ .parent = &mcbsp4_sync_mux_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &pad_clks_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -2401,7 +2401,7 @@ static struct clk timer4_fck = {
> >> >  	.clkdm_name	= "l4_per_clkdm",
> >> >  };
> >> >
> >> > -static const struct clksel timer5_sync_mux_sel[] = {
> >> > +static struct clksel timer5_sync_mux_sel[] = {
> >> >  	{ .parent = &syc_clk_div_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -2532,7 +2532,7 @@ static struct clk usb_host_fs_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel utmi_p1_gfclk_sel[] = {
> >> > +static struct clksel utmi_p1_gfclk_sel[] = {
> >> >  	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
> >> >  	{ .parent = &xclk60mhsp1_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -2559,7 +2559,7 @@ static struct clk usb_host_hs_utmi_p1_clk = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel utmi_p2_gfclk_sel[] = {
> >> > +static struct clksel utmi_p2_gfclk_sel[] = {
> >> >  	{ .parent = &init_60m_fclk, .rates = div_1_0_rates },
> >> >  	{ .parent = &xclk60mhsp2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -2656,7 +2656,7 @@ static struct clk usb_host_hs_fck = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel otg_60m_gfclk_sel[] = {
> >> > +static struct clksel otg_60m_gfclk_sel[] = {
> >> >  	{ .parent = &utmi_phy_clkout_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &xclk60motg_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = NULL },
> >> > @@ -2743,13 +2743,13 @@ static struct clk usb_tll_hs_ick = {
> >> >  	.recalc		= &followparent_recalc,
> >> >  };
> >> >
> >> > -static const struct clksel_rate div2_14to18_rates[] = {
> >> > +static struct clksel_rate div2_14to18_rates[] = {
> >> >  	{ .div = 14, .val = 0, .flags = RATE_IN_4430 },
> >> >  	{ .div = 18, .val = 1, .flags = RATE_IN_4430 },
> >> >  	{ .div = 0 },
> >> >  };
> >> >
> >> > -static const struct clksel usim_fclk_div[] = {
> >> > +static struct clksel usim_fclk_div[] = {
> >> >  	{ .parent = &dpll_per_m4x2_ck, .rates = div2_14to18_rates
},
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2807,7 +2807,7 @@ static struct clk wd_timer3_fck = {
> >> >  };
> >> >
> >> >  /* Remaining optional clocks */
> >> > -static const struct clksel stm_clk_div_div[] = {
> >> > +static struct clksel stm_clk_div_div[] = {
> >> >  	{ .parent = &pmd_stm_clock_mux_ck, .rates =
div3_1to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2824,7 +2824,7 @@ static struct clk stm_clk_div_ck = {
> >> >  	.set_rate	= &omap2_clksel_set_rate,
> >> >  };
> >> >
> >> > -static const struct clksel trace_clk_div_div[] = {
> >> > +static struct clksel trace_clk_div_div[] = {
> >> >  	{ .parent = &pmd_trace_clk_mux_ck, .rates =
div3_1to4_rates },
> >> >  	{ .parent = NULL },
> >> >  };
> >> > @@ -2843,7 +2843,7 @@ static struct clk trace_clk_div_ck = {
> >> >
> >> >  /* SCRM aux clk nodes */
> >> >
> >> > -static const struct clksel auxclk_sel[] = {
> >> > +static struct clksel auxclk_sel[] = {
> >> >  	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
> >> > @@ -2927,7 +2927,7 @@ static struct clk auxclk5_ck = {
> >> >  	.enable_bit	= OMAP4_ENABLE_SHIFT,
> >> >  };
> >> >
> >> > -static const struct clksel auxclkreq_sel[] = {
> >> > +static struct clksel auxclkreq_sel[] = {
> >> >  	{ .parent = &auxclk0_ck, .rates = div_1_0_rates },
> >> >  	{ .parent = &auxclk1_ck, .rates = div_1_1_rates },
> >> >  	{ .parent = &auxclk2_ck, .rates = div_1_2_rates },
> >> > diff --git a/arch/arm/plat-omap/clock.c
b/arch/arm/plat-omap/clock.c
> >> > index fc62fb5..9bfd193 100644
> >> > --- a/arch/arm/plat-omap/clock.c
> >> > +++ b/arch/arm/plat-omap/clock.c
> >> > @@ -308,6 +308,16 @@ void clk_enable_init_clocks(void)
> >> >  	}
> >> >  }
> >> >
> >> > +static struct clk *_omap_clk_get_by_name(const char *name)
> >> > +{
> >> > +	struct clk *c;
> >> > +
> >> > +	list_for_each_entry(c, &clocks, node)
> >> > +		if (!strcmp(c->name, name))
> >> > +			return c;
> >> > +	return NULL;
> >> > +}
> >> > +
> >> >  /**
> >> >   * omap_clk_get_by_name - locate OMAP struct clk by its name
> >> >   * @name: name of the struct clk to locate
> >> > @@ -318,21 +328,45 @@ void clk_enable_init_clocks(void)
> >> >   */
> >> >  struct clk *omap_clk_get_by_name(const char *name)
> >> >  {
> >> > -	struct clk *c;
> >> >  	struct clk *ret = NULL;
> >> >
> >> >  	mutex_lock(&clocks_mutex);
> >> > +	ret = _omap_clk_get_by_name(name);
> >> > +	mutex_unlock(&clocks_mutex);
> >> > +
> >> > +	return ret;
> >> > +}
> >> > +
> >> > +static inline void omap_init_dpll_data_clk_pts(struct dpll_data
*dd)
> >> > +{
> >> > +	if (!dd->clk_ref && dd->clk_ref_name)
> >> > +		dd->clk_ref =
_omap_clk_get_by_name(dd->clk_ref_name);
> >> > +	if (!dd->clk_bypass && dd->clk_bypass_name)
> >> > +		dd->clk_bypass =
> > _omap_clk_get_by_name(dd->clk_bypass_name);
> >> > +}
> >> > +
> >> > +static inline void omap_init_clksel_clk_pts(struct clksel *clks)
> >> > +{
> >> > +	if (!clks->parent && clks->parent_name)
> >> > +		clks->parent =
_omap_clk_get_by_name(clks->parent_name);
> >> > +}
> >> > +
> >> > +void omap_init_clk_pts(void)
> >> > +{
> >> > +	struct clk *c;
> >> > +
> >> > +	mutex_lock(&clocks_mutex);
> >> >
> >> >  	list_for_each_entry(c, &clocks, node) {
> >> > -		if (!strcmp(c->name, name)) {
> >> > -			ret = c;
> >> > -			break;
> >> > -		}
> >> > +		if (!c->parent && c->parent_name)
> >> > +			c->parent =
_omap_clk_get_by_name(c->parent_name);
> >> > +		if (c->dpll_data)
> >> > +			omap_init_dpll_data_clk_pts(c->dpll_data);
> >> > +		if (c->clksel)
> >> > +			omap_init_clksel_clk_pts(c->clksel);
> >> >  	}
> >> >
> >> >  	mutex_unlock(&clocks_mutex);
> >> > -
> >> > -	return ret;
> >> >  }
> >> >
> >> >  /*
> >> > diff --git a/arch/arm/plat-omap/include/plat/clock.h
> > b/arch/arm/plat-omap/include/plat/clock.h
> >> > index 8eb0ada..dc0d9fd 100644
> >> > --- a/arch/arm/plat-omap/include/plat/clock.h
> >> > +++ b/arch/arm/plat-omap/include/plat/clock.h
> >> > @@ -85,6 +85,7 @@ struct clksel_rate {
> >> >  /**
> >> >   * struct clksel - available parent clocks, and a pointer to their
> > divisors
> >> >   * @parent: struct clk * to a possible parent clock
> >> > + * @parent_name: Name of the possible parent clock
> >> >   * @rates: available divisors for this parent clock
> >> >   *
> >> >   * A struct clksel is always associated with one or more struct
clks
> >> > @@ -92,6 +93,7 @@ struct clksel_rate {
> >> >   */
> >> >  struct clksel {
> >> >  	struct clk		 *parent;
> >> > +	const char		 *parent_name;
> >> >  	const struct clksel_rate *rates;
> >> >  };
> >> >
> >> > @@ -101,7 +103,9 @@ struct clksel {
> >> >   * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
> >> >   * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
> >> >   * @clk_bypass: struct clk pointer to the clock's bypass clock
input
> >> > + * @clk_bypass_name: Name of the clock's bypass clock input
> >> >   * @clk_ref: struct clk pointer to the clock's reference clock
input
> >> > + * @clk_ref_name: Name of the clock's reference clock input
> >> >   * @control_reg: register containing the DPLL mode bitfield
> >> >   * @enable_mask: mask of the DPLL mode bitfield in @control_reg
> >> >   * @rate_tolerance: maximum variance allowed from target rate (in
Hz)
> >> > @@ -143,7 +147,9 @@ struct dpll_data {
> >> >  	u32			mult_mask;
> >> >  	u32			div1_mask;
> >> >  	struct clk		*clk_bypass;
> >> > +	const char		*clk_bypass_name;
> >> >  	struct clk		*clk_ref;
> >> > +	const char		*clk_ref_name;
> >> >  	void __iomem		*control_reg;
> >> >  	u32			enable_mask;
> >> >  	unsigned int		rate_tolerance;
> >> > @@ -230,6 +236,7 @@ struct clk {
> >> >  	const struct clkops	*ops;
> >> >  	const char		*name;
> >> >  	struct clk		*parent;
> >> > +	const char		*parent_name;
> >> >  	struct list_head	children;
> >> >  	struct list_head	sibling;	/* node for
children */
> >> >  	unsigned long		rate;
> >> > @@ -245,7 +252,7 @@ struct clk {
> >> >  #ifdef CONFIG_ARCH_OMAP2PLUS
> >> >  	void __iomem		*clksel_reg;
> >> >  	u32			clksel_mask;
> >> > -	const struct clksel	*clksel;
> >> > +	struct clksel		*clksel;
> >> >  	struct dpll_data	*dpll_data;
> >> >  	const char		*clkdm_name;
> >> >  	struct clockdomain	*clkdm;
> >> > @@ -292,7 +299,7 @@ extern void clk_init_cpufreq_table(struct
> > cpufreq_frequency_table **table);
> >> >  extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table
> > **table);
> >> >  #endif
> >> >  extern struct clk *omap_clk_get_by_name(const char *name);
> >> > -
> >> > +extern void omap_init_clk_pts(void);
> >> >  extern const struct clkops clkops_null;
> >> >
> >> >  extern struct clk dummy_ck;
