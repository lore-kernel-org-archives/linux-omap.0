From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Fri, 4 Nov 2011 21:01:52 +0000
Message-ID: <20111104210151.GA2541@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
 <1319702185-16108-3-git-send-email-rnayak@ti.com>
 <20111104203422.GB3918@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111104203422.GB3918@quad.lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Rajendra Nayak <rnayak@ti.com>, grant.likely@secretlab.ca, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 01:34:22PM -0700, Olof Johansson wrote:

> Shouldn't a fixed regulator just be a subset of a fixed one? If so, should the
> binding be merged with that one?

No, the fixed voltage regultor is a superset of a general regulator - it
has additional information like the voltage it supplies and the optional
enable GPIO.

> > +- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no

> Same here, you can drop the prefix. Also, the regular regulators use
> "regulator-name" for the supply name, it would make sense to reuse the same
> naming here, right?

I'm having a hard time associating your second comment with the property
being discussed - could you clarify please?
