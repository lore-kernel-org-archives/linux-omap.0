From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 09:22:52 +0300
Message-ID: <20090602092252.10a57fda.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527095949.51ed4b83.jhnikula@gmail.com>
	<200905272058.55404.jkrzyszt@tis.icnet.pl>
	<4A23CC97.1020209@tis.icnet.pl>
	<20090601210413.7678bf42.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090601210413.7678bf42.jhnikula@gmail.com>
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

On Mon, 1 Jun 2009 21:04:13 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> What I see at quick look from the older implementation that it is
> doing somewhat similar way the DMA transfer and workaround for 1510
> than current ASoC except that now the DMA parameters are not
> reprogrammed between the restarted transfers. I don't know if 1510
> requires it?
> 
Hmm, I forgot one major difference. Older implementation was
transferring the buffer by transferring periods by own DMA transfers
while ASoC implementation is transferring the whole buffer by single
transfer but letting DMA to generate interrupts at period boundaries
but this should be supported by the 1510 as well.

I just tried non-chained transfer, i.e. restarting DMA after buffer is
transferred in omap-pcm.c by using N810 and 2420 and it worked as I was
recalling. This was simulating 1510 by adding (1
|| cpu_is_omap1510) or (0 && !cpu_is_omap1510()) where 1510 was tested.

But there is no DMA stop workaround before restarting like the original
ams delta patch has. Could you try to add following line in omap-pcm.c
does it help? However this doesn't explain why you are not getting any
interrupts.

@@ -68,6 +68,7 @@ static void omap_pcm_dma_irq(int ch, u16 stat, void
*data) if (prtd->period_index >= 0) {
 			if (++prtd->period_index == runtime->periods) {
 				prtd->period_index = 0;
+				omap_stop_dma(prtd->dma_ch);
 				omap_start_dma(prtd->dma_ch);
 			}
 		}

> > 1. If the new OMAP McBSP ASoC framework provides all the
> > functionality of the depreciated OMAP Alsa under a different API,
> > the only reason of my driver not working I can imagine is that I
> > have put these two lines of hardware related code in wrong places.
> > If this is the case, could someone please point me into the right
> > direction?
> > 
I don't think there is anything in a wrong place. It would help a lot
if we would know for sure is the MCLK from OMAP to codec and McBSP FS
and bit clocks from the codec really working since that is the first
requirement for working transfer. Luckily we know that the HW is
working :-)

> > 3. Otherwise, there must be a significant difference in (alsa)
> > MsBSP handling code that I am not able to identify and resolve
> > myself. I can only say that I have seen much more mcbsp_...() stuff
> > in the old omap-alsa framework than in the current one. The
> > differece can be significant for OMAP15XX, or OMAP5910, or even
> > ams-delta only.
> > 
At least one difference is that omap-mcbsp.c is constructing McBSP
register bits itself while older implementation was passing raw
register configuration from the board files. Probably you could try to
hack omap_mcbsp_dai_hw_params and pass the same register settings there
to see are there some missing bit in omap-mcbsp.c.

> > I am personally interested in this, as I have bought two E3's
> > recently in hope I can make use of them as IP phones. But for now, I
> > have no idea what else I could try. I have noticed that Andrew de
> > Quincey is going to fix sound on Nokia 770, maybe he finds something
> > related.
> > 
It's positive that Nokia 770 will be easier thanks to OSK5912. They
both have the same CPU variant (1710 == 5912) and AIC23 codec!


-- 
Jarkko
