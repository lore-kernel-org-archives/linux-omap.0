Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433983;
	b=caMyssZNgbnHf89cv9Urc1FKR/eJ8BcTYEd8z8ZnqhwZ5Wah9rSTgSO8li3fJ3u59bs0
	 XOMRUY0CP/dptebbbnraCMsn5m/niNVkDmJlYKowtEHowXmsFQUvXndwvsk87O8eO8i3i
	 atb++1cRKrCNgAVvlgQObK2ICqUrBlunKV9Gx23YupD58JFsXB2WNgpry3o/hNWu4lOAg
	 IwnAemT76j6u/zSqEZcjQdDu8+fKH/jJJUbCGhnKL4uG5OW3FhU5rS1iyPoTh6Eka8sv7
	 3DwtOlwSOafigyUuqV0/fdYaA0NSyZ3GlNXJ31Pnx2obhbUTuaFNVDtQZJ3K088bcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433983;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w4918hHXXDmKU7fR/Ldi5kPR9rByWFlOgXHLpR/sBLM=;
	b=pQBKYJBFu0POiLB8u2pq/Q7pbEg954LffYRgxhSVKZ3bIvj23qNDuT2j2ojsa9lRPk7r
	 suM720pcJ9Ywf9fE6gHGeKYs5kJTRbuuu8AsQmpEkeZctVAj8vHeT+Fl+QLGRNetudQB5
	 NU6+8HlCS9cYTlBnheQcNRsFNqQKKNyAm02hEJ2swoulRp9U8rhY62d4hci5aUvOFPI4w
	 QLw8Cyx6cyXP+XJAnFhXYfu1p0SrIGYQhAwpwmwkKpUjMBUlTqVATUDm0WXGTbFZ9EYy0
	 jwAiXOCk0B8cmU+7iO+bL4ggnCr5hPa/Sq4EsQ3Ve1mvbfY8aAhFOJKvye8L/RHD3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCM9Q700;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F8606A31C;
	Wed, 11 Nov 2026 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCM9Q700
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C031F00A06;
	Wed, 11 Nov 2026 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433983;
	bh=w4918hHXXDmKU7fR/Ldi5kPR9rByWFlOgXHLpR/sBLM=;
	h=From:To:Cc:Subject:Date;
	b=jCM9Q700oZYghT9ZuZtkTxVa7WzCKp6T+2kNdPYJhBtwwtts0mwOMiUYHHDWedJ9w
	 h5SE8aYakvTCRXnnwyzIMWrBibmwKYpK9VmBSEnklHu67PZyFSy8WFEToGJY+hRA4D
	 NJf+CdIrNLk9pHMmWw1py4NHbZyAVkYsLofqSuF/1poR3PCt/OW8PCe1lrCKVHVqSl
	 +8YyPDLwpIB46jK9yk6StqbMysQS1bQAyhEyyzaYffSZb0zfKgZX+u8Hemzt6gZYsD
	 +AvQz1XVMeCBuINqD1WrWBSAfFX2E1PPniw+qA8GHgfd4b2hNukVvuKbe4W+9s//+7
	 7lv1AuU7Ya0AA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.com>,
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
Subject: [PATCH 00/10] pinctrl: Fix resource leaks, out-of-bounds accesses, and error handling (batch 2)
Date: Wed, 11 Nov 2026 21:51:45 +0000
Message-ID: <20261111215256.1982044-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

Cc: "Andreas Färber" <afaerber@suse.com>
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

Lee Jones (10):
  pinctrl: nuvoton: ma35: Unmap reg_base and release clock on probe
    error
  pinctrl: nuvoton: ma35: Prevent out-of-bounds write in
    ma35_pinctrl_get_soc_data()
  pinctrl: nuvoton: ma35: Assign fwnode to gpio_chip in
    ma35_gpiolib_register()
  pinctrl: nuvoton: ma35: Avoid leaking map when parent node is missing
  pinctrl: nuvoton: npcm8xx: Propagate npcm8xx_gpio_register() error in
    probe
  pinctrl: nuvoton: npcm7xx: Fix fwnode_irq_get() error check in
    npcm7xx_gpio_of()
  pinctrl: single: Reject invalid register width in pcs_probe()
  pinctrl: single: Free pinconf settings array in pcs_dt_free_map()
  pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
  pinctrl: realtek: rtd1625: Set dcycle_offset to NA for pins without
    duty-cycle support

 drivers/pinctrl/nuvoton/pinctrl-ma35.c    | 55 ++++++++++++++++++-----
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  7 +--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  2 +-
 drivers/pinctrl/pinctrl-single.c          | 42 +++++++++--------
 drivers/pinctrl/realtek/pinctrl-rtd1625.c | 12 ++---
 drivers/pinctrl/sunplus/sppctl.c          |  7 ++-
 6 files changed, 85 insertions(+), 40 deletions(-)

-- 
2.56.0.567.gdb80ae8cd5-goog

