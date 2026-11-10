Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344238;
	b=4Dti5+odXpknzbihthhkcNPZOmHX7yXsny+BATylTRQTU+2QJ0ymvmEJ7PafVj28RIaH
	 hU5VO+3mB1fizABVOcwcyZoo7dx/CA2w2Op32k8KuMYSBuhtJLK8bJ79zBbmHPsbdLFtf
	 cvanveFk3RFLvUyN8FBZ1GdrKeZBp/MdLppu66fpsBO/+9wcU2TVAxUbpCIy5s7d3eYec
	 D1oT1iavF2QtHz66+ltT0Hz0mpDUP4ww60fxA5JexF5IV2AUfDW8nhCzCXHvwhoVzkPQ6
	 4YKcH4RQNZHslscuWQpBnKlxrLPNPM1RPi/d20IawcIq33lghnyb0SN3pJ6YPXl52SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344238;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wZODk0x3yqzJBCDWpOPES/A5BYp24Qrx21fQgua+nqE=;
	b=XfeHjFuFVY1OIa4c+7v064u5GVJBZnYY5AGIpNsftQbC1B5tNJ8eaZA/sJ9d1Ay964ud
	 CXIBFSgXQcUQ+urqM7GWHkaMTrhDBEO8AL6mgFSehGLxppEFFP+ykLwf0kUPeQF8xGfFR
	 mAqTVh5ybMDf+dB4OefBzRRFnfMSg7j5CCM+gjxEGLp7h5B1zNuFNQanBxkSC5zXI0if6
	 9FOBR0W48bP0L/4iuSgQaB3UDLCuiXUxhDh0P/eeKsXOu/TC/op7x43Z2n0kPXFzDyiii
	 3wUS8tvM0ZeKKCCf1OAK4zb9OVgrTPX8ATlettKuXpvo2jqDPhR+2rWDGLuj3G11D2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=mmGND9i6;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493D606A321;
	Tue, 10 Nov 2026 20:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0493D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=mmGND9i6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=wZODk0x3yqzJBCDWpOPES/A5BYp24Qrx21fQgua+nqE=; t=1794344237; x=1795553837; 
	b=mmGND9i6wgr25Rgt7uBrnNMxVxCmVuIfvitRdqe7nFu6RnzryBNkeq10+5nBSNgRTChR6LEsfnl
	Xd+2AIGyAiipmuufApkfvHfoZJlvqdImGUP5o07sYhvP3/l7CnNI9qjHnkAWVSo5J+jA2emza6pi6
	m2hYGXL/6YsKHCQndReGK2qCyRGvDtBqkDS6QHoQhWjxFhXZXynGb31tMNRcPciz/Dj071bQV8QVq
	uSYYWdmKom5OZTohUTVW/cN3CATmaBhgCf+nBZXHMu41t7v8WzqMVQDvkQY/0TJ4+1isvlq6gsBQ9
	3zSmBXPAJgTlwq9Ieu8h/Ju1G6bhU3MVmXJQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Nov 2026 21:56:05 +0100
