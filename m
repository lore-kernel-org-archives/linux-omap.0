From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Tue, 27 Oct 2009 14:04:06 +0200
Message-ID: <1256645046.30157.344.camel@eenurkka-desktop>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
	<200910271317.52638.peter.ujfalusi@nokia.com>
	<20091027120009.GA19323@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091027120009.GA19323@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2009-10-27 at 13:00 +0100, ext Mark Brown wrote:
> On Tue, Oct 27, 2009 at 01:17:52PM +0200, Peter Ujfalusi wrote:
> > On Tuesday 27 October 2009 13:07:23 Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:
> 
> > > You may wish to double read the message above, as it's quite
> > > confusing =)
> 
> > Yes it is ;)
> > I have left one spinlock around the dma_op_mode, when it also protects the 
> > mcbsp->active, so that is why that last sentence.
> 
> I have to confess that I'm still not entirely clear what the lock is
> supposed to be doing or why it's OK to drop it.  I gather that it's just
> that dmap_on_mode() doesn't need a lock at all?

Mostly thinko's with this locking:

-       spin_lock_irq(&mcbsp->lock);
         dma_op_mode = mcbsp->dma_op_mode;
-       spin_unlock_irq(&mcbsp->lock);
 
         return dma_op_mode;


--> same as 
	return mcbsp->dma_op_mode;

and worst, it's called from pcm_trigger() ->
so irqs are enabled -> lockdep isn't happy ->
so currently things are pretty much "broken".

- Eero
