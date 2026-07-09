Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFB3BFADE
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578400; cv=none; b=cOgC7eM5A18m/hXnEad5EnLmL2wj2IyKqZyLcptpRSdcEDrfFdR+bdqLowTH8QPPfNQiq7gJsnmoCxy+MSamr98zyIoV4NQBliGYF8yAxvqImiZDUxPphkLm2wGdlkevGq0P7dcTtB593vuHjy7TZ0+QGkRpYcPQ5IAJRsO8Bm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578400; c=relaxed/simple;
	bh=RCVhJVzC+wYdvFevPUgqoSKxgJUMAgct7Wn34WkXRWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPvmLLMZLx3Jz8pGwMTZ2/Hk4zV6Jiyg0whCZEmCtSyN5qJoz3srF6CnZkZpbZz3x/GwFJ9q/qLuPgnj2a0iIh9a8c1S+ahgPX90+dFLdsGd/dOL1Hii9JyP/udTYUTvHOJdAwZZrxJ3uqqPSaHs9fznX6EsgtWUChzNcd0AvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NqHIsSbp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqPj/nAB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqHIsSbp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqPj/nAB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960Nak916740
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2026 06:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=; b=NqHIsSbpA5lvbv4Z
	47M3CAoj6uO6UEbJD5y0BQysq5L1Jr1rsf0AiPX313hzBYpS3K8LChKHvBfabvnc
	V9BSGWOrBDr2DZBQr9+B7/Pw+mjlVbaPKaY3ZTof7YB16OMWPYtTwsTmlCkVChBj
	P7lyNOhAzzk7GFFiC6wgEIsS3Bff7xMSxJlZXYrudLuIw+4puPBegSMEka9XgxXF
	la3aa+G5nxIGIfXjpCvN1m0vNN556HsMZgp0k9TETl2Ay1AZuCJPvhGpVEdKiOGD
	ya0cvjixpb/Q+TNZHJ+UTotRX0UDf/hKztHRgyPbpEln34SNELVk77g3jQkNYbXj
	rSHpTw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv57r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 06:26:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so31338975ad.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578391; x=1784183191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=;
        b=dqPj/nABZXc2cQRX7odkP/Ez0FjAvq8EtICkPzv8cHqVVjjLZucn1XGZMMnrDT1Laj
         2PAb5Wtj7FUpzthpaZlOmIsxfQksVDxDmuQx6QcP9Fg8pf0zGdOZPinbwD0BjpVfVthy
         sLl9WxS+S7CNl9kc01BEOmWNU+vESsvBBALadFEv0prh+SNgLEPwkGIFyiCR5mgLRCQf
         yaCbTHwX/yOHaYwtUaLcFF8UquklZKhNBOaXUCzQ3ztRX6es7hXeK2G4konfWo4XEW+d
         eOw3XiFMhgUZaA/jDENgZoywnSVPDNWplR07w6EgOtye8Bk20Da5Rbt73m10Id6KtHbg
         Rwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578391; x=1784183191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=;
        b=rMQevn6RplDIf+CoCOGSxrU2SUgVXdVfwLqW/PWxw5u0A/3+f+uaA0OXXJUIMPBAOS
         Dy5Ee+t7x8LXn47zfMxJ2ih5dztYIIAj4BaxFVq0ku8S+434y8A91ipDDya1pxpMPIik
         eVwoxHxuNpM4+SUv3GxoFyRZO5OWnVZg7JgoyCfzxQGeDyfMev0ZQMZRgKq/0G90pve5
         nx+YG/pvjDYNTrTlLTdzOWR0IADK8eJ8ODLatZ3rqMq3leXz/N1w5b/j6RcB+BJmrGVc
         uyej4haUnQbX9UL/WVupW/p28dd4E6xadKNPqSdQrg0/YeNjBeTWWnSTcUQlkuNXt/ed
         BpwA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6BLTjdfrH9GZaoKK7Q+xVHdhRcRcjLfGQnzZ3Dc4Z5eM7/1QHOgRghRDQViiwlcc+DCul1obpbSs0@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkqjv2Zo1R5dcTgxFoHJmOSFCoaepv79+f9c6IG8JZH9OxkiS
	iju8bq92vs5Fs87ZaGU7qUmObARr3t+AxXgS3Li6sOVJpFGaX+dyQD9g1TuNH/NGn7dcv7KKLt2
	2ntgOEOjuCHdLvs4zVVbM8W2WtxBJqGO1x0AHhiyFM3TGKUTrsBQiZdczdX7/+BaM
X-Gm-Gg: AfdE7cm6Z53pwp4VnZwHNEZbv1FgbszVQ7CDiXJ98Se+QG3dsy8RH7Qga+9dvBnG4hp
	ob75WetM1qcBuMAaCqOaG+6HGykq1RaBHpUVmU9diEhpM6YrRfrx61xL6isGzK3ALCowFeBvUrG
	RXzSJfSGwF8JubrtC0YcMR30sD7ZufMbkUVXdRUqZbuCGpaJxHNgHiDktpb3MKweQF8wv1lJaCz
	6OdXKlEOT6xvJ0AV6nNZoxUMn+xBbpEJkefxn6elyRnrlkHsAjcK3RLbnniuyLry5dfysUifpYp
	6hQ2Q/1WpMMGDCh9y/9GBnJLj+Md5xnW4HInsc/BzBokcBXXhf+gpI4FPumupGwUOvAexK/hwjK
	Mv4+l4TMdQi4ETAfWd1G9gB+RN7JBstGSUNtHTaEiaWLI
