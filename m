Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BA1A0B15;
	Thu, 30 Apr 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563215; cv=none; b=CsOglZNQ3CkLQrB/r+vv/esvq0xsFuCIZ5UfDxZc/6KsOBurXbZfJ4xBa0w8aRycBVC4fB8AXHn/HMT9uwUn0cRbEXMYgOrDcyCzPEabQ1/UMLE8Sqm+3rnqI+wliRz+7Iz0fTRUDDdruN2FHwTQpw58bFQAGxizuM/yDduxRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563215; c=relaxed/simple;
	bh=e6NeHJJSWzZxYPocOW+k/EErrtmq3OJF2KLkL+vdVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZA6K6T7nWLyTHSxJ8EHCLkA0rcunPPQSRwPtrIhns9TNvB3LgWeu8bJ6Tli1TA93stb9dTL0h1wAhWlGrGEwBJ8zdkjq/kcZEmClXXH6SewcgP6jzT8CJVz/2cI/pumUhNkuekdM2gfMvi9i7BFwGc2kjZKX2DcccrVMfbHAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD608C2BCB3;
	Thu, 30 Apr 2026 15:33:31 +0000 (UTC)
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
Subject: [PATCH 0/7] pinctrl: Fix types in .pin_config_group_get() callbacks
Date: Thu, 30 Apr 2026 17:33:11 +0200
Message-ID: <cover.1777562725.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

On 64-bit platforms, "unsigned long" is 64-bit.  However, when checking
if all "unsigned long" configuration values passed to the
.pin_config_group_get() callback are equal, several drivers use a 32-bit
temporary.  Fortunately this works, as currently all configuration
values fit in 32-bit.

This series makes the code cleaner and more future-proof by changing the
types of all temporaries to unsigned long.

I intend to queue patches 5 and 6 in renesas-pinctrl for v7.2.
Thanks for your comments!

Geert Uytterhoeven (7):
  pinctrl: airoha: Fix type in .pin_config_group_get() callback
  pinctrl: equilibrium: Fix type in .pin_config_group_get() callback
  pinctrl: ingenic: Fix type in .pin_config_group_get() callback
  pinctrl: mediatek: moore: Fix type in .pin_config_group_get() callback
  pinctrl: renesas: rzg2l: Fix type in .pin_config_group_get() callback
  pinctrl: renesas: rzv2m: Fix type in .pin_config_group_get() callback
  pinctrl: single: Fix type in .pin_config_group_get() callback

 drivers/pinctrl/mediatek/pinctrl-airoha.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c  | 3 ++-
 drivers/pinctrl/pinctrl-equilibrium.c     | 3 ++-
 drivers/pinctrl/pinctrl-ingenic.c         | 3 ++-
 drivers/pinctrl/pinctrl-single.c          | 3 ++-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c   | 3 ++-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c   | 3 ++-
 7 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
