From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [Query] OMAP: DSS2: Margin for downscaling in clock
 calculations
Date: Fri, 21 Jan 2011 13:52:19 +0200
Message-ID: <1295610739.15175.21.camel@tubuntu>
References: <FCCFB4CDC6E5564B9182F639FC356087035F86FA74@dbde02.ent.ti.com>
	 <1295360369.27310.18.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087035F923C59@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:58821 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab1AULw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 06:52:26 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035F923C59@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-01-19 at 02:39 +0530, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > On Tue, 2011-01-18 at 10:45 +0530, ext Taneja, Archit wrote:
> >> Hi,
> >> 
> >> I was going through the DSS2 code which sets up the FCLK coming
> >> from PRCM and the DISPC divivors to get the required pixel clock.
> >> 
> >> The function dss_calc_clock_div() does a brute force search across
> >> all possible values of: a) DPLL divisor whose output goes to DSS,
> >> b) DISPC_DIVISOR.LCD, c) DISPC_DIVISOR.pcd
> >> 
> >> The combination which gives a clock frequency closest to the
> >> required pixel clock is chosen. 
> >> 
> >> Hence, it seems that the resultant DISPC_FCLK clock frequency
> >> doesn't take into account the extra margin needed for downscaling:
> >> 
> >> Req dispc_fclk >= pck * hscale_ratio * vscale_ration * K
> >> 
> >> Do you thing putting a further constraint (like DISPC_FCLK needs
> >> to be greater than a given value) should be a part of the
> >> calculations to ensure successful scaling?
> > 
> > It's been a while since I looked at the fclk requirements,
> > but isn't the current CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK
> > enough? It is quite hackish and static, but a proper
> > implementation is much harder (dynamically changing the
> > clocks depending on the scaling).
> > 
> 
> I think I ignored this part of the code :), I suppose this should be good
> enough for most cases.
> 
> I was wondering why we can't try to get the DSS_FCLK always at the max
> clock supported? Which is 173 Mhz on omap2/3.
> 
> Is it because we won't get a close enough pck with the lcd, pcd divisor
> combinations or is it needed to save power?

Main reason has been power saving. I don't know how much changing the
clock itself affects, but then there are things like the lowest OPP is
only possible when DSS_FCLK is lower than 96MHz (or someting like that,
can't remember), and that may have a bigger impact.

> If we stick to 173 Mhz(or something close to it) we could provide the best
> possible downscaling(which may need dispc_fck as much as 8 times the pixel clock)
> 
> Consider 2 hypothetical divisor combinations for a desired pixel clock:
> 
> a)DISPC_FCLK=120Mhz, delta between calculated pck and desired pck ~ 1%
> b)DISPC_FCLK=160Mhz, delta between calculated pck and desired pck ~ 2%
> 
> Wouldn't it be better to go with option (b) since it gives me something close
> to a desired pixel clock and also ensures better downscaling?

It's difficult to say. I have to say I have no idea how picky panels are
with the pixels clocks. If your panel works with option a but not with
b, then obviously a is a better choice =).

> Using CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK may or may not let me arrive at(b), since
> it will ensure jumps at discrete multiples of pck.
> 
> I am not totally sure if I make much sense, but would appreciate comments anyway :)

While I think it's very important to somehow be able to get whatever
clock settings one's particular use case requires, and for many cases it
may be important to get the FCLK as low as possible, perhaps there's a
point in what you say.

We could have some kind of "non-power-saving-mode", in which DSS doesn't
aim to aim for low clock, but to give best performance and scaling. This
would probably be fine for cases where your board is powered from a wall
supply, and you are not concerned about a few milliamps.

But then again, that would still be a bit hacky. What we should have is
a dynamically changed clock depending on the clock requirements. But
that's a bit tricky...

 Tomi


