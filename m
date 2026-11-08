Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166181;
	b=tfsGpdk5nhNBDwaUZev08umVamrZRqpZXXwX1Lv4t4aJtwUluwXVp1p2L6HfhpPEzUqZ
	 HC1wq4PvhLpWOqwxhcjU2d/iptjJ6HhAhDg2fo9mTwcHvthLm2XnaMvUYkdONWg/6rV5c
	 9NLGmQAxr+EI/apkpUbRzjfa6nbTaADBPxdlXI/5R5L0JBhpsGeW7DEf5L1q2Aa9iPhb+
	 Ek6WSDiddYuAGH7R+CrnM76fEJpGQlKyW0otZ2LyNnSsNaJT/g0XwbESVNLjowBqK7Rbb
	 31N66NWiqtvAapbQk3K9xFbEULTVHekmrj344n2e0pz+lusimUB7H8kDTF1xLFjT5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
	b=qyuiI7eCWnUKwDP1M5vdG/uaDmMxUuWqWOeP1/rsAiZws2/RkuDPOETL7cctxG8YHqP0
	 IsoShOAKoKlInheshrjq/UEnyuQi1KGt8LVOqjkKhks40efrnnPG+vUxEBAehKjD7VbR0
	 UN0wwMPwZWtCE4eFTeHEAUnhok24P8+UEgv8/YhGLKS4ZPiWOJXCQmzaorSaKxk8RZeWD
	 7r0V29a1adDJt0+Czc3aIRa7+SMfFIzdWFFI9lxZPNph0VXBj1ppRqjPPZJxRLtxQUiYZ
	 0chOugZMTInoBRFDumvQX9jURQnIUZ2Sqv4ZHQQ/LTrhs5Rz3h4e/j23Ut/8zVCX/Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=diMutTdP;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A5606A334
	for <linux-omap@vger.kernel.org>; Sun,  8 Nov 2026 19:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19A5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=diMutTdP
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372cba0ecf9so17635eec.2
        for <linux-omap@vger.kernel.org>; Sun, 08 Nov 2026 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794166180; x=1794770980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=diMutTdPzaIdRwJ1lWztRLVLO88l0kujylEJez32p0TfnqNlWN7/HJxPLwLGXHRYbT
         srqdJWx53HEudaAU7kQrTSzCfV/mHA7UeHoLuXaNSAtlsKC7sit3owrJxb77c4bJAXvA
         6dRwXOOWMkh0Z2h702h9labUVhgtf+b/gG1Tr7FSxJf81hFOSWRE7E4xTTYkgkFPpIOi
         48z0jVxL8KIw6ofH+s+l0FxocWKkczvwjpgPmI/IVj3M6zOkUmZXavmyADvkKyPBYH+p
         A7OtHCIhSaN+USc1Fp+mcACnw5SZ9azFn9z5JfYqv+J6yEUi6lngPJBuyYT3z79xIRzA
         Tfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794166180; x=1794770980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=cJMGpcpHiPmSyEnSxIEvZyKmgKkwmXd93xkPp1MyQGtkr3DfyCIwWfqOUkeIKoul3W
         /yZh+A4vOaSWre4qxIpb5nTeFA3nM8G6pXVcsk9PFKFT/GHPuLtZbWRqiyVqELFQMBf5
         WvyDomk+8ekA4VAGUweUzED3J0lmzYlWyq3BHRRJPI4QAbOXicbnv8/Hy8JV0naYpl3v
         u48ekmXnuUSoKE+X/oPUnRtYrK7O8ZnhQ8oNxrohpjLuEd2pIjdWRm0W/+puv4fnt344
         m/K8wh7oWFBlBhFs55b8Gw978IJEEg1s1l6B3UPBvULNHHeHfnYR+EZaXnTfUCq6iX0H
         9/Nw==
