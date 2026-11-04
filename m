Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787471;
	b=zbW5B/RnER33rmI8xznafvwHEG1Aq0eyp4AYKq5wrUSvO8hBov7FJNtnWdMT1wnkW4ew
	 QACO0XToKz1uwfM8uyMU6k4BDH17gYUoUVzelXK3HZUv4rAmqMpRs/AbggYx/DIc2ji9/
	 zabmScZq1+63pW3NCOtM1ncql3boz1DBziqZ2APISQHcykthi9CPQaYyqeuAaDZ6rP8g+
	 FM82YeLstWJyKtXoSTv4DRYHtY5vga52vFA84QgAqCYrovjM6r7V72Ray6S15yHzyD8pl
	 YWx11AfTtzP1FvvvB16cAUDnfRTJdVFsPSQ+NsiEiJfGeirS2wrR9bDa7THdTqpjnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jbuhfSlfgFZ1tnBuSoCDBMKfZMfXYTX6enIbhL3dWk8=;
	b=lj504xCVcQCxU/3hXD/pWYR7gXDSgz89D8xKNf/BjoELuIXW1VdGofUCGsdLcxGdU9RV
	 2SOe+6ETK50ZKD12KpxHpbcXD5Y9pilW3xI4JqEfmCYGlS6y/JhAeV8EJk5O8BDut2iwd
	 EQr7k5USnPq8gVHUHrQrAWRI3xUuUb3NUT5TNFT2vibOLlAjqSVMGtE84493wXUBObOZ7
	 bYvRo4aaJTnco7lggwl2tCyIEOhURo8Un41/GrzrRvHdizVX4VJEliJ7sxpu80XsBp8+s
	 52gkKnCpP1mwRgCyAyXt6bLNrSKHDfAuYEZitMvZZsU5MUc+R0Zx2I28GzgtaA6n3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CyNEMifS;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9522606A332
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 10:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9522606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CyNEMifS
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b467581b98so3169445e9.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793787469; x=1794392269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbuhfSlfgFZ1tnBuSoCDBMKfZMfXYTX6enIbhL3dWk8=;
        b=CyNEMifSVUvkTiaf6KkOAei9iz6weszH54eAirXWayP4n7wL9TezYOigHf5joDbBja
         S8wK3tnIvZ92VTIq1L9pyaHv2pKagv+UCZZ7nZkVKoW5RvgTdmPteRu/OxZrHiL9upkY
         VhCzMqfWkaHnZgpb+uJjSCGYWdmBxAPIldN3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787469; x=1794392269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbuhfSlfgFZ1tnBuSoCDBMKfZMfXYTX6enIbhL3dWk8=;
        b=HXFD9FeqLSbpgxAAIC/Sd6VYTTngDE2o4MlgB0g656dFZ9uFKvMA7B4mCFMef2YRaD
         1/3cCOh0QRIG0e7/Uy2PRRyXeKOj7TFIFF3JNQ22Dzqu/KBNDwWS0yMxmKKqgzl5vBcD
         cXaAEYtr8FMDazbxQpgioSYlGMiVLfFKUeJpRjs4mJMiAIo7s8+oOmmBu10aqeRi6WRA
         A7VKt3l3CBjyTZ6mLdoTdLs6PFwDyKQ1uMnjFOJvdV1q5aTsXNKCHDfMcjygwmYb99QH
         2cpdzMlPR0Yog9VKgVW00fcyz6tTduUH0NHjJ23XU1FMWiLzxyKEmCjPPDumizr7vq85
         AO0g==
X-Forwarded-Encrypted: i=1; AKwUvBzqFMb0jCdnqYstbGo4J3SKtyXE069YNCd0RdjiYhqN8ZCEjV5AW67h61+RkKtjxWFR8RZmsQHrbin+@vger.kernel.org
X-Gm-Message-State: APuU4Z/u9BEAo82LIPYHkHEYIdecBg5GXRB3Js+u9DaAKYLt++TtgkaH
	P3WK6ygihF2UDmqb4XHzd8wnSLbS9snIlf7O+dMw7chvPCZhAtbAoPIRmtVTmIdJjMU=
X-Gm-Gg: AYBFou0zsWzHGOFJk1Uf1R32m87LtRzH2RNG9Idh8f2SQ/lD2V+6n3jygJvMiRHQtbd
	MNk/Besb4MJ+nY4AwZE4swAv1podPiF2UEXAGI+7VtuG0RYctzOEa2RaqOS9JLQlppu6ZI6smb3
	3yjavwG0y7Mc++dbgtjwOf3+6ov+dGVekzFAHh/osgBlOyMmvksJAeCVbMZqITcjuELvXNi3lob
	1qMttloSExphkbUPKF06XXq5JPxyudcNDUtnCTQWQoJ18q9eR2Tdq2htioixpiyoppWLXwmoy8D
	ighIVPk3+Hlp5fa6ItEoXKrvRgvBUdaY0a5dg4j8I5OnuBh9hwb1c3+n2oDpJrIIPI4kfj6QwUM
	hjLRFyboEGRKHHrpglU9KJ4fPH6TekgihlcGruPhey6wDB77g27/ogi/l+kqTPTn1q3EbHfbp6e
	KxBxrscZbDyvYX3nU1M2HUFtHzjfxc2gdE8kwKiJ4otp+4jVsObcwssBzKACd73yuSte8BK75Fo
	fLEMOgPO6teIifMSRS08Pz4I0JxKQsnwIHY0lVBJb+sBbwo3ykELhV2A0oJ87ZEK05VSi1Plm3r
	RBobBaBCHWR0eK7s45WgjmxGP2cQv4XZr0TpL9EGv5N9DqHPc4PohgwQeAAsO/k+U+YAZ7TWEZy
	42s4AsuLI73mgOV7uRJxCUWchHSZPQYazlldxFBg3uZVIKpZUUhkE
