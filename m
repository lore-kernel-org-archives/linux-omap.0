From: Ran Shalit <ranshalit@gmail.com>
Subject: ALSA DMA ping-pong
Date: Thu, 22 Oct 2015 21:50:17 +0300
Message-ID: <CAJ2oMhK4fSD1tP0F0Yc6Ovk6vbWEofLiL4dFozXkRwNw_+fV7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

I hope someone can help me understand the concept of ping-pong dma with ALSA.
I am using davinci soc: /sound/soc/davinci/davinci_pcm.c
But I am not sure if it using ping-pong dma or not.
In the header of "davinci_pcm_enqueue_dma" function it states "Not
used with ping/pong", but inside I see that it use period parameter in
order to set the offset inside the dma buffer which is used.
So, does it mean that ping-pong is used or not ?

/*
 * Not used with ping/pong
 */
static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
.....

period_size = snd_pcm_lib_period_bytes(substream);
dma_offset = prtd->period * period_size;
dma_pos = runtime->dma_addr + dma_offset;
....


acnt = prtd->params->acnt;
edma_set_src(link, src, INCR, W8BIT);
edma_set_dest(link, dst, INCR, W8BIT);
......
}

Regards,
Ran
