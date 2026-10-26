Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000825;
	b=E3+svPZol9OUCOdtNud2TYGo70rOFTC+75SXtPl/TzdUy7Bm6PHkOH7SE//BC934jCQJ
	 0daQz23j09ZR4Mw05vtse+1HS3LIoxm+H4y3Lub65hhZLgL70Eecuo8ngFKy7hrfgH/Oc
	 MbMFe3xqrWbxk6k5j2JO+cSyoBr9GtIlgok3ToyiKQGM9IxfcVUKsenXI+gE2QJA51Eoy
	 TSP6GD6L/vb0NOncJdV1PHoR5U1xOH3BBQlWl4a6wlEJpIqG5h5RYzhAVjCziAWZmgb2o
	 XBKzKgD9mBIG7CKoSuU7xgEbRsBdbJOIqS72kmT2RGiQwEmQJ+SrdrE7WdKlm5bF1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y/fMNupjmUFDA4Fs7jz5eM8c/pdIIe9SGMOk6RgTsFc=;
	b=0UyEFZWjMZ+FGZssG32z2o/yfMGARyPVJLlzxqJfecDxnsAHd6RbDxKZcLy2hDgAY0Ot
	 vUhYEXQ6Py07LfGNa+7A+mlzDNMNAHms/VTXGMpVoahdOgSJ5zJUofvFQQ36DZv6x9NBJ
	 EGerTdzZMYZSbVtK/CJK6PZPFHV8P0dMVkELPX6bCT/13Zt7YPHArT//OiXg+HcAm+I3r
	 exUfGdipQHpM/shZTDGNqCHkDtgL6CIB0SgZOFzr2Tgujq0rV1MKXwd5iUHk5Lq1pnD9W
	 hC92qyzmbAmsqBwi/Rs9KInsCPW2KOaKBzFda5AcFt+KLq5mi8IbERcqeeMDI4KFhIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ChnSGDu5;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6260A2613
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 07:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D6260A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ChnSGDu5
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1631576f8f.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793000824; x=1793605624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/fMNupjmUFDA4Fs7jz5eM8c/pdIIe9SGMOk6RgTsFc=;
        b=ChnSGDu5hUuDpuWIH9opEBsyTk71WKjPlowVCbcYkco7zRAYFTYFWR355PNsm3a4sa
         2Hn+3ixvsq89ZYW9QBpqodArWQ9uw9Zh/QpIcMpDbsY/25Y8ndmRr8VW803t2vSoTx0w
         uKcrxv14SSBF5FhIgdvDejvWrtBod57QV2bFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000824; x=1793605624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y/fMNupjmUFDA4Fs7jz5eM8c/pdIIe9SGMOk6RgTsFc=;
        b=dGcpJ9upCViVbPJl15ZeCpsFianXXFCfc0USm/7qtYz6UvaQ2TcXY43ypDeCptFeYG
         Gb/y6L2rRIurG8MuzRvsLA6/rg5EtYrPnQu+zLdLlQKSZO5OstKGrKJXq3XGHVrS9Dor
         TmxLWD/xa2kkVRosexqYwuTIxGYz7gq3yvNYYRur/ARo1X/0RjhpCnjOaT3GAtJiYzt3
         lLlV7izQJ7TH4roBlG32igRAq1ORTcRWXV+0bh1EmI04/wOCY7FgcY2nkGxkRdum+C9n
         Yysp/cTZYrmmErswi7bNRaKZfEVU524o15okA+Oe/wlYCflcH7DCRyz3hE72jwVxYTYe
         Ps7Q==
X-Forwarded-Encrypted: i=1; AKwUvByspx5456Bx0OxhdDie8jojEeKvrlMmGUatSwyBs/1kxP4er9Vf+98PlU8EiMmDuuW8QS+ZEIyyVmMR@vger.kernel.org
X-Gm-Message-State: AFq9FYJLqovQK8f0y4FGHJCXTXPsPcYPxqYKS3JsU6T3iL7ebNttN3Ku
	TAlFnfk61ctgGa/08eU9OIgPRk3Z/LwDTZH1TPRoqjHCKrSzkvuE03+DH81pCs99HQI=
X-Gm-Gg: AYBFou0KTdu0OwqQFN6OUXaiP1YhsiZBFvO/GNrQ/9geOIZ+BdWWSoURM/J+z0Jx9Zq
	4AFUSCsx0OwFF6xRnpUwUY32muE9LS6SHHpR7+Zh203D180fh4MTpdydQ4oDeDYUfXpNeLYQnuk
	qYAumGvTo8qXYCgh8tCqPgE1cmp2LLxXotXYS8S61OH0DoYzVZ0yPYBHKHuejgnh93ztxJKyEDj
	C/0311tIky2QddVVDRQyBPlf1aiDyUvPNY2nr9pxTw9N3G3CQnzeDzx7zUBHb1G0Ymo8+mdz3rT
	ZC22ReNBicxr8LLZbX2xX53pdcpeTbU63g2ydvB++P+g+uVRegwfcHokpx3EeXYIMeDpAlweIge
	6ka54xEXfj0EaceAc2s/gPV1THOfyUGbU4B/q1TmGfoKQvlkMk/RTcZg7QKFLXQ23eWHfa4P447
	5sieG2ukqhsMn+PcNhgPzX12MNCuY5i4KqJGAjTGeoglY1RNhoXIPGvvRfuwWvbLeZhrBmzWiXj
	4U+WG745LRB8LsJbQjg2yjeN33YZV0f0hbbEteJKMyZ7w3Mod5nbvpHI7efkawVj0N19aq8ZWwk
	e3cXELlSva/+HnlqAR2zydpo5+u3+eH316L15YOao9JAeoYm9OP6YNrP9TXvwvhxeKws62f9rtQ
	PwjJWVDO06SKj+C/ROFr2LNLxcZb2Vmsy2AwlB8T+wTIjEhAl4EDg7w==
X-Received: by 2002:a05:6000:1185:b0:487:106f:ee31 with SMTP id ffacd0b85a97d-48e3eb8bd5cmr7348794f8f.27.1793000823908;
        Mon, 26 Oct 2026 00:47:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm13731353f8f.7.2026.10.26.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:47:03 -0700 (PDT)
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
Subject: [PATCH v2 3/3] clk: ti: dpll: apply the spread spectrum configuration right away
Date: Mon, 26 Oct 2026 08:46:29 +0100
Message-ID: <20261026074654.3997494-4-dario.binacchi@amarulasolutions.com>
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

The spread spectrum clocking (SSC) registers are only programmed by
set_rate(), which the clock core skips when the requested rate is
already the current one, e.g. when the bootloader has set it up.
As a result, the SSC configuration is not applied, as it was with the
vendor specific properties.

Apply it from set_spread_spectrum() instead, reprogramming the DPLL
at its current rate.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

 drivers/clk/ti/dpll3xxx.c | 46 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 634fe0a1f9fd..16da86fbb25d 100644
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
+	int ret;
+	u32 ctrl;
 
 	if (!dd || !dd->ssc_enable_mask)
 		return -EOPNOTSUPP;
@@ -718,9 +723,38 @@ int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
 		return -EINVAL;
 	}
 
+	if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf)))
+		return 0;
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
+	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
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

