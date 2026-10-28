Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203590;
	b=A0MEvVmUHKauS6BFXM9sEjaRvLzdzv6siomFZGQOGQ6TNMs3lIssyyUv81t9u4dgxdwj
	 AvvlMnHwtdg8eb2w1btWV7lvM6eloxMUlPOEmMIWa/kXw7RQgE1itFf3sIcsPCfwCpfua
	 umZ0zkY/q8QIyr/3+xY1+UR5+HLJ+uaJ4+mMMLDU+nC5biPcf7CEPJ42Guf6IECiNWyCe
	 LWHbDXopKhVCDP+7uYeKazbxrBMnNrwMR+feao+TpwlKyN0+sjvHmIPhQAhcKFBZsn61C
	 tdGKD0xSQwt6otKw/nhcQKQm07Kxsr73Q0vxkI8PRktelKo0rH2Q5E1I324fJgdYSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=bmYk/QrXu3XKmbnsirtQOZn7qp9VLhyQk3cehRblGvc=;
	b=TL+azHm/zOYlJswG8CicKEk2IRSoaus46jsZHddb9fX39vWu0X7ZU0AzWqqfpbGggq35
	 jWk2RyBi0PCLzEC3P7B8ZYLKC2CLKqZ22Bzr0CFqV56OynSsV2uALIhY4H8N2ZhLxl9vL
	 5V5EIq1shOkz+DdzNvBlHKspT49fp/LZJMnH4JGLdPmnnw942qxB49OLdVcJzLBxwaADp
	 M6lXH2IVi6JD0N2ASjvaqE4ZyK6GVF5oE9RtfiI/rIHpoWkdBOQN9g3txOroOFKa3wb1D
	 lumTYdKHetc7TU8uknHkPS2qDIx+v/TWV+gxXP2j3N5F7WPcnfuNC8inPy3Lzn0KW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="kJZHcB/5";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161860A2611
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3161860A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kJZHcB/5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so11096925e9.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203589; x=1793808389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmYk/QrXu3XKmbnsirtQOZn7qp9VLhyQk3cehRblGvc=;
        b=kJZHcB/5WTqXVb1DvnmzR+CCnNkmEnR16lX9PHOvHguc8qaZsc/8rxdpfiB0j3/U9p
         kSJs2nBhLQnX4YbxVSdBgiv/vvZFj59os9lw+pm03L7/s2IV+ZqLG8AHx01OQjHjnSFh
         AiNYNqYp8I29RCDYTC9YOpPdZYORwfWRzNfH84uaT8yjcNPVIJwVAXMcBKP+lF6E/ONT
         X5fNtFcavNsgFa+0nkjZibrXfl6E7DmNvX4rbLTQJWuVFRZdGDvmzbfVzQtbMUevPJFA
         VYAZ6utGhLxvNvVlSxVLgOC2brMCiCAeDcoX9rd94x1XnlnS0rq/mlylrhUJL2uvuVm5
         OGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203589; x=1793808389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmYk/QrXu3XKmbnsirtQOZn7qp9VLhyQk3cehRblGvc=;
        b=arwsg9CeOPzzy5TDvWImSuv1vV+qPO/HJ8M5eV3tJCmE5c1STyE7sGEpXw2Hw5O3PT
         kij4u+SFUlFNOgbiauCRD7UOWjEFeeg5ncGt15UaUkK/Yq5NkDWB5DL62J0sdSaJadtE
         GRwpTv9Lr4s2mPvSZSbVerL1AiMZlQjCDFDJusUQHFgdsou+uaMsk8bSUTp4dhJCvHJb
         CYzyXhw7BMMAG7+m49ntjlPpthrzCp6Cu1bTv1l+lbRTBgkGmCdhyaoXk4Raw+IsGF4o
         x5d8Wv/qJxT+igzfr5S1ZQIsxWI33VI031oXBBoedQzBq7i/IAwrbAiaHu5ZkSMRVi3g
         aCrQ==
