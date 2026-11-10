Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307660;
	b=cGSQtlcXVQumwN+o0gnAovMAuvC+PhMplSZk8GK3uFiUvh4Chm45d/onSWg38BiSpdnp
	 DmJoqdiqfVtzm4L/VjTSz5Vxn7cYP4NZrr5barhI4LQSCtwBDvphlmUkPvjz5ky8qMmoa
	 r+sRQRtSxInk88j1IrFGb3GP4whOX3MYcQSalJkB/0KSyMnABl6FB17pTX5w1D7XyXxF+
	 2J8g6/dnzPOlAVwprJJQnzmY8QyK3KTIBZEv3Uy9GJh80MxnUVLqRcnoicWWvefc2OuMt
	 CI7S+hXhU1bhtcxeoVi7izoUiLNA4gzMb5jsxS/F/9GmOMaP+m1umT+5b0nUzfQG57A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307660;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wZODk0x3yqzJBCDWpOPES/A5BYp24Qrx21fQgua+nqE=;
	b=wD5JggpH20HMwNIf2JZBQCPnKQjK6IGd5Nujm51+FhQwCucECEVDO05WmX0Am15WDxyt
	 sfjp72pcma1aLPqUQahT2eypH2bcuWiP1fRa7X0mszttaUXzPcMioN1gXybQIIWxnJr8Y
	 WAd5lQSKVd0LWcv/H72qqxVDfuvtRrPEAGyu4g46SYdj+rHOMH9U0ayoMqApju8r6aIMR
	 Vqk6yOMf+X7lburnASWPaCiklRaCWgYOj7nmx1KcLlr9OGX3f/Ukks8q9iNcMUq/LO8c8
	 dicBA+IqMEHdrSL22+XN0jg7o0n7MzMGcMAGjiDcYpYW3FQb4dioRHPuXCz48HaTB0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=nKIdliMo;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5C60A2604;
	Tue, 10 Nov 2026 10:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB5C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=nKIdliMo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=wZODk0x3yqzJBCDWpOPES/A5BYp24Qrx21fQgua+nqE=; t=1794307659; x=1795517259; 
	b=nKIdliMorgaQx7vWL70FDqhx5wOhju0DL8x18EVc5d1Bq8R78/ml0VKpG1u4xZnMbnlG97Q8ojZ
	AnR8TjPyImmrVf/MJu9Pw0fsAgXe/QI26tpOXKdltCDqHGWPNnkX8IdLKD9fwCHBoguG25XHXxC/U
	V0HIZCKnb9xFP/B6hIFeELbZZYmvYfdmuVkAwxUKMuAhqRe9fTltQ9joHPmHJIQxiJJb7LUxniFMR
	/vwGu+RB+ZxKekHqwcncw+pB9tHhgqBSN3AZZvT3G0uz0JO02ZBlnn+fDeGEVlLC4hCEkzuxUIyIR
	/HoBu9CcL7/kjcjttErYdQcrCj14SbblLOUA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Nov 2026 11:46:14 +0100
Subject: [PATCH 3/3] ARM: OMAP2+: remove i2c from OMAP3 hwmods list
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
Message-Id: <20261110-i2c-sysc-v1-3-8945eb1d38f0@kemnade.info>
References: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
In-Reply-To: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
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
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq8vX/mebuKiyfjDpaB7vsAWdsFCaM4o4tXOGyH
 jo3fn2mjGuJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavL1/wAKCRCEYUX6QCjc
 8Y2nD/93fQpAdBOEGofXlArCwVfUTpEYp/bOTcv2A23KC24sRKUDZZoMUhwaZ/x+Q5XwxYe+/RD
 wIZNkHafPDzwyoEUhgEI07/v7P/wrxhEnI1BXpAn/kIN5xx3SyXRrUNkROz+I/fVdWdmx5nJZfU
 f7ZmR/Ggc0rzCLpDpVCWyQV2YQk2q55QLaT3zavMtxnlyI8LOfE1WW0IlgxT0GCErFfNHD2YTa+
 wPi8SIJ8UV7oQ8H/HSIYMPA+zPZAhqBVsapn7ppXFou5C7COnG/YUmqpUZDHIcZogVXXzomXQAv
 Ur5NDIrhiEbsaRGNbhQXrFyClaKIsWmLtBf7D6VZ3Pfpg1nxsGP3kamnpH6CoJN22wf/FRBBO5l
 DyNm4cJT7pqqntLuSzsCTZSF5sKw13KD5dGxs1LAa3lXXsqOhmN6Ds9Vm8a2754T14VwbDFZvVy
 +0mrgF+LFEzezu2Vt82E0ewBkp35gSFfDs9vlR3Mb3Yp0C6S79mptP8uIMN2YB1BA4U0B6cOsWJ
 h2HHMdzVms0t9loSP8TLPIB0luZaK878K2N4ZWWtcXYAG9L4KaOV3g2F63DCMsxDRDATClRPEdo
 S/ZrF1sOvTdzlof4u5N6fkdp4wTMkztPsdwEd5BHfByR/DbXjp+V8Gz4CLLL9Taw+T+983U97wj
 TC4AjYsop9ZfoJw==
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

