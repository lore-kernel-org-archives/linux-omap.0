Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202853;
	b=jzp/b8sgwCWS37ZutlehvBIv++Mq1+utgP1PgXBdMUVAUHJU7MCVAqA3xJCZQHUtORwR
	 Irm9wncYgFVoYCuF3GMf2gHgjciV76zMMifydmO2g22TmG2SBC4bhXXE/BZEm9gQEKXxz
	 ixhr6Mk8wQSZ8T1h9e9/gBWT3xUf5FKPGarL9Tzv/3FlGBAuG5fqsnW4+Ecj6LA60Fxht
	 C5yfrOsLKlTPXTKrn5dNwSVzLUFxaJCDhtJeTRzWLiMvu3Zf6wcT6oDrWKane4gd8gKdM
	 XpblwFTBhKxGWfGIAui/VQKf4ufU+L809qcAo4UpBDtOc2Oc/EVcPk1cFo40vz6lITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qlUAqcZHRmthPrXpDWxzYDUWpDG4f7VCO48jJ9/tTSM=;
	b=03ZAAcFkNtWlvkxevVe6Oz1ryiDojBORagsJyrg5EjxrvH3wbWZ2iEqpYzYq8KZAOiax
	 REBiPKgSAbN9SsGFRt4M3q8EHQVb9D/ywvrwFEvIl9o27dZ8iWSdKxobLeyLOYIxShMCW
	 QzXiZwHqA9cNcYcO6WD4SJQgS1OYSWLcGPhJhiLvkHvTgl0FRRRrvH0QZkGz4T23Wq5yd
	 x+flePp8bQwK8Jn+Tzxc9xSE1LuQqobYROu0/wmpA06DFee2ydCe0TFGrWpvPawI7dG2C
	 cbakY8leHMvkX/lWtTDwXoD9T3Nk97BH/9zkXkdtcZExN7pzY6Q2XaRdmQeVUIRIkNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A6MjP7n0;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31E606A323
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 15:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC31E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A6MjP7n0
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso11923635e9.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793202851; x=1793807651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlUAqcZHRmthPrXpDWxzYDUWpDG4f7VCO48jJ9/tTSM=;
        b=A6MjP7n0n8j8auUnILUjYtHRaznhskTP1CETZRjLb9bk+t32K09N3rjuj44Cel/RZ0
         D21SoR/yGZT7bVQRxn+qgfq/N2SvyMHNc60dNNq/NPP8fcLGbyjGP15l0CmfIvajcHUT
         aCQ5VIHHXwThZcwcRnBTAI33iqDLKb2GBDvu8Gv7U3OYV/OGhUQfTllpKDM7kJwoa7tG
         UYeCJDfs75pMnOMEJmf7l1gByWOALQZRR5a0FGE3Wghp3Z3CLqv0qgo362zY8Dps2urg
         4u/XHemPd5m7KyR6zaPYmwbAxYEOm2zJBwjT7h8DDbtTBd1c12uJlE3O7jtEkodErLof
         khFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202851; x=1793807651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlUAqcZHRmthPrXpDWxzYDUWpDG4f7VCO48jJ9/tTSM=;
        b=oIiYYC4EoEbEH6Y/uVUQ9BBJ3fuao/CXgVB48MTdkjOJHhZVuLaBViLOxU3DLNMLGN
         O0QH4Y6S+y69JCWT4g6q+nSp+ySbbswK3ue8wFK1gNSdAxlrglM7KUpiFYL1OSRzQg5m
         NFw17WvAaLuzLmkdQ9bTi3Yz2dG02H5wtJbHp9Zfdsi0krwc+OczdwHRaHklFdsLtUqE
         fvxtU+KVUbFlVGn7xLuB54nkIfS4b+Z4Dcp5R8fRReCJCK4KKQ5K7FMy7A2cet7Hcy2v
         CnxI36293F2sUJRYn+3WXK1i9Dx0OhAwbiMJo6XJE2ZhDEqnyuLt+uU+tkFXasLZjxF7
         flxw==
X-Gm-Message-State: AFq9FYIFfLHzR92/7sIDPdx0cZHEGKQ5Fo8WVlhOO6jV0yExHGkFG8Zr
	jgXWdylhq6kf36YA8IT8eVUPZGyRV0yeZsYNDP2iz8tx7ONjF2GM6yZGDiBg1kHy1g0=