X-Forwarded-Encrypted: i=1; AL+hErFlg4iT+m5osCUeZZuAeTb7a/4IKClaReYGK5pEFc6wIKlSYJo5s9QqfBqykiUqkgkl1Vf4AzVw8feE@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bk3zjwd86qJWpqWlLYtjFw+gUTfcqvMOkn6dp3+LK8McyN3Dy
	mzR0ZeHWDa5Y1EeNnSjs8/ADnVbuufQwBvMY+HD4wR2zttk6VZ7nx4JC
X-Gm-Gg: AYBFou2ZAg+ye5bugL9zlyc4ng6EyiNfEU6t5dAWa6i+XvOmLPxy9vYH3ICTY09UeRn
	iWOdxxgiJOy5/nqfUdIxnVroKblK7A8BnWN0629PHKKjjZR9pdsMSGxYZMBarf/F+Uue06LbSEH
	TDMbUDgzwQA92//tXVg7L160oiEonmVEa4bhpuDm7u5pjY91YQy6IY+3MSNuxSq2Vh09T/aGvMg
	lKpfwXV/eBdZxW9SrmD4/EASDghn2Lzh+sRPOgSjj/I0w9aAbo3lmfth2Enk9PWKM6V3YSd/A1H
	JeC2PDxyl5IaZLnPiTPJWxz+ff69alqsSmW/Iaf/dudPyB1RcRq7949OumQbACLRs40ZhsTcRHa
	1h5iJvENwrttkQ9v3JG0FaxrTqtoWdSoRYFBAV2WvCptl3garSzb6OntpUOSSaK1AWnl+YXl+xD
	FyTK9AN4EQB4SsqeETngVfqwVV3l/8KUx81nW5XwsJuWObvVdag14FPoYbnuOgmioplwuIfXVnu
	Mg5CO1bZZxKpESExTMvldhut+HqsUOTVLSteRP63+a0SUq7bxEPN4PwekbADe/NkRKf7NU3L2n/
	m2e2zoKMh9NgvKEGY/Wx683TKZjHL3Ex2LJXOnrEQSu983H4zeMyijfVvBrf
X-Received: by 2002:a05:7022:7f0b:b0:147:d430:7322 with SMTP id a92af1059eb24-1b39fe73395mr4649246c88.1.1794166179643;
        Sun, 08 Nov 2026 11:29:39 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881e:93af:b6d8:a723:b13b:3c1b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm8800387c88.4.2026.11.08.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:29:38 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Mon, 09 Nov 2026 00:59:17 +0530
Subject: [PATCH v2 1/2] ARM: dts: omap36xx: Add unit address to ABB
 regulator node
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
Message-Id: <20261109-ti-l3-noc-v2-1-509e8485a1f3@gmail.com>
References: <20261109-ti-l3-noc-v2-0-509e8485a1f3@gmail.com>
In-Reply-To: <20261109-ti-l3-noc-v2-0-509e8485a1f3@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794166167; l=884;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=mRJd2FscObSZq+5xKtM7LxfhPVQc620l8Gz6i2pWC0w=;
 b=TFOH4hkxM3D01wuR6L6Kuij4EhR1doZYnCWknkMwEvOXQXqR2Xw4A/iEi0VoxsMIDTuZfEQK0
 B89GT6/5jwlA6EA6BspnldEkt9laFNj8tzSyfMhmgkj5HCm6tLrKqeG
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The ti,abb-v1 node abb_mpu_iva has a reg property but no unit address,
which violates the devicetree rule that the unit address must match
the first reg entry.

Add unit address to the ABB node in omap3.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index c217094b50abc..6df66eb7e7eeb 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -92,7 +92,7 @@ uart4: serial@49042000 {
 			clock-frequency = <48000000>;
 		};
 
-		abb_mpu_iva: regulator-abb-mpu {
+		abb_mpu_iva: regulator-abb-mpu@483072f0 {
 			compatible = "ti,abb-v1";
 			regulator-name = "abb_mpu_iva";
 			#address-cells = <0>;

-- 
2.56.0

