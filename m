From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: Re: Re: ALSA with OMAP1510
Date: Tue, 21 Mar 2006 16:44:20 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C093662@edpc500.cedt.iisc.ernet.in>
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

Hi=20

=20

Thanks Daniel for that. I have put the OSS drivers as suggested.  The
kernel boots and gives message that ACI23 codec initialized.  I tried
two tests with the sound device=20

1) #cat /dev/dsp > t

   #cat t > /dev/dsp

   #cat test.raw > /dev/dsp

=20

2) C program opens mixer sets the mic gain.  Set the rate/bits/channels.
Open dsp and read and fill a buffer. Then open dsp in write mode and
write the buffer.

=20

In both cases (1 & 2), I found as soon as the dsp device is opened just
noise is coming (like FM radio noise without a carrier lock).   This
problem I was facing with kernel 2.4.19 and with suggestions from
linux-omap fourm I switched to 2.6.16 now.

=20

Can anyone suggest the source of the problem?  Help will be most
valuable.

=20

Thanks in advance

=20

>Hi Prakash,

=20

>Look, I think that Mika's suggestion is a good idea: first of all try
to include >standard sound support in innovator with OSS drivers. They
surely work. Then you go to >ALSA. The aic23 codec chip is present in
innovator and if you have audio is through it.

>Compare the .config files generated for oss and alsa. Look for the
>CONFIG_TLC320AIC23_SENSOR or something like that ,the AIC23 keyword, in
that file and >compare its selections. This chip is the audio codec and
is mandatory for any audio >configuration.

=20

>Cheer,

>Daniel

=20

On 3/20/06, Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in> wrote:

>=20

> Hi

>=20

> > It should be automatically selected but you can confirm that looking


> > in Drivers/I2C SUpport/Micellaneous I2C Chips/TLV320AIC23 in make=20

> > menuconfig and select if not already.

>=20

>  I am not getting TLV320AIC23 option in the above said place.....nor=20

> anywhere else.  ALSA gives this option but for OMAP5912 (I guess this=20

> cannot be enabled for OMAP1510, which we tried and got a kernel
panic).

> Is there some other patch to be applied?

> I am using Kernel 2.6.16 git tree with OMAP1 patch applied.  I also=20

> tried applying your patches discussed in ROUND 2 of the discussion in=20

> ALSA modularization in linux-omap forum.  This also produced the same=20

> result.

>=20

> Thanks in advance.

>=20

> Regards

> Prakash

>=20

> Hi,

>=20

> On 3/17/06, Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in> wrote:

> > Hai

> >

> > I am using TI Innovator OMAP1510 kit (This does not have tsc2101,=20

> > but

> > AIC23 is the codec and ADS7846 touch screen controller). Kernel=20

> > 2.6.14 toolchain gcc3.4.1.

> >

> > 1) While selecting ALSA in menuconfig (kernel 2.6.14), is it=20

> > required

> to

> > select AIC23 separately somewhere (I do not know where) for ALSA to=20

> > work?

>=20

> It should be automatically selected but you can confirm that looking=20

> in Drivers/I2C SUpport/Micellaneous I2C Chips/TLV320AIC23 in make=20

> menuconfig and select if not already.

>=20

>=20

>=20

>=20

> > 2) If I select OSK5912 it gives the following error.

> > ALSA / OSK5912 enabled sound/built-in.o(.text+0x3c16c):

> > In function `$a':

> > : undefined reference to `OMAP_DMA_CCR'

> sound/built-in.o(.text+0x3c178):

> >

> > In function `$a': : undefined reference to `OMAP_DMA_CCR'

>=20

> Humm, I don't know about it. In my tests I could generate a 1510=20

> kernel finely, although I can not test it.

>=20

> > 3) If I select OSS driver also along with ALSA the following error=20

> > is observed.

> >

> > OSS Sound modules / Persistent DMA buffers enabled

> > sound/oss/soundcard.c:68: error: `MAX_DMA_CHANNELS' undeclared here

> (not

> > in a function)

> > sound/oss/soundcard.c:68: error: storage size of `dma_alloc_map'=20

> > isn't known sound/oss/soundcard.c:68: warning: 'dma_alloc_map'=20

> > defined but

> not

> > used make[2]: *** [sound/oss/soundcard.o] Error 1 make[1]: ***=20

> > [sound/oss] Error 2 make: *** [sound]

>=20

> You should not select OSS along with ALSA, both in the main "Sound=20

> Card Support" menu. There is an option inside  ALSA menu called "OSS=20

> PCM" you can select it for OSS emulation if you wish.

>=20

> > 4) Do you have any idea of the source of error (or what to do)?

> >

> > 5) Also does "aplay" gets compiled with the kernel if you select=20

> > ALSA driver?

> > What we have to do to get "aplay" also compiled?

>=20

> Aplay is a user space application, you can install it in your file=20

> system. You can use it in your PC, as well, as long as it has alsa=20

> suport on it.

>=20

> > Hope kernel-2.6.14 / ALSA supports sound in OMAP1510 TI Innovator.

> >

> > Thanks in advance

> > Regards

> > Prakash

>=20

> Regards,

> Daniel

>=20

> > -----Original Message-----

> > From: lamikr [mailto:lamikr@cc.jyu.fi]

> > Sent: Thursday, March 16, 2006 11:42 PM

> > To: Daniel Petrini

> > Cc: Prakash Narayanan M; linux-omap-open-source@linux.omap.com

> > Subject: Re: ALSA with OMAP1510

> >

> >

> > >You should use "aplay test.raw" to play using alsa stack.

> > >

> > >

> > Yes, for alsa driver the "aplay" should be the easiest solution.

> > I have myself used alsa succesfully with the tsc2101 chipset and

> latest

> > kernel in git repository (about 2.6.16-rc5) by applying the 3=20

> > patches I and daniel send for the list about 10 days ago.

> >

> > Daniel tested the tsc2101 and aic23 drivers by using OSK and H2

> boards.

> > I used myself omap1510 based h6300 for writing and testing. With=20

> > that board there were two issues compared to other devices that I=20

> > needed to handle.

> >

> > 1) I needed to add following to audio_process_dma() in=20

> > sound/arm/omap_alsa.c that was was not needed by other boards.

> >     Without this, the dma stopped after first small buffer
transfered.

> > If you have problems you could enable that also for your boards.

> >

> > #ifdef CONFIG_MACH_OMAP_H6300

> >         spin_lock_irqsave(&s->dma_lock, flags);

> >         omap_stop_alsa_sound_dma(s);

> >         spin_unlock_irqrestore(&s->dma_lock, flags); #endif

> >

> > 2) In sound/arm/omap/omap-alsa-tsc2101.c

> tsc2101_snd_omap_alsa_playback

> > structure h6300 needs to be configured to have 8 bit dma.

> > (this is not yet in the patch sent to the list)

> >

> > #ifdef CONFIG_MACH_OMAP_H6300

> >     .formats =3D (SNDRV_PCM_FMTBIT_S8), #else

> >     .formats =3D (SNDRV_PCM_FMTBIT_S16_LE), #endif

> >

> > If you want to test the play with different samplerates, you can use


> > a program called "sox" for creating wavs with different samplerates.

> > (sox song.wav -r 8000 -c 1  -s -w song8000.wav)

> > **

> > Mika

> > _______________________________________________

> > Linux-omap-open-source mailing list

> > Linux-omap-open-source@linux.omap.com

> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source

> >

>=20

>=20

> --

> INdT - Manaus - Brazil

>=20

=20

=20

--

INdT - Manaus - Brazil

=20

=20
