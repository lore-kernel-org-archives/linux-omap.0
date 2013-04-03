From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Tue, 2 Apr 2013 21:00:02 -0500
Message-ID: <20130403020002.GA13340@snafu>
References: <20130328223513.GA19470@kahuna>
 <51596725.9060109@ti.com>
 <20130401181057.8177.19688@quantum>
 <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com>
 <20130401213430.8177.21940@quantum>
 <20130401230009.GA2038@snafu>
 <20130402000545.8177.65252@quantum>
 <20130402033545.GA2020@snafu>
 <20130402171614.8177.68752@quantum>
 <515B16F5.2090708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34440 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760596Ab3DCCAE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 22:00:04 -0400
Content-Disposition: inline
In-Reply-To: <515B16F5.2090708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

On 20:35-20130402, Andrii Tseglytskyi wrote:
> On 04/02/2013 08:16 PM, Mike Turquette wrote:
> >Quoting Nishanth Menon (2013-04-01 20:35:45)
> >>On 17:05-20130401, Mike Turquette wrote:
> >>>OK, so we're in agreement on what The Future looks like.  What does that
> >>>mean for Andrii's patchset?
> >>Unless anyone has an fundamental issue with the approach of an "Super
> >>regulator" controlling "sub regulators", I think, in-line with your
> >>view, we should probably make ABB as an regulator instead of inventing
> >>our own API and hooking it around clock notifiers.
> >ACK.  Making the ABB code into a regulator driver is the right thing to
> >do regardless of whether or not we use a Super Regulator(tm) or just
> >chain together Not So Super Regulators(tm).
> >
> >I'm not an expert at the regulator framework, but I encourage Andrii to
> >look into regulator_set_mode(), which might be a more semantically
> >accurate alternative than regulator_set_voltage() for the ABB ldo.
> 
> 
> Agree. It is a good idea in general.
> regulator_set_mode() API seems to be good enough for handling ABB
> mode (FBB/RBB/Bypass).
> Knowledge about ABB mode on each OPP can be moved from ABB regulator
> to "Super regulator".
> Thanks a lot for all your comments.
> 

Digging a little more on this:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/regulator/consumer.h#n41

If we were to mean usage of mode to mean - usage of PWM/PFM etc
mode(like in tps/twl chips), this makes sense. However, if we mean
forward, reverse and bypass as "modes" we might be misusing the original
intent of the API.

-- 
Regards,
Nishanth Menon
