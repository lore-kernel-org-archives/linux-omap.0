From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Thu, 10 Mar 2011 11:19:05 +0200
Message-ID: <1299748745.2017.66.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <1299671118-20839-6-git-send-email-mythripk@ti.com>
	 <1299671118-20839-7-git-send-email-mythripk@ti.com>
	 <1299743573.2017.16.camel@deskari>
	 <AANLkTin4Uzt8Np9hgbZDSA7UBQo1dC9E7qxOa3W19JjH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55033 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab1CJJTI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:19:08 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A9J7i1019374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:19:07 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2A9J7G4015928
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:19:07 -0600 (CST)
In-Reply-To: <AANLkTin4Uzt8Np9hgbZDSA7UBQo1dC9E7qxOa3W19JjH@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 03:00 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Thu, Mar 10, 2011 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
> >> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controller
> >> to manage the enable and disable requests and synchronize audio and video.
> >>
> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >
> > <snip>
> >
> >> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
> >> +{
> >> +     DSSDBG("ENTER hdmi_panel_probe\n");
> >> +
> >> +     dssdev->panel.config = OMAP_DSS_LCD_TFT |
> >> +                     OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
> >> +
> >> +     /*
> >> +      * Initialize the timings to 1920 * 1080
> >> +      * This is only for framebuffer update not for TV timing setting
> >> +      * Setting TV timing will be done only on enable
> >> +      */
> >> +     dssdev->panel.timings.x_res = 1920;
> >> +     dssdev->panel.timings.y_res = 1080;
> >
> > This will cause the framebuffer to be initialized to 1920x1080,
> > regardless of the timings the hdmi driver will select.
> 
> I have set it to VGA , But anyways we need to fix FB to take the
> feedback from the driver
> for the timing , atleast when you disable the overlay set manager and
> enable it again.

No, the FB cannot do anything with that information. FB driver can't
change the resolution by itself. It has to happen on some upper level,
in the user space.

The only case when the FB can select the resolution is when the driver
is loading. At that point nobody is using the framebuffer, as it didn't
even exist earlier. That's why I suggested reading the EDID in the
probe.

> > I think you should either probe the display here to find what it
> > supports, and initialize the size accordingly, or if the display is not
> > connected, use some safe resolution most of the displays should support.
> > VGA probably.
> >
> > And the timings selected here should also be used by the hdmi driver.
> > What happens now with my monitor is that I get a fb of 1920x1028, but
> > the hdmi driver doesn't like the modes my monitor gives via EDID, and
> > falls back to VGA -> messed up display.
> >
> > Also, I'm getting "timeout waiting for EVSYNC" when I load or unload the
> > driver.
> >
> This is ok, I have not seen any issue because of this warning,

It's an error, it's not ok =).

> Also we need to understand the rationale as to why the wait_timeout was added
> in the code "dispc_enable_digit_out", It seems more like a hack, and
> not necessarily needed?

When disabling, the point is to wait until the DISPC has really turned
off the output. For VENC this needed waiting for EVSYNC_EVEN and ODD. I
don't remember why the same code is ran when enabling.

HDMI may work differently, so it is possible that the function needs to
be fixed. But I wonder why it gives timeouts when enabling HDMI also...
Shouldn't the EVSYNCs happen with HDMI too?

We can look at that later, presuming the timeout doesn't cause any
problems.

 Tomi


