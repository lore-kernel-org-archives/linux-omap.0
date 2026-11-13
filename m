Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605480;
	b=SXsgex3iMZTsEKOCodmE2aRhFIe8ekSHAWfMFXoxS7hjhoHxADufCjpQ0Y+IlaOCiFJm
	 ayKwSirkTYbV4PIQneNBGyrXRjCgMpRVvWPy5QzClT3M7Qvd3T/c7Mk/C6dRGX1dF9hZc
	 AmueNsmlaP2dkJiMo69k573MW0U1MQXmZUu2q+xEm9zPFMTMK91XaoOD6VDHDQdNguC78
	 P6EWb1WNrSGiRzjS4ksxDl0KZJLc3t6Lc0su+EnCBli0CdRjrBRZ4Oi+pi3W7Uorxin6T
	 oiJ9ZOJByoOpOxKZKT+kng5QLyvHs2TBbl/ePptHQuBuZsypD6iS3UFhm4bJq7LqNjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=lUw0nvKlEMgxXW/vhONj7EZkx2F585mM1fi84MvMFks=;
	b=LFS/IdsxwmQv9El14SIgC5Bqs6W5a8I8vEuS6QtuFnGWn/2DJ+eyIG+M+cuMNGfLirxI
	 oxbAs6zZNP0XLdXOXmsxxSf0DNbeRONiTPeWAKwQpm3ZnPGVaEWSPwX+8FufPq67C3JQ/
	 7Pp8FoGrxk9WOle1Sv0ljE440X47x3GoHMx7IbNrFS3SskRtToBnvW4hNGKTApXoQ8dC0
	 GwUSHAievocTJCo9nvQEo8s+J6ul98C5mpuBENaAUPFfcZkFe+nrODt6QdWZO4OzQYA38
	 qmlrpuCJo+Meb3IqVsOOm1nY5djtiAA5GUDZkAuyXi/zMkgDQs9ythdkuUMlmrkRLYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y4TkbF94;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F523606A8AA
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 21:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F523606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y4TkbF94
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490585eddfcso1275239f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794605477; x=1795210277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUw0nvKlEMgxXW/vhONj7EZkx2F585mM1fi84MvMFks=;
        b=Y4TkbF94zey82nSeBb3iN2vJMq9WyyExLKzmunK3mXchFxyh5RriHVdVSamoqJlrrI
         UDV+FDsikj5NDmzScT86VduAplDOj+aXJkffRZ8YIIwDWsA87kCuLnLdMpGGE6LPcITL
         JBXgf89A/KSrKK3RjNnpUgBm8PvrZXaVvOLaI+EULN5a3dj4+kdDQ1jBT8Fw6v6NKdje
         PzqXkrDbNjMsbFTeK32YiN6NrQ4xa4yIurO648sAy/9C1Xll3V2FMFdlVTvh8WeompJ5
         OYmIUnMG4Vb7XG81qUGBwp/K4NExZaoDQK5BPOy/cJPvZtIdzufhqM6+nushwGRlsoXr
         qAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605477; x=1795210277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUw0nvKlEMgxXW/vhONj7EZkx2F585mM1fi84MvMFks=;
        b=r+KBWG16X3zBDTlWaUHPpnEdSHp40UPdS/znsQ0P2cUom8NFunDYvi/95KdYE6kQv1
         XjtQCKubiLTJI2bnPp06RPgZXlxQ7q8D3ylWT3a7SD0O/5NLDJGl3nj0NgXxybw9PC6a
         RE9ARf6/OkYZiBjTywlbmVAx0ETRPcwDy/Ldv0FPK9Qn4hJtpnnSvGiFiXoBFEQnn2rU
         +f8BfPBJuRX0zg0Lg0J71leBYFoLI1Y/mdHidsnT5iY5mf7YPoFZ20b2HR/UGNrhw+RP
         OAjktxUjbZxzpONzXVy7YB44GKbovok+FxEQEL2MDLScWewSSH4aTwDeKvI7O6jaQ1sS
         D4RQ==
X-Gm-Message-State: APuU4Z9P+X0iz0hC/+VZ8cNRvdZC51DLap7SMeY8LgkV1xGBsmtyjI9r
	Mx/vaNHqFqq1v3zWq4gLvK8rf4ZhJoAN7Jtf1Gcm6fjRKgHikEknKo0W2aFLY+9wpWU=
X-Gm-Gg: AYBFou22UrmuxMF+7l5k1sFfumduN3ZLNyWCtA/p4M6GU5IV90uiNn4jfr5bd2lkdF6
	+ocrbMksQovZj7DmbogNX8ZV22BskYRyC/lquYs17n1OM1IYsiXg+3DLW2U5J71xUuqFDyE1FjM
	XHryY/mAgmyVtw3VjsSQEFt2vN1mbwANb6+cX3LoKONS5YOCHsmOQwo/9Gp85CHhgjQ1w7/r1J6
	drmtHOyrDYu7pcAYZJuBr1XGKLIdzLlMotPAHjFm3YUtGLYpJIb+GfhjRywwmSQIXrBDCP8GR51
	7swh7+LjgGxMdo/GdTQK1TrIV9mecqGHapTmtScG5h9EHjUFd60MZUIcsvtK1Q86Q+/qagetSO4
	AaC9XYPRbpJtIvLBI+ZGsmdGhO3j82eGloIg5vAn4IYwMAaArjZL/44m3r/RaqokqytA/3Cw2qD
	wABCrmP0WcGtyDNkMSg/JluVxaSBag3xOzbAd0VPsBq1J/kx0oiuUfsgJ1TbpAP0hu+LBk4BYVh
	xabFeh+qDvK+5A71P3+bHAbMmAkIoX/34Kl7Hqw0FXtWVdfEdAXpH0b15qYdz2w8G0mfxqRdGxH
	Uk3nOqp/vSgT9q9psEDYgfqUDsVDj+e3RVXStvnE78lEz6fQB57mmDGTS4uPGiG1r/v8rsDdmDs
	XG/yhQLb1bNOltEGHAnW8Xjg6dg==
X-Received: by 2002:a05:6000:4808:b0:48c:4a62:9af7 with SMTP id ffacd0b85a97d-49c712ac577mr8479439f8f.28.1794605477439;
        Fri, 13 Nov 2026 13:31:17 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm7447727f8f.49.2026.11.13.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:31:17 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 13 Nov 2026 22:30:49 +0100
Subject: [PATCH v3 3/4] clk: ti: fapll: print clock name that fails to
 register
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
Message-Id: <20261113-patch-ektor5-dm8168-clk-v3-3-a42cd1edc5f3@linaro.org>
References: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
In-Reply-To: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605472; l=826;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=B0LneKztqvoYqUGoopWi+2un+koOSmHaVdRmdLk82Hw=;
 b=CtNUW1hP6KMI8YN0W1Cp0N+O81Trkq8lga9jGVtb6c+zVucXupTCQIA9gWYojp9PDIrrA93Ah
 wbwN7HKaXLWCGAh9JuY8MP3xsWIfx7VnD+NuvqFIhl3iD9AO4sqXcTz
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

Improve the error message when a clock fails to register by including
the clock's name and its parent's name for better debugging.

Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index bb9986508578..7d6a4dd4fc8c 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -524,7 +524,7 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 
 	clk = clk_register(NULL, &synth->hw);
 	if (IS_ERR(clk)) {
-		pr_err("failed to register clock\n");
+		pr_err("failed to register clock '%s' for parent '%s'\n", name, parent);
 		goto free;
 	}
 

-- 
2.56.1

