From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 11/11] ASoC: omap-pcm: Convert to use dmaengine
Date: Wed, 12 Sep 2012 17:35:56 +0300
Message-ID: <50509DCC.4000503@ti.com>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com> <1347450427-27627-12-git-send-email-peter.ujfalusi@ti.com> <20120912120028.GC28448@n2100.arm.linux.org.uk> <505085DB.5000407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60815 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758897Ab2ILOfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 10:35:22 -0400
Received: by oago6 with SMTP id o6so1025104oag.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 07:35:21 -0700 (PDT)
In-Reply-To: <505085DB.5000407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>

On 09/12/2012 03:53 PM, Peter Ujfalusi wrote:
> I need to look at this, but at first look we do wait for the drain in
> omap_stop_dma(). We used to use omap_stop_dma/omap_start_dma for paus=
e/resume
> operations.
> But sDMA also have a bit: CDPi: PAUSE_LINK_LIST which should do what =
we are
> looking for.
> Need to read the relevant parts of the TRM, but AFAIK we are using no=
rmal mode
> with linked list (self linking).
> I already have the patch for this, I just need to test it on HW.

We can get the PAUSE/RESUME work either:
1.
drivers/dma/omap-dma.c
static int omap_dma_pause(struct omap_chan *c)
 {
-       /* FIXME: not supported by platform private API */
-       return -EINVAL;
+       /* Only in cyclic mode */
+       if (!c->cyclic)
+               return -EINVAL;
+
+       if (!c->paused) {
+               omap_stop_dma(c->dma_ch);
+               c->paused =3D true;
+       }
+
+       return 0;
 }

 static int omap_dma_resume(struct omap_chan *c)
 {
-       /* FIXME: not supported by platform private API */
-       return -EINVAL;
+       /* Only in cyclic mode */
+       if (!c->cyclic)
+               return -EINVAL;
+
+       if (c->paused) {
+               omap_start_dma(c->dma_ch);
+               c->paused =3D false;
+       }
+
+       return 0;
 }


2.
arch/arm/plat-omap/dma.c
+void omap_pause_linked_dma(int lch)
+{
+       u32 l;
+       unsigned long flags;
+
+       local_irq_save(flags);
+       l =3D p->dma_read(CDP, lch);
+       l |=3D 0x80; /* PAUSE_LINK_LIST */
+       p->dma_write(l, CDP, lch);
+       local_irq_restore(flags);
+}
+EXPORT_SYMBOL(omap_pause_linked_dma);
+
+void omap_resume_linked_dma(int lch)
+{
+       u32 l;
+       unsigned long flags;
+
+       local_irq_save(flags);
+       l =3D p->dma_read(CDP, lch);
+       l &=3D (~0x80); /* PAUSE_LINK_LIST */
+       p->dma_write(l, CDP, lch);
+       local_irq_restore(flags);
+}
+EXPORT_SYMBOL(omap_resume_linked_dma);

drivers/dma/omap-dma.c
 static int omap_dma_pause(struct omap_chan *c)
 {
-       /* FIXME: not supported by platform private API */
-       return -EINVAL;
+       /* Only in cyclic mode */
+       if (!c->cyclic)
+               return -EINVAL;
+
+       if (!c->paused) {
+               omap_pause_linked_dma(c->dma_ch);
+               c->paused =3D true;
+       }
+
+       return 0;
 }

 static int omap_dma_resume(struct omap_chan *c)
 {
-       /* FIXME: not supported by platform private API */
-       return -EINVAL;
+       /* Only in cyclic mode */
+       if (!c->cyclic)
+               return -EINVAL;
+
+       if (c->paused) {
+               omap_resume_linked_dma(c->dma_ch);
+               c->paused =3D false;
+       }
+
+       return 0;
 }


Both works fine (have tested it on BeagleBoard with mplayer).
With [1] we have identical way of dealing with the PAUSE/RESUME as we h=
ad
previously, so it is know to work fine on OMAP1/2/3/4/5

We have never used [2] in the past, but I think that is not going to wo=
rk on
OMAP1 and OMAP2420. Also we need to add code to arch/arm/plat-omap/dma.=
c for
this...

I can resend the series with either of these to fix this regression cau=
sed by
the dmaengine conversion (after cleanup off course).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