X-Received: by 2002:a17:903:1b23:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccea36a539mr62888545ad.7.1783578391532;
        Wed, 08 Jul 2026 23:26:31 -0700 (PDT)
X-Received: by 2002:a17:903:1b23:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccea36a539mr62888325ad.7.1783578391002;
        Wed, 08 Jul 2026 23:26:31 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:30 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:17 +0530
Subject: [PATCH 5/6] tty: serial: propagate uart_configure_port failure to
 uart_add_one_port
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-5-e85c6ffa8ec4@oss.qualcomm.com>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
In-Reply-To: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=3013;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=RCVhJVzC+wYdvFevPUgqoSKxgJUMAgct7Wn34WkXRWM=;
 b=03mWtjLIQU7aWmNkLwR+vaK5fDe/SCxXzqhpbBs8b/Xb17vYTfEsjAwodzox5hzEhqv5I585X
 VlgTWl/svaRAQ3BHkI4jtOEcL+pvacYHbhDmbmUE3ytsKKBRXOWcuW/
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f3f18 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ix9lyGl5LlKgHWL4iMAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX6AhAiRggqh95
 YSlcspY0LMICblGAdDGKbNVRDIGahKAN1KK3nWOgmlZ43oIEl+/quNrgGEFbLLsIU7cVc1uGV4K
 fMEKfN4GumEzjBMAtOaffO2n6ozhLoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX3SBUiPQIjewM
 kSoyCD364NoDuBv4/1fE12h8Ll9HUE2wZuQZT2NuUNygzTAEP529zXlry0l8uUSwU1xhPJgeV1Z
 5HqW4WTh08U+DjkUxuGse6h2KAV1j+9idpp/bQTMaKcCXKrkJBvEHWJvfMr9zM2hszyN/TFPY4J
 TQEhCY2mw0XhH5ptYif3SQTb327QgBWfVN9/q/7rSjtUtIf4JJl2bgE6s7gf27nqpMgJh8cJ4ZH
 6tiIgZ1cwZi0Wt6mgSCEBCtlNbC4COHe8ThZqKg88fVlXb/fQC/oICXbGFDEBzqZsovt3ckTvC2
 v1A72PN7DhLr4aGGvGOBl4kUMalA7EhTRCxvfBuirRw3AeDge25Wc2pGrt9qBtzswFAiOKfCgAW
 Oez1PA0DlNIbUB0Wt4uh8Jym4MT2U543yaUgj8v9Jhism57g4aqLwG1c7k7LGwDeJxkyHC0i9Yg
 NlmIm/fJt+K0NEH8FRQ==
X-Proofpoint-ORIG-GUID: JR2zgXp6j83V8ZMirkZ2SgnR4JTWcaMT
X-Proofpoint-GUID: JR2zgXp6j83V8ZMirkZ2SgnR4JTWcaMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

uart_configure_port() was declared void, so the uart_change_pm(ON)
failure introduced in the previous patch used a bare return that silently
dropped the error and allowed port registration to proceed regardless.

Update serial_core_add_one_port() to check the return value and return
immediately on failure. This propagates up through uart_add_one_port()
to the driver's probe function, allowing the driver to handle or report
the failure rather than silently registering a port that could not be
initialised.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/serial_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e624a67a9395..6cb9e870ba86 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2526,7 +2526,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 			port->uartclk / 8, port->uartclk / 4);
 }
 
-static void
+static int
 uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		    struct uart_port *port)
 {
@@ -2536,7 +2536,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	 * If there isn't a port here, don't do anything further.
 	 */
 	if (!port->iobase && !port->mapbase && !port->membase)
-		return;
+		return 0;
 
 	/*
 	 * Now do the auto configuration stuff.  Note that config_port
@@ -2559,6 +2559,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	}
 
 	if (port->type != PORT_UNKNOWN) {
+		int ret;
+
 		uart_report_port(drv, port);
 
 		/* Synchronize with possible boot console. */
@@ -2566,11 +2568,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			console_lock();
 
 		/* Power up port for set_mctrl() */
-		if (uart_change_pm(state, UART_PM_STATE_ON)) {
+		ret = uart_change_pm(state, UART_PM_STATE_ON);
+		if (ret) {
 			dev_err(port->dev, "failed to power up port\n");
 			if (uart_console(port))
 				console_unlock();
-			return;
+			return ret;
 		}
 
 		/*
@@ -2613,6 +2616,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 				dev_err(port->dev, "failed to power down port\n");
 		}
 	}
+
+	return 0;
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -3094,6 +3099,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct tty_port *port;
 	struct device *tty_dev;
 	int num_groups;
+	int ret;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3135,7 +3141,10 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	 * immediately after.
 	 */
 	tty_port_link_device(port, drv->tty_driver, uport->line);
-	uart_configure_port(drv, state, uport);
+
+	ret = uart_configure_port(drv, state, uport);
+	if (ret)
+		return ret;
 
 	port->console = uart_console(uport);
 

-- 
2.34.1

