From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
Date: Wed, 11 Feb 2015 21:00:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502112056200.3767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com> <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com> <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com> <20150211203757.GH2531@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150211203757.GH2531@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jgchunter@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, "aaro.koskinen@iki.fi >> Aaro Koskinen" <aaro.koskinen@iki.fi>, tuukka.tikkanen@linaro.org, "khilman@deeprootsystems.com >> Kevin Hilman" <khilman@deeprootsystems.com>, "linux@arm.linux.org.uk >> Russell King" <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, 11 Feb 2015, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [150210 18:28]:
> > On Tue, 10 Feb 2015, Jon Hunter wrote:
> > > On 07/02/2015 00:23, Paul Walmsley wrote:
> > 
> > > Unfortunately, there is not a single TRM for the omap5910 but individual 
> > > documents for each chapter in the original TRM. Check out the "OMAP5910 
> > > Dual-Core Processor Timer Reference Guide" and possibly the "OMAP5910 
> > > Dual-Core Processor Clock Generation and System Reset Management 
> > > Reference Guide"
> > > 
> > > The omap15xx/5910 did have a 32k timer but as you can see it appears it
> > > was never supported by the kernel for this device (not sure why). I do
> > > recall that there is some errata regarding the 32k timer, if you look at
> > > the omap5910 errata document and search for 32k you should find it.
> > 
> > OK thanks for the context.  I probably am not going to investigate adding 
> > support for this timer on OMAP1510/5910 - am primarily trying to avoid 
> > causing a regression on the existing platforms.
> 
> At least I've never seen the 32KiHz timer registers in any 15xx
> documentation. Jon are you sure you're not mixing up 5910 (15xx)
> and 5912 (16xx)?

It's documented in the OMAP5910 Timer Reference Guide (SPRU682A) Section 3 
"32-kHz Timer", at the link Jon mentioned.  Have not checked the errata 
that Jon mentioned though.

Regarding the patch: I'd suggest keeping the compilation warning fixes 
(which was the original purpose of the patch) from anything that changes 
the logic too much.   That way if there's an error in the patch that 
changes the logic and it needs to be reverted, it won't also revert the 
warning fixes.


- Paul
