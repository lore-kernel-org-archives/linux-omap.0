Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173485;
	b=xSZ6ojQgMOxZFqdfFemseM5vepokAEtce20IvsCggCGkjRI2l546n//fodkwK+aBNDGs
	 TkrFqMF0kzZpAuEsf1la68IAubjt0R9EfiL5PFX9CftecBgn9WihSgHHPnZ375AgA6O+i
	 GTvjtAvulKB9S96fiAxWjIgFn3uO474O9c9j1Gyae5GBUNns9RXDsMROKoX9If4tDOoyY
	 gnS4oyRFP2mBSiuBYDCml8zGXX/3OSKvz+sx/gUsjhlST75AoE3m2cZ+LRvSDqbaLxA7J
	 L2tfhewzWFQqTPwJpECAVEIt47YqsUfHLl/XAqoDFHyjJM8Tg/17LxAonUOiIwE/ipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Iye3U/dlGnZ00j+zjr7HAr1TeijBnNq2JkuJKGfJwwY=;
	b=KTKgiKSG/72OXrYOgqoC/8KyuESyp9gGdpm291+3BNrCvc9CBT1lk3fnjQoj0EAhPW5F
	 gXg/x1xZIsr6gpVJlg/NXuwo3SxUq2CFzqn2Gzk8tXS63xNNbo1QJ88GQDdxl2VYuFgkS
	 dT+qa5+YRmp1fAI16d0IJVfLZy//XxNZ7UrVqACTIIhvTeEJtyVooGZ+Nj0O/OUgXJ+o2
	 H2ClC5xf0im/srEFiOza+hRnihX0D8ACqEoIdoEzFKlW0x58gjfWDgYKTrbf3CZA2Pcpn
	 TDihVusoFJuouwR/OL2TPURyQyNYCsrwkfubdzPmO7oP/GufDxUP5Ak/QunFQUbsztA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=eUFPTEYu;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CC606A331
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 07:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C3CC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=eUFPTEYu
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e46e449e8so376158f8f.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793173483; x=1793778283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iye3U/dlGnZ00j+zjr7HAr1TeijBnNq2JkuJKGfJwwY=;
        b=eUFPTEYuWWk3vbc9XWvlH2BlVk7sDoYniIKaACUAPTVadYzh2YiOHwL9bC4PjTkxKv
         Qwucdi8AvUdnGNgB1Ox8sV01tCXYu8QotrE3MdyjPCUp8ezCPwq/ZbELSt1/+eipXh9T
         PUrmWBOjntU+YFYIfkWzgSM1IF41jHTSxwAFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173483; x=1793778283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iye3U/dlGnZ00j+zjr7HAr1TeijBnNq2JkuJKGfJwwY=;
        b=V27k2yVRF+GbxIcr/z9Z0oQzby2Pcgj91NGH1KHDUY4aeRDjD8bsPE7u6YvLnH3SBx
         RlZhk/p2tGIojJ5LSoNdAoDfmeOZoMUmRaj0IvIICsx18iaGgyFMg8xEwBdgfKHpOuK5
         NKpMov+aFkaiqutIfEwyAm9LRvBQB7N/Ocvnw7Z0N5dX3gU5/SsvN+ahgnpuqRKPZiqI
         Z8b1C/hEsJJOJaHyUvILpQJNHZ+pIaST56+//YB9qSEXxCaMHyWHPPZ2cbaFU1oYGATe
         lNj/vCB3R8WCX6BbdtlWrrjbSSNVzIhCZtolvMrpucWt+Ed0Wag6icf5/lZiFDfNXtZZ
         CWbw==
X-Forwarded-Encrypted: i=1; AKwUvBw5cEMy4Ht0Bm/jPuTHjYzYUR7ZsrUwQHZ2g8Vo4kt3OKsc6uol1NQet8dqyJuQxG/2vxunJAk3Y+e+@vger.kernel.org
X-Gm-Message-State: AFq9FYLc7oBLx12lnl1IRB7HvGUiXfl1JYus4lCa6o43zS3bus2d8ewz
	AtPX3Rfolb8p90rKINaxPeHofpae8LQ3rEIsmocupU0QsWbhdneLwvZyemzL5baPIrU=
