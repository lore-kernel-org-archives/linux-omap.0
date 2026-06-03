Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE3472774
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488575; cv=none; b=mBrKWCweEbPRcOExayfOG1JrqoftNZtTIlrQQPPob9PQDQThT9TsXp1t+E/qReNvMyZKtItpPl3/5RjZk4Z2Lr6bAADelTbgWHezcFJ7KsGL6W4JNOgy6xwA1ITywg8hzioCJOdjnNKa37qscjxzUzmy7dX6j8H235Vyp6PSWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488575; c=relaxed/simple;
	bh=adyqpZD+OsKDX6hUpJXWV+uu7IA0qtWgQtlY269SJ9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkSJHR3F/kihDldvMu/nq6P+6ahebvKPAdZdf2eFnwnLWrqMaAO9wHxnJSnk0Wju/ItizewIszPI5DB1x24Y06c7G8uLkdh2rKZibcs/ESsC59rA5qmeVKet/sxgRUDXi+JlkDMCCImUNueP5/XdlvIXd8kebHguxggYw2SGYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPV-000829-CO; Wed, 03 Jun 2026 14:09:25 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-000uUf-1O;
	Wed, 03 Jun 2026 14:09:24 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-00000007LO8-1NQq;
	Wed, 03 Jun 2026 14:09:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 03 Jun 2026 14:09:24 +0200
Subject: [PATCH 3/4] ASoC: ti: rx51: drop unnecessary machine checks
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-asoc-remove-mach-types-h-v1-3-2b9446dff0c1@pengutronix.de>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sen Wang <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780488564; l=1052;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=adyqpZD+OsKDX6hUpJXWV+uu7IA0qtWgQtlY269SJ9Q=;
 b=+gIJrFB6ST15XtvA6XJDfuFRriQL2aRfpe12e/5kwDMXrIL+2k8xnd0vcAgSyUpZQ18cHaaRd
 KZfFcyU8tzcC7TuLw5UYXOsRod6hNpH9oYiDFt9qjSmXpYNQWDrh/CJ
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

Nokia N900 is device tree only, machine_is_nokia_rx51() always expands
to 0. Testing for of_machine_is_compatible() is unnecessary as the
N900 is the only board registering the device node necessary to get to
this point, so remove that as well. This makes inclusion of mach-types.h
unnecessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/ti/rx51.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index 7eeb12e5066c4..89338cf145358 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -19,8 +19,6 @@
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include <asm/mach-types.h>
-
 #include "omap-mcbsp.h"
 
 enum {
@@ -364,9 +362,6 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &rx51_sound_card;
 	int err;
 
-	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
-		return -ENODEV;
-
 	card->dev = &pdev->dev;
 
 	if (np) {

-- 
2.47.3

