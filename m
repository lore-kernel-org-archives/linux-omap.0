Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767365;
	b=PA9EDakKbXbp39xsdlaTOR0uWwta0pV7DCwOJZ8vZV/5AjIZMHkahrZtW8kt8cViGVNF
	 fWIkIY+OsvLR74KHTbkVDTmtHNBP/aqY14bWdUb+4hziE9SdqpqfqPX5pobJojrlgS98S
	 MJt3C2WBlIa2hAxmT79i7jdFZN/GPC0IEcE1G0v35eUVNkf4LgGMUlYdd3VtEzml/mgBn
	 WR5a06FD9ORXOrXVlHU6QGYyiIey67RYAuEZE9m46CRyqmiWiOPZ+ruwaHEaMQzStt9O0
	 RbAuVCToByzt2FLSaNjAAvjYaKy2FNdXUfPeYE1rzh2n1tZAvC/Fcr38a/Tl5FJVanA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VHijqk7R7nkxNtNy7fBcVFoPcvT4XkjuXZl2ndqUfI4=;
	b=BT7tJa6LTHy5df47BxjXblIdHMDX44reef6R7xnnxKK8prHzKu4/pHEq9o0IIg2nnY07
	 q9LYDDnhqMCjZF0Ri64N13/CtRWwc4RjLwktNjM44qqXg8CnloQm1L21qegdxVmXqL2oQ
	 jHvFvkiprVk52+72FQE1QP81g9qWzzSCLzSxZ7xZVJt9zMhQA7jQp2UbTcUd3ZYwea3tN
	 FaRiM4+GQqtIkKKRc8kho3QIrvHuJeNe6Ih8hO7fyJwDW2D76iUOQ22k1yGiZfavl1JZy
	 OcVnCO/UPQdoM0Clb9NowdKsqZsmwZbpRfncuTvkwGIABN8i7wQEwi5SBCmz1Jr+WlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=n3OYrdy9;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B460A2617
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2026 14:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006B460A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=n3OYrdy9
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20edd106so830802f8f.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2026 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1792767363; x=1793372163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHijqk7R7nkxNtNy7fBcVFoPcvT4XkjuXZl2ndqUfI4=;
        b=n3OYrdy9FM9nwj1ieI5oDX86AMR8SCt9xiUwa9f3q+/Oc03cZR3gfFU7OovUXsceRX
         WO/SuzO8VAEo65jxC2XS4kZaIbpZgw2HvNSwty/6lRf7iD0X5b5PmmmxzEeUYX91OxUH
         okzpOJ81Xk7LIzokWNF/elUjFI1/WnPnkY3iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767363; x=1793372163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHijqk7R7nkxNtNy7fBcVFoPcvT4XkjuXZl2ndqUfI4=;
        b=Wk4vl4AtppQGfPSwPLaB6jERYfvG8X8/rsxnwVzIzuypZHNoSZtx9JMMiWoapOfS4w
         ANCwXt3GeN4PqyCXug2Ln+dB2nbdcRQcoXuSRaxOzVGRf6OU9utGWxU+0HgvuItZySFn
         EmtRy/z4sO/caMZ6HHqAMfjajFd2HqlRlL+1aeQLQ3q8Yv4hsHWkE0dp+k3O2kEZ+e6I
         CmvlEVqVy8/J0eoDmQxi3RIdMfUugyrteAdPhIGIzYmS/Oe+sdIweAjaEFWjkB/VCKxx
         LTfzmS7iy20PhjTRTUCrPGtiXt2vt53m1o3dlPqWaoF5M3O7OGaaBnmrisMSayqJYMbK
         jHow==
X-Forwarded-Encrypted: i=1; AKwUvBwrcuHyPTwbZa3abhb0dTvwp0woPLndvLOlW5lJ3ndQODl9a1QxHr3mTdskHolz8OFTSwtkXXA4D9P/@vger.kernel.org
X-Gm-Message-State: AFq9FYLLu/qxAb3aYRg2oy4L2Vu2rq9PIuuIU8rinJQr408g1/S+vmug
	rNiyGdzENuMz4u5kNODcispwSlJLaO1VSG7h9TkuDbT7fzmz6FRTlxYjOqPYc/DiCMA=
