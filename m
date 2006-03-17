From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: RE: ALSA with OMAP1510
Date: Fri, 17 Mar 2006 17:51:39 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C09365D@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hai

I am using TI Innovator OMAP1510 kit (This does not have tsc2101, but
AIC23 is the codec and ADS7846 touch screen controller). Kernel 2.6.14
toolchain gcc3.4.1.=20

1) While selecting ALSA in menuconfig (kernel 2.6.14), is it required to
select AIC23 separately somewhere (I do not know where) for ALSA to
work?

2) If I select OSK5912 it gives the following error.
ALSA / OSK5912 enabled sound/built-in.o(.text+0x3c16c):=20
In function `$a':
: undefined reference to `OMAP_DMA_CCR' sound/built-in.o(.text+0x3c178):

In function `$a': : undefined reference to `OMAP_DMA_CCR'


3) If I select OSS driver also along with ALSA the following error is
observed.

OSS Sound modules / Persistent DMA buffers enabled
sound/oss/soundcard.c:68: error: `MAX_DMA_CHANNELS' undeclared here (not
in a function)
sound/oss/soundcard.c:68: error: storage size of `dma_alloc_map' isn't
known sound/oss/soundcard.c:68: warning: 'dma_alloc_map' defined but not
used make[2]: *** [sound/oss/soundcard.o] Error 1 make[1]: ***
[sound/oss] Error 2 make: *** [sound]

4) Do you have any idea of the source of error (or what to do)?

5) Also does "aplay" gets compiled with the kernel if you select ALSA
driver?
What we have to do to get "aplay" also compiled?

Hope kernel-2.6.14 / ALSA supports sound in OMAP1510 TI Innovator.

Thanks in advance
Regards
Prakash


-----Original Message-----
From: lamikr [mailto:lamikr@cc.jyu.fi]=20
Sent: Thursday, March 16, 2006 11:42 PM
To: Daniel Petrini
Cc: Prakash Narayanan M; linux-omap-open-source@linux.omap.com
Subject: Re: ALSA with OMAP1510


>You should use "aplay test.raw" to play using alsa stack.
> =20
>
Yes, for alsa driver the "aplay" should be the easiest solution.
I have myself used alsa succesfully with the tsc2101 chipset and latest
kernel in git repository (about 2.6.16-rc5)
by applying the 3 patches I and daniel send for the list about 10 days
ago.

Daniel tested the tsc2101 and aic23 drivers by using OSK and H2 boards.
I used myself omap1510 based h6300 for writing and testing. With that
board there were two issues compared to other devices that I needed to
handle.

1) I needed to add following to audio_process_dma() in
sound/arm/omap_alsa.c that was was not needed by other boards.
    Without this, the dma stopped after first small buffer transfered.
If you have problems you could enable that also for your boards.

#ifdef CONFIG_MACH_OMAP_H6300
        spin_lock_irqsave(&s->dma_lock, flags);
        omap_stop_alsa_sound_dma(s);
        spin_unlock_irqrestore(&s->dma_lock, flags);
#endif

2) In sound/arm/omap/omap-alsa-tsc2101.c tsc2101_snd_omap_alsa_playback
structure h6300 needs to be configured to have 8 bit dma.
(this is not yet in the patch sent to the list)

#ifdef CONFIG_MACH_OMAP_H6300
    .formats =3D (SNDRV_PCM_FMTBIT_S8),
#else
    .formats =3D (SNDRV_PCM_FMTBIT_S16_LE),
#endif

If you want to test the play with different samplerates, you can use a
program called "sox" for creating wavs with different samplerates.
(sox song.wav -r 8000 -c 1  -s -w song8000.wav)
**
Mika
