From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] omap2-clk: Add missing lcdc clock definition
Date: Wed, 31 Oct 2012 05:09:31 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB529E4@DBDE01.ent.ti.com>
References: <1351698962-3923-1-git-send-email-panto@antoniou-consulting.com>
 <20121030181837.GM11908@atomide.com>
 <alpine.DEB.2.00.1210302324530.6152@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1210302324530.6152@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 31, 2012 at 04:56:40, Paul Walmsley wrote:
> + Vaibhav Hiremath
> 
> On Tue, 30 Oct 2012, Tony Lindgren wrote:
> 
> > * Pantelis Antoniou <panto@antoniou-consulting.com> [121030 11:04]:
> > > Looks like the lcdc clock definition got dropped.
> > > It is required for the LCD controller to work. Reintroduce.
> > 
> > This looks like a regression, can you also add the commit
> > causing it?
> 
> Looks like probably a new "feature," in that this clock didn't exist in 
> the original check-in.  Would be good to get Vaibhav's opinion on this; 
> also the common clock patches will need to be updated.
> 

Thanks Paul for looping me in, something went wrong with my l-o subscription, 
so I didn't receive these Patches. 

As far as lck clock node is concerned, we had deliberately dropped all leaf-
node clocks from the clock tree, please refer to the description mentioned 
in -
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/101987.html


>From LCDC driver perspective, driver is using,

fb_clk = clk_get(&device->dev, NULL);

This I feel needs to be corrected for valid name as per Spec (mostly I would 
vote for "fck") and then every platform should make sure that it returns 
valid clock-node for it.

Change in Driver would be,

fb_clk = clk_get(&device->dev, "fck");


Thanks,
Vaibhav

> 
> - Paul
> 
