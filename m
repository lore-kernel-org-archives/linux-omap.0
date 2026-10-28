Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203592;
	b=iYq+XwNPonhiYQMejzzF+88sNVEmVgh/ssjdVA9rCOjw87/EkliiEanVin0uhEg7EYit
	 xUajXfXzRzTL6JOsPkF2umUuTtpAU9X7b28/NxxfP1WCD3sKdbj9DQ5nGupEKnPpjuL/x
	 YCtL2fccptN1murJLX7jVBlo273WwCEfpeIHe98PuNsarsRJzuCBNv23Jnp5XU8TlvmSQ
	 FCWCn1wjZjpeyLal4GstgMP/oRBMCl8mGQ6Xib7SrRbVMVOvhBKDMZveD4azP6C0GcyXC
	 vp3cqi2CRldBc44N8Pigu9Kho47Vey4yurLM2MoiDommi3VCTfkLsAHdFnxgcwIEpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pA88NLv/TBiOG5702LaEvC3C13NKIBA4nDe3RPxHldU=;
	b=UrMDfPOIaWSI8FuYEYvnvgUI/+UVx9KcZPiDm4sk62S1Fw9FR20BmDmN4c1YMcIQXtTe
	 u3hXJv3x2PERBA/cQQXEIAqDmn82gTU3HkyPTwz1B47mEbrDyOozx6SdYuQaFZM0hPxs+
	 2YZWbZLB51zhKcJPBO80SJGd2whAvOblcqYIQQhSGHOa1opZlMrWzgKEokIFtY0SuAeQ7
	 pnruOG0YfZywsx7b4SWNmgE9vh/tYXUNKc1CTBoV3YQ7qX7A7gGnSBp7tFdBLOquRQyB5
	 IlqwvuyUgnBdsbQhaliC4MoHaU1yvKcvqZQ4QDyLmkRzn9OHi4poa5noXFSS/VfX22g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mX2vO3FY;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFED60A261E
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFED60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mX2vO3FY
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a210470b49so9271655e9.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203590; x=1793808390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA88NLv/TBiOG5702LaEvC3C13NKIBA4nDe3RPxHldU=;
        b=mX2vO3FYnHDZl/aSq8Rl1okNk3szjaAEGBAdFyXIfANi2eJ3tIOK0tRXggIUspgJmV
         DGF2iZxGghby2FdsmAp9SWkyCZgaWZmWtXdUzcimJBRO4UGioATMGetZwSFHZbQhWtuQ
         7XUrgcxi3JETJF4x64nCoR5+YQMJ2aN0FMTaAvYObBJJpLTadws9zGoihr7SODscq7b1
         LNXzxEh2RoYYwQNXNeZ9FSsursflhr8h1IKxZF1Cs7Re1P9KolYunddpyBkaPCRw9fvh
         TPkb0vPc0Z17qJdC7CiMntAUk0jinvtSb7LCDoIDqhokETAw6//mM2ESsqVXltNzCGq2
         uNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203590; x=1793808390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pA88NLv/TBiOG5702LaEvC3C13NKIBA4nDe3RPxHldU=;
        b=a5Lt60Z9Nv8dDiBPZp6MavHYDQozo1OuF9sc1Lxfkhsc7eJV2FJBSsnAfp7qS/9cpG
         fqiTS9/6fSmikZAsf7aT9ljmuhT+hv8p7XO8ZBj80pv0lswF1v0vEV+GGci+qWlez/DT
         kLo1ZSW/F/JW9Xm3yauahxTNdFRsb5OXnF8VzeJgQHxkt3AmT5Ju2Ykl8ehz8qoq+IuP
         3n5k1bpkXzEkGrgxjG8peCWBvfZRsI+Gak5ls7VxiNzfWfWDYPbEy+v7PKkW8DnO/mj/
         wfIaVyc4tBjFz1RCZbPDpAq7EUkE3b5uVvotyLfELKdsUNnXjK0JRgK6rnPH2kRS35sQ
         aIqg==
X-Gm-Message-State: AFq9FYIEEAt3wmOpaD354mb3Qc6agE3oeqQ2EKNHhbZDRogCRDnaHBuZ
	IzuTCE541Q/3vhUEI4FcF0zdFadYI1QRs57QHB0GHSK5uR1NAggO7lxk+U4OafaF/G8=
X-Gm-Gg: AYBFou18zhezDwxzhSdyhdEXXR4lwbDx5oalNjuR7qv9tRq0tb+86XeAXq0+VGH5Q2n
	j1nGDZaNffvQo0Cq7A1RqZQ5txyyuBBA9xRn3xWVBNwSoMRyHrhJnpdps5Mtwj2bAa6cWnal349
	NoPuq+wCJUvlS4l/vaIIhGE4L08latbu7ttw7eR2Rws56R2pS68YZ3KlI/sGtXi2SPY1Z0s142F
	VPkZ856AvJnFOn9ijs10xJ0k2gjd9dwLPhn5tfX5kS6MlzZ4GgPORKGx48S3AymOJeAm0CpHa7s
	m7Zi4i5DgFjxWDTV8JNLIWnukb/aEO/3m+9BdjHo6oLqLnv4B1j05M02y++z9tILCm+aviAmMvF
	/oiEr1qe6HXOrcuGT4Vc391Q2bv4/aiRJJkmCExebk0rCrW3bXv+5nzBV/qZqWrUPGlmUjtLNfP
	2fy7660piDCcc6S2d5CbxGwCc2ttHUNE2dkH6p6u/9LGIkN9Ywo9cMkQYa817KdqwsEAUuo1v49
	nAeOx4AYX4lAve2wGSoaNbt25MxLfSxTSb7MqaD4PfHJ9tYqB9B+50zY9O4yq9ZrMBNUF5IG5Lg
	5K9+0Ot/+OK0bDb+RYuJnYO/74dM/o4oRFWUlCIt+sgcfPM4FJ1ZXFqVpDArg9w7tMakw5nf2LX
	2tAdqqUWyQ9p+Y4p9Ebtxrf+R9w==
X-Received: by 2002:a05:600d:8496:20b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a96677324cmr41899385e9.16.1793203589613;
        Wed, 28 Oct 2026 09:06:29 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:29 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:06 +0100
Subject: [PATCH v2 5/9] ARM: dts: omap: dm816x: Correct speed for sysclk5
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-5-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=905;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=PhDr6kpoBVqdoNYvmZIO1sO7TmGrj5fxqBZLDfq+g74=;
 b=Ve5ogxnAtZbereXXv0mgHSa0OWS6nuHnMRIs7juPg0Xxqcdyy48+rKoPrzs7fTTee5kOME2TL
 uMCbLUMJEGsDSU0zMp4yL/ovJSLbJeyb30romwpOuisL69qnsLoYj5d
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The default code for setting up the clocks results in sysclk5 running at
1.6GHz whereas it is expected to run at half that ie 813MHz. Force the
divider to be /2 to achieve the 813MHz speed.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
index 76ebc6c3c3e5..cb990773b098 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
@@ -144,7 +144,7 @@ sysclk5_ck: sysclk5_ck@310 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&sysclk4_ck>;
-		ti,max-div = <1>;
+		ti,dividers = <2>;
 		reg = <0x0310>;
 	};
 

-- 
2.56.0

