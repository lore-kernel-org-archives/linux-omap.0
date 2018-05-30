From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in Linux next again
Date: Wed, 30 May 2018 07:45:05 -0700
Message-ID: <20180530144505.GB5705@atomide.com>
References: <20180529221501.GJ5702@atomide.com>
 <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
 <20180530091314.GB6920@sirena.org.uk>
 <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
 <20180530143338.GM6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530143338.GM6920@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180530 14:36]:
> On Wed, May 30, 2018 at 04:03:15PM +0200, Maciej Purski wrote:
> 
> > I'm afraid, I have no idea, how to fix it quickly. You can revert it and
> > in the next version I'll fix the build error and split the last patch even
> > more, so we could perform a more precise bisection. I'd be grateful if you
> > could push it on your test coupled branch and Tony could test it again before
> > merging it with next again.
> 
> Yeah, if we could get testing from Tony first that'd be ideal.

I can boot test the patches easily no problem. Maciej, maybe email
me some debug version and I'll email you back the dmesg output.

Regards,

Tony
