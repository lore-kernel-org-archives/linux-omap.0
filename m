From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Thu, 10 Mar 2011 11:49:55 +0200
Message-ID: <1299750595.2017.84.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <1299671118-20839-6-git-send-email-mythripk@ti.com>
	 <1299671118-20839-7-git-send-email-mythripk@ti.com>
	 <1299743573.2017.16.camel@deskari>
	 <AANLkTin4Uzt8Np9hgbZDSA7UBQo1dC9E7qxOa3W19JjH@mail.gmail.com>
	 <1299748745.2017.66.camel@deskari>
	 <AANLkTi=xCtzgnP8e0NOWu6PZu3qB9FKbe34YYX36e1+U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab1CJJt5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:49:57 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2A9nvET019837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:49:57 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2A9nvG2026190
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 03:49:57 -0600 (CST)
In-Reply-To: <AANLkTi=xCtzgnP8e0NOWu6PZu3qB9FKbe34YYX36e1+U@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-03-10 at 03:33 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Thu, Mar 10, 2011 at 2:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Thu, 2011-03-10 at 03:00 -0600, K, Mythri P wrote:
> >> Hi Tomi,
> >>
> >> On Thu, Mar 10, 2011 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
> >> >> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controller
> >> >> to manage the enable and disable requests and synchronize audio and video.
> >> >>
> >> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> >
> >> > <snip>
> >> >
> >> >> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
> >> >> +{
> >> >> +     DSSDBG("ENTER hdmi_panel_probe\n");
> >> >> +
> >> >> +     dssdev->panel.config = OMAP_DSS_LCD_TFT |
> >> >> +                     OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
> >> >> +
> >> >> +     /*
> >> >> +      * Initialize the timings to 1920 * 1080
> >> >> +      * This is only for framebuffer update not for TV timing setting
> >> >> +      * Setting TV timing will be done only on enable
> >> >> +      */
> >> >> +     dssdev->panel.timings.x_res = 1920;
> >> >> +     dssdev->panel.timings.y_res = 1080;
> >> >
> >> > This will cause the framebuffer to be initialized to 1920x1080,
> >> > regardless of the timings the hdmi driver will select.
> >>
> >> I have set it to VGA , But anyways we need to fix FB to take the
> >> feedback from the driver
> >> for the timing , atleast when you disable the overlay set manager and
> >> enable it again.
> >
> > No, the FB cannot do anything with that information. FB driver can't
> > change the resolution by itself. It has to happen on some upper level,
> > in the user space.
> >
> > The only case when the FB can select the resolution is when the driver
> > is loading. At that point nobody is using the framebuffer, as it didn't
> > even exist earlier. That's why I suggested reading the EDID in the
> > probe.
> 
> Reading the EDID during probe is not feasible ,
> 1. To read EDID we have to enable clocks and configure HDMI , which
> may not be intended - as probe does not mean
> that the user would want to enable HDMI.

Well, the function is called "probe" for a purpose =). It can probe the
HW to find out what's there. I believe that for reading the EDID we
don't need DISPC at all, but just a small subset of the HDMI hardware?

> 2. If HDMI is  not connected at boot up , but the cable is plugged in
> later on we will run into issues.

Not any more than currently, when we don't read EDID in the probe.
Probing would just allow the driver to setup sane default if the monitor
is connected when the driver is loaded.

If we have the user space properly handling hotplugs etc, this probe is
of course extra. But it wouldn't do any harm in that case either, would
it?

> There are mechanisms in v4l2 to reconfigure the overlay size and its
> own parameters , Even if a notification is sent there is no

I'm not familiar with v4l2, it may be possible there. But it doesn't
mean it's possible in the framebuffer.

> mechanism today in FB to do it.
> What happens if FB is switched from one manager to other with  resolution ?
> There is not neat way to do it today, So i think a more reasonable way
> is to find a way to atleast
> let the user space change the virtual size of FB dynamically given
> there is enough VRAM allocated.

The userspace can do all the configuration it wants, sure. And that's
how it should work. But the FB driver itself cannot do this.

Well, to be exact, it could in some cases, but not always. If the
framebuffer memory is ioremapped, the fb cannot go and change it. And
even if it's not ioremapped, changing the fb resolution independently
would easily mess up applications. They won't be expecting the fb to
change suddenly when they are using it.

> >> > I think you should either probe the display here to find what it
> >> > supports, and initialize the size accordingly, or if the display is not
> >> > connected, use some safe resolution most of the displays should support.
> >> > VGA probably.
> >> >
> >> > And the timings selected here should also be used by the hdmi driver.
> >> > What happens now with my monitor is that I get a fb of 1920x1028, but
> >> > the hdmi driver doesn't like the modes my monitor gives via EDID, and
> >> > falls back to VGA -> messed up display.
> >> >
> >> > Also, I'm getting "timeout waiting for EVSYNC" when I load or unload the
> >> > driver.
> >> >
> >> This is ok, I have not seen any issue because of this warning,
> >
> > It's an error, it's not ok =).
> >
> >> Also we need to understand the rationale as to why the wait_timeout was added
> >> in the code "dispc_enable_digit_out", It seems more like a hack, and
> >> not necessarily needed?
> >
> > When disabling, the point is to wait until the DISPC has really turned
> > off the output. For VENC this needed waiting for EVSYNC_EVEN and ODD. I
> > don't remember why the same code is ran when enabling.
> >
> > HDMI may work differently, so it is possible that the function needs to
> > be fixed. But I wonder why it gives timeouts when enabling HDMI also...
> > Shouldn't the EVSYNCs happen with HDMI too?
> >
> > We can look at that later, presuming the timeout doesn't cause any
> > problems.
> >
> HDMI is not dependent on the EVSYNC_ODD , but on EVSYNC EVEN,

What do you mean dependent? When HDMI is enabled, we only get
EVSYNC_EVENs? Even when using interlace mode?

> it has never needed to wait and has not caused any issue for last 8-10
> months it is being used :).

That doesn't mean it's not needed. VENC worked fine without the wait for
years. Until it didn't, after some PM work if I recall right.

Both VENC and LCD outputs need to wait until DISPC has really finished
with the output, before disabling the clocks. At least on OMAP3. HDMI
may be different, but I find it a bit difficult to believe, as the same
digit output is used for both HDMI and VENC.

 Tomi


