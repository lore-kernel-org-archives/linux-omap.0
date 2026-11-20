Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201196;
	b=I7p+gLz4L5xABYfEGPuNYgW8pMvstSwfKncxAHDt3PM9nzcs1oyYeNVsRjlhMQX2vh1E
	 w5rdzuasqMUc1pnHUZH3YFcOTXe7vU2CKbH9FG1B06ejfMZFnSCH28ejFj2+JzRNygskv
	 GyUigOMedhlr929b4j+4HA0mddYAoP8uBShVJ8x6r+6cAdlzNdYwFuSk0QqtlBsGNWXA0
	 tPK3obpEIVJxns3uFfRg0A+kBK6vmXQzfXunPP+uTYYVjnDjYF+LLPmen6NdaF0H3ts98
	 WSyOrjtyRHVFUhyLm685sY3eVUBQrbJkGoVFQCxF6wtw6qBA2dNF1HFTI5ga8XvMx+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=NoISCCzhxe7U+goaILnjP25nDlvPuHjVS1eKRPiiEUhVfHqTSUyNQcnS5wCanlDAwtGV
	 SBEOLttXAZMcFblD7ZDQumCNXCRx69+cA199JAx9krbpkYV+FSyIHtUfPuRmuaiUe4ceD
	 BlF0tdKP0U1s+kM5Sm8tCe0US2vlUkJq0ML2xSVmjhUC26yFQRWWgGmPK/+h9ASG598hL
	 REIS3BshfBdDtA7hPe236DY9+7e27s+Z4kJdr0Qx2nOPrgU5ZRLvovNIfLrHavXiJDUC7
	 6nvmo1/Gmp0cOnGwPSWDo4BCD1WYrF8szqHRPN+las7rDys+wxOWn+9beZBu75Ok+DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IzVVT4y/";
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFF60A380A
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 18:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCFF60A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IzVVT4y/
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso220892366b.2
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2026 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201189; x=1795805989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=IzVVT4y/3rbXHh6TAeSjFM3cC/AXHTbk+EhYy6zelufBVD4aPc/hWkjoxi1Rmb0jVk
         s8JQtdeHZNZNToyzuRKfrDqtxBtvkSgIcKgvDajPuk9h3TBzAJFbNAbDi2xvVdbfPNjt
         vlhP387H/b2+Jl7MMMbGvXvpSU6EK1dgwwo6qLb32LTYeFMGZkmpvM/PneQqIL8ZLlOu
         w38ix/s2fEZxKMfzh11UOfkdk2e63A3zZV5mnnWLwOmMLdh1YoetQvFl9H8lPkUpKtlq
         ZQUFx3enbC0FIlisEq+y4S8VXTVhJvqt1f86dPpdDm+/xHoNrFTkiN9cJgXlbapmrHdz
         xY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201189; x=1795805989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=tPl9EDhp5herIyPvFyNiIliI82SM5NHudrjvDGlCQGcCxFmTzmxhgJO/jM/TDzB9L0
         PEwIHF7qLXe6MpxoYeyvgKxnObe8EGnsTeUOGesNPn2byjB9aPibTOV5VtcqgRoDJp+O
         BcVhntJEziQlPhUn8gpOv7H7FsV4xv9ouUplQgDOa7hf9kkpLSRgZGQMzmkapb+dUJV1
         Pa2xlB05kd+uEqLIZ90eIJnsOzYWKs5ivxax8bkY4zKW7RT7gpJrropzhkxRSSexQB6z
         8T5Q5djhGGDgaoe5SYrf9ouCb9BxxMPtqGHKK1p/gILkJIxV5cB+0b6hqJxgaaenK9hI
         avlg==
X-Gm-Message-State: APuU4Z9pNoYF+E0IBzJp9SzC/mpS3o7Bb1jV66aIAoEdQTHcJO8atDsC
	U5+ZsR+EGlSKVMoMzH5EGpRnarV0s3xhmaI1v89NYw9KWkOBqXkmKaDv
X-Gm-Gg: AZFdTZcL7TM+AfTdNF4CDvdqraeOKx8BuoEzPkFV0fQQ7e9gUov3a2bNtbpVMTDLBYx
	+gFQ26BHck45ESCTIkguRmhJ9SQ9Xp/7mSIFEj98rjqXNNYm8HyYbU5eG3q2otEUDmbPdxC5jYr
	tKLnWCOa6xefuJDSJGc7nKkWOr8TILsuFBDLB0cqQv04fF2Ib6xisH884WilXqkrn1HpWFzQhwc
	jlLr+L9lZdHxva2m2s9PYFmcHmncQgEjx5eIVQr/xXnelDg0Fxe+ahR6JIUKVoPRhzyOUNAmenz
	SYZKnA2UOwlSWfOGgElqyJhXjfD6IzDpVKgh538vEcszh8+DXaKisr+SojAr+Gzqa6wVQRVysuv
	0Dn3thG0FV6RWgrXykrBoJcRVXeL0VIt1AKCBjsvqz8VomRQaslLYkJgyWsZVcx8VecQRwMRSa2
	ju7I8TE0OLZvYu0Nyz8K3dcuMJ2CWN01W06i+DrEDWkkqrbAmITZpkCGowXHx6TtfSha081D7OS
	i29Q/3M152WIkp/lLNtS4vYkofQjI+urxjhyPZpxKfy2X2Qox969AKB/V28AcGmRwxevM1MOkSy
	unNc8nfRe3QnutU2OX704b/2flquOUfZYwm3rU935MyQ1njQY71ma+jlTLsoF5pwyaFLjdAAq0p
	UksDcq1g=
X-Received: by 2002:a17:906:f583:b0:c51:3c8f:55e8 with SMTP id a640c23a62f3a-c513c8f658dmr365847966b.46.1795201189284;
        Fri, 20 Nov 2026 10:59:49 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:48 -0800 (PST)
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
Subject: [PATCH v3 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Fri, 20 Nov 2026 19:59:12 +0100
Message-ID: <20261120185915.150228-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120185915.150228-1-apokusinski01@gmail.com>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.1

