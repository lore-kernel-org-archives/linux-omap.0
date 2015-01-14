From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
Date: Wed, 14 Jan 2015 09:07:17 -0800
Message-ID: <20150114170716.GL2419@atomide.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
 <20150106173734.GL6502@saruman>
 <20150108162512.GC31926@saruman>
 <20150112164654.GB6525@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150112164654.GB6525@saruman>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150112 08:50]:
> Hi,
> 
> On Thu, Jan 08, 2015 at 10:25:12AM -0600, Felipe Balbi wrote:
> > On Tue, Jan 06, 2015 at 11:37:34AM -0600, Felipe Balbi wrote:
> > > On Fri, Dec 26, 2014 at 01:28:20PM -0600, Felipe Balbi wrote:
> > > > STATUS register can be modified by the HW, so we
> > > > should bypass cache because of that.
> > > > 
> > > > In the case of INT[12] registers, they are the ones
> > > > that actually clear the IRQ source at the time they
> > > > are read. If we rely on the cache for them, we will
> > > > never be able to clear the interrupt, which will cause
> > > > our IRQ line to be disabled due to IRQ throttling.
> > > > 
> > > > Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> > > > Cc: <stable@vger.kernel.org> # v3.15+
> > > > Cc: Keerthy <j-keerthy@ti.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > > ping
> > 
> > another ping. Without this and the following patch TPS65218 power button
> > driver which was already applied by Dmitry, won't work.
> 
> Anybody ? -rc4 is out and tps65218 is still broken because nobody has
> acted on these two patches. All other patches which are meant for 3.20
> merge window are applied and because of these pending, those patches
> won't work.

Lee, are you planning to pick these two drivers/mfd patches?

Regards,

Tony
