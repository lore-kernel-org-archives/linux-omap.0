Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788370;
	b=iJTmPXndz9xSY2Lioq2prDBJt9YpoYDzNq/Gp+UVoTEn36hrbgJ9g181oTVmiZEb6C3U
	 jV7y/K9g4rZCHQd36LIOQTizDsWUNpN0g7tFOVc882i5kL2POOhbbm1r1PPS8cTXb+cU9
	 5un/yWyJ9tTrQ8f2yrdK+ZIk7AhluLeK1l/Y0AGd+yA58IaGT7x+xjhF1VT4txrRcwOcO
	 QwMQyNVSG3XXICECmzYV5OV493ZQKbDz+t1/UH1+ybTQ2pjBMRnVN9lpj9fWpyfF29h4M
	 rKI3Vya04ysUq/YBhFa4Rcu/O3JIg3jjNrzD7fhHYAaQbEayIxiFnZc85RWMwmwQkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7GOB/E9/w4+QB2YM44F2JEEKj4p9ZduGdyqEC2k4F4o=;
	b=5lf3TXwrg8uyHsMUHD69+jkkVqApxq5gcV/kI078Uy+zux8kp5dIDw8ZEsxdp3yPK2jJ
	 Rk1TgK4McxOxlNR1hxurUZI1TO7wx3iISBB4u7iCPSr44VxR70VDQ2/UjmoK2PZb9M58q
	 u4beeI3jx6sT5HtwBhUPpO0JBpOixaDjrdSPj2nO0GkyTj6b+r07XH5ejet+Dt1OECRe2
	 vaHwv7jnB8FnQYAyCeH3lzwSBv4qgSuwbx0wR5WUKZF4aQaHrwEGW3J0g8wEa4j2VjsS8
	 7///ssRy917hIfR7vjsQfBj9qi3Z37hqD4jhYNr7uu1rVW78/VexvEhuNP+1cyUJ6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtbdMjPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00554606A324;
	Fri, 27 Nov 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtbdMjPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1CD1F00893;
	Fri, 27 Nov 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788369;
	bh=7GOB/E9/w4+QB2YM44F2JEEKj4p9ZduGdyqEC2k4F4o=;
	h=From:To:Cc:Subject:Date;
	b=KtbdMjPLJSHotPfFnBfjjNdlVcccrI0qrEAeLFi3O8c9Y2fB1ZWOkTDqLgo16BQOx
	 82Ry299J/BGSuVxwCUxqo1E0c9aeyG3F9eBKsAU5s3a9rbrycRA4W1Ad/m762S5Zdf
	 Wod+fA95q8f1Ina3HGjsLvOyxa3WAie2K0sq8roKN5jhD3ABGgyPjdE6WpzqRRloQD
	 PDjUvCuR2KJz8Jeb88/hW08E9A+NlbVaMByQpFOALY50CdmmWcQanmaBQWKJgMpMmM
	 9cZjkIRu3QSnRtL/WG8kSdTDsgm0sSXEen4i8JF2uG9VlvCN6EPWuz2lCPS/0UHN7X
	 Jckf+YaUpmbbA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
	Andrew Gaylard <ag@ffroot.co.za>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Dan Carpenter <error27@gmail.com>,
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
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Nancy Yuen <yuenn@google.com>,
	openbmc@lists.ozlabs.org,
	Patrick Venture <venture@google.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	tomer.maimon@nuvoton.com,
	Tony Lindgren <tony@atomide.com>,
	Tzuyi Chang <tychang@realtek.com>,
	Wells Lu <wellslutw@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>
Subject: [PATCH v3 00/12] pinctrl: Fix memory leaks, OOB writes, and resource handling bugs
Date: Fri, 27 Nov 2026 14:04:48 +0000
Message-ID: <20261127140602.2790001-1-lee@kernel.org>
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

This v3 series addresses Alexander Sverdlin's review feedback on
pinctrl-single and rebases the twelve patches onto pinctrl/for-next.

v2 => v3:
 - Rebase onto pinctrl/for-next.
 - Add Alexander Sverdlin's Reviewed-by tag on patch 09.
 - Update patch 10 (pinctrl: single) to use kzalloc_objs() with pinctrl_utils_free_map() directly and update its Fixes tag, per Alexander Sverdlin's review.

Cc: "Andreas Färber" <afaerber@suse.com>
Cc: Andrew Gaylard <ag@ffroot.co.za>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Dan Carpenter <error27@gmail.com>
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
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: openbmc@lists.ozlabs.org
Cc: Patrick Venture <venture@google.com>
Cc: Shan-Chun Hung <schung@nuvoton.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: tomer.maimon@nuvoton.com
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tzuyi Chang <tychang@realtek.com>
Cc: Wells Lu <wellslutw@gmail.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
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
  pinctrl: single: Free pinconf settings array with
    pinctrl_utils_free_map()
  pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
  pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without
    duty-cycle support

 drivers/pinctrl/nuvoton/pinctrl-ma35.c    | 70 +++++++++++++++++++----
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 20 +++++--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 15 ++++-
 drivers/pinctrl/pinctrl-single.c          | 52 +++++++----------
 drivers/pinctrl/realtek/pinctrl-rtd1625.c | 12 ++--
 drivers/pinctrl/sunplus/sppctl.c          |  7 ++-
 6 files changed, 123 insertions(+), 53 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