X-Gm-Message-State: AFq9FYIHbzOFtu4HwsQ74YH+m+sD2Uqz9jnOkdZUekqZOh5MbKHBXIYV
	I/JMzfyHldDQ/Q4Et9sihEMigM58uQxhyvbT7nyfOCzW9GzJ1v+77v1N/i3IOAMDObI=
X-Gm-Gg: AYBFou16MHX7UZvfbrvBNaOXWXeJMY3O/49iNCzDjENOGCZQrwB0DqBQZZ/rokWmZM9
	FGnLlgw9jJzn0dU1g1ja1BDMDnBaK/npo5LTFT1OXPM6IPP5ypBPMNOgNXm8H7CCJsyjQFpe8EQ
	ElwjyLSCAD0w5vmDg9kECeTD3GhAcMzgNDBKlJ5KbAtOArHFP9TdRJgJTo4VNoZGnnx3Sxv77wR
	kfJmlW0AylRrxjDo5O5nk611F3GOv0rRXHiE2C0IRS6EVuFwJ4SsOFbpJtq19XeJ1X2nYlwLOwd
	B4qR3k3Vwins2X7l8iXhYzcTo9V5a1rlGrpI4quosvaq2dxeMEpwbs+ZZta1zDEXjWiLxb9sYiW
	jzr3T1KbY3ViglbOVTWSig9vFzAW6dUzZJvHNbws4FneW99BPOyX/ern8toARE9RkEUYTgHCcVx
	t1Eg+8ImyXFsPNf5wFk+fx6Vl6QgR/LYWBMlu2glUQHlkXXBRzXdYkAgOMISA2Hv7+6llIi6HVN
	V6x4qcCJH+Oups1g98F1vIAaT55qsdmJSkdfQRlUQPqpV3iLIze/bX/tiXd/zccT/pqzlyDzpKa
	AAXSPstVlypXRDoNli4BOPUjYeE/EQYgIMDheNnc4fDQ+Ea8axaf2cILWHrFboCa0wU/6m/oq0o
	lrCw8+NJnuX7sg3M6sTW44iFmGw==
X-Received: by 2002:a05:600c:1546:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4aa86a42518mr551525e9.2.1793203588489;
        Wed, 28 Oct 2026 09:06:28 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:28 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:05 +0100
Subject: [PATCH v2 4/9] ARM: dts: omap: dm816x: refactor and align MMC node
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
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-4-4544429251e2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=1896;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=IkyleFnGyybE4VzcWEWPfLI1Efue7Bk+OPR7RvuZIO0=;
 b=lIHp8XwSVWwwtqhg9KXgnsjTTPwk8NehLG81Fs5GcnUmU5x9Wem4sQ65vOXY3nTuDNjdInMfh
 QOUq/2ATOCpCsaCVOLmbWdkcluBE4eJ9hNEUFz9+CeuBmsqCH/yq6iJ
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Update the MMC node in the TI Sitara DM816x device tree to align with
the structure used in other similar SoCs. The changes include
refactoring the node to better describe the target module and its
sub-nodes.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index fc124f9ecfa1..e3d49651b44e 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -423,13 +423,34 @@ &edma 20 0 &edma 21 0
 				    "tx2", "rx2", "tx3", "rx3";
 		};
 
-		mmc1: mmc@48060000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x48060000 0x11000>;
+		mmc1_target: target-module@48060000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "mmc1";
-			interrupts = <64>;
-			dmas = <&edma 24 0 &edma 25 0>;
-			dma-names = "tx", "rx";
+			reg = <0x48060000 0x4>,
+			      <0x48060110 0x4>,
+			      <0x48060114 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&alwon_clkctrl DM816_MMC1_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x48060000 0x11000>;
+
+			mmc1: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				reg = <0x0 0x11000>;
+				interrupts = <64>;
+				dmas = <&edma 24 0 &edma 25 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		timer1_target: target-module@4802e000 {

-- 
2.56.0

