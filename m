From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Introduce local common.h files
Date: Thu, 10 Nov 2011 20:23:56 +0000
Message-ID: <20111110202356.GQ15294@n2100.arm.linux.org.uk>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk> <20111108004550.GH31337@atomide.com> <20111110201719.GW31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110201719.GW31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 12:17:19PM -0800, Tony Lindgren wrote:
> As suggested by Russell King - ARM Linux <linux@arm.linux.org.uk>,
> there's no need to keep local prototypes in non-local headers.
> 
> Add mach-omap1/common.h and mach-omap2/common.h and move the
> local prototypes there from plat/common.h and mach/omap4-common.h.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Great, looks fine, thanks.  I suspect the chance of conflicts on this are
about the same as the chance of conflicts with the rest of the restart
series (in that, new platforms will need to be fixed for both these
changes.)

So, I suggest that I add it to my series so I can fix the OMAP changes
there so stuff still builds - and then I can see about publishing a more
stable branch in a couple of weeks for new platforms to base on.

If you agree, could you put it in the patch system please?  Thanks.
