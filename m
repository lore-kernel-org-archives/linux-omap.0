From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Introduce local common.h files
Date: Thu, 10 Nov 2011 15:33:47 -0800
Message-ID: <20111110233347.GZ31337@atomide.com>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk>
 <20111108004550.GH31337@atomide.com>
 <20111110201719.GW31337@atomide.com>
 <20111110202356.GQ15294@n2100.arm.linux.org.uk>
 <20111110215008.GX31337@atomide.com>
 <20111110222907.GR15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110222907.GR15294@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111110 13:54]:
> On Thu, Nov 10, 2011 at 01:50:09PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111110 11:49]:
> > 
> > OK, a stable branch is needed badly for this.. If possible please
> > publish some minimal stable base branch as soon as you can as pretty
> > much all omap patches need to be updated for this one.
> 
> I want to give it something between a week and two before closing the
> window for acked-bys etc (amongst other reasons).

OK
 
> > > If you agree, could you put it in the patch system please?  Thanks.
> > 
> > Sounds good to me, it there now as patch 7159/1.
> 
> Thanks, merged that into the series.  The updated OMAP patch updated is
> below, which has been moved to part 2.  Lastly, the final patch of part
> 2 has been updated to delete the empty arch_reset(), so OMAP is now
> entirely free of arch_reset() references.  This leaves a total of 12
> references left to nobble.

Great, good to hear.
 
> 8<---
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: [PATCH] ARM: restart: omap: use new restart hook
> 
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
