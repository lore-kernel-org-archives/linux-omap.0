Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807589;
	b=cpT9weYkWxDCoBkGm8zRFQ+06LUuAYRSwVgl0n48AezESjJpRbmF9x0TZqa/QleHFiLZ
	 5/U4ZE++mmcM330Fv6WewVeRXpjyfVBOHVOYwXrjKv1a7A+yZu3qTpW6/09IIdHg1jIn0
	 Yw4pclc0mllbxN2rXp1pljo7Eqb7aHp6Gxur0hsuR89RlThhGtTcU2EMv6N50i0MRqc3W
	 x/Kog/rUXZ9WKUu8XTP84lP9l0mGc5aC2S3O7nNXqBej4ftX+t4r0C1ti4L3+PKgyKGTP
	 3MOp+te7Ia4YxJo+dmux62G5OWVtxqK+itQKHFECLhSLV+LMzTRBxpmwlxivu8pr7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0Bj2HfA+RacmXf4tT16y1Nvz3cM+4pVUyjdUHKbVS6w=;
	b=bNVIIU3HcGbscXkYMjfxxwO3+6FdBFA0CUieiLkKq/XuSieRf6ByXn26wp/Mh9oWr0tH
	 YuCH/dxihwF145Do741vnw5NISpG5yTxM25UgXW695pzGnMtbzvQe1IxEfbrnAvRCCxk1
	 961QqPgsT5Rd24Q9kw8020JKYVFfegi8fuyoR6DSQ5m6Mfy0hWO6qi/G279wgD41m3eBm
	 uejW4n2jnvD7qVOssBiEi2bfJid2u/o4o16xHSLqTcEXR26tH25PsS1Xs3Q7W2k0SQI3E
	 of7ilN4GYr1SydCUaQVBrC1tmft745f7bJ909ACgVFCXklKL8BMPo60vRXrjtiJhO0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OF3EfNgR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24F606A31C;
	Fri, 27 Nov 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OF3EfNgR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B11F00899;
	Fri, 27 Nov 2026 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807589;
	bh=0Bj2HfA+RacmXf4tT16y1Nvz3cM+4pVUyjdUHKbVS6w=;
	h=From:To:Cc:Subject:Date;
	b=OF3EfNgRN+x5+FYr5KfqcWvf0pbWlwgu+0wy2XuPXwrMt+6BFUZmr7IYsMxke1tAR
	 2H8siDyj/38n9CKtkV67H4YremSwVVgxOnjHAr+9vMeaE1GtIwYIQFOR+GranT1NZW
	 Z5rGvx0cm7bFnbSxl1BHRpCy247QHU65ILaXuRcKrAtczFR5DBelI0c+GyMqHLSF6s
	 go8ygOgIiF4g/Ni+xoE5tVBPdpNbs+fXk6ahqf7HS6wGdBpBLyyojE0YAW5Nsp1iaI
	 voET/Ktf0U33MxcyO0+8ZMT9aQVAzF9sb0h/TIwQi1dwFyN5Mf+8geIV26Y31p5Xzm
	 oHrdZ0DzRtdlg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	"Thomas Richard (TI)" <thomas.richard@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Dominique Belhachemi <db@domibel.de>,
	Doug Anderson <dianders@chromium.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Michael Turquette <mturquette@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Nishanth Menon <nm@ti.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Thomas Abraham <thomas.ab@samsung.com>,
	Timo Alho <talho@nvidia.com>,
	Tony Lindgren <tony@atomide.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: [PATCH 00/10] clk: Fix OOB writes, UAFs, ERR_PTR dereferences, and rate-calc bugs (batch 2)
Date: Fri, 27 Nov 2026 19:25:24 +0000
Message-ID: <20261127192620.3443537-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

This is batch 2 of Common Clock Framework fixes, based on clk/clk-next.
It addresses output array OOB writes in ti/fapll, ERR_PTR dereferences
and double-unregister in tegra/bpmp, notifier UAFs and global array
mutation in starfive/jh7110 and rockchip/cpu, rate and parent lookup
bugs in rp1, and allocation error handling in sci-clk and icst.

Cc: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>
Cc: Brian Masney <bmasney+clk@redhat.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Dominique Belhachemi <db@domibel.de>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: Michael Turquette <mturquette@linaro.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Naushir Patuck <naush@raspberrypi.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Timo Alho <talho@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>

Lee Jones (10):
  clk: ti: fapll: Fix output clock array allocation and bounds check
  clk: tegra: bpmp: Drop manual clock unregister on provider failure
  clk: starfive: jh7110-sys: Use devres for PLL0 clock and notifier
  clk: starfive: jh7110: Duplicate top clock bulk arrays per device
  clk: rockchip: cpu: Allocate rate_table before registering notifier
  clk: tegra: bpmp: Skip ERR_PTR entries in tegra_bpmp_clk_of_xlate()
  clk: rp1: Propagate determine_rate() return value for PLL dividers
  clk: rp1: Reference secondary PLL divider clk_hw in parent tables
  clk: keystone: sci-clk: Check allocation failure before copying clock
    array
  clk: versatile: icst: Check kasprintf() and put parent node on error

 drivers/clk/clk-rp1.c                         | 32 +++++++++----------
 drivers/clk/keystone/sci-clk.c                |  8 +++--
 drivers/clk/rockchip/clk-cpu.c                | 26 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  9 ++++--
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  5 +--
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  9 ++++--
 drivers/clk/tegra/clk-bpmp.c                  | 14 +-------
 drivers/clk/ti/fapll.c                        | 13 +++++---
 drivers/clk/versatile/clk-icst.c              |  5 +++
 9 files changed, 66 insertions(+), 55 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

