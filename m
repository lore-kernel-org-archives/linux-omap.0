From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: omap alsa tsc2101 driver
Date: Tue, 7 Feb 2006 10:34:55 -0400
Message-ID: <9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>
References: <43E66CF6.8040600@cc.jyu.fi>
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
	<43E7AEC3.3020901@cc.jyu.fi>
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
	<43E8960E.6090005@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <43E8960E.6090005@cc.jyu.fi>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 2/7/06, lamikr <lamikr@cc.jyu.fi> wrote:
>
> >Yes, I am sending it right now (I have just updated my tree). Please
> >note that it is really work in progress code, with remaining debug
> >printks and so on. I will clean up soon.
> >Try to make it work w/ your device, you will have to change the board*
> >file accordingly H2 or osk in this patch.
> >
> >
> Yes, I made the changes. I kind of liked from the idea to codec
> aic/tsc2101 specific
> functions in the board, but the side-effect is that I was not able to
> build the driver anymore
> as a module. (I got unresolved function errors in the end of build). But
> when selecting to
> build the driver in to image, it compiled just fine.

That will be fixed. The idea to have separeted file for alsa generic
and codecs is that you can work or improve diferent parts of the
driver indenpendently. And of course reuse code.

> >Let me know if you can play sounds with this patch so that I will
> >prepare it to receive your mixer then you can debug it
> >
> >
> But unfortunately your version seemed to work in a similar way for me
> than my one,--> I was able to hear only the beginning of song. The only
> code difference for our h6300 board compared to h2/osk is the mcbsp
> settings and they could be wrong.

Humm, Maybe the problems dwells in this function:
omap_get_dma_src_addr_counter
 (called in alsa-omap driver core file) Please try to analyse its
behavior for omap1510, the idea is to get the current position of a
dma transfer. Maybe the registers are diferent in 1510 which has
different dma engine.

> But could they be wrong when with the OSS driver "cat song.wav >
> /dev/dsp" works just fine with the same mcbsp settings...
>
> Following questions comes to my mind:
> Are you able to play all kind of wav/mp3 songs with your driver by using
> aplay?

Yeah. I can play them. In most of the frequencies although I use
madplay for mp3.

> Any changes you could also test the playback with my driver version, it
> could help me to identify the problem

I compiled but I can not play yet, I think that my alsa programs are
old in my rootfs. I compile them as modules or integrated without
success. I will update my rfs.
It says: alsactl: load_state:1236: No soundcards found...
After I make it run I give you a feedback.

> if I know/not know whether that version works with h2 or osk.
> I have found at least one difference in my and your driver versions is
> that in set_samplerate function
> you do not change all mcbsp registers by calling omap_mcbsp_config().
> Instead you will only update
> srgr1 and srgr2 by calling
>
>     OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR2, srgr2);
>     OMAP_MCBSP_WRITE(OMAP1610_MCBSP1_BASE, SRGR1, srgr1);

This means no difference. It is just to avoid callings to mcbsp
function explicitly.

> Below is the debug from my attempt with your driver...
>
> Mika
>
> root@h6300:~# aplay 01_the_grudge.mp3
> Playing raw data '01_the_grudge.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono

The support for 8Khz is not ok yet although I think that you have
tested for other frequencies. I can see in the remaining of the debug
that it seems ok. Maybe the problem is in that function pointed above.

Daniel
--
INdT - Manaus - Brazil
