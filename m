From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant
 code from DSS.
Date: Thu, 23 Jun 2011 15:31:14 +0300
Message-ID: <1308832274.1834.109.camel@deskari>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
	 <1308823101.1834.79.camel@deskari>
	 <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55131 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759400Ab1FWMiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 08:38:03 -0400
Received: by mail-bw0-f47.google.com with SMTP id 5so1899921bwz.20
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 05:38:02 -0700 (PDT)
In-Reply-To: <BANLkTinc9JUr-gBGSynzMtrqTVncDUbNKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-06-23 at 17:35 +0530, K, Mythri P wrote:
> Hi Tomi,
> 
> On Thu, Jun 23, 2011 at 3:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
> >> HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
> >> the Display subsytem is different. Thus to reuse the code between these two
> >> processors , HDMI IP dependant code is seperated out from hdmi.c and moved to
> >> new library file hdmi_ti_4xxx_ip.c which now resides in /drivers/video a more
> >> generic location out of omap2/dss folder.
> >>
> >> This patch series does the split and also renames hdmi_omap4_panel.c to
> >> hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
> >> other OMAP family of processors as well.
> >
> > These comments are based on the branch you have, not to particular
> > patches:
> >
> > include/video/hdmi_ti_4xxx_ip.h:
> >
> > - This file is in a way the most important one, because it's the public
> > API of the component. So you should be extra careful with this, and see
> > that everything in it makes sense, and it's clear how it is to be used.
> >
> > - hdmi_core_hdmi_dvi is defined but not used. Should it be in the
> > private header?
> 
>  HDMI_HDMI  and HDMI_DVI are used everywhere in hdmi.c and hdmi_ti_4xxx_ip.c,
> one thing  i could do is to add a patch to used this enumerator
> instead of int mode ?

Oh, so the "int mode" in the header is actually "enum hdmi_core_hdmi_dvi
mode"? Using int is obviously wrong, then.

> > - hdmi_pll_pwr seems to be very low level thing. It requires the user to
> > know HW details about the PLL, I don't think it should be visible to the
> > users. It is used in parameters for hdmi_ti_4xxx_set_pll_pwr(). When is
> > it supposed to be used? Why is hdmi_ti_4xxx_wp_video_start() not enough?
> >
> HDMI has core , PLL and PHY blocks, so user of the ip driver should
> configure them separately.

Why? Is there some requirement/benefit to it?

> > - The same goes to hdmi_ti_4xxx_pll_program. Who does the PLL
> > calculations, omapdss driver? Shouldn't the HDMI driver do it, the PLL
> > is a HDMI HW thing, not DSS HW? Or if they are defined in the board
> > file, and omapdss just gives them to the HDMI driver, I think the data
> > should be somehow passed through omapdss without omapdss actively
> > participating in the PLL programming. This would be easy if the HDMI
> > would use a platform device/driver model, the data could be passed via
> > the device data.

Can you comment on this? Why the PLL calculation is not in the HDMI IP
driver?

> > - If the PLL calculations have to be done by omapdss, couldn't the
> > hdmi_pll_info be part of hdmi_config?
> 
> hdmi_pll_info would be used only once while configuring (power on) ,
> Why would we have to store the pll_info then in hdmi_config?

Whether you store the hdmi_pll_info or not is HDMI IP driver internal
thing, not related to the API. We're talking about the API here.

Look at the include/video/hdmi_ti_4xxx_ip.h file and think from the
users view point: what is the most obvious and easiest way to use the
API. Then make the HDMI IP driver work with the API.

> > - Is hdmi_ti_4xxx_phy_off the counterpart of hdmi_ti_4xxx_phy_init? If
> > so, the naming could be better to clearly show this. Like init/uninit,
> > enable/disable, etc.
> 
> I shall rename. yes phy_off is counterpart of init , i shall renmane
> it to enable ,disable.
> >
> > - Is the "phy" relevant (from the user's point of view) in
> > hdmi_ti_4xxx_phy_init and off? Or could they be just init and uninit?
> 
> PHY is a seperate block in HDMI and even from the user point of view
> user should be aware of PHY, PLL and core blocks. so phy_init is
> relevant.

Again, why? Why cannot the user just give the configurations to the HDMI
IP driver, and start it, without knowing anything about PHY/PLL/core.

> > - Perhaps hdmi_ti_4xxx_basic_configure could be just configure, there's
> > no advanced configure or similar.
> Well, makes sense but this is the init_configuration(default
> configuration) is what was intended in the patch.
> >
> > - is the "wp" important in hdmi_ti_4xxx_wp_video_start?
> >
> yes wp == wrapper , so it would be clear to have a wp_video_Start.

Why does the user need to know wp == wrapper? Isn't the function just
about enabling the video output?

> > - read_ti_4xxx_edid() is named differently than the other functions.
> >
> I shall rename to hdmi_ti_4xxx_read_edid.
> 
> > drivers/video/hdmi_ti_4xxx_ip.c:
> >
> > - EXPORT_SYMBOL(hdmi_ti_4xxx_phy_init); is not below the function.
> >
> > drivers/video/omap2/dss/hdmi.c:
> >
> > - hdmi_ti_4xxx_set_pll_pwr() is only called in power_off(), but never
> > enabled. I presume the HDMI driver does that internally. That doesn't
> > sound like a valid use of the function.
> 
> It is enabled in hdmi_ti_4xxx_pll_program called from power on.

Yes, I can see that. But it's bad usage pattern. Never enable something
in one component, and disable it in another. The same entity has to do
them both.

> > - Looking at hdmi_power_on(), I feel that the API of the HDMI driver
> > could be simpler. Would it be enough to have just one function to setup
> > the HDMI, and another to turn the output on?
> No , I suppose it is the responsibility of the user of IP driver to
> configure PHY , PLL and CORE blocks seperately as we can reuse the PLL
> or PHY block in different SOC's as well.

Well, in that case, shouldn't PHY, PLL and CORE be in separate drivers?
If they are all in one HDMI IP driver, I don't see why the user would
need to know about PHY/PLL/CORE at all. The user just wants to use the
HDMI IP as a whole, doesn't it?

> > - omapdss_hdmi_display_set_timing() seems to be broken. It just sets
> > some variables and calls display_enable().
> It sets a variable custom_set , appropriate action will be taken while
> configuring timings based on that parameter.

This is the same thing as with the use of hdmi_ti_4xxx_set_pll_pwr.
Well, actually not, this is worse. A "set_timing" function which
unconditionally calls omapdss_hdmi_display_enable() makes no sense to
me. Why would set_timing function enable the display? And even more
importantly, omapdss_hdmi_display_enable() won't work correctly if it is
called unevenly related to omapdss_hdmi_display_disable(), which will
happen here.

 Tomi


