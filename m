Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505905;
	b=4l1FvhYon41r6sPc/RRgZ5+X8+bkIcy3957D3QHtk7Mz6e3iHbRLfJ6JNvNP/TErKpUk
	 Yr5aGef55pkxZKVWEyJIgCSTTVVTbkZdnbFLLFMwQQlx2vfchewXa6HRFCOcd+BQ5/dSb
	 sqGK6Jtn/akP3COpzknvVbJPLSBtNg2I5Vl1T+r05XvtEMiPjK/d9ld4PzhPm2KQl/Zde
	 7YrZzq/v0hG5VgVBBVKqS7RCN7feF+4eANO3Cm09+Ek9SBf4UZXIfyavF/h7lgyf8gna+
	 CNBTLo9763KIHPgA7UCBqs7jFPAvLP1pMyFe/EDWgp1V1c+D5ZP1hqXKowbEg3XSLwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
	b=R42ThYeW7zFne+P1ZWg2DCuOjD27yIXj536zWnhd3QOMdgCRA85U/OGLWc37FIMaxRfI
	 t1A8FY+C5wKzQ3OS8DVz0J9ULQ7JSsShUZT3UJ3qJFZGxZ+3adbxjxMjGbESc6GZ/Wydg
	 m4v45y9nwOHsX+8FjPeYsam5xYCK5eHss5UIgpES5AfFn1VrLiCEuKJR2uqGuDdUjAgMc
	 zsWwdmfasouhfkq9u9jqMltM6ufyD8gOp2S9TEQSIqVG03LuyAF9oMTK6C/YCInB8pTsY
	 nZ/gM2xoSkTc5Irqo5j4BQj/147KAMcPZM31zWcZdLpt1HcJy/dw4OfjOsX7jNt9QtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FuMkdfEd;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F17606A31C
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 17:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FuMkdfEd
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3719e3cb82bso16539eec.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505904; x=1795110704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=FuMkdfEdlT1P3ev4PXKojTkMlNnor+zR4f51g4QXzaiybAr3MJuD2VEwcHXwMRzkpB
         IpPNuAoLeKgkVngpP8BEayNI11G07++miWdVFE92eJONoz33xhxqDcUv3CLM6a4rumGU
         23Bwj13+8MvpX4SA4s/gw8Arg8rxYUQIOb2PcxkpVmzEEM/I16PEmkUiD7qKtbuFt1Gc
         TkDg6PwMExUNpMY84GPEXCTyT059IZL+OSHLHm33wKWRK368ltivq7eoqGhWYm07dMsd
         1xiR/FwcP8m9+c96Hc1IGnNpAg3ieVFKT7S2zUSccoYVmYWoYHh3eG4J3BcJ44lP7dZf
         1Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505904; x=1795110704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=03iXSMSLY7XDdCiyrFZrQChAFNI1f9zs2OFOGFj+zk4ADmxmfJhGET/PebgcHhpEKY
         gtXHT+VmGJnzjm6WXJvbXmadIP6KWHgMet+7+CWVrDtA8Mjk6oFLofi2+zvubcMO0DCd
         TrN+VP0nY1RMC1fWOJKthupd7IM/pozfNan2oV5T7evEnSwoIYTwineDM9nBgHx6mx2Q
         tAvOYk7aMInM/rsd95zOjI4PnXrLkskuIkko48SDOiM2A4uVYkde3xIR25YmqDaQJMtY
         QpRUDE/NabXT9QjgCLaDvR8jYUeZo+ALM/adQm/AG8OC0BcZmrc/C6QTCDr0mXXma6wV
         4s1Q==
X-Forwarded-Encrypted: i=1; AL+hErFpKELLT4gr1fxZvcWRxWte6oRwFceURDBPxlKNiJsewL4SKd9zVJhZwN5BouHTf30ogWA989M9QP0B@vger.kernel.org
X-Gm-Message-State: APuU4Z9jJsVgoJsbGimLfESeELZ0jD1RlzWwdKgHgV7u0HA42Nn8OnXO
	oKrrx80y2mCThBXFqgb1k8vWY8jJ3rfHuvsrvpdFGJhU0EUKVDKoOXNR
X-Gm-Gg: AYBFou2fPEIyx2YnwZKlmCg+3/RU+ph6GtxDJVUPldSOTEPgS0uVwDEMxo6HiF0jiH+
	Ek6uh49pSLzIHWLe4IfVvVkFu7GJtz1ghkHDl0enKqpAEZEpdaGxk/4lA+jgkCKbL5Z/ReNXbe2
	i6GTqu8OBnxl+YDyAV3vOTkDt2Xol6BxGAMJSO+4VlM61HsmTfyEzVCK3mMooG5Gg498or8COc4
	FgwCDV4T/xECfD9sSYLgGRDjXjnW5tDh4GcnjIhkdFcijAD+Tl3bTJ2CyaMG2ySjc02eRxNP3oQ
	CK+a/O98j+f5quGoSfP82EQI1JKzfXwxmsPmj3/7i/IiytXAM/nimC1z2Oryz6HjsjpNj63PGi9
	mGwAqIrokovxm/u0Z6IDxdx6VlM4hDt+D2a6nQ+ZZWxUnJ0VkQujxu/PzJGfCDyu8vMFnUe/NG6
	lIaTb/T+tyv0bRWt6a02VvncUnE9JMf0LwbCifyJqDTp/XlxDmK/MmzD8iMtJZqLoYzU55hwolm
	xwsif8HTL2IbVBVQqWLODzsbIXlKyQtscxHRXdVb2CpdXIvCw6+XhS5s/+ZjFwo5pOuU0hzXUDC
	iQNy1Gvdf5QKVsZz7BrET2wBr5tGYVRXRaTTRw==
X-Received: by 2002:a05:693c:26c5:b0:35e:d21c:f33e with SMTP id 5a478bee46e88-3768460b9dbmr8682787eec.1.1794505904425;
        Thu, 12 Nov 2026 09:51:44 -0800 (PST)
Received: from [192.168.1.4] ([2401:4900:881d:321d:eb39:71d3:15f6:5fe0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm237865eec.21.2026.11.12.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:51:43 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 12 Nov 2026 23:21:21 +0530
Subject: [PATCH v3 1/3] ARM: dts: omap36xx: Add unit address to ABB
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
Message-Id: <20261112-ti-l3-noc-v3-1-7281b1af8030@gmail.com>
References: <20261112-ti-l3-noc-v3-0-7281b1af8030@gmail.com>
In-Reply-To: <20261112-ti-l3-noc-v3-0-7281b1af8030@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794505884; l=884;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=mRJd2FscObSZq+5xKtM7LxfhPVQc620l8Gz6i2pWC0w=;
 b=73oBRMlA0aezchojrsi8CDd4YUWZTmGd3KfiThi3FVMNXut3eaeP4Vpx7Iiqnm8AEN+HkOgzQ
 z3fo53GUh2uA7OlcdF3z/Tp27siGOYFxTa3YVcqCwgICd1lne2/bdsO
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

