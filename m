From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 02 Jun 2009 15:35:10 +0200
Message-ID: <4A252A8E.9060602@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<20090527095949.51ed4b83.jhnikula@gmail.com>	<200905272058.55404.jkrzyszt@tis.icnet.pl>	<4A23CC97.1020209@tis.icnet.pl>	<20090601210413.7678bf42.jhnikula@gmail.com>
	<20090602092252.10a57fda.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090602092252.10a57fda.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Jarkko,

Jarkko Nikula wrote:
> On Mon, 1 Jun 2009 21:04:13 +0300
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
> Hmm, I forgot one major difference. Older implementation was
> transferring the buffer by transferring periods by own DMA transfers
> while ASoC implementation is transferring the whole buffer by single
> transfer but letting DMA to generate interrupts at period boundaries
> but this should be supported by the 1510 as well.

I am not sure if this is of any importance, but with the old working 
code, playing /dev/urandom to /dev/dsp I get only 3-4 DMA interrupts per 
second, while doing the same on a x86_64 via82cxxx results in 40-50 
device interrupts per second.

> I just tried non-chained transfer, i.e. restarting DMA after buffer is
> transferred in omap-pcm.c by using N810 and 2420 and it worked as I was
> recalling. This was simulating 1510 by adding (1
> || cpu_is_omap1510) or (0 && !cpu_is_omap1510()) where 1510 was tested.
> 
> But there is no DMA stop workaround before restarting like the original
> ams delta patch has.

The original patch had no extra omap_dma_stop(), but extra unconditional 
  (form ams-delta point of view) omap_dma_start() inside 
omap_start_alsa_sound_dma(). Later on, there was an extra 
omap_stop_alsa_sound_dma() call introduced in audio_process_dma() as a 
workaround for a similiar problem found on other omap1510 machines, that 
cleared the flag preventing omap_start_alsa_sound_dma() from calling 
omap_dma_start(). I found that with the latter, the old driver happened 
to stop working after a while or two.

> Could you try to add following line in omap-pcm.c
> does it help? However this doesn't explain why you are not getting any
> interrupts.
> 
> @@ -68,6 +68,7 @@ static void omap_pcm_dma_irq(int ch, u16 stat, void
> *data) if (prtd->period_index >= 0) {
>  			if (++prtd->period_index == runtime->periods) {
>  				prtd->period_index = 0;
> +				omap_stop_dma(prtd->dma_ch);
>  				omap_start_dma(prtd->dma_ch);
>  			}
>  		}

OK, I will.

>>> the only reason of my driver not working I can imagine is that I
>>> have put these two lines of hardware related code in wrong places.
>>>
> I don't think there is anything in a wrong place. It would help a lot
> if we would know for sure is the MCLK from OMAP to codec and McBSP FS
> and bit clocks from the codec really working since that is the first
> requirement for working transfer. Luckily we know that the HW is
> working :-)

And we know mcbsp settings that make it working.

I did not find any documentation on the codec itself, only on its 
"master" modem chip cx81801. Regarding modem<->codec interface, there 
were only pins with breif description specified for both chips, nothing 
more, as this interface was probably not intended for access from 
outside. From the codec side, it looks like this:

- Sleep (SLEEP); input
- Master Clock (M_CLKIN); input
- Serial Clock (M_SCK); output
- Control (M_CNTRLSIN); input
- Serial Frame Sync (M_STROBE); output
- Serial Transmit Data (M_TXSIN); input
- Serial Receive Data (M_RXOUT); output
- Reset (POR); input

However, I can't tell which lines are switched from modem to mcbsp and 
which are kept connected to the modem chip all the time.
Anyway, it looks like we can be sure that both bit clock and frame sync 
should come from codec to mcbsp. It is not clear for me if MCLK is 
really used by the codec, or it is possible that it gets its master 
clock from an other, modem related source, and if this does really matter.

> At least one difference is that omap-mcbsp.c is constructing McBSP
> register bits itself while older implementation was passing raw
> register configuration from the board files. Probably you could try to
> hack omap_mcbsp_dai_hw_params and pass the same register settings there
> to see are there some missing bit in omap-mcbsp.c.

OK, I'll see if I know how to do this.

Cheers,
Janusz