X-Gm-Gg: AYBFou1boiNi5iFrSqkZ0eSTdLv+PTSUDnt0e4sQY//S+SyR/dzspdIbp5jCWujCi9M
	JO1gqhG68WtsWeG64PV44mT4NclnWc3X2uuNAsfPmUe7cVIoUuEXh7XIWVsBHUqzX0WRNILHjKG
	PBWmDoCIji20S0svlo9ZT5c+zLlpVaTDa0N3EUbFbCvN1SCnvvacN+7avc4LrAW1gcJHzSDxPti
	+IyyBrvkaSXLJ8BuXCWwmUU3jOzJYtIzn4xZMC800OfLG1gICThM7qISuZmNw9dDMTMOvZbzAov
	fJKUEC2Zd7oRxXwD2KwfmXkhgTafWpcrdmQ9ehNCUeWHN/XSI9lXiNekI03lqCDWARaexkADk6w
	kRt4EhsuTXCeJZUDcMVFEyZKQVOgHStSy8mpRdeHZZ+M24h1s37W+6TcldUoWKSxO93VKM5zskA
	2Ot/aWwcGx2uFw6Qew07GP3O4xBizdcXZNKEZY+bERJ/S/gjiCpDn5VMYDOtC55HqdLZ2/5Madi
	VgmIj2NE3ArEoLHWhBnJBIEu73Vv5eyAR5NpusEJhHxneMcr4qacv70CdHaEEsf6D4cTuFTNtff
	wu1QzFwr7q5DHIZ7VUIDIhMw5POPf1ZSSGcY2XTuE+4ixzt1GWrbZ73vS15uf8hldE+rep9kmPa
	RpEjtXWuf+4Hmr+xPVBnegDODaiA3Pexn3i4mp1pqch9fh5IZ/8I5YJ+g+rravhx2EL/Tgrb3uO
	+tX6CrN89Kr2q/MdHczMpU4uZbOw==
X-Received: by 2002:a5d:4f07:0:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48e5d312c2bmr2716635f8f.52.1793173483413;
        Wed, 28 Oct 2026 00:44:43 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm25324882f8f.7.2026.10.28.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:44:42 -0700 (PDT)
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
Subject: [PATCH v3 2/3] clk: ti: dpll: use the generic spread spectrum configuration
Date: Wed, 28 Oct 2026 08:44:08 +0100
Message-ID: <20261028074436.1958132-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
References: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
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
and convert the deprecated vendor specific properties to the generic
configuration, so that existing DTs keep working.

The SSC registers are programmed at the next rate change, as with the
vendor specific properties. The generic framework expresses the spread
in permyriad rather than permille, hence the change in the deltaM step
computation, and also supports up-spread, which is rejected as the
hardware does not support it.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Keep parsing the deprecated vendor specific properties

 drivers/clk/ti/clock.h    |  2 ++
 drivers/clk/ti/dpll.c     | 20 +++++++++----
 drivers/clk/ti/dpll3xxx.c | 61 ++++++++++++++++++++++++++++++++-------
 include/linux/clk/ti.h    |  9 ++----
 4 files changed, 70 insertions(+), 22 deletions(-)

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
index e01272cd628d..1329b4bc02f0 100644
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
@@ -278,6 +280,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	struct dpll_data *dd = NULL;
 	int ssc_clk_index;
 	u8 dpll_mode = 0;
+	u32 ssc_modfreq = 0, ssc_deltam = 0;
 	u32 min_div;
 
 	dd = kmemdup(ddt, sizeof(*dd), GFP_KERNEL);
@@ -349,11 +352,18 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 					&dd->ssc_modfreq_reg))
 			goto cleanup;
 
-		of_property_read_u32(node, "ti,ssc-modfreq-hz",
-				     &dd->ssc_modfreq);
-		of_property_read_u32(node, "ti,ssc-deltam", &dd->ssc_deltam);
-		dd->ssc_downspread =
-			of_property_read_bool(node, "ti,ssc-downspread");
+		/* Deprecated, superseded by assigned-clock-sscs */
+		of_property_read_u32(node, "ti,ssc-modfreq-hz", &ssc_modfreq);
+		of_property_read_u32(node, "ti,ssc-deltam", &ssc_deltam);
+		if (ssc_modfreq && ssc_deltam) {
+			dd->ssc_conf.modfreq_hz = ssc_modfreq;
+			/* permille to permyriad */
+			dd->ssc_conf.spread_bp = ssc_deltam * 10;
+			if (of_property_read_bool(node, "ti,ssc-downspread"))
+				dd->ssc_conf.method = CLK_SPREAD_DOWN;
+			else
+				dd->ssc_conf.method = CLK_SPREAD_CENTER;
+		}
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
index 54a3fa370004..107056120c2c 100644
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
+ * @ssc_conf: the DPLL SSC configuration
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

