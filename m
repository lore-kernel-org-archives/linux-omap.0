From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dmaengine: edma: fix build without CONFIG_OF
Date: Wed, 04 Nov 2015 11:29:01 +0100
Message-ID: <3771870.4l0jsKt335@wuerfel>
References: <17811472.bY8CqmdEVy@wuerfel> <16166945.0Jm7Xdjkb9@wuerfel> <5639CA72.4050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5639CA72.4050604@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 04 November 2015 11:05:54 Peter Ujfalusi wrote:
> > 
> > I think that would be less readable, and gives no compile-time coverage
> > to the contents of the edma_tc_set_pm_state function.
> 
> Hrm, if the compiler knows that there is no need to compile the code after the:
> if (!IS_ENABLED(CONFIG_OF) || !tc)
> when OF is disabled, then it does not give more compile coverage then have
> empty inline function in case of !OF.

No, the way it works (simplified but close enough here) is that gcc parses
all the source code first and throws warnings or errors for everything that
looks wrong to it, and only later throws out all code that it knows is never
used before emitting the object code.

The difference to the #ifdef is that the preprocessor here throws out all
disabled code before it gets parsed, so we don't get warnings for it.

> Not sure about it, but if we disable all optimization in gcc, then we might
> get the same missing symbol?

It's impossible to build the kernel with inlining disabled, because we
rely on the same kind of optimization in lots of places.

> > The effect is the same, so I'd rather stay with my version.
> 
> I'm fine with both. It is up to Vinod to decide which one he prefers (I prefer
> the #if #else #endif version).
> 
> Anyways:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks!

	Arnd
