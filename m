From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Tue, 15 Mar 2011 09:36:15 +0530
Message-ID: <1300161975.1946.7.camel@lappyti>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	 <1299764643.2017.177.camel@deskari>
	 <AANLkTi=CKaUAXtLgFOSVmhrHm2Kdt8yUzY2_07Bijqi-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab1COEGY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 00:06:24 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F46K6n024102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 23:06:23 -0500
In-Reply-To: <AANLkTi=CKaUAXtLgFOSVmhrHm2Kdt8yUzY2_07Bijqi-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Jan, Sebastien" <s-jan@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-14 at 05:37 -0500, Jan, Sebastien wrote:
> Hi Tomi,
> 
> On Thu, Mar 10, 2011 at 2:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > I think this version is good. It works for me, at least =).
> >
> > Any Panda or Blaze owners reading this want to give this a try?
> 
> Tested on my pandaboard, with these patches applied on top of your
> dss2 tree: I get a working display on my DVI or my HDMI screen. => I
> tested by running the Ubuntu UI.
> 
> I have a couple of these traces from times to times (seems linked to
> screen saver enabling/disabling the screen):
> omapdss DISPC error: timeout waiting for EVSYNC

Yes, I get those every time I enable or disable the HDMI output. That
shouldn't cause any problems, but it's something that needs to be fixed
at some point.

> The best screen resolution is properly selected on both of my screens,
> but the frame-buffer is sized to 640x480. So the display works but the
> usable surface when going though /dev/fb0 is quite reduced.
> Is there a way to get the FB sized according to the screen resolution
> (in the init sequence, it appears that the FBs are allocated before
> the init of the HDMI)?

Currently the resolution has to be configured by the user manually. I
haven't tried, but I think giving the resolution with boot parameters
should also work. Mythri, have you tried that?

I don't think it is possible for the omapdss, panel or omapfb drivers to
configure the resolution automatically, except at boot time. After we
have booted up, there may be users for the framebuffer and changing it
"secretly" would cause problems.

I think the best way here is that the HDMI/omapdss driver gives hotplug
event, which is conveyed through omapfb to an userspace application.
This application can then query the available resolutions via some
mechanism, and select one of those.

> Fyi, I have also tested with the patches for DVI support and can get
> both outputs working simultaneously (my tree is here:
> http://dev.omapzoom.org/?p=sebjan/kernel.git;a=shortlog;h=refs/tags/topic-display-iv1-2.6.38-rc7).

Thanks. I'll also set up a "test" branch in DSS2 tree shortly, to which
I'll add DVI and HDMI patches for easier testing.

 Tomi


