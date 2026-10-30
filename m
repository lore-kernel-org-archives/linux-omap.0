Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356837;
	b=3UkH3QlgNtxbp2S7O3ZpFSixxS3R0ZlnMJJ+Yw5qRYayuswozMuKpvErnwOO+8l4rkWK
	 iM5MwzzuWvKDzNqs7h/BpG+OZ8W2MpZsLvKX2cYfHVB0gtMJKoBSk8a4sMf9duk1WVoZd
	 cRAjlfIo++la6KeLLUA6ry17Ljydv8sXu6qUsFkpe9rhZehxvnllF+LrVohAJAMHfwwwE
	 oNIQpSP7YRvZV4VNJlsYW6VDDxqFijfUiLPvqnlrxSRJB2jybbPP/1Dy88t+6p17fExAe
	 dzw+vYCqT/B52hXKuJz8fHrbtrQQexfrPzyINkUO0qzfAUIraf46E1xGvtLsUuxkRpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pvWiGhrTNAzK7aAEaulPXx3JNKfuDMHI4rCQcPEIeC0=;
	b=Sc5ZjMt3+0872R+9QrSoLSn+Y1rVNsx9T2XKDehP8yawYbTb8wjZKRy0gAiFWbHtAeWi
	 6d4zKjyPyCxvELAzigVAhvVbuq6FtpyUdIgUaM6V1RqVKJ77LT5w7aTzdOh2N8zwmY/GW
	 p1rfSs6221ZwEF6X0xaiIBYVr2aFuAaI9iutmlu1whMswNF8zutOSz+WD9mw+Ow1iVk4T
	 YTjBiW54mEDwg2OEZ8o8KX4SxBJ2ydPbDPwaH5+IF1Eo/GNxjUsT7fa4BXhSRZqu5ispl
	 G9cBJIQp/vZefcGc+/ZY3QaWK3Q5BfFWMimhKI6xYsFJ2OWNNXq8738SDMM3qjZXesg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fyeRihqv;
	arc=none smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29151606A31D
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 10:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29151606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fyeRihqv
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48b04af51faso34803f8f.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793356835; x=1793961635; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pvWiGhrTNAzK7aAEaulPXx3JNKfuDMHI4rCQcPEIeC0=;
        b=fyeRihqvtIyW3JW9mdFT1KgJ0Enpjqpzy59ZzvSWqO6bHvlbro6C5QJduVM370/jWv
         eyhzwbuq1jv8DQX4AuNtPJcbQ+lhvDt3F5QHOPsmtFCUSnm5QkKAab/P7r/u6rLGdTHX
         YFgVUhmGuxvaVsqvGmEkbbX/Sd7JzpgjeO+nCJb7pbTM0gmES29yV4uY2n4Z7Mcay5wu
         cBfEvmocAWGPnCoQPe1jjpZwxVEsC9UnYGILN2EfpcrMzLjtKtWGqOqdmxHcLkvnMszp
         b81AHgePItYfSEN7UtM8UD2Z/JVFdAhfNXZmXjyrXF6O6oM4/1w6Kc6V17rLCca3yeZO
         V8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356835; x=1793961635;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pvWiGhrTNAzK7aAEaulPXx3JNKfuDMHI4rCQcPEIeC0=;
        b=UETw+IxT4RYoNg4alWRmqVTRS5BSZvsFSVOxsLziX2nhrJQNtXdLl9EsRcDR+1llHn
         jkY1MhuX4FvRA+51ePo0GUZsSwxVFpjx2+bT00otqLvgASZ1x24zXf4Nu445LG5nUfei
         AKM7NVD+yrzl0s1FqlVn+cfeB4PVF6a+1/6FAWyDqzLRZ045DOwUa7LCPxL2ZwTtucBK
         Duu6Cn7mR08k0gybqLqDSi7Ji2m4bZ9YrTKEZ/CYGU8aj/SizAcrCYxBnuhyeay/MFhp
         A+ouVZ7Sr4JyzZH8P0Ke+5rdWVzOiu/8p7d1GyaZtdz2oEVLI66mu18E4dRtrb7qJBO0
         /U3A==
X-Gm-Message-State: AFq9FYIP6xOFOAIuhh2TzVEJGBaNsNdPpCIAGkxVoXxDReUrw+zHnvcN
	1s7dxI8+YhJzbWODuTPj920cGTJ1B2LWaMM3qCxxQo3AZaLt3XfQgKo2kvFWNk+Cq08=
