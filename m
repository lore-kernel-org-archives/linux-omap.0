From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Thu, 17 Mar 2016 15:18:00 +0000
Message-ID: <20160317151800.GH1184@io.lakedaemon.net>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171550200.3978@nanos>
 <56EAC761.1040801@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAC761.1040801@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2016 at 03:04:01PM +0000, Jon Hunter wrote:
> 
> On 17/03/16 14:51, Thomas Gleixner wrote:
> > On Thu, 17 Mar 2016, Jon Hunter wrote:
> > 
> >> Setting the interrupt type for private peripheral interrupts (PPIs) may
> >> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
> >> whether this is allowed. There is no way to know if setting the type is
> >> supported for a given GIC and so the value written is read back to
> >> verify it matches the desired configuration. If it does not match then
> >> an error is return.
> >>
> >> There are cases where the interrupt configuration read from firmware
> >> (such as a device-tree blob), has been incorrect and hence
> >> gic_configure_irq() has returned an error. This error has gone
> >> undetected because the error code returned was ignored but the interrupt
> >> still worked fine because the configuration for the interrupt could not
> >> be overwritten.
> >>
> >> Given that this has done undetected and we should only fail to set the
> >> type for PPIs whose configuration cannot be changed anyway, don't return
> >> an error and simply WARN if this fails. This will allows us to fix up any
> >> places in the kernel where we should be checking the return status and
> >> maintain back compatibility with firmware images that may have incorrect
> >> interrupt configurations.
> > 
> > Though silently returning 0 is really the wrong thing to do. You can add the
> > warn, but why do you want to return success?
> 
> Yes that would be the correct thing to do I agree. However, the problem
> is that if we do this, then after the patch "irqdomain: Don't set type
> when mapping an IRQ" is applied, we may break interrupts for some
> existing device-tree binaries that have bad configuration (such as omap4
> and tegra20/30 ... see patches 1 and 2) that have gone unnoticed. So it
> is a back compatibility issue.

This sounds like a textbook case for adding a boolean dt property.  If
"can-set-ppi-type" is absent (old DT blobs and new blobs without the
ability), warn and return zero.  If it's present, the driver can set the
type, returning errors as encountered.

thx,

Jason.
