Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6AE4204E
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837923; cv=none; b=LMFNRNeTAkzJLYaGBJDD/XqJyCTYfOsiNBd9dS1aVDEGmsoMEyr8sUxG0FECoshGd2HmR7+Jl9aOEoCLfL+WY2ZH0MFSWX0cJg4u66zZJ131Bk+Hq1jtll1HjMu45SD0ULT98uwHdnaPBPPj7rPHVszvzYDrnBUQCcL9yOfPW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837923; c=relaxed/simple;
	bh=pV4BB7VESvwwOGoINJ0yyIw3maBinxln5Jf5/nDWw4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hijMfz/IFr1EXCQwZtwFC8S8Qa1QQcnOEEUAo1ZAkZE6HXpi6sTs+Re7SFiYLPkDo1gm/jxh2TlPccISMA2ohGXeOblbBxosPP1l5w7eyIFaO/zdfJli0DTLjCMy+oNiNXT6LN3v9SlHd1Mpt4Rn8xjuEKmbX7LZOrNwt8klOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ToyIMv+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSzNekIu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ToyIMv+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSzNekIu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MKs7GS2816475
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=; b=ToyIMv+4gPxgJGDz
	OtTJXTi+6ijgFirVZaPLg6Jy4RUZZX/AFbbK6RX8Fhl71qcqqPoNGUpt+HIkIoYx
	KR6qVao5alntB2UyLJWIr5+IeFEVsdgt+LTmo7nncGhgyO6pWAx4qD61h4uLIB3B
	o90pKouDd3F14S6qyY3DuPE2J12wqRQSznVP4aELkujb7vuz8p90KIAiAPm7R3TW
	nZ3IliwtwLlDnho2o8M54txvXbR6J9bvN5gRnY8dFTSeyGYPZj/sxLUNk9NlpXzZ
	D1DSFY6dg5vPPwAMLMHoHqL37h7BSrFoOU6IELobApS8Ifq4umNQV4JoOpgjMcqW
	Vg84Xg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vj423u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:12:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8946f1b8691so453461276d6.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837920; x=1772442720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=;
        b=gSzNekIuFsZlV/I9zMU8numrcXSI13/CAzRGuWnJ2Rwlho7Jyypj92D/4wjyt7Pwun
         ihLZGcE26pxPH1L7G6eD+YNqcJJ31HxjHOh9iTP0bqXQlr9n+7YePSzvX+KYTzk+O+6W
         GmMFCzBfWeyoOsnDWq3GCsptdZPEW/s279BAQMxahD8jqo5TxY/T3725/5Rc98IpSb+r
         uRxTN9tAwxPEqXBLQFRia990MximvNa8qLmKG8YIO24ip/BewkYsPesaYpGPRvPTGt6m
         Ve7Yn+zVJqfTORfxqQzFeUi38fBx0l40nlbRXtae6VJuGvJFVzwJbvOm2T/7I8Cfq9ZC
         dDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837920; x=1772442720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV/DHL0paDpUXzhwtvc8PrdZr2Xx/XbyfZPyz0Y56tQ=;
        b=MA9PDGD7QNnTGkZ3mEjRwZicpbe7NBrb//g/aMHsT+6T7E/NvNVlcoq2LgbIyG5AEN
         yPeQl/ZQYN6Jav0woN0vv8S5DeG37PNqmRHxFbh+l1HlJwYZyc5Blk4/nEATBg2AYbq6
         vD+3Z3iyPzFCJF6q01/Ix7rZUjkvgi4aZpc7Ikhig4LLV/jOQTE1T0jEMN9LeEGJ2rQl
         lRnmYMeJFVWCGfud0OlP6YEV1F/dzJE75+3mOJ51oea7wiVZb7AYxyngjfsjL3WhTU8o
         9IAkPwTAXlXPzdQuTycBMC4DrSGfXTibbvDGzEAWRmsJ8uSRJ1L8+xGymKsJ6k646C36
         E+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVbkDBV5rUxnPxl9kzwEdm+QTRcnX8tOOh4XRrFsoGsMqStEEcKl3dKOk7YW5PWAaxJwLzloGBEALPh@vger.kernel.org
X-Gm-Message-State: AOJu0YzqktJiNS+SZg4Qlo3udT92FqrVva+wFLPj5JIjhASRglpVgNtW
	jCIKKHKISRrw2RIOAHvDVdbqOLSR1/nSmL1zlr02CkzmoIHd96TRZpZVY0cf97RUEXjrs+UHdHZ
	nClze5DW7BlFfVhsTi95dfXS38Y0/a2s386plbyPGOx4GcSa3+hSEbrM1czJLN8HmliQCe7EM
