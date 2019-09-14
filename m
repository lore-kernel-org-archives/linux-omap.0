From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] Non-urgent fixes and improvments for omap3-rom-rng
Date: Sat, 14 Sep 2019 10:59:13 -0700
Message-ID: <20190914175913.GW52127@atomide.com>
References: <20190913220922.29501-1-tony@atomide.com>
 <20190914130540.jvtxaame7pat7jph@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190914130540.jvtxaame7pat7jph@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [190914 13:06]:
> Hi,
> 
> On Fri, Sep 13, 2019 at 03:09:16PM -0700, Tony Lindgren wrote:
> > Here are fixes and improvments for omap3-rom-rng that's been broken for
> > a while.
> > 
> > The first four patches get it working, and then the last two patches add
> > support for runtime PM.
> 
> Nice cleanups, the series is
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Assuming you use clk_prepare_enable() in the runtime PM handler, I
> suggest to add another patch and go all the way to managed resources:
> devm_add_action() can be used for disabling runtime PM and
> devm_hwrng_register() can be used to register the hwrng device.

Sure good idea. I'll post a patch for that when I post v2 of
this set.

Regards,

Tony
