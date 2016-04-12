From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Tue, 12 Apr 2016 09:37:50 -0700
Message-ID: <20160412163750.GR5995@atomide.com>
References: <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com>
 <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com>
 <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570CC54E.6020703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160412 02:53]:
> Tony,
> 
> On 04/12/16 00:28, Tony Lindgren wrote:
> >>> Then for the long term solution using
> >>> PM runtime to block gating of the clock while sidetone is active is
> >>> the way to go it seems.
> >>
> >> Hrm, I think one of the main issue is that with pm_runtime we can not block
> >> the clock gating, this is why legacy code uses enable_st_clock(), which will
> >> call omap2_clk_deny_idle() or omap2_clk_allow_idle().
> > 
> > I see. I think Tero wanted to export omap2_clk_allow_idle() and
> > omap2_clk_deny_idle() for drivers to use. That should get discussed in
> > the linux-clk list, probably best to use the pdata callbacks until
> > the clock idling issue has been discussed.
> 
> It is already exported, used by the arch/arm/mach-omap2/mcbsp.c file.

Oh but not with EXPORT_SYMBOL so not usable except for built-in code.
Probably best to keep it that way IMO..

> Why not to remove the callback for legacy also and handle it in the driver? It
> is less ugly in my opinion.
> Going via the pdata callback is just going to cement the current setup.

Sure, maybe you can have a piece of built-in driver code to do that?

> I have drafted out something which would be needed if we separate the McBSP-ST
> from the McBSP driver. It is not pretty...
> 
> In the new omap3-mcbsp-st.h:
> 
> struct omap3_mcbspst;
> 
> struct omap_st_to_mcbsp_data {
> 	bool (*is_enabled)(struct omap_st_to_mcbsp_data *st_data);
> 	bool (*enable)(struct omap_st_to_mcbsp_data *st_data);
> 	bool (*disable)(struct omap_st_to_mcbsp_data *st_data);
> 	struct omap3_mcbspst *st_priv;
> };
> 
> In the current omap-mcbsp.h:
> 
> #include <omap3-mcbsp-st.h>
> ...
> struct omap_mcbsp_to_st_data {
> 	bool (*is_enabled)(struct omap_mcbsp_to_st_data *mcbsp_data);
> 	bool (*iclk_idle)(struct omap_mcbsp_to_st_data *mcbsp_data, bool allow);
> 	bool (*enable)(struct omap_mcbsp_to_st_data *mcbsp_data);
> 	bool (*disable)(struct omap_mcbsp_to_st_data *mcbsp_data);
> 	struct omap_mcbsp *mcbsp_priv;
> };
> 
> #ifdef CONFIG_SND_SOC_OMAP3_MCBSPST
> struct omap_mcbsp_to_st_data *omap_mcbsp_st_register(
> 						struct platform_device *pdev, /* McBSP pdev! probably? */
> 						struct omap_st_to_mcbsp_data *st_data);
> int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_data *st_data);
> #else
> static inline int omap_mcbsp_st_register(struct platform_device *pdev,
> 					 struct omap_st_to_mcbsp_data *st_data)
> {
> 	return -ENODEV;
> }
> static inline int omap_mcbsp_st_unregister(struct omap_st_to_mcbsp_data *st_data)
> {
> 	return 0;
> }
> #endif
> 
> Since the ST would be separate driver, it should create the needed ALSA
> controls as well, probably I need to pass something else here and there.
> But, in this setup it would be possible to remove the ST driver while the
> McBSP and the sound card is up, which means we must be able to remove
> kcontrols runtime, probably there is a way, but not sure about this.
> 
> There will be issues like this we have not prepared for I'm sure if we do
> dramatic change to the simple implementation we have right now.

Best to stick to incremental improvments I think..

> I have reasonably clean patches (6 of them) on top of this three which would
> remove the arch code for the iclk handling and implements it in the mcbsp
> driver w/o changing the architecture of the McBSP driver itself. Both DT and
> legacy boot works. The only part I was not happy about the one where I looked
> up the mcbsp2/3_ick, but I think I have found much cleaner way to do it
> (meaning that the code will not look hackish at all).
> If you want to see, I can make this change and I can send the whole thing as
> RFC and continue the discussion around that?

Sure, especially if that helps with splitting up the modules too.

Regards,

Tony
