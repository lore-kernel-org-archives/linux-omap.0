Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B946AEE8
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488578; cv=none; b=KCo/q2vPSi+8L6tdCvQEQSWc6DGH2Ac6K7xRrEcY/Wpck4Wc3O7/1Q35JMr8ODAOap6j1lOPpTN1NPy76YU9kYWoAZYJ4v6PRGCRZ8XVvkw5LK0UUDQhBQD8kVXJp2QtO0rf5iAkPE1l0ZebTJaaP+dAKPV7wn/QsH4xL68X1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488578; c=relaxed/simple;
	bh=4P+bziFDiBdSdMtkgcA+hCpgReZyTOSZhJRCnTDG8rU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XSRDb46Un+v8vkww3Bq76ObD6fTPCvhQGv8H8gUktSjg9S/yHFJDTp2KEmnnyGtgQdHgs/KSMfQ0m2h5BFuWvvbwoe4De0IgTGIW1ooOej3IKp1yRW5JRTSFBYpxqnUbdS6nKpJe4qMigYKR4YKNTYCC8AFso8s1MQ/KiGSmnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPV-000827-CO; Wed, 03 Jun 2026 14:09:25 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-000uUg-1L;
	Wed, 03 Jun 2026 14:09:24 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-00000007LO8-1J9M;
	Wed, 03 Jun 2026 14:09:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/4] ASoC: drop some mach-types.h inclusions
Date: Wed, 03 Jun 2026 14:09:21 +0200
Message-Id: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEZIGoC/x3MQQ5AMBBG4avIrE1SlQiuIhZN/XQWVDoiRNxdY
 /kt3ntIkQRKffFQwikqccuoyoJ8cNsClimbrLGNaUzNTqPnhDWe4NX5wMe9Qznw1NmuhpthfUs
 53xNmuf71ML7vB0oAG6tqAAAA
X-Change-ID: 20260603-asoc-remove-mach-types-h-d9293eafe2c8
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sen Wang <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780488564; l=1118;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=4P+bziFDiBdSdMtkgcA+hCpgReZyTOSZhJRCnTDG8rU=;
 b=RVd/y0U1MZ8dOKRStbUNCEBLcSbdb1hRyrhLXta6LJSz8+p3H1dRoGBDw5fC1ULvmSpcvbklM
 hVd8QiICZFDBbvk4X7LCKwsOi5uWrbOUPQNFqEEprQhNlFQ/TifQyZi
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

This series drops some mach-types.h inclusions by
- removing dead machine_is_* macros because the boards are converted to
  dt
- removing a driver that entirely hangs on a machine_is_* macro for a
  machine that is converted to dt
- removing unnecessary inclusion because nothing from the header is
  used.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (4):
      ASoC: fsl: eukrea-tlv320: drop unused machine support
      ASoC: ti: omap3pandora: remove
      ASoC: ti: rx51: drop unnecessary machine checks
      ASoC: ti: n810: drop unused header inclusion

 sound/soc/fsl/eukrea-tlv320.c |  12 +-
 sound/soc/ti/Kconfig          |   9 --
 sound/soc/ti/Makefile         |   2 -
 sound/soc/ti/n810.c           |   1 -
 sound/soc/ti/omap3pandora.c   | 290 ------------------------------------------
 sound/soc/ti/rx51.c           |   5 -
 6 files changed, 3 insertions(+), 316 deletions(-)
---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-asoc-remove-mach-types-h-d9293eafe2c8

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

