Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D32FD695;
	Thu, 30 Apr 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563240; cv=none; b=dMKhmqT9XnLfnLcpwbbnDnEYFDCW8ZBYHAk2woPKPW2R8+XZzmydMLXdGPurdg6sC+9vBkwgOt3x7x3BdoHfD5U8AIJpxTA2YeMsFuDtAHCyGgbxwNq5DAtzgibwNYZWORhKm+QGpO6SOZZ6n7CeAkXRZgRPF4eaAdAmb5k5TZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563240; c=relaxed/simple;
	bh=85aBRNknhmuEGkiw7kGtubjhGyd/2ROHbunjWidKiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATtHR0BGrGKtHB03hR80+nJ3MU+CkRooAakvM2/4EQXOUbIzI/gA4xZfd2Z6oyrgE0kOYmug3MbQdZkOmlCQd4h+2JwBIpKuFYN0vp9J1woNdVUOZ+yhMnhALqxHjqdeDxaFgdrB45/9aiYb6Tccf8Y3tE/cwJt8StAM9XmlhHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1457BC2BCC6;
	Thu, 30 Apr 2026 15:33:55 +0000 (UTC)
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
Subject: [PATCH 6/7] pinctrl: renesas: rzv2m: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:17 +0200
Message-ID: <4bcb78b40d685b0aab8c3150d379240ffb765b37.1777562725.git.geert+renesas@glider.be>
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
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 495e7f5d41280dc9..827b3e91a6cc2622 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -695,8 +695,9 @@ static int rzv2m_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 					   unsigned int group,
 					   unsigned long *config)
 {
+	unsigned long prev_config = 0;
 	const unsigned int *pins;
-	unsigned int i, npins, prev_config = 0;
+	unsigned int i, npins;
 	int ret;
 
 	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-- 
2.43.0

