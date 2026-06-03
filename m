Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD6472772
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488575; cv=none; b=lvs3At7F3uMQGK+T9hrU5LuVRihWmb3w3trdzst7Fw/pTo4EqyaJalBS+k/M/kNif7GjwZLfkACgot5dj6EeRgpJmJ9TvzO+UXb7fLT2ir7vKA9RRup+gcgizXPMjUPR33/zJ3v4RPKNURKXavpdIkJx/8C6YKNvM3XoOb8+xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488575; c=relaxed/simple;
	bh=7wMy1WO6xvhj/Oe0Gpo6D9YGm7PoPttonv39QVJHKrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUGYWt4ex1m2iGXXj+yfGfpRneCRM8A3stDSQYbPk7VBdu0XW2/AqxYnIc6s2WI6h7209OuTiSHe0BzCMQWUoXSTekfcvARAZtEqYjNAWBs4l4YDHx8n47Mvd26aeQjUAoNV5TaYckdDFQ+joD9EeS5hY3f3H1txfxk6wAZlbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPV-000828-CO; Wed, 03 Jun 2026 14:09:25 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-000uUj-1O;
	Wed, 03 Jun 2026 14:09:24 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUkPU-00000007LO8-1OVQ;
	Wed, 03 Jun 2026 14:09:24 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 03 Jun 2026 14:09:25 +0200
Subject: [PATCH 4/4] ASoC: ti: n810: drop unused header inclusion
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-asoc-remove-mach-types-h-v1-4-2b9446dff0c1@pengutronix.de>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sen Wang <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780488564; l=602;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=7wMy1WO6xvhj/Oe0Gpo6D9YGm7PoPttonv39QVJHKrQ=;
 b=6WwSzIK2ElyBriAPsxvB5FfmoqIjliAJFBa82eL/y3FrXJ4RBqjGiVhCZTmZ6yjttLBUygYms
 iBtIJUiPkWzDA+2Y19Yie7yhJD4+mURdVpwdMw2AfFeZqEgK929wy+m
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

mach-types.h is only needed for machine_is_* macros and is unneeded
in this driver. Remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/ti/n810.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ti/n810.c b/sound/soc/ti/n810.c
index 242b07034816d..ce1e7d796004a 100644
--- a/sound/soc/ti/n810.c
+++ b/sound/soc/ti/n810.c
@@ -14,7 +14,6 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <asm/mach-types.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>

-- 
2.47.3

