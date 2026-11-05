Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909239;
	b=jAk3kR5ddtrzCdOmrNygH4w1KMFISvKHDTADAVQQFAFKIt3x7Y4j0uWFsvOLeTfRf2DL
	 Dm/jjTZloSAT4+YuO/7c9uGhFE85Q3ig//QDag2FLCpOUtMxDho7DQjlHC0Wt8C19N+9l
	 fs3/e+kiv8tqC2UToWR0ZLo7IA5NH7el5Vl7GuZp92/ELOpo5nmgiys4gP5pP5vjCJ3Wy
	 xOrzKDmqhsvkaezWsYzyVeiaFZeO5LuJ+NmrrOdsd2vi0FD9KDROSa4YPtXOWNAsGFKrm
	 //UVYE9XtuJsXnRrWmJUI9XUNPnuc+qhhB7uZ4zgOrzq4dHsvCM35eqG2oGBzukYwkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
	b=YmfSLur3jKqrrYXNiSajJr9o40jXjZiIcFgqgHDhJ62MS51dUeWCR8T0Fb+pikZoZUXe
	 vffvcUfawtayJJw3VZQ3E+vQ+f8Pcj1DvwJBnh2ROTSyTUeDk1G4AjcLk4E93npuoxE37
	 0PBv7Qi/PSgv+JAQAv2u16McVkxoPFNv0b6fw3Jy4nCseLxQZhgvU7ZqYAsluxx2SP+hM
	 ENN/JU7dgjL4Od1Bz70v6JR0PO8scWYKDqImwuJMBngtBgJA8mN8Cbg0EzfA5f3ro0UkX
	 IQX+jLwk3k3ENa6qzRwd1tdbWUV2agXX7/iZLqsTW7EHXlUi7eZJDNgbRbtM34bbL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ub1ox8GP;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE2606A33A
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 20:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77EE2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ub1ox8GP
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16925475e9.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2026 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909238; x=1794514038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
        b=ub1ox8GPhezjPHlk9Iw0X1EMDdUJXux+i9QRQ7wB/kyUmsRoRwEtaWe2krP5upbaz9
         Hbxlh9pZL+ZsPFL1WzxOGEXjUs7coUW8OlvXL/CyZ9P4jRSNwCsp8+ITtJchShWjobLS
         VS4jqDWatzVBi5x0J9R2aYUGhWARactIEuNQA5hGwCRJBxPeMt4cUf5AgcQmaiCJzbcE
         63VPl+CKEaQ+Y51TybM7udRIgteXEsgBMhrcdhsAeifodq8QUhC+P41aIfqQ03+J4xUm
         9UnEw483xSJmburH9EKf2VI2ZG7cPzJRZ3VYnFtGGDiHD71LbauDl98eFNnRHS/dEAv2
         rAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909238; x=1794514038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
        b=RrSKqkNlgM5jA3ZNnwFiSqNJgkNUPEpybcQxOP7S/dk/D8S76lb8OBwzx0jiPnSYru
         1tV2zerb+qE8HkOZ0yofXORk3vyOrTGA/UvRk8dIanrETuO1uePsxkOnHAP1XW5Y5Zr8
         7YkHbmSuRP+DHG+KVvp4Zy8yKR09yKjfxQRWuwy2w/wVN90ZeCVJK/K/8gMsLI6JD4rq
         jKcdkzEQAyrhOvxzmTE9rnCyOn6ORKSZWnRj+4s01RkPazWbmB4bQNhm/Qq6HSscBtrR
         tlVP8jbFuXR9luRI8RttX+LR5ZKj+4Eau9nlY2+RHJkWIGrpCf8VPnQJFgeFGoaTeSRu
         zY4w==
X-Gm-Message-State: APuU4Z9xGf4b4cGaygWN9lWz8K//sHddD4pzuMgPdga8xbsuuwAHQsRD
	EH51XSFnp/3YqNB7/9Fq/g7QgXmXHQziQFEdZSwL375DJXqG1QWUy76+
X-Gm-Gg: AYBFou0gwo2dy9YXAI4sMo1Vf8Dag+2e+7FPe2zVTPvt+55xIj4d6YoiGPydhF9JYwh
	KbmyHCGFTqQmQGJHucA9UCww2Zal+73Py9H6ijXIO/jUpWex6LgV7+nsCCol9ZER1AF6h5BlWCs
	E5h1OyZhPY4wRsG9MTAw7h4WVfzC3irxn77O2iHaWn9P2br850dflX44qqELuZJLbE62mYY5JR5
	ZF+MU+175uU75oScWHL8mD1W00dfMjx26p83nkuAhVQ001fCPIeWHyAnNlfFGSI9k8gTywRhrQn
	Rhy91bKeTxpT4zIgcrXyOPG5Qe/b2gj4M6z8/NqU3C8ga6IDHlfFZ6lE9GNM9mkWLJwNjabg0XI
	b6KvQ0Vhi4h+CPAFzwuI1qjhcdTKGa2N3d8DSHaa4bzhaGCY8dcCLQ1Oe5X6a7p/kuz83UAcXvP
	MKyiHR32n6Uiau0/c28wyQxj6H6hYND7yJGUwp+n1Iq881Aec+CMmBAvBKw/5dmCEmGw3RCXO9t
	7/73joqU4yS2j7hjifLWbxkL2+ddxogaJ3NF+sTmNz5JOtmRUaMaxde+7CaVVWHvvETfmU/FOZp
	mchjZkOluhi6/twaSTILd/obpUOUg/2pDrfKNFAVlSqm3q9xTzXmg4zFcRU=
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4b6df6df5d9mr3339265e9.32.1793909237922;
        Thu, 05 Nov 2026 12:07:17 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:17 -0800 (PST)
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
Subject: [PATCH 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Thu,  5 Nov 2026 21:05:53 +0100
Message-ID: <20261105200556.34240-4-apokusinski01@gmail.com>
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
2.56.0

