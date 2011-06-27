From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant
 code from DSS.
Date: Mon, 27 Jun 2011 15:58:38 +0300
Message-ID: <1309179518.1813.38.camel@lappyti>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
	 <1308823101.1834.79.camel@deskari>
	 <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
	 <1308832274.1834.109.camel@deskari>
	 <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58099 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759877Ab1F0NGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 09:06:18 -0400
Received: by bwb11 with SMTP id 11so2024467bwb.37
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 06:06:13 -0700 (PDT)
In-Reply-To: <BANLkTik1TYgaGBYKqYxih1RjPKn8nU_cAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-06-27 at 11:21 +0530, K, Mythri P wrote:
> Hi Tomi,
> 
> On Thu, Jun 23, 2011 at 6:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Thu, 2011-06-23 at 17:35 +0530, K, Mythri P wrote:
> >> Hi Tomi,
> >>
> >> On Thu, Jun 23, 2011 at 3:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
> >> >> HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
> >> >> the Display subsytem is different. Thus to reuse the code between these two
> >> >> processors , HDMI IP dependant code is seperated out from hdmi.c and moved to
> >> >> new library file hdmi_ti_4xxx_ip.c which now resides in /drivers/video a more
> >> >> generic location out of omap2/dss folder.
> >> >>
> >> >> This patch series does the split and also renames hdmi_omap4_panel.c to
> >> >> hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
> >> >> other OMAP family of processors as well.
> >> >
> >> > These comments are based on the branch you have, not to particular
> >> > patches:
> >> >
> >> > include/video/hdmi_ti_4xxx_ip.h:
> >> >
> >> > - This file is in a way the most important one, because it's the public
> >> > API of the component. So you should be extra careful with this, and see
> >> > that everything in it makes sense, and it's clear how it is to be used.
> >> >
> >> > - hdmi_core_hdmi_dvi is defined but not used. Should it be in the
> >> > private header?
> >>
> >>  HDMI_HDMI  and HDMI_DVI are used everywhere in hdmi.c and hdmi_ti_4xxx_ip.c,
> >> one thing  i could do is to add a patch to used this enumerator
> >> instead of int mode ?
> >
> > Oh, so the "int mode" in the header is actually "enum hdmi_core_hdmi_dvi
> > mode"? Using int is obviously wrong, then.
> sure i shall fix it in a separate patch.
> >
> >> > - hdmi_pll_pwr seems to be very low level thing. It requires the user to
> >> > know HW details about the PLL, I don't think it should be visible to the
> >> > users. It is used in parameters for hdmi_ti_4xxx_set_pll_pwr(). When is
> >> > it supposed to be used? Why is hdmi_ti_4xxx_wp_video_start() not enough?
> >> >
> >> HDMI has core , PLL and PHY blocks, so user of the ip driver should
> >> configure them separately.
> >
> > Why? Is there some requirement/benefit to it?
> 
> Yes , When the core block is replaced in future OMAP's same PLL and
> PHY blocks are used.

That doesn't answer the question why the user should know about the
details of the HW. As far as I see, the user wants basically to
configure, enable and disable the HDMI HW. The user wants to do the same
things, regardless of the HDMI HW blocks used in that particular OMAP.

However, there is a reason why the HDMI PLL should be considered
separately: the PLL can be used as a clock source for DISPC and VENC. So
the API should offer functionality to configure and use the PLL
separately from the HDMI core/phy. But even so, hdmi_pll_pwr feels a bit
too low-level function for this API.

As for HDMI core/phy, is there ever reason to use one but not another?
Or is there a reason to configure them separately? If not, I don't see
why they should be present separately in the API.

