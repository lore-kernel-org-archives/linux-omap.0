Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF53D522C
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039528; cv=none; b=sCThav+73KzbCbVwFHcEGM1TspEyb1SLD+XzIhn46IwfoNXBZzDV+5eWPd6VTMbZMaQy/OjkgcpTYmDC3VeWebicJOGa7F5Shz+K4HB7W4mwEQExFc6vCXRycfhtiyT0d5oUeX1Z0UG4icEoLgKWJtsTZXSCiMpU49NTw+Z9C2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039528; c=relaxed/simple;
	bh=lUtIgAbMh/vNpRAdiwHHkrbPL+Vk6Sh4GYYNaqza5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVVT7w3GRDT9HQdIIXUqZBu8f4Arc7+g2LxHb4BYbbAxDf/DYYhEf7Mcw5OQ/IvAlM5sm0Jd1W0t0AVBf43N3LogR1U6Fil67D7uHx0Ml9rNcsBq2WQT/ftBO+7A3LEJJKXs725AGENjqLX3IkxSR3XJcSVpyANxv6H6RLHVYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0KSE6v2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZNemjc3L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0KSE6v2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNemjc3L"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SK8N1025009
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 17:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uAXRlKsSKgVHXRo/hlqcCpXBiAKwXP05ii0
	Mt1jrQg8=; b=B0KSE6v2BR2faMgYkKqV5TeNf1Gqsf5Bdwcu5HGNAhTwbpqLuh4
	53VT2GyzzV5skXuIbp+HAb8yViDEVPuKdNamsy94Ew9JGcHdV3I6CTZfZrwMGj9s
	FxBSQDlLw8+PF5lQYyhgU2Dec/6XAKcD48nxbyFmC6kAGWA/MfwXPImWI0NhS8Ln
	erbvfrP1scZuEfbdAhxEHFRcZoSTtBvNMlM42oT82ndi1cUSw5RWHXOjKCFlGQqT
	OhVFAB+zsfcDBEQzbeNBFIyC9ByxGbv99Ru8dj2PdvDay7SzVpT6M8qSnnVAiWuC
	fmLdnFweiXgdQrevL/Zqp1EYFd7jEAE+7xw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chq57tp7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 17:12:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899b98ebf47so122489256d6.2
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2026 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772039525; x=1772644325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAXRlKsSKgVHXRo/hlqcCpXBiAKwXP05ii0Mt1jrQg8=;
        b=ZNemjc3LCK0fcZM4IMwsoMSylyJoVsqcsiedY03eXMV/2ekUoyjbxdwvdmrS8wNzGv
         bWqkNFsWeAvkpYzGoCAzmqXwmRaJGhbQLhTWpecK6D5M9H4xzKHPdWkQMrwV8BHnP8YW
         v7eDYg2UmNkI++T23pTeoFmY3vDC/6ZqGxo9RVxN2uUGLZFXF1Gh/PaULIq+XweAwY8k
         U2Y44osN4PHfiekSt9eZSiGbDHey7m3fXtxtOeMSFAr+awCTqoxAPrLVSWMB1GviLr/I
         XqGBPiOoC8dc7irgkPbrnDRqiQ0mra2g+dvNg1AZ7jeBO3sLqSLfLKvcmoieJiW5Xtrr
         GUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039525; x=1772644325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAXRlKsSKgVHXRo/hlqcCpXBiAKwXP05ii0Mt1jrQg8=;
        b=SN38xOZlsDXKAjcYtFbtz7vNkdEY2yxeEW0yf1FnbAISeIXOJyB+PNHErb/NPDKT2m
         /VRlvNV0XKPE49oC1lCYcxgd/GuiT391dV1Cfb3Rc26KyKvdQ+YIobF5CH1pvJJivfMx
         1AbbObUEuYAr6Ldoa0v48T4s4SmYkyHSJDEBs7frsWMMbkm5VCXu/OTKtmkNaohX9sdh
         l4v7XsJ2cqcxGA8d9YhGZfPFrhgBeAB+I9wWiarpofG7lN1ZaAR5j5ZkH4Pda2micqcb
         yDvG/LWW8+6ud63cHOlRYjELhOvl9dl3nW4+nZQ0fbaolytecMkS24uXKagy73kPC2jL
         9uug==