X-Gm-Gg: ATEYQzwA01wJehlWyyJhONyC8fcBCav9nAqhiX4O88XuBkOQb9yoDc7Cb1APnasfWkJ
	LqxKRR5cGTgFQNmDmZZpnR/INu9P/GlTJYxS1ghYkmx24ewwepoROBBQVTcsKH9FMLdvidr1V3J
	2o+OuszUhPBbYfjnUltNbYvDnw55KufTD2GEE7OmRfeBqQmvUJ7l28n7L7F0Dj9fgL2hyls8h7V
	8nJApqZs414T9ZDWLce25bnZp7NA5VRKELB74nbZu8CU7QqHR9dj4RQ36vgLGCehlOKwB9ZO5PV
	H1+Y33RBBm7Pyv0CXW3c88+w8EdVO3QBVJJlObE2YEt/zOgonqJGoxQhp/hh1ucZMZE5YU2gYQN
	GhTJu5aqfCNZE+AhmvWOXW/zc+uKMyJhy/7YCI4vZIQLrgcNrBpPT
X-Received: by 2002:ad4:5942:0:b0:895:3b03:7720 with SMTP id 6a1803df08f44-89979cd4002mr115918836d6.30.1771837920330;
        Mon, 23 Feb 2026 01:12:00 -0800 (PST)
X-Received: by 2002:a05:620a:298d:b0:8ca:105a:f5ca with SMTP id af79cd13be357-8cb8ca6e5d4mr903307085a.47.1771837570545;
        Mon, 23 Feb 2026 01:06:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:49 +0100
Subject: [PATCH v2 03/12] i2c: bcm-kona: set device parent and of_node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pV4BB7VESvwwOGoINJ0yyIw3maBinxln5Jf5/nDWw4w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBhyCl9Rsm+yhDXm29XU/HR2ugRm1pVK1Y0CD
 7TkNCnQDmyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYcgAKCRAFnS7L/zaE
 w7sLD/9SO5N/l8NkJMRZ8orITe68nCScnBshSzOQl8EaGa3Jvtk/L6f1vmYPYghezYgbU0WUPaN
 3OGPStzjSplnC5Uz1Vwe6MXVBKVTcbFm7QE2UOnTNgutHhrBBFyzeRvaVxQfNpFtPvVtANkMVNO
 x4gDOe34eQU2T/3XWReYHftzyFtIH5/HUN4lPIfv9Zmji2bY1AqKceOY3SGgp9t8DAhgDHMrriu
 3dDpBleL8kMsea2pzl2AX08+3SNj4BUPQihaut2B8qV+Oq4Aog2HlJ+o9x5cuCCGmlzuXzTR/kh
 Ia7RmentNuQ3hevCck55A1CgD7SXDP0osGD41ERDL//ZnADXc6bwgvew41k4GfQljU4dyloLXaV
 9d+QWNt1A5E4rl0YRPBya6pxjKsv/aGWyUH+k0/VXskdehU3dHYT/d9SYyBYEBqlk02LbEWVf3e
 IoT+UtOmEVc73SghWDbQu5u2keilAj8ivk779OFrHM3fM9bZC4jkEm1KQJ0a5S0LOqz7jxL8mMt
 qmkDF4Jr5jhmohm/R74LFaWAGcpcBDcSqpBxa+3shxx+3Nmv5DNW71aB7UmPbU9djdUxDMjpBFR
 hz1SlZPTMQYxf+zrDk6TVx4BnyUMUhyAOYttQlGV6VwcHCm4NRVUWGwJARKC2DnUtAJd4Si1BtW
 tbT+IjCraKX9bsA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXx/4YWdpW+Otd
 ftT5mxRnMmHkUsaRc/gm4COulyyN5N0RRhp8Ihb1U2F1NIMCfq6Qv4E3koYzvsj81BqvEgfWoIN
 nQzIZYlvTU+JI7ciiFh1D+VrmGOGJOj/Ym9QLZwxQSPMXnb9QVrpISAQ/Y+FB68bGCxNyNNjXaV
 Q7GJ15uHeuVvloglolXPM2boY/eASEfkQeL+OGPvwev1C752Nm5ik0RH8G9VmUBJ3/yZybv99vm
 H7r2PevExniJjDFxI9ZEq8EUeIcr6cQpAC+nLVhTVbX1MROHLQZltz0pLX+g3y4wRtc/vzEZ2yz
 Qw45GpNnEw31SPPgQbR9z055pFb0cP9hC3O5sLztKLgSUBMD46X2Ks91EB/mlamxKR48xcm1lW9
 cs4WTtIKrWu5KsKGzyrhvrEKOlwuQiqnTLNwpD7TpHrB9tPMSn/YQ6T1vuH6C+0z9Tuk4TSp76Z
 SrWK4zdwjIAYx4RotBQ==
X-Authority-Analysis: v=2.4 cv=T5KBjvKQ c=1 sm=1 tr=0 ts=699c19e0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=xxYytfOIdaUIj31isgUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: w_RUHRL4H1X527gTrC7I4yr-v4NxNHYx
X-Proofpoint-ORIG-GUID: w_RUHRL4H1X527gTrC7I4yr-v4NxNHYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 9d8838bbd938bf6c43d9553d9f54acac1282f7e8..edd79689f40f451fc216455c9da5704bdc73c62f 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -840,8 +840,8 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	strscpy(adap->name, "Broadcom I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm_algo;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->parent = &pdev->dev;
+	adap->of_node = pdev->dev.of_node;
 
 	rc = i2c_add_adapter(adap);
 	if (rc)

-- 
2.47.3

