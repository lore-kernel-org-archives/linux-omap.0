Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203596;
	b=k0TClAc3j/nVUbSaWZmEAIK5FqgfvqA7WFLf94Gloyhvuj7Z3huXiIumy/QDfChoZljR
	 o2n8kQtJObwugnnCDmRcnSmplVFse2ks5KqfkbcuXsN146eZ+0iapfRB2nNBXWCONE4bX
	 6T3sHF6//mLmE3XfIdhbD4+6WsejI40pcDUIPmeB2nqtTpkzypPCQelqmx+sATTL5Emfa
	 OS84N6kXBIg7VkfoMdp4pnWNcWTF9Q545qf7FvKrgW9jO6FNSy00lvrRhmPnHzHRLB42O
	 NMjx4YJK4L/onzgdlNSkT5K2F/qsxzggAl6sbQ/QHV9DlNpzFrBG4CoJU2pzFmmjpyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z8/Xk2PZDV84vw6TpgqIZSg/Fqm5aTct485yHDlUUv0=;
	b=Xd3FGyEo2IG8s+B9702lP1nWETGR33ZaujGmHPDtjJRIiihjPwqDcPkQVodBgm4sv56f
	 0FWJDI+5sPnCftmsu8x3uDRQ19N9kZSyvatDnRLroQkkqHoSASFvbTuAudmxFxBl6qLgv
	 DqSC7TJZWZOBNmboTR7+XxoOW+/HXvchtPOrN6BxlkiVUdWV/tfrMZCLuyg1/b0kWdh7g
	 3BfF/TPgtkFbPoEwl015R/n5sfVBr7VMFw84xUS5FFLN06bgjdWHDdGAUZnSK5qv5x007
	 Zo8t5JcNoa3OCoO+3FwvrRVmasknHpjlCFcGtEFkHNW1tguTi3f/OSFYYI+rIpcbYUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hXdFDHGP;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDA606B270
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69CDA606B270
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hXdFDHGP
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so11218965e9.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203594; x=1793808394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8/Xk2PZDV84vw6TpgqIZSg/Fqm5aTct485yHDlUUv0=;
        b=hXdFDHGPmWU6mP6G5/xCluPbuMXxOiHWgSJSzoRor1apnhZ6GTaV0JsBTeQAFZjLWT
         hXcoaD6o+zXFzj60fF3YWL2Kol39gLchltQ0UMKtPhiHx8FMyVSx57FyzMPDeSp6sQWy
         AvncDceFrVgtuxOsJrJyauVhsBJFWKl9AMV2wfux+vaQgF5pVI9Jvsr2gcxCqK6WJ/6m
         JdE53dSwwfhbvdl7m+b0xsy2HHcOz8PaaKZKa/Q4X2f9jbCK+tMlk8KbxVMImq6QmZx7
         89F37MTUWm1MU5KU5fWm3Uty0yFUrx7dPNLw/DGbdPUgjzYpSQfV3i914kW+QqeyBauh
         oD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203594; x=1793808394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8/Xk2PZDV84vw6TpgqIZSg/Fqm5aTct485yHDlUUv0=;
        b=0jgEAR1k2UWN1N3Gy8fZPvlRov9eVn21P04pOPFKZiUgF3/E7kON30d6ZQrSVuvr6Y
         4zsG60WFkteCHCXhMzAmSrt1Zj55aRL/uik3p59/5vs0T5NOzOFZdTQSoSMskxX3l2jo
         2xztQy5SZu87DID7E+G4qF3OHVfDKwZRJcKxLIALPoeYQynUHfhaRzPNaBRiutqWK9xe
         dpCp8uF/1Oy+5velqYwIiIC0RN4QWUapYuj21Nf3yA0GGI7/8ElQg53H6ttNxHd40kq5
         SW6iFN3D7vMLuBXnhPCveUDqVYNaPVC+ZNJr+g63Z3n90+YNt3F9WOX2aSr3iwV6SvRz
         0vdA==