X-Forwarded-Encrypted: i=1; AJvYcCVJVaM0RfpI0CGHNTdQvA4fVPOaxgAUokAm2o0I5MsOCQJjyBuFxVh17AZGdkYP/Za+1qLy05RnuTkx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjRxl4g2s5KiNI1FgA5f8GZ5efpdd6bwmbyLogU/wCTKj4eMb
	V7SASANrT76wzfMg0gb587oyv6aELhg3yBNgTHIURsBhwLWXkEL4IA3N+JWLn3r7/v5eugzdliW
	AzX9JIMQFN9GPE/MRLdfYwUTpThQc1BjxNcRcTr93ExRK42XXbMXUrdItbH9C0XZN
X-Gm-Gg: ATEYQzx+isi5VyyJLehkHn8lfLtNe9uNr3UYAd7Xsn4sNHd/WRe1orxtVGbYhVoX6UG
	X07ok/2rE1Z+IY8h4/QoX4XuHHN0A6XqlB2C4qIw4CFGuv0/W1iNWVH2s7DZfJeL8MhlbxRUEcW
	apvX9acdZjFOJb2p6KANFAm67bkVHc7IbjyoSti/O3pFM7oeVaWm14DnsDhg/o4W2T8hsRRr9Ey
	HWBAT7IY9kHsxxENosWz8BWIczh8or/5cZMKlkjHQHNB0OOybUPq7rtVUtFRg4BQDtH1znoepl7
	m2RzaEsjpaVAdaGHq8Nein8IqZbVSmo+1Kw6FjcDViwKjZvoyCFXrIM+uhAiRFQzJy0hMxKA43z
	MGb+wgc6Oy0V3KwxrFWKxwlOnhwaB52RrmZCDsw==
X-Received: by 2002:a05:620a:454d:b0:8c7:806:386 with SMTP id af79cd13be357-8cbbcf97f2dmr180913585a.34.1772039524720;
        Wed, 25 Feb 2026 09:12:04 -0800 (PST)
X-Received: by 2002:a05:620a:454d:b0:8c7:806:386 with SMTP id af79cd13be357-8cbbcf97f2dmr180885485a.34.1772039521931;
        Wed, 25 Feb 2026 09:12:01 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6854c7sm186988115e9.0.2026.02.25.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:12:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux@ew.tq-group.com,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        markus.niebel@tq-group.com, matthias.schiffer@tq-group.com,
        alexander.stein@ew.tq-group.com
Subject: [PATCH] ARM: MAINTAINERS: TQ: Orphan TQ Systems boards
Date: Wed, 25 Feb 2026 18:11:36 +0100
Message-ID: <20260225171135.122955-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=lUtIgAbMh/vNpRAdiwHHkrbPL+Vk6Sh4GYYNaqza5DU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpny1H1OE3Y0Zw2+jF8iqQR9ncHs2XAfCuD6jNY
 yg1lhx0aeyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZ8tRwAKCRDBN2bmhouD
 1z2cEACPrAM7M39NN5/GiyNmPWC51/WqMFstXNtfr92G2BKdF13xgZYoo/jFhKt4ed2CA4JRW/S
 d4SpDiefTVbEl2q7SizU7thmiKY80CUNa/5MzJ4D9aa04P0UjcT9sln8cX9sAxYS3WLa4en+jVr
 giCnZQaHaccNekgM0jyGyR0OgQUkp4Hnnae+fZHx3VsZ6HOY366llKj50QUST4B6v9zTEgxGjRX
 xlnXqhkyjaYcaTe6t6xxPwlSBCi2EvGALNN05Ab+e2Q/5Gmh4D6faGd/Z63wWPQEaLE5QH8jfqr
 voliSKNnogG/BAh2+AcK36XVZ66HkWosvbKH9Jw2zbeIyAoMHh7e8wAcTNT1R3NjMdhjHz0nIC4
 t6jnH7o1uChADZ4ZZGRZPMG0tyzdfSFl+osFpPFQeC8v/g09qGaVfmj1w8hcfUf/mgN+15d8h7Y
 A7ylhEHWQke3gGNo5iyd8CI24PZXmbeIFzKDUlD7PpCWzPI+aMTN34+dZFVjMaBRuztJTzV1xuU
 Gppujo2WK5PXzlpojUXx6diJWSPCKQohIEl3V7rMQpbnc6hRftU+lpfe4qJeRL5Rhds7EOcLx6j
 qR1IOGKSN9GZ1VxaVPsQxMhuh7zJhhd2qEWHQnlwg4QyINmC3mrWEOhSWWRyHwPhOZouDEZ75nS FLN8nE9LEL98+7A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=faOgCkQF c=1 sm=1 tr=0 ts=699f2d66 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=8f9FM25-AAAA:8
 a=VwQbUJbxAAAA:8 a=1TEZt6uuAAAA:8 a=EUspDBNiAAAA:8 a=MG-3fz8axUtF_4d9Gg0A:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=uSNRK0Bqq4PXrUp6LDpb:22 a=K6b9sarf6D5yyto29Wkr:22
