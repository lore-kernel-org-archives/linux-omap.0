From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
 constraints for streams
Date: Tue, 1 Jun 2010 12:29:21 +0300
Message-ID: <20100601122921.6d842ae8.jhnikula@gmail.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201006010947.09640.peter.ujfalusi@nokia.com>
	<20100601103828.55e7b394.jhnikula@gmail.com>
	<201006011119.30651.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201006011119.30651.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Jun 2010 11:19:30 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> If threshold is configured to 100 (99 in register), than McBSP will asserts the 
> DMA request line, when 100 locations are free. Than DMA has to send 100 words 
> per DMA request.
> 
> So we need to limit the period size (which is used to configure the DMA's elem 
> count - number of words per DMA request) that it shall never be bigger than the 
> threshold.
> 
Now I get it with some get hands dirty testing :-)

So this is a feature of SDMA that in threshold mode the transfer size
must equal or smaller than threshold (as says the TRM). Still don't
understand why the transfer size is dependent on peripheral FIFO
threshold size but that's the fact and we must obey it as Eduardo's
original patch and your's are doing.

> If there is interest, I might look at this.
> I guess this could be useful on McBSP1,3,4, and 5, which has small FIFO...
> 
Yes, have a packet based DMA transfer saving power and then we have
bunch of interrupts coming :-)


-- 
Jarkko
