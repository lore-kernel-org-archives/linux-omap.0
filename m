Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095675;
	b=J/V3/D4xb2MjzPha9qCazLQCtXw4LHPHsPuJltxJmMVOxcvtb/upA5LKEru9m1FjWcfr
	 Nkk5TwNEXV+CFqrb11MKKQv37y4dgti+90QHqz1Ek6srUvFsJTRGyY1v4nhK/FhnOYnlu
	 RZJhk/VxG/CvF7CnKqGycbs2ORtbbDV1aVfj+O/T+9Hlt7IX/HCsv+z/JaBy182NaO4YO
	 p1atY11o2Px2QifsSuIewu/Uf5I6DwHCnZj5Sv5GR6/UgexlVLAjY7+LzhtsvQSigU9Ra
	 DvEzmsgr+N3NrxPwL0wJ2N8XgjCyoc1QtTR7frKWFJhOzWnvWlNwZKXu01NfE0FqWzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095675;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RQWsE6Ui5nt1SCyNlkHl613h7zDcFjwnMDjLWUyQUDg=;
	b=YV6qtC5LiDU2YDOOf4nslM2d4diYDHTFo7WLruCbTTJvNjM19qFEryXMYLvzc9GW2brP
	 1D/1LV33PxTL6Bn00Ylc7MA5IP26jDVN3OLMJ3xONPJuQc34Ju9O0waG2Bwos00vhvj4V
	 OOSwb+v3xgWf6r/XA643kfxr9pZVtXZo+7lwj3zo04N9X1sjWkeyHzUBbGD9fYS4v9Cxv
	 wUGVxp2AfJtRfQJcCFcEmqj5nb54B5zEX+iiF3NUQAs7ShFtQ5UKoH62ClYZSaVVjHw4B
	 p5qJa+YeN9RAWe4A0J+10dqrruLDt1D+jSN7ai6orVpY1KpCXuiYOmPGbN80a4fZQWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32F606A339;
	Thu, 19 Nov 2026 13:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3067D1F00925;
	Thu, 19 Nov 2026 13:41:11 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
Date: Thu, 19 Nov 2026 14:40:38 +0100
Message-ID: <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
used for power management, so the latter show up as "deviceless" in the
consumer column of the clk_summary file in debugfs.

Fix this by using dev_clk_get_from_provider() instead, letting us pass
the consumer device, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

The first change is probably OK.  The second change may fail if anything
in the oh->od->pdev->dev chain is not available yet at this point.
---
 arch/arm/mach-omap2/omap_device.c | 2 +-
 arch/arm/mach-omap2/omap_hwmod.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 77a75b0b9ae69c85..5695e0c8f2392eca 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -73,7 +73,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 
 		clkspec.np = of_find_node_by_name(NULL, clk_name);
 
-		r = of_clk_get_from_provider(&clkspec);
+		r = dev_clk_get_from_provider(&od->pdev->dev, &clkspec);
 
 		rc = clk_register_clkdev(r, clk_alias,
 					 dev_name(&od->pdev->dev));
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 03cd523dff874bb0..5e4123014909d4ac 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -147,6 +147,7 @@
 #include <asm/system_misc.h>
 
 #include "clock.h"
+#include "omap_device.h"
 #include "omap_hwmod.h"
 
 #include "soc.h"
@@ -796,7 +797,7 @@ static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)
 				clkspec.args[0] = addr - provider->addr[0];
 				clkspec.args[1] = 0;
 
-				clk = of_clk_get_from_provider(&clkspec);
+				clk = dev_clk_get_from_provider(&oh->od->pdev->dev, &clkspec);
 
 				pr_debug("%s: %s got %p (offset=%x, provider=%pOF)\n",
 					 __func__, oh->name, clk,
-- 
2.43.0

