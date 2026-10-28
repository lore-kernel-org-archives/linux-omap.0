Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173501;
	b=Xy85IG1f8Kj8bZi3LwGPLV0lBdaEimb4E6FOwPbaKmSa5Dll8PLrTqXMVKHIwP0dcsSL
	 60wUFis3iQBo8Gif+GLziaSfUUHnI8YbjHV0kuRrnG4wquIDtmXgT5NlLDiNFgvQMiZtM
	 EyKgF9m5SYE/mXhch+Qw8JzjbGhMwnUaZeGkBJm0Tv9q+5a3jxkUJPqfa7uT/EbXapp/o
	 tPJyXBXR6UIEG1LMp+7Y8k/RDzr2CuA0Et7KdL2GQtsxT6GxMQhJBFfG8oBMRBasULK4E
	 IrhuKK0kjiIFVtLWztA875U8Ksz+9s/quQdsshm1uDSzgvYIXrB1qaSt/r0MoYvS+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QgCBPMZCOQV3dhf3hMT8g1VGDheFKuoWsIpy3UHh9yk=;
	b=FZ2giVMrzt8U7xOCW4Va2ykhtcLNmlpV9HnTcfMKg0ukrAj71xitlxmipBOsUg/1kAlm
	 ayBeC8/7jRvi2Ck6cZUPKmGjdIEQopVJocVs41+wMu/pUbRXhmonGm0vzOSatmqnaamek
	 LhSQ/R/LU+Eut1K5NJbKC0CIl4aY9ssZd3ZaM6ePfQJucg2/1q1n18CVjNaK9UIdwKyMN
	 lwZ/1ARiUSwvPh6lLrz85MYBnPJy6eW+cHWLEByep4TQyaURYCIkP2AkaT2uldB4KXWYL
	 +c9D0MylBwpYqw2cGEcPSEnZsU990lFK56NwOqHMXtldwQz4cwfHxViDB4KBadExL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="eN1+/EYN";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC58606A330
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 07:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC58606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=eN1+/EYN
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so294786f8f.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793173485; x=1793778285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgCBPMZCOQV3dhf3hMT8g1VGDheFKuoWsIpy3UHh9yk=;
        b=eN1+/EYNYIDktRuxOw3uNO+DZhgK1GWfGibNOD5IQI0n647iKIz1uwnOAUiKB+IaUU
         RGmtoSAUHPd9KTANMfgITpg8Mc3y89eyII0bdCh6frOc6UEOPfv6mhFQ8haF5svShK9E
         9KZXLr3JaUq2J+MR8hBkWNAmj+iRGkD2iXYtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173485; x=1793778285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgCBPMZCOQV3dhf3hMT8g1VGDheFKuoWsIpy3UHh9yk=;
        b=Ikk11V5eMOVD5n+SiQY0r3t7c7S7gfPTkpYEiP7R71fCH/ODzAtSyzaZ+3rV4hYsb7
         EhiklWT0XP2cPFuf+iA2mNpDA/2mt88CkGjdUF9kzPOKEFyesoP8+p9ktN1TPhGLHNUf
         +SSzi4DuJlzh7+w3J/BdpqDHvcGtXlnYY+weerILRyrDiAoqjilH2IcpJnHMd0wXQNkh
         0VIYl1P8Z8ZYawJCWVf5ZBNBuDaXi6wTxyD9TEfkCBLhuwimQtluWYSKhxfQozP/NVUt
         FLGCs9bT1VJxK6E5ftqIguwOCimc+yZ6lnwVI9L9mJ0L6ggh8IqMp80W1scRIUHx2RP8
         wWOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmwfmofW7WvxF2b/YPLDBK2WiwcPJcBPEzZNkK9jgbrtAX/wgYrWt0aiU9N97gVXtF0MkJ6nNcfGaA@vger.kernel.org
X-Gm-Message-State: AFq9FYLADc6AoHOskbvYFDZw1W1kfyWG5fuPAwE/kE7EqFG0e9UNIrKB
	s/MDvIMNGt5/cCIctzX+L4iLkWJWP81mT5z9k0P29YTvmNpmh44VILfGBY+eZGiwJqU=
X-Gm-Gg: AYBFou1DdfHKOkeAK2SCYOKwarIF6lf3TWWudhkgJBRXpwE+tsBZxnGlHXvpXwpgnL0
	ZiFxdF3BuEzHn1C48GINZx7hS7mOg8zdA23ItqZZGUVuKXQ7om/SFtYwSyyUqR7U/AszjRW1Vrz
	RQxiGNx5TAXdsSIQ1KMerSXoJKGuFQv4OdR9q/wPRPEJnlsWTUBPRd8QBrJmkdKi1fwE2CiwTE7
	KKgApbLirXoMULEGPqcKy0KzGb/nr0Y4HM1Z6Jw/sUYEighvyZaNUZeJSOBLaYChd/3rXmG90TL
	HWCMidDG4L+w6MBjLlLcedBFBIA1OZrTH5PG064d6fZmQXrzPGroWvm6H/uG7uMDkHxf322HPWW
	TOeojjA/B/nwhid9yOfvFlV69EXycX73tDphqJOjEwwqvP/QuaWpWA+4NJ5Qcws6/MDKc4g6gG2
	RpJPiV3flXyyR15BgOdtEVrKrQZno6wvDThUFaZkMe0zjgScjnw9aUYV7dWCMT0UzfJXJhCjV5O
	YoL2gNU1h7bF0LMUBign68aKAYBnviBEhRZZN8TjOQaG9lQ0sxq3zYJodvZec8AWhfbk2BO/UYG
	keQAdEzrPnrA98setd18w6cYoyVTsZSFKv4CjcAPElGfEvFUwgewbjvuDNShgteSyB4pMjvR++H
	bBO2tJ3/+vQup4xztcMq+5R2W4Cd1kGHiQAbahtLGDcnUKZXGjPChcaPleYrXiodrsVXc1Hq4cO
	2h5rlwp14Gl67zC9g7cQIarF1P0Q==
X-Received: by 2002:a05:6000:29d7:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e5d5cb889mr2331992f8f.47.1793173484835;
        Wed, 28 Oct 2026 00:44:44 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm25324882f8f.7.2026.10.28.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:44:44 -0700 (PDT)
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
Subject: [PATCH v3 3/3] clk: ti: dpll: apply the spread spectrum configuration right away
Date: Wed, 28 Oct 2026 08:44:09 +0100
Message-ID: <20261028074436.1958132-4-dario.binacchi@amarulasolutions.com>
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

The spread spectrum clocking (SSC) registers are only programmed by
set_rate(), which the clock core skips when the requested rate is
already the current one, e.g. when the bootloader has set it up.
As a result, the SSC configuration is not applied, as it was with the
vendor specific properties.

Apply it from set_spread_spectrum() instead, reprogramming the DPLL
at its current rate.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Skip reprogramming only if the configuration is already applied
  to the hardware

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

 drivers/clk/ti/dpll3xxx.c | 49 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 634fe0a1f9fd..d32d81a27bfe 100644
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
@@ -718,9 +723,41 @@ int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
 		return -EINVAL;
 	}
 
+	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
+
+	/* Already applied */
+	if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf)) &&
+	    !!(ctrl & dd->ssc_enable_mask) == (ss_conf->method != CLK_SPREAD_NO))
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

