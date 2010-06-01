From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Tue, 1 Jun 2010 13:30:10 +0300
Message-ID: <201006011330.11044.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201006011119.30651.peter.ujfalusi@nokia.com>
	<20100601122921.6d842ae8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100601122921.6d842ae8.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 June 2010 12:29:21 ext Jarkko Nikula wrote:
> On Tue, 1 Jun 2010 11:19:30 +0300
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > If threshold is configured to 100 (99 in register), than McBSP will
> > asserts the DMA request line, when 100 locations are free. Than DMA has
> > to send 100 words per DMA request.
> > =

> > So we need to limit the period size (which is used to configure the DMA=
's
> > elem count - number of words per DMA request) that it shall never be
> > bigger than the threshold.
> =

> Now I get it with some get hands dirty testing :-)
> =

> So this is a feature of SDMA that in threshold mode the transfer size
> must equal or smaller than threshold (as says the TRM).

No exactly. This is the feature of McBSP, that the SDMA must transfer exact=
ly =

the same number of words as the McBSP threshold on DMA request.

> Still don't understand why the transfer size is dependent on peripheral F=
IFO
> threshold size but that's the fact and we must obey it as Eduardo's
> original patch and your's are doing.

Because, if you want to transfer in one SDMA burst more than the space free=
 in =

the McBSP FIFO, than where would the rest go?

> =

> > If there is interest, I might look at this.
> > I guess this could be useful on McBSP1,3,4, and 5, which has small
> > FIFO...
> =

> Yes, have a packet based DMA transfer saving power and then we have
> bunch of interrupts coming :-)

I guess it could be better than having 128 word long periods on McBSP1, 3, =
4, =

and 5. With small period size the applications also need to be woken up, bu=
t if =

we silently handling the DMA IRQs, and the application is only woken up by =
every =

10. DMA IRQ, it might still save some power?



-- =

P=E9ter
