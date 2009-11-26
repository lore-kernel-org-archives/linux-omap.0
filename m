From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume
 hang
Date: Thu, 26 Nov 2009 10:22:31 +0000
Message-ID: <20091126102230.GB27562@rakim.wolfsonmicro.main>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
 <4B0D9212.1060805@boundarydevices.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57529 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754569AbZKZKWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Nov 2009 05:22:25 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC2F86@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: 'Troy Kisky' <troy.kisky@boundarydevices.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>

On Thu, Nov 26, 2009 at 08:31:11AM +0530, Aggarwal, Anuj wrote:

> I have already tried that but it doesn't fix the problem entirely.
> Still, I was not able to playback properly because the bias settings
> were not handled correctly and as you can see, it writes to some 
> invalid registers too (all registers don't exist between 0 and ARRAY_SIZE).

Please also note the following patch which is queued for 2.6.32:

commit 50b6bce59d154b5db137907a5c0ed45a4e7a3829
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Nov 23 13:11:53 2009 +0000

    ASoC: Fix suspend with active audio streams
    
    When we get a stream suspend event force the power down since otherwise
    the stream would remain marked as active.  In future we'll probably want
    to make this stream-specific and add an interface to make the power down
    of other widgets optional in order to support leaving bypass paths
    active while suspending the processor.
    
    Cc: stable@kernel.org
    Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
    Tested-by: Joonyoung Shim <jy0922.shim@samsung.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d89f6dc..66d4c16 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -973,9 +973,19 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			if (!w->power_check)
 				continue;
 
-			power = w->power_check(w);
-			if (power)
-				sys_power = 1;
+			/* If we're suspending then pull down all the 
+			 * power. */
+			switch (event) {
+			case SND_SOC_DAPM_STREAM_SUSPEND:
+				power = 0;
+				break;
+
+			default:
+				power = w->power_check(w);
+				if (power)
+					sys_power = 1;
+				break;
+			}
 
 			if (w->power == power)
 				continue;
@@ -999,8 +1009,12 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		case SND_SOC_DAPM_STREAM_RESUME:
 			sys_power = 1;
 			break;
+		case SND_SOC_DAPM_STREAM_SUSPEND:
+			sys_power = 0;
+			break;
 		case SND_SOC_DAPM_STREAM_NOP:
 			sys_power = codec->bias_level != SND_SOC_BIAS_STANDBY;
+			break;
 		default:
 			break;
 		}
