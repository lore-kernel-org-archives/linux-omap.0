From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 1 Apr 2013 18:00:10 -0500
Message-ID: <20130401230009.GA2038@snafu>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
 <20130328212739.13785.44736@quantum>
 <20130328223513.GA19470@kahuna>
 <51596725.9060109@ti.com>
 <20130401181057.8177.19688@quantum>
 <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com>
 <20130401213430.8177.21940@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48573 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756506Ab3DAXAL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 19:00:11 -0400
Content-Disposition: inline
In-Reply-To: <20130401213430.8177.21940@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

On 14:34-20130401, Mike Turquette wrote:
> Quoting Nishanth Menon (2013-04-01 12:28:20)
> > On Mon, Apr 1, 2013 at 1:10 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > > Let's figure out what is happening to the VC/VP code first and then
> > > figure out what to do about ABB.
> > >
> > http://picpaste.com/KmqDYTn0.jpg
> > is an quick depiction of the thought I have in my mind.
> > 
> 
> OK, looks like the Super Regulator Approach(tm).
:D I hope it can be modelled after TI SoCs and then expanded to other
SoCs as needed.
> 
> > We do have, in the upcoming SoCs, where Nominal Voltages per device,
> > will now be encoded into the efuse itself(so called class 0 voltage).
> > Future SoCs will need to be able to use ABB along with standard
> > regulators (without use of VC-VP) - in fact, even today, SoCs like AM
> > and DM series of processors have the same requirement.
> > 
> 
> This de-linking of ABB from VC/VP probably supports modeling ABB ldo's
> as Linux regulators.  That would provide a common interface where either
> the VC/VP code or another regulator could call something like
> regulator_set_mode.
> 
> If we're going to export something which can get called by different
> actors it's best to use an already exported interface which the
> regulator framework supplies, instead of exporting something new and
> omap-specific.
Yep - that was my original thought - though modeling it as a regulator
in itself is, IMHO, I think is a good idea.

> 
> > We also will have to support class 2 variants of AVS (which will use
> > standard regulators to set voltage).
> > 
> > As of date, CCF does not control regulators - which means the interim
> > solution would be for the device control to manipulate both clock and
> > regulator voltage (similar to what cpufreq-cpu0 driver does today).
> > these drivers should not know the existance of SoC specific
> > intricacies - so ABB linked to voltage values make more sense if ABB
> > sequencing is handled in "TI regulator"
> > 
> > Intent of VC/VP regulator is to be replaceable, on required platforms,
> > with appropriate regulator which do not use VC/VP paths (e.g. on SoCs
> > that do not have it).
> > 
> 
> Well if everything is nicely modeled then I suppose per-board and
> per-soc DT will give you the ability to link things up nicely.  E.g.
> replacing VC/VP with an external physical LDO, etc.

True - that is precisely what are attempting to do in (hopefully) edible
stages :).

-- 
Regards,
Nishanth Menon
