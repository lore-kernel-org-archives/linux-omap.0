From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Fri, 10 Nov 2017 16:39:22 +0000
Message-ID: <20171110163922.GK28231@n2100.armlinux.org.uk>
References: <20171013205915.9652-1-d-gerlach@ti.com>
 <20171013205915.9652-3-d-gerlach@ti.com>
 <19256977-40e1-a972-4de8-838a8da863cc@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19256977-40e1-a972-4de8-838a8da863cc@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 16, 2017 at 08:31:59AM -0700, Santosh Shilimkar wrote:
> Hi Russell,
> 
> On 10/13/2017 1:59 PM, Dave Gerlach wrote:
> >Certain SoCs like Texas Instruments AM335x and AM437x require parts
> >of the EMIF PM code to run late in the suspend sequence from SRAM,
> >such as saving and restoring the EMIF context and placing the memory
> >into self-refresh.
> >
> >One requirement for these SoCs to suspend and enter its lowest power
> >mode, called DeepSleep0, is that the PER power domain must be shut off.
> >Because the EMIF (DDR Controller) resides within this power domain, it
> >will lose context during a suspend operation, so we must save it so we
> >can restore once we resume. However, we cannot execute this code from
> >external memory, as it is not available at this point, so the code must
> >be executed late in the suspend path from SRAM.
> >
> >This patch introduces a ti-emif-sram driver that includes several
> >functions written in ARM ASM that are relocatable so the PM SRAM
> >code can use them. It also allocates a region of writable SRAM to
> >be used by the code running in the executable region of SRAM to save
> >and restore the EMIF context. It can export a table containing the
> >absolute addresses of the available PM functions so that other SRAM
> >code can branch to them. This code is required for suspend/resume on
> >AM335x and AM437x to work.
> >
> >In addition to this, to be able to share data structures between C and
> >the ti-emif-sram-pm assembly code, we can automatically generate all of
> >the C struct member offsets and sizes as macros by processing
> >emif-asm-offsets.c into assembly code and then extracting the relevant
> >data as is done for the generated platform asm-offsets.h files.
> >
> >Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >---
> >v4->v5:
> >* Simplify Makefile to generate include/generated/ti-emif-asm-offsets.h
> >
> If you are happy with this version from Dave, can I get your ack please?
> I can add this to the driver-soc then.

Does it need my ack anymore?  It doesn't touch anything in arch/arm.
If you still want it, then... notwithstanding the loss of type checking
that fncpy() gave and the new sram stuff messes up...

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
