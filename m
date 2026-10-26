Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000823;
	b=oEomPAKit/gPlidr/Izged49R1UJs9GWO2XCPZrhJYg0YwPT3y+RnUmZUeVYKnEGy7TD
	 +8I11ctz4lRMe1qqCDQH0HfeqrL+DHKvPdRYzQ5BpUaHNvLDenT5n3fxLnpBANHiOT4DE
	 GwGya3wAG/appJMuE16l7iCWlAoEJXt+qj8pTOy1LG4cAZhCp98gkVvQDqJfGxynLyRca
	 es7HuBcJwAjbaCuKiPFSOS0hjZwVD3P71+9ud/pSgHWSPZBRUblpOH+tR2dwFXuqZ+XGs
	 zS0hOyn0/0G0TdEs9LFI+FyqHXEXamXbaQ4VYGkdwnqOSHTWOpjlgvqsvxDx7Jnvyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AyUGw9y+lTYy33bkDqkQyHAnwgp3s7+TGmPupaPsrss=;
	b=w8lcDrjGLtkSKAnMb3M25AYk/nPaaZy6xnAfH0e+Soi3+4l9a24EbrAayQVQhn43jF/h
	 ENdUT1PeT4xlriUcBo6a8s9rOnkee8GDdNpa0YYUxhvtUHli6vCgiKn6mFiZgtmMpUdqV
	 NYVDx2nI75D+ixwTUZTLomHXDcAQ2jZlCxY8tVgO8DmOmFpMUSbeJGP3SIL/ffuMG0Lu7
	 oNEt7y2fRnlPjaEcLRevXAXobcSnErC8HI+wHq2wCkGGemlvWiocGKZDbNCMVnzf5U0A8
	 HnaGmtC9s1iCb+DOi6Ez7NwwqOskQucHOWq0oChBba6yYbeEk6ailQDnQ6W1f2+h9lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=bX3kRMW2;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862560A2602
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 07:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6862560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=bX3kRMW2
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso17186055e9.2
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793000822; x=1793605622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AyUGw9y+lTYy33bkDqkQyHAnwgp3s7+TGmPupaPsrss=;
        b=bX3kRMW24nMkF8yrKW/om/f/NwBbOa/rUD2be/zPmv5Lr2Yk+iYDXcSX7m9YZDgmFZ
         aTK2CfZtoOdqJZfuvahIAiflRMMG8qR8v78mk8+EMKOC19aAZ3xKoGuMFl37/gdgEqwn
         Rmj9gWdnAp+IYSjOHiw2l9CjUCZFmi/BOg7n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000822; x=1793605622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AyUGw9y+lTYy33bkDqkQyHAnwgp3s7+TGmPupaPsrss=;
        b=XMwtHJUF55EZ1dvnXIj+89UdtHSqHD/BlvIE1eTlBeYGOqzBV4vSbahb/yeLzJXqqp
         HKJ6HfeBUpjV5PZKsTj4KLBOsZKaBpdznf2pzAlGeH5Fg7Nq1woLNsWkn4erXNvGCdE6
         J8rjbI8ToVmoTKG1OTDjEKjJ12LrTw6TUgEpQZqS3WtHVKcnrT1zsLNgnS5+N9FiVjx1
         iUssukWQrArVcWTECcslq2o8Cy0XhZ3rM0Gmas09YfEAtVKG0oI1kRdhqj68mEEvJ6O9
         jMcLI0Dg1k/jahLcuvPYGNHjlrVKz5bTsI6STkunNSkvQNHt3iw5Mwha/EPi2CCHBHr8
         hP2A==
X-Forwarded-Encrypted: i=1; AKwUvBwk5MKejVJ8Uls39hGo1uVvwde4BsZEvmXPgUj3PxsyLfpZUFQP84fVHnHXnke/Q+xsugVCfhzF/fYg@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ3SAduzaXF/bcb5HCP1BVVR8Hrd2zl08k3h9YvM//IioeqF10
	o5O4KmwBCKuWOdFmuHJYI6ehlbB1mEu1WaVAR/TEJ3TnTz9Sc1cl4Up4Ga6mpU7XSME=