X-Gm-Message-State: AFq9FYIGcyijjAFON6Uvz65YFXjqF9DzDvivcL1wLxKpEK8y4wz/KrOA
	MT6F+oOHVSOOAzTWTU3KC5psUfFCMRtc6ZZRy8tg2oWhO2r3t3yRrloHPm5ypidmkgQ=
X-Gm-Gg: AYBFou1VhvaW9D7NOOgeMBnfWf8Iy6Wg1fVfMI08XISlrAbj629NBwP77M6gwh7tvj/
	nuJ4LPgEvDobwH9mNPVGfDl8hTVTzU4HSVyPsm4dkuonrcjJ4W0to1nQ6gfSeWA8rRwSYJnMyig
	a/RIRLi5/lXQt0WLaegZkbOc1gfEQtBmQxod2r5gKpViniJn7d+fVnUFQ78EBoUT8Cbed9B9sKs
	oMGCW1V7hrfpNSw6sWdfOGCPShMPq4DxF6sKvN6e1xu6Imf2LPfQwrPRLfvTUVlCLtX2lZa7XA8
	/9Qj7x3NhA9f/+AdhyxhvKQeqr1dSvzbCHelccOvJPCcl05dLbRD2npP5HPweihVbMW3MtYgFsq
	2xifehsiyr9HEHti8/lCo8WkLNQaJGk8/YFn8/JOgYFvbxQjN6UJGDglcf9QmgomyOwHGKM+MPz
	85WQaayQ5SfihMkGjqDU2XVmYzRv6RBjLIUWWyZOvPSURqYNg1wF+FxYdVyUqXcjmqvXwlVAN9V
	SAT7YR756ynBJXRxqLW26jvsPbNRxGlOFMctIlS8levyHh2aKS3wu8fHuyTqdgXomPl+uuhVErH
	kTnAWGKRnGKrxWfcfiHmoMTPq1BCErqqQxMNJRbsT82IZGGLS8x6oHAJeTkiRxGwY4cer7rkET3
	M7JUQL2WkgQCop0i9LP1yyDujJQx/q73KwPC+MR583q5G154=
X-Received: by 2002:a05:600c:348f:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4a9643d380dmr62293675e9.4.1793203593792;
        Wed, 28 Oct 2026 09:06:33 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:33 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:10 +0100
Subject: [PATCH v2 9/9] ARM: dts: omap: dm8168-evm: enable MUSB multipoint
 support
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-9-4544429251e2@linaro.org>
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
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=1428;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=T/OTFeU/v/eoDvotZ5j14Er/J0T6ty7EyR4RK8RPU/Y=;
 b=tNkgUp3nDaJHGL2hMsaJN+z8EhlSjiujuDHYAdAC3akJpa5TYYAUeQyN7Hs7ubj5f3GxEPgs1
 rlFx3lwxv9SDGeA63+/JqJUP3QwhstYNTZkSLFqa1KBjtDWJh1fPc6D
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Christopher Obbard <christopher.obbard@linaro.org>

The DM8168 USB controllers are used in host mode and must advertise
multipoint support to the MUSB core. Without this the kernel disables
external hub support and warns:

    musb-hdrc: kernel must disable external hubs, please fix the
	configuration

On the affected board this also prevents devices from enumerating
reliably, with descriptor reads failing with -EPROTO:

    usb 1-1: device descriptor read/all, error -71

Set mentor,multipoint to the default value of 1 for both MUSB instances.
With this enabled, USB devices enumerate successfully on the host ports.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
index a6d42766a496..4b4e4d850231 100644
--- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
@@ -198,17 +198,14 @@ &mmc1 {
 	wp-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 };
 
-/* At least dm8168-evm rev c won't support multipoint, later may */
 &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_pins>;
-	mentor,multipoint = <0>;
 };
 
 &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
-	mentor,multipoint = <0>;
 };
 
 &sata {

-- 
2.56.0

