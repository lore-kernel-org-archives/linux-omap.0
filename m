From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/5] regulator: Introduce TI Adaptive Body Bias(ABB)
 on-chip LDO driver
Date: Fri, 3 May 2013 07:03:50 -0500
Message-ID: <20130503120349.GA2735@snafu>
References: <1367515215-30753-1-git-send-email-nm@ti.com>
 <1367515215-30753-2-git-send-email-nm@ti.com>
 <20130503090258.GG4945@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130503090258.GG4945@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On 10:02-20130503, Mark Brown wrote:
> On Thu, May 02, 2013 at 12:20:10PM -0500, Nishanth Menon wrote:
> > From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
> > 
> > Adaptive Body Biasing (ABB) modulates transistor bias voltages
> > dynamically in order to optimize switching speed versus leakage.
> 
> I've applied this but please note that I still have deep concerns about
> some of the discussion about controlling this from other regulators.
Thanks for the merge.

We don't have any further plans of pursuing the concept of regulator
chaining for upstream. After an off-line chat with Mike T, we are
planning on introducing OMAP specific notifier hooks to clock
framework. This should allow us to do the appropriate sequencing
necessary to control AVS, regulators for ABB and PMIC in the right
sequence.

-- 
Regards,
Nishanth Menon
