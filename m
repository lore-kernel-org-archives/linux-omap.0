Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804591;
	b=BHUq1c+G5dVU6XpcmqJ3TWkAV2BUfEUVuTrkeY+YeW0SQ/kBsFxxjLsrtbNoHa8wE00J
	 eVcTzVewILwj+6Re/28RKNrsNsrMoFvoiaHftGFmABB/OfBAmCqgoBOeJ+T1wL0REW2Aq
	 6SsYyn/rvfqQdkWrqHZ++KRU7o9+BuziOcm7ZKdVrK/PHjcJ8kqlQ8RqWFB0ThK2iS8AH
	 0wJisOvbL49ABnpg3Whu39EuwB/FpIH4QO3yIVwTLesq7132a5xHtw1awDDYYDk6PQxfb
	 2EKO+onDRbNcRkazVn9wsT6J8E8X0Xcy4vkN7KUi1Jkdk9BDhOvkUHjyaNnPcKy9e+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dnCyPV6D2bArF3GLES9sJUnpZcNoKPgSrEv1HpReYYc=;
	b=aWuQBPuPxDQEBYYBzR2xxCJ+lOxzi6U/IO5kX81It8TE6vLIq/5oj3gN8sh7B4T7K9RT
	 BsOY+ZD11ruU5PY3RpVv2W7z2yIPCMZddPp3xJPA9jRX3xQN85ESaIVxQlwzcf7+WNxv+
	 148xPu80qFHjpMDXUf/0XNtF+MP1zD/RcNtplWfc4WUtrGLR/7K59HXDOTgIj+jsezIDZ
	 r2gpxb5Xt6VoksOxmOxnvVBSVlrU6pCtmIeNHRWuQavxc4gAmufiCADpw5p95Mb1ynl4M
	 hZRGoMrF64L3PoI6Cl8ouDmYwtyP3QlewlEroC3Nrd9KNFQ5r31vNHW47RMyDnwrqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKpDybEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC7606A31C;
	Fri, 27 Nov 2026 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKpDybEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E21F000C1;
	Fri, 27 Nov 2026 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804591;
	bh=dnCyPV6D2bArF3GLES9sJUnpZcNoKPgSrEv1HpReYYc=;
	h=From:To:Cc:Subject:Date;
	b=kKpDybEmuPt4Ni4wm+qrSrm6qahoB9wY52yf0j9Yvcx5MYkBqK0toucrFoDn39z7v
	 k3EcaEzHnkN5liDjS1K3QR51dw+pFoZSQPY5QApFtE2AVkRbGS4Uu76/CxQ56YsNIZ
	 mIdL2P/mKlBvLeOSwmNLl4JeX8rhqsMG0rSB2NiR5TNsCkMFN3tapTu9jz3BXqwo3C
	 S0gvbA30RQ/xhvCROU0BEtJZbb9NLfR3uRS0ipzGFLeSpllAHVGnjyqEN7VMMmFKUh
	 NfYOjjmuZdo9ZBEJTs6Qv7Obqi6d+iqHiPYFrDIQEqdP/XPCekcatfRZE8I5ZYZ6lO
	 Nb6jwsG2Z399Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexey Charkov <alchark@flipper.net>,
	Andreas Kemnade <andreas@kemnade.info>,
	Corentin Labbe <clabbe@baylibre.com>,
	Douglas Anderson <dianders@chromium.org>,
	Eduardo Candelaria <jedu@slimlogic.co.uk>,
	Esteban Blanc <eblanc@baylibre.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Gyungoh Yoo <jack.yoo@maxim-ic.com>,
	Jerome Neanne <jneanne@baylibre.com>,
	Jin Park <jinyoungp@nvidia.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-omap@vger.kernel.org,
	Mal Nadar <m.nirmaladevi@ltts.com>,
	Mark Brown <broonie@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Rajendra Nayak <rnayak@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Stephen Warren <swarren@nvidia.com>,
	Tony Lindgren <tony@atomide.com>,
	Uday Khare <udaykhare77@gmail.com>
Subject: [PATCH 0/8] regulator: Fix locking, OOB read, lifetime, and global state bugs (batch 2)
Date: Fri, 27 Nov 2026 18:35:40 +0000
Message-ID: <20261127183624.3341010-1-lee@kernel.org>
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

This is batch 2 of Regulator bug fixes, based on regulator/for-next.
It addresses supply teardown and locking bugs in regulator core, slab
and global out-of-bounds reads in tps6594 and tps65910, devres lifetime
mismatches in tps6594, a NULL device_node dereference in of_regulator,
and shared global table mutations in max8907 and aat2870.

Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: Esteban Blanc <eblanc@baylibre.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Gyungoh Yoo <jack.yoo@maxim-ic.com>
Cc: Jerome Neanne <jneanne@baylibre.com>
Cc: Jin Park <jinyoungp@nvidia.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-omap@vger.kernel.org
Cc: Mal Nadar <m.nirmaladevi@ltts.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Uday Khare <udaykhare77@gmail.com>

Lee Jones (8):
  regulator: core: Defer supply cleanup and unregister event forwarding
    on error
  regulator: max8907: Duplicate of_regulator_match table per device
  regulator: tps6594-regulator: Use dedicated handler for external
    regulator IRQs
  regulator: tps65910: Fix OOB read and bit shift in external sleep
    config
  regulator: tps6594-regulator: Bind IRQ resources to child platform
    device
  regulator: core: Respect is_locked when disabling supply on enable
    failure
  regulator: of: Guard against NULL device_node in
    of_regulator_bulk_get_all()
  regulator: aat2870: Duplicate regulator data per device

 drivers/regulator/aat2870-regulator.c  | 30 +++++++++-----
 drivers/regulator/core.c               | 18 ++++----
 drivers/regulator/max8907-regulator.c  | 57 +++++++++++---------------
 drivers/regulator/of_regulator.c       |  3 ++
 drivers/regulator/tps65910-regulator.c | 20 +++++++--
 drivers/regulator/tps6594-regulator.c  | 27 +++++++++---
 6 files changed, 95 insertions(+), 60 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

