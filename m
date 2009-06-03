From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: *SPAM* Re: Please help in adding ams-delta support to ASoC
Date: Wed, 3 Jun 2009 08:28:06 +0300
Message-ID: <200906030828.06933.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <20090601210413.7678bf42.jhnikula@gmail.com> <4A25040A.4050506@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25932 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbZFCF3l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 01:29:41 -0400
In-Reply-To: <4A25040A.4050506@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Hello Janusz,

On Tuesday 02 June 2009 13:50:50 ext Janusz Krzysztofik wrote:
> Hi Jarkko,
>
> Jarkko Nikula wrote:
> > Is the older implementation working at commit
> > d8376cc482b241701f7606c81ad578b90853e175 in linux-omap, i.e. last
> > commit before their removal?
>
> I have managed to check with that revision this morning and yes, the
> driver is working.
>
> I'll try you other suggestions as soon as I get back home.

Looking at the code at commit: d8376cc482b241701f7606c81ad578b90853e175=
 on l-o=20
the comment about the need for the call the omap_stop_dma puzzled me.
Can you try something like this:

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6454e15..2df1792 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -67,6 +67,7 @@ static void omap_pcm_dma_irq(int ch, u16 stat, void *=
data)
                spin_lock_irqsave(&prtd->lock, flags);
                if (prtd->period_index >=3D 0) {
                        if (++prtd->period_index =3D=3D runtime->period=
s) {
+                               omap_stop_dma(prtd->dma_ch);
                                prtd->period_index =3D 0;
                                omap_start_dma(prtd->dma_ch);
                        }
@@ -191,6 +192,7 @@ static int omap_pcm_trigger(struct snd_pcm_substrea=
m=20
*substream, int cmd)
        case SNDRV_PCM_TRIGGER_START:
        case SNDRV_PCM_TRIGGER_RESUME:
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+               omap_stop_dma(prtd->dma_ch);
                prtd->period_index =3D 0;
                omap_start_dma(prtd->dma_ch);
                break;

This is on top of sound-2.6:topic/asoc, but l-o should not be that diff=
erent.
Call the omap_stop_dma before actually starting the dma, and call stop =
also=20
before restarting it.


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
