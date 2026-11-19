Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095653;
	b=E+3vOb0HImioZ0avFG33NPn+SciHWWeeGyJ7Imb0Rdk7vimeziv1LNqmW0ZPSQEKK0oV
	 CRq4Qm0R5bAGm4RKq65rE+NHMBccfyZi915Wu8kZcWZI8tnyulvP8i1cQWgcKSSbm9iZB
	 fbbg+8/kOuyWJ48Wds8ZmXQenNf7siSYJLRUDIAkLy7ErpKEFv5TpVto9zKWQ3jl6CzTb
	 7drM+XybQf2YaQLTUO2SRBWZjn9gnKGhBZiEWOuHP/kTMLXFlRS6ZFFLFh+JfAlXmqull
	 jPmag9kSb7kux5mMTXm2KEwuYh2n32lL5QgASQgAYeOjYq4Dd5es2tf1QXHdnbLa2MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095653;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NYdcVDwwKTLDFYwyrcPETMsPlvi/iH4FJG9TXdikXo=;
	b=GcQHgyiY0ENp9gwRgwZbfx3tx6ZmaUXzoveGmh+d2y0tqZZ3XYZuGuDzdJQXEZhTdD3l
	 yPsDI6T5zs3HeDS7eeGuxdemWkb4fnP8Qu/cTuz6teG0Sp4YAnsZgoHNId0ZKujvXlkYg
	 8lZro936K3hYIZJlY8MIaq1yKm4gP2vT3P/XZ85UEvGDf/O0cgSHzFLY7Ru/0NcbBgf4/
	 LQAbppLUs0e/Yo50hY0xC37nIryNnFCPeld2UnNfXR/OgWr+IEn2SwkxfkAn4YlNMNUpw
	 d1RNxuxvrpesYTQKdB3Z9M+A29qgIlURqv4LOFVbxlXPRyN3PytOVU179Q2jwSFILjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D64606A324;
	Thu, 19 Nov 2026 13:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B921F000C6;
	Thu, 19 Nov 2026 13:40:48 +0000 (UTC)
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
Subject: [PATCH 0/6] clk: Improve consumer field in debugfs clk_summary
Date: Thu, 19 Nov 2026 14:40:33 +0100
Message-ID: <cover.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

	Hi all,

When a driver uses of_clk_get_from_provider() to obtain clocks, the
latter show up as "deviceless" in the consumer column of the clk_summary
file in debugfs.

This patch series aims to improve that, by introducing a new variant
dev_clk_get_from_provider() that also takes a consumer device.
When callers provide it, the consumer's name will be shown in the
clk_summary output.

Sample clk_summary change snippet on R-Car H1 Marzen:
    - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
    + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider

Overview:
  - The first patch removes the unused "dev" member from struct clk and
    the "dev" parameter from clk_hw_create_clk(): it felt wrong to add
    yet another user of clk_hw_create_clk() passing a useless device
    pointer,
  - The second patch introduces the new dev_clk_get_from_provider()
    function,
  - Patches 3-6 convert users to the new helper:
      - The Renesas clock patch was tested on R-Car H1 and H3, and
	should work fine on other Renesas SoCs,
      - The Rockchip HDMI patch was only compile-tested, but is probably
	fine, too,
      - The OMAP2+ patch definitely needs testing,
      - The Renesas pmdomain patch depends on work in progress.

This series has been tested on R-Car H1, H3, and X5H.

Thanks for your comments!

Geert Uytterhoeven (6):
  clk: Remove unused clk.dev
  clk: Add dev_clk_get_from_provider()
  clk: renesas: Convert to dev_clk_get_from_provider()
  [RFT] drm/rockchip: dw_hdmi: Convert to dev_clk_get_from_provider()
  [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
  [RFC] pmdomain: renesas: r8a78000: Convert to
    dev_clk_get_from_provider()

 arch/arm/mach-omap2/omap_device.c           |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c            |  3 ++-
 drivers/clk/clk.c                           | 23 ++++++++++-----------
 drivers/clk/clk.h                           | 11 ++++------
 drivers/clk/clkdev.c                        | 14 ++++---------
 drivers/clk/renesas/clk-mstp.c              |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c      |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c      |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c             |  2 +-
 drivers/clk/renesas/rzv2h-cpg.c             |  2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  3 ++-
 drivers/pmdomain/renesas/r8a78000-mdlc.c    |  2 +-
 include/linux/clk.h                         | 10 +++++++--
 13 files changed, 38 insertions(+), 40 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
