From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] hwrng: omap3-rom - Call clk_prepare() on init and
 exit only
Date: Sat, 14 Sep 2019 10:57:59 -0700
Message-ID: <20190914175759.GV52127@atomide.com>
References: <20190913220922.29501-1-tony@atomide.com>
 <20190913220922.29501-4-tony@atomide.com>
 <20190914125427.nvbrxoubvll43b3j@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190914125427.nvbrxoubvll43b3j@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [190914 13:01]:
> Hi,
> 
> On Fri, Sep 13, 2019 at 03:09:19PM -0700, Tony Lindgren wrote:
> > Also, we should not call prepare and unprepare except during init, and
> > only call enable and disable during use.
> 
> Why? Usually clk_(un)prepare() is the part saving most power, so I
> would expect the runtime resume handlers to call clk_prepare_enable
> and vice versa in the suspend handler.

Sure yeah fine with me, clk_prepare_enable() is more generic at the
cost of some extra calls to toggle a clock gate bit :) Let's also
forget the probe changes, those will get cleared with the runtime
PM changes anyways.

Regards,

Tony
