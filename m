Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708120E334;
	Thu, 30 Apr 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563243; cv=none; b=dDbEoJ95MsQsfXTQQhl7GFVvADVH2UesY/1fjzUGjPklo9WqYc9OIA7S+B2wXpzeI4TvW3BJBWKSy9ESWoUijsoankUMY3TNrGHtV18D7l5wAGeMMyasvZQB54O5ieK885G47NWH0QnYAZ8vItFdhbdNa4kva+V6VKuphFp3JxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563243; c=relaxed/simple;
	bh=751QAqK4aOm3hsprG5JXhBWVnKICFIp3TJ0K+M+IEt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzEHQcbk8yKXCbMbtPHlzV4QqU28VqjxtJjUGWoIb9fkHhFg8w5XX772VdwoNcI1ZcCUOfPnamVNH2ZrEfZ3H1RmVT83k4ptEBKMHyTUHmHuScY1hOPiUET7Gwc+17soGJItRbDmA2/N2n390E5aGK+LA0XaUrEMXqsa+pvBVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE2C4AF0B;
	Thu, 30 Apr 2026 15:33:59 +0000 (UTC)
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
Subject: [PATCH 7/7] pinctrl: single: Fix type in .pin_config_group_get() callback
Date: Thu, 30 Apr 2026 17:33:18 +0200
Message-ID: <72df69f272aa302059c470e0680a9c70985aaf36.1777562725.git.geert+renesas@glider.be>
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
 drivers/pinctrl/pinctrl-single.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 7e022a46ee422dc1..4d5f85b7e6bbe2b0 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -619,8 +619,9 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 static int pcs_pinconf_group_get(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long *config)
 {
+	unsigned long old = 0;
 	const unsigned *pins;
-	unsigned npins, old = 0;
+	unsigned npins;
 	int i, ret;
 
 	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-- 
2.43.0