X-Proofpoint-ORIG-GUID: 5Q8Q14x-c6_E4Io102qlHEcsIJpBaR9n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2NSBTYWx0ZWRfX2k/0DboxXe2P
 YLLmH3DwZBygyM6ZyvkCKiym8WVC6BaPUj2lXDrlUtOOUR/apOk0Z5Rvp8nkZT2+9vMWqA/O8l+
 PXATCzwaRCa7lQgNyjquP+A+Dn7UxnAWj9PMwH3rVPrPKvAxq90QASW4ImV/iK+Y7B8bG150QeE
 7aXHlyZ+5aHExwJGPaueodmVR701ofgEK4Ls6Q2s5dsz86KntDzIAFnPigLsOwXt6OmXsJyihGV
 5MWiG/42El1nqZ59dwl+BiXyX0DQdpLqoHdW3Ij/l+jldnYGSurCQAeLIq6mNZtmCgQpuIHwKhH
 y9aZyPo8NG8WSvxMAHPhaAITrM6n2NYL7RaCjLZAkPZ/PI7uhBWKHtvVbi+P8TTJEtSkquEXX9f
 CYfpy7ji6mLC877mSlPEqIWQanyTvq1z4jy2Ok9FjsxSf8VaFnnb1wh8OqSmUBzhHnHfP/20q+x
 4hiWOjA+IonOTfZHUlA==
X-Proofpoint-GUID: 5Q8Q14x-c6_E4Io102qlHEcsIJpBaR9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250165

Emails to all TQ maintainers bounce for a month or longer, because their
systems decided to block smtp.kernel.org.  This is nothing which can be
fixed by Linux Foundation IT staff, but aggresive and irresponsible
email provider.

There were no answers from linux@ew.tq-group.com or anyone else in TQ
Systems after my inquiries about this problem, thus assume the mainline
efforts are abandoned.

  <Markus.Niebel@tq-group.com>: host mx01.hornetsecurity.com[94.100.132.8] said:
    554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.

  <matthias.schiffer@tq-group.com>: host mx01.hornetsecurity.com[94.100.132.8]
    said: 554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.

  <alexander.stein@ew.tq-group.com>: host mx01.hornetsecurity.com[94.100.132.8]
    said: 554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.

Cc: markus.niebel@tq-group.com
Cc: matthias.schiffer@tq-group.com
Cc: alexander.stein@ew.tq-group.com
Cc: linux@ew.tq-group.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index faa914a5f34d..f446fb30cf6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26781,7 +26781,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
 
 TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
-S:	Supported
+S:	Orphan
 W:	https://www.tq-group.com/en/products/tq-embedded/
 F:	arch/arm/boot/dts/nxp/imx/*mba*.dts*
 F:	arch/arm/boot/dts/nxp/imx/*tqma*.dts*
-- 
2.51.0