X-Gm-Gg: AYBFou0rwWylkzS7Sd8wHD016HpO4M8FlXCdRONFnKsAsKYGsTO8G1j5A4q1XMfTsrW
	lbMMzbb1FMto0V+ZlwvvsdQT6ZtXIrB+1J9nR2RIjpnxE8m/yNN+alnZOVskX4WhiTiuooxkfcI
	xPA/3FmmeXb/JHUeDfsqETUTR+5WOyX18q4bdfO/5cM8ZZq9777HnZR3nUGogLpqq/VPwHlc7UZ
	UmYq7p0//eXZXtG7yzP/qZXMbTbNdEwyqnAyM+MlmYRg3g1wMUfduuui4DQBxZ1jYW6bYiYQEAR
	rBS1UBC2pPDgZOHnZcXOlncgL6LsQlDwoWTKkeccRfbn+2FauwECSr0PHCojUcXeUBYpdk8AvKv
	9VZe9cfy1UIwOm7QpP39Kkrn30sE1NqP1yAFafm7eyADbGzAnESFbdMVpXev4KXlou9n/FkcoT1
	CXqlJig/IGE7dBPoiYCmy9xjyqpJCOdulOu65RBk8nlK5El2wHEqiBYYrJ3N6kd5C2CXcdzqmTk
	ydiGuszdQdd3PunwapjIzgQg2Z+BuTR1Z0Tj0XvG1IX7fNanme8wd0+61lsBxqlYocjEP3R0OLZ
	d7YKtMg4HvEmPb2xFZM+zGRA/0jDllpzm/rsRhlSZ/DJ6bIMeAHcPXn7Dep29TPx42GEc0+wdfA
	oxyGXMxnrJXMqsaHjUyW3Q4s+z+2p0UZq6jXxX0prRKnCWB+VZMz4lucEFFDDjOyYHqwucgLo5X
	w=
X-Received: by 2002:a05:600c:4746:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4a35ac8bb3fmr114614925e9.7.1793000821809;
        Mon, 26 Oct 2026 00:47:01 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm13731353f8f.7.2026.10.26.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:47:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v2 2/3] clk: ti: dpll: use the generic spread spectrum configuration
Date: Mon, 26 Oct 2026 08:46:28 +0100
Message-ID: <20261026074654.3997494-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026074654.3997494-1-dario.binacchi@amarulasolutions.com>
References: <20261026074654.3997494-1-dario.binacchi@amarulasolutions.com>
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

The clock framework provides a generic API and DT property for spread
spectrum clocking (SSC) since commit c86814e70390 ("clk: Introduce
clk_hw_set_spread_spectrum"). Implement the set_spread_spectrum callback
and drop the vendor specific properties.

The SSC registers are programmed at the next rate change, as with the
vendor specific properties. The generic framework expresses the spread
in permyriad rather than permille, hence the change in the deltaM step
computation, and also supports up-spread, which is rejected as the
hardware does not support it.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/ti/clock.h    |  2 ++
 drivers/clk/ti/dpll.c     |  8 ++---
 drivers/clk/ti/dpll3xxx.c | 61 ++++++++++++++++++++++++++++++++-------
 include/linux/clk/ti.h    |  9 ++----
 4 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index d5e24fe4ae3a..83225e506314 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -271,6 +271,8 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 					   unsigned long rate,
 					   unsigned long parent_rate,
 					   u8 index);
+int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
+					   const struct clk_spread_spectrum *ss_conf);
 int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req);
 int omap2_dpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index e01272cd628d..626b44297e42 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -51,6 +51,7 @@ static const struct clk_ops dpll_ck_ops = {
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
+	.set_spread_spectrum	= &omap3_noncore_dpll_set_spread_spectrum,
 	.get_parent	= &omap2_init_dpll_parent,
 	.save_context	= &omap3_noncore_dpll_save_context,
 	.restore_context = &omap3_noncore_dpll_restore_context,
@@ -63,6 +64,7 @@ static const struct clk_ops dpll_no_gate_ck_ops = {
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
+	.set_spread_spectrum	= &omap3_noncore_dpll_set_spread_spectrum,
 	.save_context	= &omap3_noncore_dpll_save_context,
 	.restore_context = &omap3_noncore_dpll_restore_context
 };
@@ -348,12 +350,6 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 		if (ti_clk_get_reg_addr(node, ssc_clk_index++,
 					&dd->ssc_modfreq_reg))
 			goto cleanup;
-
-		of_property_read_u32(node, "ti,ssc-modfreq-hz",
-				     &dd->ssc_modfreq);
-		of_property_read_u32(node, "ti,ssc-deltam", &dd->ssc_deltam);
-		dd->ssc_downspread =
-			of_property_read_bool(node, "ti,ssc-downspread");
 	}
 
 	if (of_property_read_bool(node, "ti,low-power-stop"))
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 8c51b988a04f..634fe0a1f9fd 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -295,30 +295,32 @@ static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
  * omap3_noncore_dpll_ssc_program - set spread-spectrum clocking registers
  * @clk:	struct clk * of DPLL to set
  *
