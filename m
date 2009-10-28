From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Wed, 28 Oct 2009 08:53:34 +0200
Message-ID: <1256712814.30157.388.camel@eenurkka-desktop>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
	<20091027160000.f276e706.jhnikula@gmail.com>
	<200910280752.23859.peter.ujfalusi@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200910280752.23859.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-10-28 at 06:52 +0100, Ujfalusi Peter (Nokia-D/Tampere)
wrote:
> On Tuesday 27 October 2009 16:00:00 ext Jarkko Nikula wrote:
> > On Tue, 27 Oct 2009 13:07:23 +0200
> > 
> > Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:
> > > Otherwise, that spinlocking is highly unnecessary and things are
> > > far better without than with it. The only case it could be useful
> > > is in SMPs, but OMAPs are not such quite yet - and when they
> > > are, things will need to be re-though anyway.
> > 
> > Following commit is suggesting that mcbsp code *must* be SMP safe
> > already now:
> > 
> > commit a5b92cc348299c20be215b9f4b50853ecfbf3864
> > Author: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > Date:   Tue Jul 28 18:57:10 2009 +0530
> > 
> >     ARM: OMAP4: Add McBSP support
> 
> Yeah, but I think this locking issue has nothing to do with SMP safe or not.
> On playback start in omap_mcbsp_request the mcbsp->free is cleared.
> Further modification to the dma_op_mode in dma_op_mode_store is not allowed if 
> the mcbsp port is in use, thus the dma_op_mode is protected against change while 
> the port is in use (ensuring that the mode is same in omap34xx_mcbsp_request and 
> omap_mcbsp_get_dma_op_mode functions). This alone makes the use of spinlock 
> around the dma_op_mode unnecessary.
> 

Yeah, maybe I took the SMP safeness into play without looking any code,
my bad =) I was remembering a different version of this McBSP thing, now
that I looked into it, it looked different.

Right, I reviewed the code, and it was first looking really bad at
sound/soc/omap/omap-mcbsp.c, where it calls omap_mcbsp_get_dma_op_mode()
from different places. However, it's not an issue because in:
arch/arm/plat-omap/mcbsp.c : dma_op_mode_store(),
the dma_op_mode is written only if the mcbsp is unoccupied. So it is SMP
safe.

..and a single read is always atomic, so this is buggy code:

301         spin_lock_irq(&mcbsp->lock);
302         dma_op_mode = mcbsp->dma_op_mode;
303         spin_unlock_irq(&mcbsp->lock);
304 
305         return dma_op_mode;

The spinlocks are unnecessary. In the above example, you get the same
with just "return mcbsp->dma_op_mode;"

-> Peter's patch is a good cleanup.
