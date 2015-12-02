From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 2 Dec 2015 10:13:30 -0800
Message-ID: <20151202181330.GG64635@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151026212346.GJ13239@google.com>
 <562F45BF.8020205@ti.com>
 <20151130195449.GI64635@google.com>
 <565DB18C.7040505@ti.com>
 <20151202032643.GF64635@google.com>
 <565E7DAC.7060401@ti.com>
 <20151202150317.GC23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151202150317.GC23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 02, 2015 at 07:03:17AM -0800, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [151201 21:13]:
> > On 02/12/15 08:56, Brian Norris wrote:
> > > 
> > > I'll take another pass over your patch set, but if things are looking
> > > better, how do you expect to merge this? There are significant portions
> > > that touch at least 2 or 3 different subsystem trees, AFAICT.
> > 
> > Tony could create an immutable branch with all the dts and memory changes.
> > You could base the mtd changes on top of that?
> 
> If we all agree on that it will be immutable Roger can set up the branch
> with our acks and we can all merge it in as needed. I believe v4.4-rc1
> should work as a base for us all?

There are oustanding comments about the NAND ready/busy GPIO naming in
patch 18, which I'd like addressed. I'll re-review the rest before the
end of the day (West Coast U.S.A.). I'm not sure my acks are worth much
beyond the MTD stuff.

Regarding branches, 4.4-rc1 is fine with me.

Regards,
Brian