> >> > - The same goes to hdmi_ti_4xxx_pll_program. Who does the PLL
> >> > calculations, omapdss driver? Shouldn't the HDMI driver do it, the PLL
> >> > is a HDMI HW thing, not DSS HW? Or if they are defined in the board
> >> > file, and omapdss just gives them to the HDMI driver, I think the data
> >> > should be somehow passed through omapdss without omapdss actively
> >> > participating in the PLL programming. This would be easy if the HDMI
> >> > would use a platform device/driver model, the data could be passed via
> >> > the device data.
> >
> > Can you comment on this? Why the PLL calculation is not in the HDMI IP
> > driver?
> The calculation of the PLL would depend on the sysclk freq right ? but
> only the TMDS is the concern of HDMI IP block , so i would configure
> only the TMDS portion in HDMI IP and calculation in DSS.

The HDMI PLL is part of the HDMI HW, not DSS HW, right? What if the HDMI
PLL used in next OMAP would contain one more divider? Using it would
require writing new calculation code into DSS driver. The PLL dividers
and calculations sound very much like HDMI PLL internal thing, not
something that should be handled in the DSS level.

Yes, PLL calculations depend on the input clock, in this case sys_clk.
So it should be provided to the HDMI code.

> >> > - If the PLL calculations have to be done by omapdss, couldn't the
> >> > hdmi_pll_info be part of hdmi_config?
> >>
> >> hdmi_pll_info would be used only once while configuring (power on) ,
> >> Why would we have to store the pll_info then in hdmi_config?
> >
> > Whether you store the hdmi_pll_info or not is HDMI IP driver internal
> > thing, not related to the API. We're talking about the API here.
> >
> > Look at the include/video/hdmi_ti_4xxx_ip.h file and think from the
> > users view point: what is the most obvious and easiest way to use the
> > API. Then make the HDMI IP driver work with the API.
> 
> As the pll_info in needed only for config of the PLL block it wouldnt
> make sense to store it.[even from API point of view].

The API doesn't have anything related to storing the pll_info. If a good
API requires the HDMI driver to store some pieces of information, why
would that be a problem?

