From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: omap alsa tsc2101 driver
Date: Wed, 08 Feb 2006 14:59:59 +0200
Message-ID: <43E9EB4F.9090902@cc.jyu.fi>
References: <43E66CF6.8040600@cc.jyu.fi>	
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>	
	<43E7AEC3.3020901@cc.jyu.fi>	
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>	
	<43E8960E.6090005@cc.jyu.fi>	
	<9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>	
	<43E905A8.9090307@cc.jyu.fi>
	<9268368b0602071429k9563756hc94fbc4efd124aa0@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602071429k9563756hc94fbc4efd124aa0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I got my driver version working also with h6300/1510! But the solution
is not perfect and I do not yet understand why it helped.
I did not made any changes to audio_dma_get_pos() method. Instead I just
added dma_close to audio_process_dma() method
before each dma_start call and that forces the DMA to somehow trigger
irq_handler more oftern.

*diff -Naur h6300_dev_old/sound/arm/omap/omap-alsa-tsc2101.c h6300_dev_working/sound/arm/omap/omap-alsa-tsc2101.c*
*--- h6300_dev_old/sound/arm/omap/omap-alsa-tsc2101.c	2006-02-06 15:36:21.000000000 +0200*
*+++ h6300_dev_working/sound/arm/omap/omap-alsa-tsc2101.c	2006-02-08 14:37:27.000000000 +0200*
@@ -508,6 +508,7 @@
 	int period;
 	unsigned int dma_size;
 	unsigned int offset;
+	unsigned long flags;
 	int ret;
 
 	runtime = substream->runtime;
@@ -528,6 +529,11 @@
 			runtime->frame_bits,
 			runtime->dma_addr,
 			(dma_addr_t)runtime->dma_area + offset);
+#ifdef CONFIG_MACH_OMAP_H6300
+		spin_lock_irqsave(&s->dma_lock, flags);
+		omap_alsa_audio_stop_dma(s);
+		spin_unlock_irqrestore(&s->dma_lock, flags);
+#endif
 		ret	= omap_start_alsa_sound_dma(s,
 						 (dma_addr_t)runtime->dma_area + offset, 
 						 dma_size);

Now I need to figure out why this fixed the problem and what would be a
smarter solution for this.
In addition I can hear that 41000 hz sound is still not played with full
speed. (Maybe 1/2 speed is more correct...)

Mika