X-Gm-Gg: AYBFou22t3lIlid2Fg5ZLz3vaHgfMr8a/K/D25GO8QQqaCdqqZsZkZgryNppLS3zIQl
	q27W0cskz6uvcySqGPkdzKYdu2tO95TU64bjuekYAY99iIm6RoqqRHknlk2mHh5LdKkE2pJpDoz
	fo+KerS8TksikHQb3svjDrpH9HNvk5FHBX1kfU0UZ+LzkDZBJWZnMx7gqTzJeNZLtTjGoDrQ/gD
	fCcbk5JsIAgw8FPzlLGYsvR3jaONPFKJMZvc7WiypMaaAEAzKwFsI+OAgyI7npC7dJFzwbs3sfa
	M8J9XKgktoGI+j4yVg8aWGmKZWJ0or51Wk5eVZjBaJw4Fg64JcbOj/JSou5IVQpmC/0nB9LwrsX
	ydvFkOPDAroY/OtXYL13YAvYaucOdVX9ST0WeIXpK2UqlqhiXudopQxiAFgGxgr1hop+wOe8aIN
	npxDvzHuuUd32IhwRU8C+L67FsNv2Ns233aW6dFlYBZuVI/121W9F/BEdOT6M0Ch6vdaMPII+ev
	9wbkUyHDH/GbTPFGM4FBdrm4Pew77T+CyrJS0wMuvwIGsvgDtTtkrPZT4V/ka83rzaHJUBbPWqZ
	AZJv4NlDU9C4Y7iv+kicpzIXysP4T6b3dpsSWKptT+/KuG2EyQmAXsxDVarE+EVF1kHDvfO+1sw
	UL+a2N+nn8lSPsEXBcdJ15pJfYsYn1aypbRqrNuOj0SynYBk=
X-Received: by 2002:a05:600c:4e08:b0:4a1:9c71:9f17 with SMTP id 5b1f17b1804b1-4ac17287d04mr43924345e9.9.1793356835493;
        Fri, 30 Oct 2026 03:40:35 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm128054145e9.1.2026.10.30.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:40:33 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 30 Oct 2026 11:40:30 +0100
Subject: [PATCH] ARM: OMAP2+: ti81xx: use non-scalable voltage domains
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
Message-Id: <20261030-patch-ektor5-dm81xx-vd-v1-1-8ba90608c25b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s3YSoKLoVYyLAoMdjS0B2pA0v
 buoy7f4f4NMiSnDtdsg0cqZ56lBHjpw4zA9CNk3gxLqJEUvMA7FjUivMieN/m1krbh6NEL7o7K
 Xsw0GWhwTBa6/8e3+d17sk1z53mDfP5nUuDB6AAAA
X-Change-ID: 20261030-patch-ektor5-dm81xx-vd-805d42b97bf8
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793356832; l=2174;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=fW7+0/WXEVB4unwZegY0rWJvXAG1+Sm+jd3ooJSV6oE=;
 b=oBDmhYYvqpRgRr++FtlQcR0z2LNcib+56DwS5KNiU4zDkyTp3TRXHEVXIBVFdwnKuwGqasWY8
 MfXTTatdE9LAITQKNQgQKdE0Sd1c2Jhbzs++0H3zLwYKN3G4EJQI+Yl
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

TI81xx SoCs reuse omap3xxx_voltagedomains_init(), which registers the
OMAP34xx/36xx voltage domains for every SoC except AM35xx. Those
domains are marked scalable and reference OMAP3 Voltage Controller and
Voltage Processor instances, which do not exist on DM814x/DM816x, and
no PMIC data is registered for these SoCs either.

As a result, omap_voltage_late_init() tries to set them up on every
boot and bails out early with:

  omap_voltage_late_init: Could not get sys clk.

Adding a "sys_ck" clock alias would only push the failure further into
omap_vc_init_channel() and omap_vp_init(), which then complain about
missing PMIC data.

TI81xx has no voltage scaling support in mainline, so, as done for
AM35xx in commit ddf536d0d7e1 ("ARM: OMAP: AM3517/3505: fix crash on
boot due to incorrect voltagedomain data"), register the non-scalable
voltage domains instead. They still provide the "mpu_iva", "core" and
"wkup" domains needed by the powerdomain data, and
omap_voltage_late_init() now skips them.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
This patch has been tested on DM8168-EVM only. It will affect also
DM814x boards, but seems that the problem probably affects every DM81xx
SoC.
---
 arch/arm/mach-omap2/voltagedomains3xxx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index e98a3f289c27..478f5eb2a17f 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -119,7 +119,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	omap3_voltdm_mpu.vc_param = &omap3_mpu_vc_data;
 	omap3_voltdm_core.vc_param = &omap3_core_vc_data;
 
-	if (soc_is_am35xx())
+	if (soc_is_am35xx() || soc_is_ti81xx())
 		voltdms = voltagedomains_am35xx;
 	else
 		voltdms = voltagedomains_omap3;

---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261030-patch-ektor5-dm81xx-vd-805d42b97bf8

Best regards,
--  
Ettore Chimenti <ettore.chimenti@linaro.org>

