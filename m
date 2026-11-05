Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909237;
	b=jpc27vSyB5QCI5V3Z9NaYaKPslY9lHmYUNJmXSR/nQVVpTfuKD06wDYnpPDtydr2IAz0
	 tQuajhrdHUoMGCgJYTo7ARhBW/TvYarhPQkxRpAdnytoVGBqZeENWuinc1t5Ri5qRzTqu
	 aBftFXLMEGzjvrniL/Q7nKk6jrjxEpDWRfvObECFhAvUP9b1dasvftfKnxvDvG6Yl8Ehg
	 4ShsT1g3OXRDcL1K3xvOGLz1nLZgcRpeh8g8KKxH52RkZwMQpdcwJo6ySs+4UgQsJLgw+
	 vCHvuIVVxrpJlLA7vpqd3YJ1nZ7Pf/sp8AetifvBbfN00olHchl/tnTOqfLyMshJwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
	b=c3QRS8+hAd5PVXU3d0OK6gXYcZd87spy9GJEu9/W5wv5s6zz4P9EqVqlzXIRwe7VUcZW
	 cnMMmlYdTqoVEgrAGeUXRRXru4b56kRzbxBPzkSwhJlvmFVxO/LyqDXG1a0OCNC0lHBrz
	 V6/13s083dwbKuXHFqn8jLbjVQdZBM00KSFMlG8i0n6fXwRf7p3/DUEVFRx3qlTBaRjJU
	 sGW9+k2PSLv2HmAiL2o2bKzSzzEOZgKyx6K2831N8DwoNf1fptKZwSFeL7nnY9sCAyR69
	 epKj5lbnAfbqAHa0AaM7K9bUTl3aRXPubo3DdJImfizYDs98sDmxAa2CiM8gfgcV+kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHgnd0Yw;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E7606EE9E
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 20:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5E7606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHgnd0Yw
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so21375365e9.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909235; x=1794514035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
        b=xHgnd0YwB3pVKxQKrb7e1Dxdlxiafgo9GQRfOsdPZr7HAuus+XL5JFG05Yxw/pNIWg
         kY/rIy1IlI40ze6PsdD0U92wi8F6AoC0m9dIAXPJWrkj+Ys0WZuXWhkA1Ept874kB29X
         j4HXwSVEKoiekoKMeShmaYyF+YE/odF5B0EICZM1GCeP/I9h/mBBKouctuzMZI/wuaLg
         HI56tMGrt3yDDoZsvSVOOOL80AzwogojKRkey3o3z/+WZo7A9Al9TZuAwTz9dr65H+T8
         izYXAm3RXgSm60s3sU4thmzgOWXZye3MjHa68XRvdut8E5UWKVJJwPISjCRPGoPH4LCb
         uloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909235; x=1794514035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
        b=rnuxB9lJE7e92c/gMm0U4v9E8fBsl5nTa0Ocxk8jHsfn+9ql1Xr/LKv2SsPF5d+qIS
         hbO2X3vVWgMFAjieoKrgeqGpBP+OddAumZmzkIYq6SWvs29QtJGRmjUCEglol0g4+p18
         NG+e+RRBL8i3h6fvuUSTviP4CoDCu3jdIm33ZvY/9E9GjHZfBo+dfb59rnM4AByFQ913
         aH+3+J2GQRwYyc/PdRgDfW5AQvQyD4TyHkGVjdamYI3o9TpWwoDtki/XqmF90KSw3LUM
         DwnBLaEr+7Do1UnjCXiAWAAR9WUPd4tf8haad/FieFM17tc4RAyG3+08Tb2Tcl9rsuNk
         6h+g==
X-Gm-Message-State: APuU4Z/oTiv33lBT+kg0U54/VXIf3YQcsyo3FC6bJbGV6QByDjyX/I2j
	+ZcLmMC9vFp9QOrWHhW569/CnD1zw2ObOwpaNmxZ+1wixV7IZTpTtJJ+
X-Gm-Gg: AYBFou1bfQRH+WqWM6BkQPlX0SpqIjtliIt2bPGkMVs+0D0msVtUKfVCQAkFwWA3EGa
	oemefTW3hYk6llnVxL6hfP+PgSNopPQh0tti7wydHcUbMfSIL4T8v7w8OEvgApMwAoPM3aCXpCc
	ZS/FpO0pq33WwaxhIhpnTyAfDSPCfRGXoKkH6lKYU7vid9B/CILBBni28XwwQh1GBjgUjclUEhd
	3ZJVUt+zyi/SfVIUCm6AC+xFkA8Llh2E6M7M33wqo1ZWxDATxfdQ2ib6vrDwf4zn10El7Ql5/Aj
	W8iuIIziOOTFtmK/H4LcqnKuJTjR2gNhoqmbjNsY2svuFPCoS+qbn1klFt+KgmSrWgtXD3mA6wP
	2A8UJ49Hjj3m7MxGjdJrnvI94aHwX0yOX8kH0+OHkcKqLs7Y4bHF/VenzQQO3dvGonO/yWcBdWo
	vSP4DJpzxqux2CA7DLOucMkHKATOhdhEo5P6VBla/43zG2jjFIlM2bz1TF1YrRo06qaQQw+fv7u
	VNYUGRJqVu7TK9SFsPMnJKJ67p+T/d86gVCgoCWJ7NdAU7MLQS+zcDG4lHigzLqYYSJ2pnPnEG1
	7xW3jmjPJGVSr7MUQfE9i55Izhw/PqoKVUw8xpiH79irGn1rBGjtUO9H+MA=
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4b6de1c6450mr3686705e9.19.1793909234959;
        Thu, 05 Nov 2026 12:07:14 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:14 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Thu,  5 Nov 2026 21:05:52 +0100
Message-ID: <20261105200556.34240-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105200556.34240-2-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
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

Document the TX and RX DMA request channels featured
by the OMAP I2C controller.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index 58d32ceeacfc..ff946fdfaad3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   clock-names:
     const: fck
 
+  dmas:
+    items:
+      - description: TX DMA channel phandle
+      - description: RX DMA channel phandle
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   power-domains: true
 
   ti,hwmods:
@@ -93,4 +103,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         mux-states = <&i2c_mux 1>;
+        dmas = <&edma 58 0>, <&edma 59 0>;
+        dma-names = "tx", "rx";
     };
-- 
2.56.0