- * Enable the DPLL spread spectrum clocking if frequency modulation and
- * frequency spreading have been set, otherwise disable it.
+ * Enable the DPLL spread spectrum clocking according to the configuration
+ * set by omap3_noncore_dpll_set_spread_spectrum(), otherwise disable it.
  */
 static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
 {
 	struct dpll_data *dd = clk->dpll_data;
+	const struct clk_spread_spectrum *conf = &dd->ssc_conf;
+	bool downspread = conf->method == CLK_SPREAD_DOWN;
 	unsigned long ref_rate;
 	u32 v, ctrl, mod_freq_divider, exponent, mantissa;
 	u32 deltam_step, deltam_ceil;
 
 	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 
-	if (dd->ssc_modfreq && dd->ssc_deltam) {
+	if (conf->method != CLK_SPREAD_NO) {
 		ctrl |= dd->ssc_enable_mask;
 
-		if (dd->ssc_downspread)
+		if (downspread)
 			ctrl |= dd->ssc_downspread_mask;
 		else
 			ctrl &= ~dd->ssc_downspread_mask;
 
 		ref_rate = clk_hw_get_rate(dd->clk_ref);
 		mod_freq_divider =
-		    (ref_rate / dd->last_rounded_n) / (4 * dd->ssc_modfreq);
-		if (dd->ssc_modfreq > (ref_rate / 70))
+		    (ref_rate / dd->last_rounded_n) / (4 * conf->modfreq_hz);
+		if (conf->modfreq_hz > (ref_rate / 70))
 			pr_warn("clock: SSC modulation frequency of DPLL %s greater than %ld\n",
 				__clk_get_name(clk->hw.clk), ref_rate / 70);
 
@@ -337,9 +339,10 @@ static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
 		v |= exponent << __ffs(dd->ssc_modfreq_exp_mask);
 		ti_clk_ll_ops->clk_writel(v, &dd->ssc_modfreq_reg);
 
-		deltam_step = dd->last_rounded_m * dd->ssc_deltam;
-		deltam_step /= 10;
-		if (dd->ssc_downspread)
+		/* spread_bp is in permyriad, convert to percent first */
+		deltam_step = dd->last_rounded_m * conf->spread_bp;
+		deltam_step /= 100;
+		if (downspread)
 			deltam_step /= 2;
 
 		deltam_step <<= __ffs(dd->ssc_deltam_int_mask);
@@ -353,7 +356,7 @@ static void omap3_noncore_dpll_ssc_program(struct clk_hw_omap *clk)
 		if (deltam_step & dd->ssc_deltam_frac_mask)
 			deltam_ceil++;
 
-		if ((dd->ssc_downspread &&
+		if ((downspread &&
 		     ((dd->last_rounded_m - (2 * deltam_ceil)) < 20 ||
 		      dd->last_rounded_m > 2045)) ||
 		    ((dd->last_rounded_m - deltam_ceil) < 20 ||
@@ -682,6 +685,44 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
+/**
+ * omap3_noncore_dpll_set_spread_spectrum - set the DPLL SSC configuration
+ * @hw: pointer to the clock to set the spread spectrum configuration for
+ * @ss_conf: spread spectrum configuration
+ *
+ * Stores the spread spectrum clocking (SSC) configuration of the DPLL. The
+ * configuration is programmed along with the DPLL multiplier and divider
+ * at the next rate change. The hardware supports center-spread and
+ * down-spread only. Returns 0 on success, or a negative error value on
+ * failure.
+ */
+int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
+					   const struct clk_spread_spectrum *ss_conf)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd = clk->dpll_data;
+
+	if (!dd || !dd->ssc_enable_mask)
+		return -EOPNOTSUPP;
+
+	switch (ss_conf->method) {
+	case CLK_SPREAD_NO:
+		break;
+	case CLK_SPREAD_CENTER:
+	case CLK_SPREAD_DOWN:
+		if (!ss_conf->modfreq_hz || !ss_conf->spread_bp)
+			return -EINVAL;
+		break;
+	default:
+		/* Up-spread is not supported by the hardware */
+		return -EINVAL;
+	}
+
+	dd->ssc_conf = *ss_conf;
+
+	return 0;
+}
+
 /**
  * omap3_noncore_dpll_set_rate_and_parent - set rate and parent for a DPLL clock
  * @hw: pointer to the clock to set rate and parent for
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 54a3fa370004..81ac070551f9 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -65,10 +65,7 @@ struct clk_omap_reg {
  * @ssc_enable_mask: mask of the DPLL SSC enable bit in @control_reg
  * @ssc_downspread_mask: mask of the DPLL SSC low frequency only bit in
  *                       @control_reg
- * @ssc_modfreq: the DPLL SSC frequency modulation in kHz
- * @ssc_deltam: the DPLL SSC frequency spreading in permille (10th of percent)
- * @ssc_downspread: require the only low frequency spread of the DPLL in SSC
- *                   mode
+ * @ssc_conf: the DPLL SSC configuration, as set by clk_hw_set_spread_spectrum()
  * @flags: DPLL type/features (see below)
  *
  * Possible values for @flags:
@@ -124,9 +121,7 @@ struct dpll_data {
 	u32			ssc_modfreq_exp_mask;
 	u32                     ssc_enable_mask;
 	u32                     ssc_downspread_mask;
-	u32                     ssc_modfreq;
-	u32                     ssc_deltam;
-	bool                    ssc_downspread;
+	struct clk_spread_spectrum ssc_conf;
 	u8			flags;
 };
 
-- 
2.43.0

