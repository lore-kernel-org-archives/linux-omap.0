From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Wed, 03 Apr 2013 13:09:07 -0700
Message-ID: <20130403200907.3383.55806@quantum>
References: <20130328223513.GA19470@kahuna> <20130401181057.8177.19688@quantum>
 <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com>
 <20130401213430.8177.21940@quantum> <20130401230009.GA2038@snafu>
 <20130402000545.8177.65252@quantum> <20130402033545.GA2020@snafu>
 <20130402171614.8177.68752@quantum> <515B16F5.2090708@ti.com>
 <20130403020002.GA13340@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:58568 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762404Ab3DCUJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:09:12 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so1044204pdj.16
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 13:09:12 -0700 (PDT)
In-Reply-To: <20130403020002.GA13340@snafu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

Quoting Nishanth Menon (2013-04-02 19:00:02)
> On 20:35-20130402, Andrii Tseglytskyi wrote:
> > On 04/02/2013 08:16 PM, Mike Turquette wrote:
> > >Quoting Nishanth Menon (2013-04-01 20:35:45)
> > >>On 17:05-20130401, Mike Turquette wrote:
> > >>>OK, so we're in agreement on what The Future looks like.  What does that
> > >>>mean for Andrii's patchset?
> > >>Unless anyone has an fundamental issue with the approach of an "Super
> > >>regulator" controlling "sub regulators", I think, in-line with your
> > >>view, we should probably make ABB as an regulator instead of inventing
> > >>our own API and hooking it around clock notifiers.
> > >ACK.  Making the ABB code into a regulator driver is the right thing to
> > >do regardless of whether or not we use a Super Regulator(tm) or just
> > >chain together Not So Super Regulators(tm).
> > >
> > >I'm not an expert at the regulator framework, but I encourage Andrii to
> > >look into regulator_set_mode(), which might be a more semantically
> > >accurate alternative than regulator_set_voltage() for the ABB ldo.
> > 
> > 
> > Agree. It is a good idea in general.
> > regulator_set_mode() API seems to be good enough for handling ABB
> > mode (FBB/RBB/Bypass).
> > Knowledge about ABB mode on each OPP can be moved from ABB regulator
> > to "Super regulator".
> > Thanks a lot for all your comments.
> > 
> 
> Digging a little more on this:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/regulator/consumer.h#n41
> 
> If we were to mean usage of mode to mean - usage of PWM/PFM etc
> mode(like in tps/twl chips), this makes sense. However, if we mean
> forward, reverse and bypass as "modes" we might be misusing the original
> intent of the API.

Yeah, I agree that using those modes would probably qualify as abuse.
However I still find it tempting to use FAST for FBB and maybe NORMAL or
STANDBY for bypass.

Instead of using a mode then a voltage could be used.  Any Vnom value
passed into regulator_set_voltage would result in ABB ldo being
bypassed, whereas if 900mV was passed in that would put the ABB ldo into
FBB.  And that 900mV value isn't really set in stone, it is just more
often than not the value observed on OMAP3630 and OMAP4.

However that is really a kludge and completely non-intuitive for someone
looking at the code for the first time.  I haven't gone digging through
the regulator stuff concerning this but I hope a good solution can be
found.

Regards,
Mike

> 
> -- 
> Regards,
> Nishanth Menon