Subject: [PATCH v2 3/3] ARM: OMAP2+: remove i2c from OMAP3 hwmods list
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-i2c-sysc-v2-3-490cda69e350@kemnade.info>
References: <20261110-i2c-sysc-v2-0-490cda69e350@kemnade.info>
In-Reply-To: <20261110-i2c-sysc-v2-0-490cda69e350@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>
Cc: Sicelo <absicsz@gmail.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=4470; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=dJ7m5yFM4nPU3HLiIjt0TUzuu0qUiJjWRTDLZhcz+GY=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq84UIP8HhrdyMxF/4yM8sSKbSZgeAop7ENCA7i
 keQe06z13aJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavOFCAAKCRCEYUX6QCjc
 8dLCD/98X/tUcqTuGQJMv0QVoHfI/hFz6Y13KG3eognjaidL3WMJzZU2CPmp8b+b7bN49xJnXce
 pGn01HRM8EJyKX8mbcvulT4ZKfGy5T+tAtC6UeSdiXlcfkzVQCR4nms3m6J/DrDI0R9QVwFrQiB
 jPf1EUmMQEsHzpFNqDNOs8RfXfPrwo31lIJF2nJWhttDjA/k7JHJN7sFTsYryrJc6vlrpT33xte
 j8IkbBQ6zhI6+ZStsFdKe2E2q3QtQuBSW9GMr7w8jKvnmpgyXbbJ6AhucDAYTZmPGH/E232gQoW
 oRHomS9cgvLn0M7MBkZwhhUxs4Cgx4HI991Il7dpLNB10Qnsl+JqbppQLdP6aIp5Hh0eFGkjd9Z
 Wuv5zK4HF4qjwH5Xs67qzLK42m9c2Fs+2YhhaGL8m5ePeHG5SLku5W34hb/UWbnpHsme14byl1J
 Oycg6akZBfF8J7Jilvqiu2g7MBjkCCwRy1pWCIxq52n1AE2MKzQyQGg9gQfBeIFEWd90MKmQNgt
 iCKgoy+z8fUuG8wmu8lvtil8D5jHCrgtkxiIMfxsznK2KeW2Ms3mLA699ZbJlAEFJnTWbJAJhx/
 vUL9kE8Yhu71FhbDJsPsfFrhAeer3Hn4VhJ3RkI57/UpZOAa+wtbZ0tFSOajH57L10IKwYduL88
 JpX2omp9pdbiQPg==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Not need anymore due to ti-sysc transition, so clean up here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 112 -----------------------------
 1 file changed, 112 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5cbdf58ad59f7..022019ff4a398 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -299,18 +299,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
-/* I2C common */
-static struct omap_hwmod_class_sysconfig i2c_sysc = {
-	.rev_offs	= 0x00,
-	.sysc_offs	= 0x20,
-	.syss_offs	= 0x10,
-	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields    = &omap_hwmod_sysc_type1,
-};
-
 static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap3xxx_wd_timer_sysc,
@@ -431,12 +419,6 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
 	.class		= &omap2_uart_class,
 };
 
-static struct omap_hwmod_class i2c_class = {
-	.name	= "i2c",
-	.sysc	= &i2c_sysc,
-	.reset	= &omap_i2c_reset,
-};
-
 /* dss */
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	/*
@@ -592,51 +574,6 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-/* I2C1 */
-static struct omap_hwmod omap3xxx_i2c1_hwmod = {
-	.name		= "i2c1",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "i2c1_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_ST_I2C1_SHIFT,
-		},
-	},
-	.class		= &i2c_class,
-};
-
-/* I2C2 */
-static struct omap_hwmod omap3xxx_i2c2_hwmod = {
-	.name		= "i2c2",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "i2c2_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_ST_I2C2_SHIFT,
-		},
-	},
-	.class		= &i2c_class,
-};
-
-/* I2C3 */
-static struct omap_hwmod omap3xxx_i2c3_hwmod = {
-	.name		= "i2c3",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "i2c3_fck",
-	.prcm		= {
-		.omap2 = {
-			.module_offs = CORE_MOD,
-			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_ST_I2C3_SHIFT,
-		},
-	},
-	.class		= &i2c_class,
-};
-
 /*
  * 'gpio' class
  * general purpose io module
@@ -1605,52 +1542,6 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__uart4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* L4 CORE -> I2C1 interface */
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
-	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_i2c1_hwmod,
-	.clk		= "i2c1_ick",
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C1_REGION,
-			.l4_prot_group = 7,
-			.flags	= OMAP_FIREWALL_L4,
-		},
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> I2C2 interface */
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
-	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_i2c2_hwmod,
-	.clk		= "i2c2_ick",
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C2_REGION,
-			.l4_prot_group = 7,
-			.flags = OMAP_FIREWALL_L4,
-		},
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> I2C3 interface */
-
-static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
-	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_i2c3_hwmod,
-	.clk		= "i2c3_ick",
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C3_REGION,
-			.l4_prot_group = 7,
-			.flags = OMAP_FIREWALL_L4,
-		},
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* L4 CORE -> SR1 interface */
 static struct omap_hwmod_ocp_if omap34xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -2300,9 +2191,6 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3_l4_core__uart1,
 	&omap3_l4_core__uart2,
 	&omap3_l4_per__uart3,
-	&omap3_l4_core__i2c1,
-	&omap3_l4_core__i2c2,
-	&omap3_l4_core__i2c3,
 	&omap3xxx_l4_wkup__l4_sec,
 	&omap3xxx_l4_per__timer3,
 	&omap3xxx_l4_per__timer4,

-- 
2.47.3

