From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: ALSA with OMAP1510
Date: Thu, 16 Mar 2006 20:12:07 +0200
Message-ID: <4419AA77.2000502@cc.jyu.fi>
References: <9343BE359FA4224CA72A94D8CC362C9C093659@edpc500.cedt.iisc.ernet.in>
	<9268368b0603160927v6de56f8cqc8037455344a365c@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9268368b0603160927v6de56f8cqc8037455344a365c@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
List-Id: linux-omap@vger.kernel.org


>You should use "aplay test.raw" to play using alsa stack.
>  
>
Yes, for alsa driver the "aplay" should be the easiest solution.
I have myself used alsa succesfully with the tsc2101 chipset and latest
kernel in git repository (about 2.6.16-rc5)
by applying the 3 patches I and daniel send for the list about 10 days ago.

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
    .formats = (SNDRV_PCM_FMTBIT_S8),
#else
    .formats = (SNDRV_PCM_FMTBIT_S16_LE),
#endif

If you want to test the play with different samplerates, you can use a
program called "sox" for creating wavs with different samplerates.
(sox song.wav -r 8000 -c 1  -s -w song8000.wav)
**
Mika
