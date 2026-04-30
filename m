Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9E3016F1;
	Thu, 30 Apr 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563231; cv=none; b=FRn5IH2QY3pnFJKVAo8xx96hxfef6CS64+LNJqqG4TmMHNF2/21JjYKQLdkVFmvLqVabzm+DDZWSS1mloz1C1SsDdb1/4bhTEwhviW2avdpZy5lUPUR7AojKShap8nitNEXm0kXHnU56DsPVQZd+HQboTbH4LEmc7rP/6ruvHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563231; c=relaxed/simple;
	bh=FOAw4AWbp77lx2wLlMA4jgFLHWN35/kBTPKtS2uBMh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWYQ91iFKCkHNSOCoj1qRoWVUbtF1j20EVsbqhe0BbeFWUxeZlfM6K4gZceuF1Y+MxeovnR9WC6EBBLDTohCi2yA4VgFC9aRSwgOVuKpO7a0TebL3+EJu8cZdRTOis72338fkLEDOgRtBOZ7MAINfkb6MPXd6fDKzspCO3yoTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E7C2BCB9;
	Thu, 30 Apr 2026 15:33:47 +0000 (UTC)
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
Subject: [PATCH 4/7] pinctrl: mediatek: moore: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:15 +0200
Message-ID: <ebdc02536f922f2261d6d338a6afa234015621ff.1777562725.git.geert+renesas@glider.be>
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
 drivers/pinctrl/mediatek/pinctrl-moore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 071ba849e5322396..17e30f83dc1972c0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -402,7 +402,8 @@ static int mtk_pinconf_group_get(struct pinctrl_dev *pctldev,
 				 unsigned int group, unsigned long *config)
 {
 	const unsigned int *pins;
-	unsigned int i, npins, old = 0;
+	unsigned int i, npins;
+	unsigned long old = 0;
 	int ret;
 
 	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-- 
2.43.0

