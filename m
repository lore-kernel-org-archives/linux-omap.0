Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462E3290C4
	for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478242; cv=none; b=krPirs4GC5dO1km+L8VbK8CVjmdTpBJrQqk37l0ddmVm3Hm9s9o2PIPiAthEX0nolPHl2hvDKCo7j/o41ZsjkA86DHoeA9Fq3q7iPSCcHLQwIe7Fpm4L+tXR0ODA8IWFD7H53ikN8C0E/h3It0MUvk/aseFuzI9pTmd2qDVMM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478242; c=relaxed/simple;
	bh=stnYPRRYW4ehUtGOCnoALxaJtnVyhk4yp0l6QT/e12Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzR9J8rVBUbxjujcTmjYBGPqnV3EProkt6d0ru/K+tC+JWHmdr74VkAqMWW6xxEJJCU76FAae8P/m7bsG2YAJnlgNy+slt7UxL6yTAcTLYReuJTwPzhj0unA7Ao9JQhRfXlP3d7Eo+a2HLHgyxsTpg2kyHV9OLZEcBTtt/uqOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyhU0ysa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyhU0ysa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb439299so3438215e9.0
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2026 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774478239; x=1775083039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hs3iD4jieahwE1HmMDLbVwvUq6t7AMyJcPwCLiDFPM=;
        b=HyhU0ysakwdnP/gmwEGaHbar0lFCs4MLiXwM2O42wAX8XOGIRWXNChxDaWY59CHHYV
         79XjC/KZByvh4/f/zNRcJOvit6UmaZyAm1lRb5ySqvwZouXRf2+flMl/fNoKrcDxMy3k
         KcvCZryhJlnLgeVZg9Epnl63ZZHlzyamAXN86hGryF3pLjdGtdzQ3hj3FkHNQ4KeGeB7
         6RdrQbpngWzNnXH/hokSaiVZwlDw8VmjdejdS/9U3zyURUR/5jn3tOjO8Zd6YepyFpVe
         ggFSg3i8eaom69se98EcZp3G+ssLbOzigHGo5Ns0iQiGABG9XZwtVRJ8H/SvntZbtzC6
         r6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774478239; x=1775083039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hs3iD4jieahwE1HmMDLbVwvUq6t7AMyJcPwCLiDFPM=;
        b=QhqWgKMPRuF0spXJFchjUXv+uDPTYP/IS0KirU9aBZFgi5ExgsnDg38SeQFW6TRKe0
         FjxSCC4UQJ0DkQKhy5WkyKTNIaL6gYoXwDKdF+BjbT4lPJWJDz4ltqx/XJnNnj2zdbmN
         yzNEdKVOQW4D0ckxd9TwkOraTEx6GDc4OIm6opeW820f9VOI3Z+63y/8lUWhluu7XxQX
         DASPYVKrMrFT3XxXlEgBWqK/XqmWWTzXNtjK8A77pjSjwoWuY4pQjTdc9vWTRs7kadJm
         u4fQzXN6pfr1XrgchIfbPicmF9Rx1gEgVdofPEiSqQXneS3koW8EUtcezxMyae3cFarT
         lYtw==
X-Forwarded-Encrypted: i=1; AJvYcCVYKKgttpM74Ke7DersZwyDiFU8IFvRxzR6ad67gqz9kT1T2LTLtsNgvXL7o4ArrC70aOsWltiz27h2@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5d6DE54xUf7qVmKo7iOt7kosThx0qVWEdj0CKaj7ukXBHY0L
	4pS7fWFd6ZJcF11lhR/f5TJnSzodbhfz2k9De1Uik84puhZcB38HtBE=
X-Gm-Gg: ATEYQzxbbpSeJJqf62wAwt2DqRKT2yc/Zgbvr41eLfb41tFT4i8CvFCDbzUzikil9cZ
	1lpLZdsk8i+OGGfChQEcepvAVUF+MVYY50sDKE8Carng/dxuDqO7GHJX69R6alO5bP7rolToMRL
	eRHrXWDQcZ6Xw/dY54gGPgVBdgj5UIlkPEzSV50LTyvtaLIcGRkg4OdEIc3g4EvuHse/2Awa1wS
	2eLOc5XuvtW8fVhu1e09j4PyDFB2yZXDEIybIxPn5G6wjPN2jYc24fSGhCG1sdHK7gOLkZ/5bDC
	eVh48lSPrHq6O9fGhg4NZbovaF0yT4U+wwz8eINrkSdyfdJymF4Zsf4jPVklio2di+SOBX3s6oY
	PU3VGYlQ6KBkJ7ASyOe37jYp46Y+LNr+2HAAsJx8pgXmzR0WgS108r1jBW9WlFGlqCug+yow7Jh
	K4hk7ysIUgr1g+beoJCOIB7JbeR4Dkbj9/MVnJa67ocQ==
X-Received: by 2002:a05:600c:33aa:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-4871607e25amr43115135e9.31.1774478238282;
        Wed, 25 Mar 2026 15:37:18 -0700 (PDT)
Received: from localhost.localdomain ([78.241.70.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901ac9sm1352285e9.14.2026.03.25.15.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:37:17 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eballetbo@kernel.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint
Date: Wed, 25 Mar 2026 23:34:11 +0100
Message-ID: <20260325223411.123666-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_endpoint in mcasp0 specifies the TLV320AIC3106 codec as the
bitclock and frame master, but the phandles point to the codec's port
node (codec_port) rather than its endpoint node (codec_endpoint).

audio-graph-card calls simple_util_parse_daifmt() with ep_codec set to
the endpoint node (codec_endpoint). The function resolves the
bitclock-master phandle and checks whether it equals ep_codec. Since
codec_port is the parent of codec_endpoint, not the endpoint itself, the
comparison always evaluates to false. This causes the mcasp0 CPU side to
be silently configured as bitclock and frame master instead of the codec,
which is the opposite of the intended configuration.

Fix by pointing bitclock-master and frame-master to codec_endpoint.

Fixes: e5f89dbdebc5 ("ARM: dts: am335x-sl50: use audio-graph-card for sound")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
index 1dc4e344efd6..b3a7f2c91d4e 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
@@ -558,8 +558,8 @@ cpu_endpoint: endpoint {
 			remote-endpoint = <&codec_endpoint>;

 			dai-format = "dsp_b";
-			bitclock-master = <&codec_port>;
-			frame-master = <&codec_port>;
+			bitclock-master = <&codec_endpoint>;
+			frame-master = <&codec_endpoint>;
 			bitclock-inversion;
 			clocks = <&audio_mclk>;
 		};
--
2.47.3