X-Gm-Gg: AYBFou3ZBz1WNnhRoX23MH7sibBrQn20hKhKGehiJpEiyi4N0kNWYxRawKRqy8uOWe2
	DgjIgI0VD+bfEdEZDYtlkNNOX+UmFJT4QI76T9/zBlv5B5IPWHkt+XMROnqpuPMaciYtSPRfPxS
	ka2dYRGiEhnRp+f2ZfVUWpDfC+tz/c0Pf4finU3Xm8EH+rSCI6GbBfitbePmZgT3qYJBvUsgaBC
	9OiujlWbEfaHYXZuRopY5QnlCRne5VO+ZRuXNwMTxC60z2UxFB1PmP8LZVwfs8PJi4UnsmobE0S
	+cXn7A9SGG4oMBILCB4JwY0APSIJopQl3ajhp/XSQmXBK5xeFhLfDLAJWC2I6/q/jn2c1RMP/ME
	LFvLmA7yamfhFce3tNQ6MOoD1ZCI0uPThmigQc9Qy0/Jy1PwLBsBfNVfVuSc5i6ek1zdmirQ53X
	6K+M2d0NHhh74SJm+FtzxPHOnF0wj1ZtKYYIM90g7xPtpWYsoQFzTZmDMH2syIQDcJWR89+1i97
	5+CMqQVbdMvb6L5EHhkE5mRYIiUsxZ3LXfGhvWQdYQhRAApDAj2xNiF414YhdMWC0hEmviNQtbu
	eYhF3kgte890T16P5qc/tH/J9MtVHO+GLut/N4bSld1XOKnOWcphqj2U7xMipL2F31UE0qU9bRN
	VMivhTywuSwSnGus/BAsyK3icpv2MrNZtwG4+x4F1BYqukdWQxWrj
X-Received: by 2002:a05:6000:29d5:b0:48d:f025:110d with SMTP id ffacd0b85a97d-48e385a0752mr3000782f8f.43.1792767363456;
        Fri, 23 Oct 2026 07:56:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d42f884sm226760f8f.57.2026.10.23.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:56:02 -0700 (PDT)
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
Subject: [PATCH 3/3] clk: ti: dpll: apply the spread spectrum configuration right away
Date: Fri, 23 Oct 2026 16:55:32 +0200
Message-ID: <20261023145555.3578469-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145555.3578469-1-dario.binacchi@amarulasolutions.com>
References: <20261023145555.3578469-1-dario.binacchi@amarulasolutions.com>
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

 drivers/clk/ti/dpll3xxx.c | 49 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 634fe0a1f9fd..c181bba2792d 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -690,17 +690,26 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
  * @hw: pointer to the clock to set the spread spectrum configuration for
  * @ss_conf: spread spectrum configuration
  *
- * Stores the spread spectrum clocking (SSC) configuration of the DPLL. The
- * configuration is programmed along with the DPLL multiplier and divider
- * at the next rate change. The hardware supports center-spread and
- * down-spread only. Returns 0 on success, or a negative error value on
- * failure.
+ * Stores the spread spectrum clocking (SSC) configuration of the DPLL and
+ * applies it right away. The clock framework does not call set_rate()
+ * when the rate is unchanged, so the current rate is rounded again and
+ * the DPLL is reprogrammed. If the DPLL is in bypass the configuration is
+ * applied at the next rate change. Setting again the current
+ * configuration is a no-op, so that the DPLL is not relocked for nothing
+ * (e.g. of_clk_set_defaults() runs twice for CLK_OF_DECLARE providers
+ * that register themselves with of_clk_add_provider()). The hardware
+ * supports center-spread and down-spread only. Returns 0 on success, or a
+ * negative error value on failure.
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
 
 	if (!dd || !dd->ssc_enable_mask)
 		return -EOPNOTSUPP;
@@ -718,9 +727,37 @@ int omap3_noncore_dpll_set_spread_spectrum(struct clk_hw *hw,
 		return -EINVAL;
 	}
 
+	if (!memcmp(ss_conf, &dd->ssc_conf, sizeof(*ss_conf)))
+		return 0;
+
+	old_conf = dd->ssc_conf;
 	dd->ssc_conf = *ss_conf;
 
-	return 0;
+	/* In bypass: SSC is programmed along with the next rate change */
+	if (clk_hw_get_parent(hw) != dd->clk_ref)
+		return 0;
+
+	/* Disabling SSC does not need to reprogram the DPLL */
+	if (ss_conf->method == CLK_SPREAD_NO) {
+		omap3_noncore_dpll_ssc_program(clk);
+		return 0;
+	}
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

