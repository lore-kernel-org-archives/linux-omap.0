Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37582E8B98;
	Thu, 30 Apr 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563236; cv=none; b=n9JzmDMs2obLNG9cOxIT3j3NOSl+R5Xwp51q5/+f0YqoYdlH13nLnpSxzo4/eOXiBkC3dVq6j2kXc4hXrxEXjBjOyyFheg0VODY73fLSXB4gRNuHc34MgM3qv4q50ScSKH7elr0E46g6VDK+JMfQAZeOt+kVVJ/754wdbWn4rJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563236; c=relaxed/simple;
	bh=ngjibsCsSzDLd6OSKqwa8aDnxPKUB7O0twtyAwWZNTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgecCj6B5iEsFJjyUaOuL03vad3YGjjklkVgtnCAdG5y25JgZxjUkl70bcF0XedPY14kShCupc1PVm01xBKLFIwXB7LRH3bOvfL+iDjyseDlWrmEnmtRpmy28AiYbza1MICH4BcPNOmrfGPUsMttdSI2Vg6u3q/RS7BXCNrkPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E30C2BCB3;
	Thu, 30 Apr 2026 15:33:51 +0000 (UTC)
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
Subject: [PATCH 5/7] pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:16 +0200
Message-ID: <6befae30f129daffd94f7a9507d874443e444a21.1777562725.git.geert+renesas@glider.be>
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
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index bc2154b695149809..5b0f23af5a6cc9de 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1647,8 +1647,9 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
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

