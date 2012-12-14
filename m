From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] OMAP: board-files: fix i2c_bus for tfp410
Date: Fri, 14 Dec 2012 09:23:52 -0800
Message-ID: <20121214172350.GS4989@atomide.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
 <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
 <50B87CD2.8010107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50B87CD2.8010107@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <thomas@tomweber.eu>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121130 01:33]:
> Hi Tony,
> 
> On 2012-11-22 10:39, Tomi Valkeinen wrote:
> > The i2c handling in tfp410 driver, which handles converting parallel RGB
> > to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af
> > (OMAPDSS: TFP410: pdata rewrite). The patch changed what value the
> > driver considers as invalid/undefined.  Before the patch, 0 was the
> > invalid value, but as 0 is a valid bus number, the patch changed this to
> > -1.
> > 
> > However, the fact was missed that many board files do not define the bus
> > number at all, thus it's left to 0. This causes the driver to fail to
> > get the i2c bus, exiting from the driver's probe with an error, meaning
> > that the DVI output does not work for those boards.
> > 
> > This patch fixes the issue by changing the i2c_bus number field in the
> > driver's platform data from u16 to int, and setting the bus number to -1
> > in the board files for the boards that did not define the bus. The
> > exception is devkit8000, for which the bus is set to 1, which is the
> > correct bus for that board.
> > 
> > The bug exists in v3.5+ kernels.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Reported-by: Thomas Weber <thomas@tomweber.eu>
> > Cc: Thomas Weber <thomas@tomweber.eu>
> > Cc: <stable@vger.kernel.org> # v3.5+
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c      |    1 +
> >  arch/arm/mach-omap2/board-am3517evm.c    |    1 +
> >  arch/arm/mach-omap2/board-cm-t35.c       |    1 +
> >  arch/arm/mach-omap2/board-devkit8000.c   |    1 +
> >  arch/arm/mach-omap2/board-omap3evm.c     |    1 +
> >  arch/arm/mach-omap2/board-omap3stalker.c |    1 +
> >  include/video/omap-panel-tfp410.h        |    2 +-
> >  7 files changed, 7 insertions(+), 1 deletion(-)
> 
> Did this make it into your v3.8 branch?

Applying now into omap-for-v3.8/fixes-for-merge-window.

Thanks,

Tony
