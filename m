Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605481;
	b=vGBZlJJFFEA3ZCQPQt6SDy/RB8c6TI/1eVgd3p5PD4UC9KdWuypkdh6zgdescuNbwRqm
	 fxJ/ORxQunQMQkoqnWscY/CuauNsyNTl9XPUFG2W2hQRaoou4aAnyLGPrscxf56a02zHy
	 EJi1Y8JK6wOqKUGiNASlSDvVvnuP9bIHqueX6eOoIIRgK4VgsCd7kJW2NxYoY8br+opPg
	 8yioApElzoWxdB1BctH1vhszlXC/KzY/lWqQxqQArOh6+FB0QuTITC6pDPBePFBPwS+gn
	 Sml+B9bkLfo3Lx1cBZN62+4YSpVmBz6CElyk8kJyA482tObY7iZrLvvKgNGJ64QBYiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1Z97KMLhks2eUt1zVFkZTVVZd8kDUivIxgxGyFdw6i8=;
	b=MBJzae6Ujf3Tet2A/jKdVp5D8Enj6DgMCB5LCoUQdQEw42frGK4XgdvYtmMNUjLM1GgO
	 yyDP1AYutvX4sgrmM6676afDr02mrtFbA8VNjfU5iKDRPQmJbpsCap3M2AR4xBc0Bf5Uj
	 RQMUsny49RXhsD+BR5Nx/ns2rfxWcmarjhH5WEz9xTUBOlSrB7ulWZVb3xntBSl5hVRov
	 E4yHOQendauJvHqKid5qki0cXDkyfJpNxxwV+OcXQ2lLVa59lAL2RCFN/0xRLwPlVPh7h
	 Gif5ToTGrDyt2GQcSNm04oTFvf8wKtX3V4c4NwnXaZG8Biq/ApWTUiLK1Co7g96mIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iXISRmA+;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF12606A8A6
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 21:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF12606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iXISRmA+
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490f38e9688so1014437f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794605479; x=1795210279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z97KMLhks2eUt1zVFkZTVVZd8kDUivIxgxGyFdw6i8=;
        b=iXISRmA+oktDtrSv4kMbnArkrGEcskye3m/DKWMCHC3TWyVdckPnyUctcpisWOiEkB
         sMVbcaILkheEaGTGyIknfeMxWCMVG9EDCFoIxLwY8PZv/YW4/EybM5Z6VkGITfmSU0l/
         ymf5zvwoZur1gbqZef7QlNw+/jqJCae1/2e4E8jqEodtr9rrYIuh1WU4SVTTs9WV08R0
         VFiYpo8EX7uxwTjXipkDm94WVOLKYE4AWLtO3R1LZyr0QbXgpt9uHfy4nQlBnWSFUdBr
         hYLEUdFGx35sr04h5U5gbSECsGEKti1kElQ830u7UwVGVI2F1VZZjkS6TmWilQecauRs
         hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605479; x=1795210279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Z97KMLhks2eUt1zVFkZTVVZd8kDUivIxgxGyFdw6i8=;
        b=V1OR4biM96xuw5zTnliAZxy4k2lDb6iloADIrLnp0ziKXtinqU8kx8bxkeU7pdUGkP
         uWDQN2HymNV9iHSDaQ3R2N4U7Pvr1gTCsUSxiElEnc2dcTP4t4ulZoqr64/wWV7qrd/i
         LHi33viLjvaJeY5npeQuKfoOs8lHmDTZObGUU9Z8myWLbA/wPOpuiw67kaUtM80WjUn9
         3bGpNXBlwKh5noffBLS4/dN8dAjOAMmYt6NKZGSJhhVkfCsnq2qT9ixbrIP8rI4b0n7E
         +tAa90C54zgZo59f1s5RyR1fXEUTfh4TSEhd242W0s54Xn2ys0AVZMM4jyVvtJdz4rkL
         0DLg==
X-Gm-Message-State: APuU4Z+vR0UTrWllLfOxKHepV/tH7FOwZ5cUWtpWlVKg46zHB4YoCqke
	j5ZvKieYWhj0eHJda9klCBLdc/datBHb0TS4CCiy6Q3PxObZ/wVV0neOW8S2kTRmvkw=
