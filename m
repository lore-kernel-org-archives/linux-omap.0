Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99647278F
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488575; cv=none; b=Tk1k1hAi06jNgfpUikxeMGxhER8+MQar2ACaQvjTJfoHDV+xNWQcaLeOuB/SDccVC2Zyvxh6T/WdTH/LJd6BMocETZTL14i/RG9iBdb2yuGfQjTjFLTmJvj/+IYoHeBQYNi5rxLE9nzHkvPjpCaZFbfVjgZ+SrpNPhS1/1WZIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488575; c=relaxed/simple;
	bh=w1IEaMTd3EAUbRt/40/yjNMhChHBflCVYbylv3nkaQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1QFb2P0APQYyHI2nWZqbScsOqd49Dab2bLoJsyRj653XvI2TPBvIhuVrevFGRG2XsJ1aqAyHhjWmddLGQevbDAfHKxX4WyuubA56G8fc+OKtao9ERXdm1eCceOcDeH6/zJ9mDF0/qZ8yds52cxLB0l2JcxjQvcL6sjAy/ztL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPV-00082B-CO; Wed, 03 Jun 2026 14:09:25 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-000uUh-1R;
	Wed, 03 Jun 2026 14:09:24 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-00000007LO8-1KjM;
	Wed, 03 Jun 2026 14:09:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 03 Jun 2026 14:09:22 +0200
Subject: [PATCH 1/4] ASoC: fsl: eukrea-tlv320: drop unused machine support
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-asoc-remove-mach-types-h-v1-1-2b9446dff0c1@pengutronix.de>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sen Wang <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780488564; l=2082;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=w1IEaMTd3EAUbRt/40/yjNMhChHBflCVYbylv3nkaQ8=;
 b=21W5POJoX0M+pC/12wriS8j9eF4OagFRh2jayKqw7Ml5TJWx1hPjUHNGYsCb1WCNRh5nU20Rw
 dYH09lUKtDJB5Ja6WLlgz3Y4cWVDgowMIZEGk+Z2j/l7wYtsfa3ywjk
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

The Eukrea boards are dt only, platform support has been removed in [1].
Drop the machine_is_* macros which always expand to 0 and remove no
longer needed asm/mach-types.h inclusion.

[1]
8da4d6b2f7988 ("ARM: mx51: Remove mach-cpuimx51sd board file")
f2f55499942a0 ("ARM: imx: Remove eukrea_mbimxsd35 non-dt support")
3877942b0c7f3 ("ARM: imx25: Remove eukrea mx25 board files")
7c5deaf775265 ("ARM: i.MX: Remove mach-cpuimx27sd board file")

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/eukrea-tlv320.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 6be074ea0b3f0..551d5c102240b 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -19,7 +19,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <asm/mach-types.h>
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
@@ -142,8 +141,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		eukrea_tlv320.name = "cpuimx-audio";
 	}
 
-	if (machine_is_eukrea_cpuimx27() ||
-	    (tmp_np = of_find_compatible_node(NULL, NULL, "fsl,imx21-audmux"))) {
+	if ((tmp_np = of_find_compatible_node(NULL, NULL, "fsl,imx21-audmux"))) {
 		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
 			IMX_AUDMUX_V1_PCR_SYN |
 			IMX_AUDMUX_V1_PCR_TFSDIR |
@@ -159,13 +157,9 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
 		);
 		of_node_put(tmp_np);
-	} else if (machine_is_eukrea_cpuimx25sd() ||
-		   machine_is_eukrea_cpuimx35sd() ||
-		   machine_is_eukrea_cpuimx51sd() ||
-		   (tmp_np = of_find_compatible_node(NULL, NULL, "fsl,imx31-audmux"))) {
+	} else if ((tmp_np = of_find_compatible_node(NULL, NULL, "fsl,imx31-audmux"))) {
 		if (!np)
-			ext_port = machine_is_eukrea_cpuimx25sd() ?
-				4 : 3;
+			ext_port = 3;
 
 		imx_audmux_v2_configure_port(int_port,
 			IMX_AUDMUX_V2_PTCR_SYN |

-- 
2.47.3

