From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: Re: [PATCH V2] Add missing modules aliases to get sound working on
 omap devices
Date: Tue, 17 Jul 2012 15:31:11 +0200
Message-ID: <5005691F.9010301@free.fr>
References: <4FFECC40.5020502@free.fr> <20120713100953.GF4215@opensource.wolfsonmicro.com>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.tech.numericable.fr ([82.216.111.38]:54121 "EHLO
	smtp2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab2GQNbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 09:31:14 -0400
In-Reply-To: <20120713100953.GF4215@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, mans.rullgard@linaro.org, Liam Girdwood <lrg@ti.com>

Hi,

Le 13/07/2012 12:09, Mark Brown a =E9crit :
> On Thu, Jul 12, 2012 at 03:08:16PM +0200, Guillaume Gardet wrote:
>> This patch add missing modules aliases to get sound working on omap =
devices.
>>
>> Tested on Beagleboard xM rev. B.
>>
>> This patch is against 3.5-rc6 vanilla.
>>
>> Signed-off-by: Guillaume GARDET <guillaume.gardet@free.fr>
>> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
>>
>>
>>  From 18b1ba8becc3dd256bdaad2d825f46b551debda3 Mon Sep 17 00:00:00 2=
001
>> From: Guillaume GARDET <guillaume.gardet@oliseo.fr>
>> Date: Tue, 10 Jul 2012 13:47:16 +0200
> Please resend in the format from SubmittingPatches rather than as an
> attachment.

Ok. Please find the patch below.

This patch add missing modules aliases to get sound working on omap dev=
ices.

Tested on Beagleboard xM rev. B.

This patch is against 3.5-rc6 vanilla.

Signed-off-by: Guillaume GARDET <guillaume.gardet@free.fr>
Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>


 From 18b1ba8becc3dd256bdaad2d825f46b551debda3 Mon Sep 17 00:00:00 2001
=46rom: Guillaume GARDET <guillaume.gardet@oliseo.fr>
Date: Tue, 10 Jul 2012 13:47:16 +0200
Subject: [PATCH] Add missing modules aliases to fix audio on omap devic=
es

---
  sound/soc/omap/omap-mcbsp.c |    1 +
  sound/soc/omap/omap-pcm.c   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1046083..acdd3ef 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -820,3 +820,4 @@ module_platform_driver(asoc_mcbsp_driver);
  MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
  MODULE_DESCRIPTION("OMAP I2S SoC Interface");
  MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-mcbsp");
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 5a649da..f0feb06 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -441,3 +441,4 @@ module_platform_driver(omap_pcm_driver);
  MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
  MODULE_DESCRIPTION("OMAP PCM DMA module");
  MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-pcm-audio");
--=20
1.7.7


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
