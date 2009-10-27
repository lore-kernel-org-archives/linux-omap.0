From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Tue, 27 Oct 2009 12:00:09 +0000
Message-ID: <20091027120009.GA19323@rakim.wolfsonmicro.main>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
	<200910271317.52638.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200910271317.52638.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 27, 2009 at 01:17:52PM +0200, Peter Ujfalusi wrote:
> On Tuesday 27 October 2009 13:07:23 Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:

> > You may wish to double read the message above, as it's quite
> > confusing =)

> Yes it is ;)
> I have left one spinlock around the dma_op_mode, when it also protects the 
> mcbsp->active, so that is why that last sentence.

I have to confess that I'm still not entirely clear what the lock is
supposed to be doing or why it's OK to drop it.  I gather that it's just
that dmap_on_mode() doesn't need a lock at all?
