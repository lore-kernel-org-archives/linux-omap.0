From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 2 Dec 2015 10:43:30 -0800
Message-ID: <20151202184330.GH64635@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151026212346.GJ13239@google.com>
 <562F45BF.8020205@ti.com>
 <20151130195449.GI64635@google.com>
 <565DB18C.7040505@ti.com>
 <20151202032643.GF64635@google.com>
 <565E7DAC.7060401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565E7DAC.7060401@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Wed, Dec 02, 2015 at 10:42:12AM +0530, Roger Quadros wrote:
> On 02/12/15 08:56, Brian Norris wrote:
> > On Tue, Dec 01, 2015 at 04:41:16PM +0200, Roger Quadros wrote:
> >> On 30/11/15 21:54, Brian Norris wrote:
> >>> But anyway, I'm not sure that completely answered my question. My
> >>> question was whether you were removing the irqchip code solely for
> >>> performance reasons, or are there others?
> >>
> >> Yes. Only for performance reasons.
> > 
> > Hmm, that's not my favorite answer. I'd prefer that more analysis was
> > done here before scrapping irqchip...
> 
> I agree. We could retain the irqchip model till we have more satisfying
> analysis.

I won't insist, though if it's not too ugly/horrible to do so, I think
that would make sense. I'll leave it as your call.

Brian