> >> > - Is hdmi_ti_4xxx_phy_off the counterpart of hdmi_ti_4xxx_phy_init? If
> >> > so, the naming could be better to clearly show this. Like init/uninit,
> >> > enable/disable, etc.
> >>
> >> I shall rename. yes phy_off is counterpart of init , i shall renmane
> >> it to enable ,disable.
> >> >
> >> > - Is the "phy" relevant (from the user's point of view) in
> >> > hdmi_ti_4xxx_phy_init and off? Or could they be just init and uninit?
> >>
> >> PHY is a seperate block in HDMI and even from the user point of view
> >> user should be aware of PHY, PLL and core blocks. so phy_init is
> >> relevant.
> >
> > Again, why? Why cannot the user just give the configurations to the HDMI
> > IP driver, and start it, without knowing anything about PHY/PLL/core.
> >
> Please see the comment above. The PHY , PLL and core blocks are interchangeable.

I don't see how this answers the question.

If the GPIO hardware on some platform would have three HW blocks that
can be changed depending on the SoC version, we would still just use the
normal GPIO API. Not a GPIO API with separate functions to configure all
those three HW blocks.

> >> > - Perhaps hdmi_ti_4xxx_basic_configure could be just configure, there's
> >> > no advanced configure or similar.
> >> Well, makes sense but this is the init_configuration(default
> >> configuration) is what was intended in the patch.
> >> >
> >> > - is the "wp" important in hdmi_ti_4xxx_wp_video_start?
> >> >
> >> yes wp == wrapper , so it would be clear to have a wp_video_Start.
> >
> > Why does the user need to know wp == wrapper? Isn't the function just
> > about enabling the video output?
> Well it is just to distinguish , yes the user doesn't have to know.
> >
> >> > - read_ti_4xxx_edid() is named differently than the other functions.
> >> >
> >> I shall rename to hdmi_ti_4xxx_read_edid.
> >>
> >> > drivers/video/hdmi_ti_4xxx_ip.c:
> >> >
> >> > - EXPORT_SYMBOL(hdmi_ti_4xxx_phy_init); is not below the function.
> >> >
> >> > drivers/video/omap2/dss/hdmi.c:
> >> >
> >> > - hdmi_ti_4xxx_set_pll_pwr() is only called in power_off(), but never
> >> > enabled. I presume the HDMI driver does that internally. That doesn't
> >> > sound like a valid use of the function.
> >>
> >> It is enabled in hdmi_ti_4xxx_pll_program called from power on.
> >
> > Yes, I can see that. But it's bad usage pattern. Never enable something
> > in one component, and disable it in another. The same entity has to do
> > them both.
> >
> >> > - Looking at hdmi_power_on(), I feel that the API of the HDMI driver
> >> > could be simpler. Would it be enough to have just one function to setup
> >> > the HDMI, and another to turn the output on?
> >> No , I suppose it is the responsibility of the user of IP driver to
> >> configure PHY , PLL and CORE blocks seperately as we can reuse the PLL
> >> or PHY block in different SOC's as well.
> >
> > Well, in that case, shouldn't PHY, PLL and CORE be in separate drivers?
> > If they are all in one HDMI IP driver, I don't see why the user would
> > need to know about PHY/PLL/CORE at all. The user just wants to use the
> > HDMI IP as a whole, doesn't it?
> 
> Please see above comment, we could still use the same PLL block in
> future OMAP's only replacing the core block so is the case with
> PHY.But then it doesnt make sense to split the driver for every 2/3
> functions right ? User could still access the PLL and PHY from this IP
> where as use the new API's for core?

But it shouldn't be the user's job to handle that. The user doesn't want
to use a driver for a particular version of the HDMI core. It just wants
to use the HDMI, regardless of what HW blocks are being used on that
particular platform.

> >> > - omapdss_hdmi_display_set_timing() seems to be broken. It just sets
> >> > some variables and calls display_enable().
> >> It sets a variable custom_set , appropriate action will be taken while
> >> configuring timings based on that parameter.
> >
> > This is the same thing as with the use of hdmi_ti_4xxx_set_pll_pwr.
> > Well, actually not, this is worse. A "set_timing" function which
> > unconditionally calls omapdss_hdmi_display_enable() makes no sense to
> > me. Why would set_timing function enable the display? And even more
> > importantly, omapdss_hdmi_display_enable() won't work correctly if it is
> > called unevenly related to omapdss_hdmi_display_disable(), which will
> > happen here.
> >
> There is a disable and enable called , This is on the same lines as
> other panels,

What other panel/interface does it like that? It needs to be fixed also,
then.

The problem is not that enable and disable would not be called. It's how
they are called.

A set_timing function which would disable the interface, configure the
timings, and enable the interface would make sense. A set_timings
function which would require the caller to first disable the interface,
and re-enable it after calling would make sense. A set_timing function
that requires the caller to disable the interface, and then implicitly
enables the interface by its own does not make sense.

I also wonder why the interface needs to be disabled and enabled when
timings are changed. Is there a specific requirement from the HW that
this needs to be done?

> I shall re check and post different patch in case of any correction,
> as i don't see it as a part of this patch series.

Sure. The set_timings issue is not directly related to this split patch
set.

However, I just want to point out that getting this patch set ready may
require more changes than you (or I) had originally in  mind. The reason
is that the HDMI API will become public and used by other SoCs. The API
has to be good enough so that we don't need to do major rewrites to all
users of the API later. If this requires making fixes and changes to the
current HDMI driver, that's what needs to be done first.

And it just occurred to me that perhaps our views of the API are a bit
different, and that's why we have differing opinions. I see this API as
something that could be used by OMAP DSS (and equivalent components on
other SoCs) to use the HDMI HW on OMAP4 and any future OMAPs. And
perhaps you see this API more as an API to use the current HDMI HW in
the OMAP4.

While I don't want to take this too far, and try to make a perfect API
(because it'd just fail as we don't have a clear view of the future HW
and the future needs), I would still like to get the API into the
direction where it's not strictly an API to use the current HDMI HW, but
something that can be easily used for later HWs also.

 Tomi


