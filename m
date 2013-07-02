From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 2/9] wlcore: use irq_flags in pdata instead of hiding
 it behind a quirk
Date: Tue, 2 Jul 2013 23:12:12 +0300
Message-ID: <1372795932.21065.84.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-3-git-send-email-coelho@ti.com>
 <20130702152657.GE7013@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130702152657.GE7013@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, linux-doc@vger.kernel.org, tony@atomide.com, linux-wireless@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-07-02 at 18:26 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 02, 2013 at 05:55:41PM +0300, Luciano Coelho wrote:
> > The platform_quirk element in the platform data was used to change the
> > way the IRQ is triggered.  When set, the EDGE_IRQ quirk would change
> > the irqflags used and treat edge trigger differently from the rest.
> > 
> > Instead of hiding this irq flag setting behind the quirk, export the
> > whole irq_flags element and let the board file define what to use.
> > This will be more meaningful than driver-specific quirks when we
> > switch to DT.
> > 
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-davinci/board-da850-evm.c      |    2 +-
> >  arch/arm/mach-omap2/board-4430sdp.c          |    1 +
> >  arch/arm/mach-omap2/board-omap3evm.c         |    1 +
> >  arch/arm/mach-omap2/board-omap4panda.c       |    1 +
> >  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
> >  drivers/net/wireless/ti/wlcore/debugfs.c     |    2 +-
> >  drivers/net/wireless/ti/wlcore/main.c        |   13 +++----------
> >  drivers/net/wireless/ti/wlcore/wlcore.h      |    5 ++---
> >  include/linux/wl12xx.h                       |    5 +----
> >  9 files changed, 12 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> > index 8a24b6c..d2a2a98 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> > @@ -1377,8 +1377,8 @@ static const short da850_wl12xx_pins[] __initconst = {
> >  
> >  static struct wl12xx_platform_data da850_wl12xx_wlan_data __initdata = {
> >  	.irq			= -1,
> > +	.irq_flags		= IRQF_TRIGGER_RISING,
> >  	.board_ref_clock	= WL12XX_REFCLOCK_38,
> > -	.platform_quirks	= WL12XX_PLATFORM_QUIRK_EDGE_IRQ,
> >  };
> >  
> >  static __init int da850_wl12xx_init(void)
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index 56a9a4f..c2334aa 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -693,6 +693,7 @@ static void __init omap4_sdp4430_wifi_mux_init(void)
> >  }
> >  
> >  static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata = {
> > +	.irq_flags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 
> couldn't you just call irq_set_irq_type() from the board-file itself ?
> Then on your driver you can just pass IRQF_ONESHOT (to make sure heh) to
> your request_threaded_irq_handler()

Good point.  This is an oldish patch from the time I still thought I'd
have to pass the flags in the device tree.  It turned out that I don't
need it anymore, so this can be totally removed from pdata and be set by
the board file itself.

As you saw in a later patch, I do make sure the driver sets
IRQF_ONESHOT. ;)

--
Cheers,
Luca.
