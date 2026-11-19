Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121420;
	b=sUAJBGu0KV4HlA6KNWdTx45sDcQs9RD45yz5ApDgH0EWqEzpit0C7mdV3fdv0duWk4Qq
	 U1+KJphC/StLHLrdzxu12mO3S0OK50fjI74BS0m5MYtyW3rzgCyFjP83e6+yH6W2vWc4Q
	 E/YXgB/C75yId6rRzzTWfgtB4l1KMzzVFDwE1uUcu7yk5eEMkjwcw9S8hY4P5y9ikVt9f
	 BW8fFcOrkO1kePtCpk1tc3GJR3Lsn9vQXLd+BPzkUscsckLHZhjJjg+0irVTRppd4ptX4
	 EaY/P2alx4HpsJ5Z9UGJRELTMfhKrQBJpw47g3iY8IuSnl4OepSFSIyCEYF5VFJKoCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9kpI7Vq4supsYlMGRpz50aG63c4CSQV96+wn8mS3O4I=;
	b=Wr41eg1zhKy8xSkd37bFkxVeygmrgBEACCnOy+MRMg3x9HY6p57wxOtPECe137XVW+Ph
	 5PdZG/plYHA8ee0hxy00fMiDA/XvjXuqMhFi4Up5ztRrQAioez4s3K6hA1+aKKLb4iRpn
	 S1xPQjRl7IrqRo98kCkLKkIELYKlaneTyL4QL2a6RZLBskUhZiYLYpUVDwAqCq4vPAOi1
	 YYSyyeAT1UpJTWH0G77Za0i0bMXQEIv4T424Cq4Gp7AFXMyVu6YVeD1LtV5ztQaqXHPnM
	 P2Ni1dTEf9CAqA6aAKOtGiPa0Fc8/56gzqb3b8WMk6udPQor9OTaiMyzeS/O+2rhFVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7g3URJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B443606A91D;
	Thu, 19 Nov 2026 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7g3URJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6122D1F000C6;
	Thu, 19 Nov 2026 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121420;
	bh=9kpI7Vq4supsYlMGRpz50aG63c4CSQV96+wn8mS3O4I=;
	h=From:To:Cc:Subject:Date;
	b=B7g3URJjIH6bQfbnjExdaBIFhBZy+ITUC6TvmuTsYjj9Ev6hyn8K/sM3jmzyhXran
	 dXDMiO2QjapDv+UTqIv0OuJZN7FM5Vki90dte4g5d+aaaT1k8ZYX4SfegB7R6A3AtH
	 c1m/TX5wzsegJeN1t7uXFQl2Ae7d56oSf8tvh+hpvVro4EWtYoWIZh3x2ALcupEP2V
	 7nBltUj2R3fZA1bUvKOVZwXO4huEeRgCOU6F+a6SHZG4WZ5jbkxmFCnGJODJk+hKc9
	 JFz9yAeqcEMbQuWNdxOcVgDkXwJEdnvXa8ZNXQz/Mdyds5ZJ34C6HfSQizlRv6PZY7
	 UyJGIDXNhDLAw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexander Sverdlin <alex@sverdlin.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
	Andrew Gaylard <ag@ffroot.co.za>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	James Tai <james.tai@realtek.com>,
	jordan_hargrave@dell.com,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-realtek-soc@lists.infradead.org,
	Nancy Yuen <yuenn@google.com>,
	openbmc@lists.ozlabs.org,
	Patrick Venture <venture@google.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Tali Perry <tali.perry1@gmail.com>,
	tomer.maimon@nuvoton.com,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Tzuyi Chang <tychang@realtek.com>,
	Wells Lu <wellslutw@gmail.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>
Subject: [PATCH v2 00/12] pinctrl: Fix resource leaks, out-of-bounds accesses, and error handling (batch 2)
Date: Thu, 19 Nov 2026 20:48:56 +0000
Message-ID: <20261119205013.2563811-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
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

These issues were reported by Sashiko (batch 2).

v1 => v2:
 - Rebase onto pinctrl for-next, dropping the manual fwnode_handle_put()
   in npcm7xx_gpio_of() now covered by __free(fwnode_handle)
 - ma35: Explicitly include the I/O mapping header for iounmap()
 - ma35: Retain a reference on bank->fwnode in ma35_pinctrl_get_soc_data()
   (Sashiko)
 - ma35: Correct the description of commit 3fd976afe974 in the
   dt_node_to_map commit message (Sashiko)
 - npcm7xx, npcm8xx: Release GPIO bank fwnode_iomap() mappings via devres
   on error (Sashiko)
 - single: Switch *map and settings in pcs_dt_node_to_map() and
   pcs_parse_pinconf() to unmanaged kcalloc()/kfree() so devres teardown
   cannot free *map before pcs_dt_free_map() runs

v1: https://lore.kernel.org/all/20261111215256.1982044-1-lee@kernel.org/

Cc: Alexander Sverdlin <alex@sverdlin.org>
Cc: "Andreas Färber" <afaerber@suse.com>
Cc: Andrew Gaylard <ag@ffroot.co.za>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Dvorkin Dmitry <dvorkin@tibbo.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: James Tai <james.tai@realtek.com>
Cc: jordan_hargrave@dell.com
Cc: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-realtek-soc@lists.infradead.org
Cc: Nancy Yuen <yuenn@google.com>
Cc: openbmc@lists.ozlabs.org
Cc: Patrick Venture <venture@google.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: tomer.maimon@nuvoton.com
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tzuyi Chang <tychang@realtek.com>
Cc: Wells Lu <wellslutw@gmail.com>
Cc: Yu-Chun Lin <eleanor.lin@realtek.com>

Lee Jones (12):
  pinctrl: nuvoton: ma35: Unmap reg_base and release clock on probe
    error
  pinctrl: nuvoton: ma35: Prevent out-of-bounds write in
    ma35_pinctrl_get_soc_data()
  pinctrl: nuvoton: ma35: Retain child firmware node reference in
    ma35_pinctrl_get_soc_data()
  pinctrl: nuvoton: ma35: Assign fwnode to gpio_chip in
    ma35_gpiolib_register()
  pinctrl: nuvoton: ma35: Avoid leaking map when parent node is missing
  pinctrl: nuvoton: Unmap GPIO bank registers on error in NPCM7xx and
    NPCM8xx
  pinctrl: nuvoton: npcm8xx: Propagate npcm8xx_gpio_register() error in
    probe
  pinctrl: nuvoton: npcm7xx: Fix fwnode_irq_get() error check in
    npcm7xx_gpio_of()
  pinctrl: single: Reject invalid register width in pcs_probe()
  pinctrl: single: Free pinconf settings array in pcs_dt_free_map()
  pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
  pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without
    duty-cycle support

 drivers/pinctrl/nuvoton/pinctrl-ma35.c    | 70 +++++++++++++++++++----
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 20 +++++--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 15 ++++-
 drivers/pinctrl/pinctrl-single.c          | 49 ++++++++--------
 drivers/pinctrl/realtek/pinctrl-rtd1625.c | 12 ++--
 drivers/pinctrl/sunplus/sppctl.c          |  7 ++-
 6 files changed, 126 insertions(+), 47 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