X-Gm-Gg: AYBFou2wG+NgmJI2om9E1kDVr2XkEu2Gbc3IGe7p4Mn+CF/FITCVAtARp+AtmWyYWBS
	o+1OaSQxzKyn0+fseTeJhKf5bfykIXeWJnAZRNfmtLxlTGxSfsSkjvHxCuC6ePucMvnAI215jVQ
	bpTatWgoBnyl7CFHEnMEtK0SXqqpuePPUpmr/i5K9FgtSU3tq9pcY0cWsqha6HInN2cLr3VmYvg
	vp2Gw4QTzAozh0p/fc0A8Qffbp8zLgMs36bdUHBd3H51pcLQ1GVFKLyDZHXj/6fSMVrvhvXIBgi
	V6hYzZGibZ2ywMwx6gvdd11n+WeS84tvZ+34Yu2NH1gkwrORA4H1ezqnI6pGCzipRnDYx8rKyNI
	bwo94+hwvevPMDroR9F73ezygws8toTQThJEa1/xcHXZFIZXscWQp+gfMjH78/FKMBF6me3tJr/
	eZxQeaP0MjpALTluc6hg2edy9CuQlilvWaOB9Xx2RrGUOmqyjUojWHql7wSZ6G86s7t8z0v9jlq
	Ko2OEnCLONHB7fWymznLfJLdUESlEhkTkzH+dp1Vi/g1kggsFSQTIR9Rz7hFjzRbIeTs+2KcjK8
	+ndyMSvj/+rrXRO5MePEoUN2SyoWLmmqL44g6GCN1ZPoFylZpOto0Ecf+aSw/FPNRTEWnCQ8Vlz
	Qga+tb0EnIoRv5V6JUqnI+rwZBg==
X-Received: by 2002:a05:6000:4305:b0:49b:d8e6:1723 with SMTP id ffacd0b85a97d-49c6d452d42mr9891966f8f.2.1794605478667;
        Fri, 13 Nov 2026 13:31:18 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm7447727f8f.49.2026.11.13.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:31:18 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 13 Nov 2026 22:30:50 +0100
Subject: [PATCH v3 4/4] ARM: OMAP2+: ti81xx: use non-scalable voltage
 domains
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
Message-Id: <20261113-patch-ektor5-dm8168-clk-v3-4-a42cd1edc5f3@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605472; l=1792;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=IKFwMoPwqeJrJOd6paqyhsFrEgkIZs2drKUuLxdD8no=;
 b=AERHNgcVKZvhpwIQt1j4A6/AX353m/5rBEbtNJaMMfUtPJAmy0ZnFJTKThqFJVvq3htmRF3v/
 p2RyPKtI4iJBfzcDoXyR3witwvXGXrcp/sEgpjcxpBju2m8aSdYnfkN
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

TI81xx SoCs reuse omap3xxx_voltagedomains_init(), which registers the
OMAP34xx/36xx voltage domains for every SoC except AM35xx. Those
domains are marked scalable and reference OMAP3 Voltage Controller and
Voltage Processor instances, which do not exist on DM814x/DM816x, and
no PMIC data is registered for these SoCs either.

As a result, omap_voltage_late_init() tries to set them up on every
boot and bails out early with:

  omap_voltage_late_init: Could not get sys clk.

Adding a "sys_ck" clock alias would only push the failure further into
omap_vc_init_channel() and omap_vp_init(), which then complain about
missing PMIC data.

TI81xx has no voltage scaling support in mainline, so, as done for
AM35xx in commit ddf536d0d7e1 ("ARM: OMAP: AM3517/3505: fix crash on
boot due to incorrect voltagedomain data"), register the non-scalable
voltage domains instead. They still provide the "mpu_iva", "core" and
"wkup" domains needed by the powerdomain data, and
omap_voltage_late_init() now skips them.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/mach-omap2/voltagedomains3xxx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index e98a3f289c27..478f5eb2a17f 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -119,7 +119,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	omap3_voltdm_mpu.vc_param = &omap3_mpu_vc_data;
 	omap3_voltdm_core.vc_param = &omap3_core_vc_data;
 
-	if (soc_is_am35xx())
+	if (soc_is_am35xx() || soc_is_ti81xx())
 		voltdms = voltagedomains_am35xx;
 	else
 		voltdms = voltagedomains_omap3;

-- 
2.56.1