X-Received: by 2002:a05:600c:1f93:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ac180f299emr332117065e9.14.1793787469058;
        Wed, 04 Nov 2026 02:17:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([217.201.213.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feeb51a9csm3035105f8f.59.2026.11.04.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:17:48 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 3/3] clk: ti: dpll: apply the spread spectrum configuration right away
Date: Wed,  4 Nov 2026 11:16:57 +0100
Message-ID: <20261104101732.4043372-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104101732.4043372-1-dario.binacchi@amarulasolutions.com>
References: <20261104101732.4043372-1-dario.binacchi@amarulasolutions.com>
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

The spread spectrum clocking (SSC) registers are only programmed by
set_rate(), which the clock core skips when the requested rate is
already the current one, e.g. when the bootloader has set it up.
As a result, the SSC configuration is not applied, as it was with the
vendor specific properties.

Apply it from set_spread_spectrum() instead, reprogramming the DPLL
at its current rate.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Split the already applied check into the disabled and enabled cases
- Keep the reverse Christmas tree order for the variables list

Changes in v3:
- Skip reprogramming only if the configuration is already applied
  to the hardware

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

 drivers/clk/ti/dpll3xxx.c | 56 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 052233f2e12b..b48ea0492378 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -690,17 +690,22 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
  * @hw: pointer to the clock to set the spread spectrum configuration for
  * @ss_conf: spread spectrum configuration
  *
- * Stores the spread spectrum clocking (SSC) configuration of the DPLL. The
- * configuration is programmed along with the DPLL multiplier and divider
- * at the next rate change. The hardware supports center-spread and
- * down-spread only. Returns 0 on success, or a negative error value on
- * failure.
+ * Stores the spread spectrum clocking (SSC) configuration of the DPLL and,
+ * if the DPLL is locked, reprograms it at its current rate to apply it.
+ * Otherwise the configuration is applied at the next rate change. The
+ * hardware supports center-spread and down-spread only. Returns 0 on
+ * success, negative error value otherwise.
  */
 int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
 					   const struct clk_spread_spectrum *ss_conf)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk->dpll_data;
+	struct clk_spread_spectrum old_conf;
+	struct clk_rate_request req;
+	unsigned long rate;
+	u32 ctrl;
+	int ret;
 
 	if (!dd || !dd->ssc_enable_mask)
 		return -EOPNOTSUPP;
@@ -709,9 +714,48 @@ int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
 	if (ss_conf->method == CLK_SPREAD_UP)
 		return -EINVAL;
 
+	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
+
+	if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf))) {
+		/* Already disabled */
+		if (ss_conf->method == CLK_SPREAD_NO &&
+		    !(ctrl & dd->ssc_enable_mask))
+			return 0;
+
+		/* Already enabled */
+		if (ss_conf->method != CLK_SPREAD_NO &&
+		    (ctrl & dd->ssc_enable_mask))
+			return 0;
+	}
+
+	old_conf = dd->ssc_conf;
 	dd->ssc_conf = *ss_conf;
 
-	return 0;
+	/* Disabling SSC does not need to reprogram the DPLL */
+	if (ss_conf->method == CLK_SPREAD_NO) {
+		omap3_noncore_dpll_ssc_program(clk);
+		return 0;
+	}
+
+	/* Not locked: SSC is programmed along with the next rate change */
+	if (((ctrl & dd->enable_mask) >> __ffs(dd->enable_mask)) != DPLL_LOCKED)
+		return 0;
+
+	rate = clk_hw_get_rate(hw);
+	clk_hw_init_rate_request(hw, &req, rate);
+	ret = omap2_dpll_determine_rate(hw, &req);
+	if (!ret && req.rate != rate)
+		ret = -EINVAL;
+	if (!ret)
+		ret = omap3_noncore_dpll_set_rate(hw, rate,
+						  clk_hw_get_rate(dd->clk_ref));
+	if (ret) {
+		pr_warn("clock: %s: rate %lu can't be kept with SSC enabled\n",
+			clk_hw_get_name(hw), rate);
+		dd->ssc_conf = old_conf;
+	}
+
+	return ret;
 }
 
 /**
-- 
2.43.0

