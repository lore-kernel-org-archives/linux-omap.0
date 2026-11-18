Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035182;
	b=HIBNi+CkT8VIYbYhJ/XOQL7c1ChReB+ZUFZ368C9hH2g5qkOpGSKkX5xArz3zbz3yP/8
	 kn69LTAw6lQutWbX217EwWkzCGmu/dQsh9ZKGMSRhKtLpqCCRvz88dBvxRPCd7J52cB1b
	 e7ZUFBGEEH3uu1c4Wyc6AIkMSN3AhaMFLSx9tR4tAmrX/13dPdLJR7gdEhTtiw0eMntCs
	 v9QfMfn/jieRV4ipUrkEuTWRTEZbKzqz/USZ8bOxjNaArWlsTYsfNzdw63b1ZTuRgGdcG
	 h+SbjjSXUhaCmQrnd+QosX/+pq5KfDVXmVTW1tsw8YJvLdvvfFx6Xtry2vJyw8UyrSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
	b=gVQO7UxVU/lz/Oipwpzzhw5+XCOoe694pPAZaKdxr/+dLPqubtBS0dE/3xf8C2I/0/C/
	 hkWLpf+46SKgIaK5hgFzfYfkiNDe9yDz1BitFV2AOhbrP6GkGIVTUPu5qvlE8sIgYzGAR
	 8ozxIO3uUbs4KSoWXDmaKhDGsNgmTamFrmM9C8SNQlKhrA+ZwK7UuUDEP6weUYnIcYo/c
	 RsSKx4NbXy7bHVZJCG9cjOmCUcZW12/lR9hh/TFWr9gLbvjtDRJ5A/cMaHF0QzH4pXErK
	 hAPswH4apaDOiZ4MH2tNT1Vi1UdH8XVbaR6DFojIbQWJrts9CG0uWnmiZtVPuSNquGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbO3L50W;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FC606A32F
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 20:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D01FC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbO3L50W
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so253708466b.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035180; x=1795639980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=GbO3L50W3zPBCKpX4nWT/H81Rr/VofVkYHAV/6mTN0RreJa/VLJiHzdAzzbm1YNJQu
         TUxDyX7UBLBNHjz4ODRXfQhQ+Y4AaBLmgj2SD0s84sMz5dCx+13G9Rv2kPKG6rg8MrBx
         xv/nBTKlaPQRWBTcov+z4vhnapuM/VkuMFHUb33WGBC2sMX4RNCwygHORTOnvuVmFOtH
         znrtOPCXOo59JqsgjVEX0uSt1XjDdI5KFuDauxeOGs+4EsHbplhM+k6+hFSilAR2Ms0l
         JHOX7VEhB8Uala5teN610QZfolr3YbrqrtpH5QZtSfi1G/zUVse3gawlNG+8H29SEeIM
         67gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035180; x=1795639980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=YxUrFk+ai4oWVDqMX5/DG0mU1kWOuYlJw+ZHZhjIvymVC6Inl3fBP6qjeOZasz1ht3
         YsiY58ueabP0HFAXfyzTmdTx+PW7kuZDh5QmS5Lfyatq3zDs2kqzoge/rAwceKzB+ogy
         i1OC0lck/q3cpulhtPugKi9hK6cD5BuN2CkZRZn+QgWZEOkH7uv9l4lbb9iRO+RuiaVf
         /ylngkeQD9NTfb10COgp0tJVOG/z1fv7+hTd5gO99V+QMEj3yE3bP7itST5SjEJ3MhqX
         zpd9sbtGjTK2KC6fJeH4hJi3f0HQVGm4Is9Rf7ati8KpwsarXPmFGD12A0kkiDRAtIqc
         YlSg==
X-Gm-Message-State: APuU4Z/mPf/4fakBlENV0FtfZvFyQwE4gIv8bK3TkpJk/ih9BWBGRI4U
	/ip1SjDU+9t2I/XDmgV2EbRYMgGp7A7b01TQGMxNDQXwcXPXyd8c2MqF
X-Gm-Gg: AYBFou1r+ErExEuVJweZs/uJu08zTwQNGHmc6yc1MRIizU+HYgzyoZ4ikOMCz9fbj1m
	IsfJ5BsApjdpNI3JeYxX8dC0srt7tXoXHNHlaSfZY9sfVMSd3SSwzShhG3BZFksYJq/clFzQMUW
	uIW0LarGdmHOoleTr9wqHV4LMgYgOgg93lr8uFzzq+Hs8dHnRfZEB+QL+DcvjGxxyT7WaS03aGq
	yK+TLStbbNZ8SbrRK/mX4/4lNVv0RLqdvQQprw7lv94msi9OpXURhNjLp2uUvH/cPpmuMUWF2lw
	HX06j/QzZkbtoUrq+BVUP+Y1cPNX74rzWrrxxMrylU6ssHuqA9oZMKIQ+9l1DuUBCplCTnijg2v
	df9OMNIuE9ZanlhDHsBXb9IdHRf9nfDvjZnYR+f6ThyJCij1uOYCm0PT53ST7/WMebFPEZZDSje
	RICXrj0xFmN2t5GsTbN5ht3Re3mOSijRH/HGbRUqg0+TiPscFdr29rj4fNRmxFIsn20NZkA3utn
	99fLDhwfWPmc/ppIuJoGX64B2Ze7QrX8DpUs+wSuKAvUn/LZH9LBI21lFrMB+RGqgajbFPtgcfx
	TjXuMVtuesdiTk5v8Oi/zVM+2HeXuYqy9PY72xSba3HnLB7eYS8bSpvX8md/qRdd478IQ4++3Yq
	U3NSlxrI=
X-Received: by 2002:a17:907:6d1f:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c510e2d4ee1mr357637066b.20.1795035180171;
        Wed, 18 Nov 2026 12:53:00 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:52:59 -0800 (PST)
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
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/4] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 18 Nov 2026 21:52:04 +0100
Message-ID: <20261118205213.88778-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
2.56.1

