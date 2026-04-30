Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556C3054C7;
	Thu, 30 Apr 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563219; cv=none; b=GU7PU+F5pXT7sVjnqkkFZOZjxAjzyr2i7I9ubK1Po90lUnK+MXVPpwtf7Xj/MhGRJh2080WEGxEpKdPRW1/RrmDEpQBHwunjOU5i7zqoLYM/zpiYfvBCO6gQQqEpCifSZzUkDxq5I0Z65v2rA/SPQDr2xJqzBWo2x0nY7O+x2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563219; c=relaxed/simple;
	bh=Luo6Ww4a+3AW+MS6kuIQdZRuQbZSvoD/2PPUPUmOpEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzhCcYiAlLm/e/G3PSAOk57boopzxn/BxosAgdtYPvFHVjch3POA2hZS1BEZgZvWsLWFODMAeSVpjUL8beNIEzTriRmZdswMaZvi8Dg2cMF23aDsqyFvSBpvCEc3Yetp8VIaa5EjAGlcpv464G4AXS4QsMU0cKynNZbYHXv1YZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7574C2BCB3;
	Thu, 30 Apr 2026 15:33:35 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-gpio@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] pinctrl: airoha: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:12 +0200
Message-ID: <5ba0a81c6868b67ec740e46d56405b4c4bbf0962.1777562725.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777562725.git.geert+renesas@glider.be>
References: <cover.1777562725.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit platforms, "unsigned long" is 64-bit.  Hence checking if all
"unsigned long" configuration values are equal should be done using an
"unsigned long" temporary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/mediatek/pinctrl-airoha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.c b/drivers/pinctrl/mediatek/pinctrl-airoha.c
index 995ba6175c9504ba..e5a6a60fb3c660cb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-airoha.c
+++ b/drivers/pinctrl/mediatek/pinctrl-airoha.c
@@ -2811,7 +2811,7 @@ static int airoha_pinconf_group_get(struct pinctrl_dev *pctrl_dev,
 				    unsigned int group, unsigned long *config)
 {
 	struct airoha_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
-	u32 cur_config = 0;
+	unsigned long cur_config = 0;
 	int i;
 
 	for (i = 0; i < pinctrl->grps[group].npins; i++) {
-- 
2.43.0

