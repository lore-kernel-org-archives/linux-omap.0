From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Wed, 10 Jun 2009 20:05:35 +0200
Message-ID: <200906102005.36323.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906101227.39856.jkrzyszt@tis.icnet.pl> <200906101353.43411.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53876 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbZFJSGJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 14:06:09 -0400
In-Reply-To: <200906101353.43411.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

Wednesday 10 June 2009 12:53:42 Peter Ujfalusi napisa=C5=82(a):
> On Wednesday 10 June 2009 13:27:38 ext Janusz Krzysztofik wrote:
> Just out of curiosity, can you try this one as well:
>
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -191,6 +191,7 @@ static int omap_mcbsp_dai_trigger(struct
> snd_pcm_substream *substream, int cmd,
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>                 if (!mcbsp_data->active++)
>                         omap_mcbsp_start(mcbsp_data->bus_id);
> +               omap_mcbsp_pollwrite(mcbsp_data->bus_id, 0xdb55);
>                 break;
>
> basically write 0xdb55 to the DXR1 register (0xdb55 is 11011011010101=
01)
> With this, if McBSP is operating correctly you should be seeing this
> pattern going to the codec.

Peter,

I am not sure how did you expect me to see this pattern. On a scope scr=
een?=20
Unforunatelly I had to return the scope this morning.

I have further modified the code like this:

@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/random.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -186,7 +186,7 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_su=
bstream=20
*substream, int cmd,
        struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
        struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
        struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->privat=
e_data);
-       int err =3D 0;
+       int i, err =3D 0;

        switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
@@ -191,6 +191,8 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_su=
bstream=20
*substream, int cmd,
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
                if (!mcbsp_data->active++)
                        omap_mcbsp_start(mcbsp_data->bus_id);
+               for (i =3D 8000; i > 0; i--)
+                       omap_mcbsp_pollwrite(mcbsp_data->bus_id, (u16)r=
andom32
());
                break;

        case SNDRV_PCM_TRIGGER_STOP:

in hope I should be able to hear a noise for one second, shouldn't I.

> If it does, than we have some problems with the=20
> McBSP/DMA cooperation, if this pattern is not seen on the bus, than t=
he
> McBSP is not shifting data out for some reason.

Now aplay returns 1 second later than before, so I conclude the loop is=
=20
processed correctly. However, I am not able to hear a single ripple nor=
 see=20
any error messages from omap_mcbsp_pollwrite() :(, so it looks like the=
=20
latter is more probable.

Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
