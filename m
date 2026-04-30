Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1331F9BB;
	Thu, 30 Apr 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563223; cv=none; b=JgoyBZ9ikWF9DWIidUvHpqyP0IoF6epw6ZTS6GQx2VYvvLMfTH2irIg66gT98HlINqzerLK7MVoMNpe9zgIgfiuqp5FuWtbWI1fgd78sWCT1AEwkRCIIOOPO9pTW33jWaysUzClBfgWiVb79zVTOlQdb5TfOcF+g2XwqBQ+UExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563223; c=relaxed/simple;
	bh=qeOLEPJiBBeQ6++QIfH3LugzR2DBnRuayR/bAyB9Mn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXbviIbMtoSZtYtGWv/ku4fWRz3GlPBbLGTmHAY6xuvcGcVnl8NDKBtUZOVlKCSCJy5eAn7LIo9ERbCz2xWdrROrIH49tzaCzxErhRjc6zNZl62PbchITS/FSlLvDQyjWZmQ0Ny9i+B/8UhdnNBg+upbK5UduIX26fmShT/Fbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5152C2BCF6;
	Thu, 30 Apr 2026 15:33:39 +0000 (UTC)
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
Subject: [PATCH 2/7] pinctrl: equilibrium: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:13 +0200
Message-ID: <9364b13288faae01e53b65712150bab22348b14b.1777562725.git.geert+renesas@glider.be>
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
 drivers/pinctrl/pinctrl-equilibrium.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index ba1c867b7b891abb..349eb944b4ac880e 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -532,8 +532,9 @@ static int eqbr_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 static int eqbr_pinconf_group_get(struct pinctrl_dev *pctldev,
 				  unsigned int group, unsigned long *config)
 {
-	unsigned int i, npins, old = 0;
 	const unsigned int *pins;
+	unsigned int i, npins;
+	unsigned long old = 0;
 	int ret;
 
 	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-- 
2.43.0

