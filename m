From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Tue, 1 Jun 2010 11:19:30 +0300
Message-ID: <201006011119.30651.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201006010947.09640.peter.ujfalusi@nokia.com>
	<20100601103828.55e7b394.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100601103828.55e7b394.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi

Resending...

On Tuesday 01 June 2010 10:38:28 ext Jarkko Nikula wrote:
> On Tue, 1 Jun 2010 09:47:09 +0300
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > I like the following naming:
> > omap_mcbsp_hwrule_min_buffersize()
> > omap_mcbsp_hwrule_max_periodsize()
> =

> Looks clear to me.
> =

> > Also, I think there is no point to limit the lower period size in
> > threshold mode to 32, so I will remove that as well I think.
> =

> What was the reason why period size cannot be bigger than threshold?
> This constraint was there before your patch but I don't remember reason
> for it.

When DMA is used to push the data to McBSP on OMAP3:
The McBSP threshold means, that if threshold amount of locations (words) ar=
e =

free in the buffer, than the DMA request line will be asserted, and McBSP =

expects that DMA will transfer exactly threshold number of words in respons=
e =

to the DMA request.
So, if threshold is 1 (in register it is 0), than McBSP requests for new wo=
rd, =

whenever a single location is free in the FIFO. The DMA should send 1 word =
per =

DMA request.

If threshold is configured to 100 (99 in register), than McBSP will asserts=
 the =

DMA request line, when 100 locations are free. Than DMA has to send 100 wor=
ds =

per DMA request.

So we need to limit the period size (which is used to configure the DMA's e=
lem =

count - number of words per DMA request) that it shall never be bigger than=
 the =

threshold.

> Should it be opposite that period size cannot be smaller than threshold?

No.

Well... One thing I was wondering about for a long time.
If we change the way how McBSP/DMA is used on OMAP3 (we could use the frame=
 mode =

for that):
We place constraint on the period step to be the size of the threshold sele=
cted.
So userspace can have bigger periods than the McBSP FIFO and still gain ben=
efit =

from the usage of the FIFO.
So period size is x * threshold.
We configure McBSP threshold
We configure DMA to push threshold amount of word per request.
In the DMA callback, we count, and when the x-th DMA request has been serve=
d, =

than we call elapsed.
If there is interest, I might look at this.
I guess this could be useful on McBSP1,3,4, and 5, which has small FIFO...

-- =

P=E9ter
