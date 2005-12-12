From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Mon, 12 Dec 2005 15:34:11 -0400
Message-ID: <9268368b0512121134j2e3abc93g57f8982352147406@mail.gmail.com>
References: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
	<20051123164523.GC7547@atomide.com> <4389F0EB.6000404@de.bosch.com>
	<438AD41C.4090006@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <438AD41C.4090006@de.bosch.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dirk,

On 11/28/05, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> Dirk Behme wrote:
> > Yves Godin wrote:
> >  > The files from the alsa driver have not changed between 2.6.14-rc1 a=
nd
> >  > 2.6.14-omap2. So I supposed the changes have been made to the OMAP d=
ma
> >  > drivers.
> >
> > Looks to me that it is something in DMA as well.
>
> Next step ;) Looking into sound/oss/omap-audio-dma-intfc.c I found that
> there is done much more stuff than in sound/arm/omap-alsa-dma.c. So, I
> put the ping pong work item logic from OSS DMA to ALSA DMA as well. And
> looks like this fixes the issue of repeated audio samples :)
>
> Please test. I use 'madplay foo.mp3' for tests.
>
> But unfortunately, now there seems to be some noise over the (now
> unrepeated) audio output.
>
> Any ideas about that?

Tested this as well (against omap-2.6.15-rc4), the ping pong works,
but you have to set nr_linked_channels to 2 or 3, unlike your patch
which has 1 for this variable.

I heard the same noise throughout the music playing. Both in mp3 and wav.
With the increased channels it became more prone to inconsistences if
I stop the music with ctrl-c. But worth mention that after this key
combination, if the song can restart (calling the command again), it
starts without the mentioned noises.

Daniel
--
INdT - Manaus - Brazil