X-Gm-Gg: AYBFou3udpKkVDVY71GWCmY+qwPJ+T8tq+KpuH6F4fzCWTXjrvuex57LYDm58pwFQvQ
	g0oQrg6QJRO7z4SMinlDPIrM5HZzwRBJarqtpZLzmte2kMgMRTy1P8G///G2t4ufSP/NUX1f9C1
	0xifUiA8WczHtn524Bl0mu9U4G+n+Rw3eNr5GmCg0UgGFMsN+ahH/1Gh6d6/mNoJI6L014MuKkW
	ZCzHlzz0TmEs6zmdzUl94xpZCHWglG18noCSX+frU41zj65Fz+3pRjpg89tHN1qGVi1KbkdWikr
	VQbRO1CKWXRQySrToyh6sacxKcpHjZWww8Y2SCs/u3eUdJDBCTQou1pI5ZHGJAns7yigcgzZijU
	5gIV01hQ6YnyDtkRxoyo4167MhqfFoO5hhbQUX24Q5/3Ovb+YBlGa7Ne7vqsqw0D2LSwUhMJBkt
	Cj4nuK7MkICu2VoamP3aTlk9KF6PJUSVyTjjE3ZkbRZzWxqI2E5E4XywC5vATSYJZ0Mz0Nk1n0b
	Q0g4BJV2MCtSBoakgo8yqHVeDgnnm6VLyCqFd1jy2RM0UiL0lAvrIb15i8+OaaJ2cGtujMJyg/F
	tDt8pCK0FKOkAmty2NBFV+MeHZAy/l1C+i8+Vu+ndHgQUAVtdCnMMuqt4E8FufxXGVWUxTKXTBf
	BjB5hWPA9Bg2bmfanuk1KYcWkqw==
X-Received: by 2002:a05:600c:e547:20b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4a96667c854mr38601675e9.7.1793202851019;
        Wed, 28 Oct 2026 08:54:11 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm1468515e9.1.2026.10.28.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:10 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 16:53:49 +0100
Subject: [PATCH v2 1/4] clk: ti: fapll: remove ti_dt_clk_name helper
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
Message-Id: <20261028-patch-ektor5-dm8168-clk-v2-1-dc6bf0fabae4@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202849; l=2114;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=ABvwyWZf34jMuxGuFGtYQbL5MA+37XtO7nEVwJg9AX8=;
 b=YsbRHc+3mjXFpWBUFToT1ViSmvk62je91w4y33JIgYo1glSMvV8Hyut13+0E3nQR0ot6/Vib8
 hHFXYIkubaHCA35/qWKSTze2o9bnX1QffpmMcOVQPy7jTUM02LM6v8U
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

The fapll driver uses multiple `clock-output-names`, so we cannot use the
DT helper in this driver because that would assign the first clock
output name as the parent name. This change do not affect other SoCs as
the only consumer is DM816x.

Fixes: 9e56a7d4263c ("clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()")
Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index e54b1df3436e..ae2f6fed10f6 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -10,8 +10,6 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
-#include "clock.h"
-
 /* FAPLL Control Register PLL_CTRL */
 #define FAPLL_MAIN_MULT_N_SHIFT	16
 #define FAPLL_MAIN_DIV_P_SHIFT	8
@@ -541,7 +539,6 @@ static void __init ti_fapll_setup(struct device_node *node)
 	struct clk_init_data *init = NULL;
 	const char *parent_name[2];
 	struct clk *pll_clk;
-	const char *name;
 	int i;
 
 	fd = kzalloc_obj(*fd);
@@ -559,8 +556,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 		goto free;
 
 	init->ops = &ti_fapll_ops;
-	name = ti_dt_clk_name(node);
-	init->name = name;
+	init->name = node->name;
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 2) {
@@ -592,7 +588,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	if (fapll_is_ddr_pll(fd->base))
 		fd->bypass_bit_inverted = true;
 
-	fd->name = name;
+	fd->name = node->name;
 	fd->hw.init = init;
 
 	/* Register the parent PLL */
@@ -639,7 +635,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 				freq = NULL;
 		}
 		synth_clk = ti_fapll_synth_setup(fd, freq, div, output_instance,
-						 output_name, name, pll_clk);
+						 output_name, node->name, pll_clk);
 		if (IS_ERR(synth_clk))
 			continue;
 

-- 
2.56.0

