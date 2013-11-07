From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
Date: Thu, 7 Nov 2013 13:26:55 +0100
Message-ID: <20131107122655.GA7110@amd.pavel.ucw.cz>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
 <20131106142559.GC15551@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131106142559.GC15551-tWAi6jLit6GreWDznjuHag@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!


> So in (error) case of ! aux_dev->codec_of_node && ! aux_dev->codec_name 
> we match first possible codec?
> 
> Given code similarity between this and the one above, should there be
> helper function that does the comparison (or even walks the list)?

Something like this? soc_probe_aux_dev now looks better... (Only
compile tested).

Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 392f479..3097e17 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1526,69 +1526,65 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
 }
 #endif
 
-static int soc_check_aux_dev(struct snd_soc_card *card, int num)
+struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	const char *codecname = aux_dev->codec_name;
 	struct snd_soc_codec *codec;
 
-	/* find CODEC from registered CODECs*/
+	/* find CODEC from registered CODECs */
 	list_for_each_entry(codec, &codec_list, list) {
-		if (aux_dev->codec_of_node &&
-				codec->dev->of_node == aux_dev->codec_of_node)
-			return 0;
-		if (aux_dev->codec_name &&
-				!strcmp(codec->name, aux_dev->codec_name))
-			return 0;
+		if (aux_dev->codec_of_node && 
+		    (codec->dev->of_node != aux_dev->codec_of_node))
+			continue;
+		if (aux_dev->codec_name && strcmp(codec->name, aux_dev->codec_name))
+			continue;
+		return codec;
 	}
+	return NULL;
+}
 
+static int soc_check_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	const char *codecname = aux_dev->codec_name;
+	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
+
+	if (codec)
+		return 0;
 	if (aux_dev->codec_of_node)
 		codecname = of_node_full_name(aux_dev->codec_of_node);
 
 	dev_err(card->dev, "ASoC: %s not registered\n", codecname);
-
 	return -EPROBE_DEFER;
 }
 
+
 static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	struct snd_soc_codec *codec;
 	const char *codecname = aux_dev->codec_name;
 	int ret = -ENODEV;
+	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
 
-	/* find CODEC from registered CODECs*/
-	list_for_each_entry(codec, &codec_list, list) {
-		if (aux_dev->codec_of_node &&
-				codec->dev->of_node != aux_dev->codec_of_node)
-			continue;
-		if (aux_dev->codec_name &&
-				strcmp(codec->name, aux_dev->codec_name))
-			continue;
+	if (!codec) {
+		if (aux_dev->codec_of_node)
+			codecname = of_node_full_name(aux_dev->codec_of_node);
 
-		if (codec->probed) {
-			dev_err(codec->dev, "ASoC: codec already probed");
-			ret = -EBUSY;
-			goto out;
-		}
-		goto found;
+		/* codec not found */
+		dev_err(card->dev, "ASoC: codec %s not found", codecname);
+		return -EPROBE_DEFER;
 	}
 
-	if (aux_dev->codec_of_node)
-		codecname = of_node_full_name(aux_dev->codec_of_node);
-
-	/* codec not found */
-	dev_err(card->dev, "ASoC: codec %s not found", codecname);
-	return -EPROBE_DEFER;
+	if (codec->probed) {
+		dev_err(codec->dev, "ASoC: codec already probed");
+		return -EBUSY;
+	}
 
-found:
 	ret = soc_probe_codec(card, codec);
 	if (ret < 0)
 		return ret;
 
 	ret = soc_post_component_init(card, codec, num, 1);
-
-out:
 	return ret;
 }
 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
