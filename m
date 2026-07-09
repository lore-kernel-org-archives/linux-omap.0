Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B93C197A
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578366; cv=none; b=ovQhfF0OqDsew69/S2dDJ6xKp1QyKFLaJfcNT1R/MDJ+JOT9ophNuV9UD9mQ9VPercEoqCC8y45jntCzACF+jJIoa8QOR7AgBsx+aMAsvvKO6qmBniQsOvUfnGBZV36aBlLQYeSiZ4GlnRABaaLQk2eN7rEKen0zDYmNjDoBYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578366; c=relaxed/simple;
	bh=b2izFxn+4IiiyKp9j0s8vQoNlL/tiuR3/hHtBJpHypk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERyM62WvT7nGHxbs4u1Vb4utimeBxM/DLgGKi91kS31WpeG6QfIoh74sHHxBTIRGl4E+crjFaHo+8QkrRhTPA2pOsyAfffOhBw7PdewXXLs4Tz9uhXd4i3XAhBcsaIWSArSMcf5wOfIprWowZ8RBUYvF3u2wRQgnbBVUxXEwZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8drr8S6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1daU/Fm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8drr8S6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1daU/Fm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960aCJ837403
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2026 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XkS0qjbBMR4bx7I0LwF03G25ZO0lBo870NfALSlDjq4=; b=e8drr8S6L/NQmGEG
	+01bhR+Y+IVDfJc99E+U3BaaxSi87bNGogUvMwHI6OjC/MlcteROsVg0tpt15Uic
	iK7VAiITAy4z0uDp3HZWFOV2k5QK6nBh7kDZzgPdwnpYFX3XI7qsHgUjQMLQHz/b
	ArxVvks6Si/rwNIEsKdmhTEBMMftGG58nWCOrOC7m5YtsD8UPMf4wa6h/zpOn6Kd
	XbmkXSpQPgXLJi6Ze7mkyXtmKBrEK6GaSw+IjuFVvDI6wB+AbUcmvtRZ3VfEDc9A
	VWwcv7sjdTl0XE/dAh+qpiKbWJNYGFKX7u0XdpCpAfmQJM92BbfBXbaGUpe46D53
	TDOQVw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwap3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 06:25:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc88e22f92so34766825ad.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578357; x=1784183157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkS0qjbBMR4bx7I0LwF03G25ZO0lBo870NfALSlDjq4=;
        b=h1daU/Fmx3Hjus0nNPbksoi6Jf8pbFseciWOCN4YLgPj71iue1cKb7Hp4j2kVzaY/D
         J5D9vnP7FVEg4oxiBc7Fd3Ezch4tq98FZD5crtcHEbHhIGHBktvvt47QvyjsqkUUIr3I
         K8pmMtrsSCAPHz4f7/LiavFMY332CaZJsbQ4KBRZ4ZTuSbSwVmvQvekwJj3qcxtp5iwE
         UWgAEnTzmvXfZ+SIPZezGVboI14WegzBJA1qK0mITWIwmR0JNnO6XJ3+DWk9iIo54pAv
         K2NjEnP0GtTT6nGRJZ8t+n6BRViTkxkT7LUoK/H7Qyxg4i959aRMBU6JoRlU/0Gs7Yf+
         vUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578357; x=1784183157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkS0qjbBMR4bx7I0LwF03G25ZO0lBo870NfALSlDjq4=;
        b=Tuzj11nCw9hj0CPMK0osrM2IeNOpKhnxj6n3VPsdaAbXWftqkIfuRPEnn48CIoPAMj
         L9QA2/WTBf2z30ut3qTvrnuDm6ofykHXH9gwn6FHA+LuMwaxia0ayFmOgHsofL7m58eJ
         DlthSK7/tmIjjB2pRSUeZIMdZCdl/m7OwvtJ12+F/AAsS0jKhPlNqMrg/KZxJ5RS/fX+
         vzcxm+e2HxkuDW91/CmaHFShGrrTy2B63PVbDOBRegAIpPda6FhH+MUz2Y1Te+TVm4Yt
         nrPahFRNNGKaHIPI/yyhhoGOBEyhAaaxiy54Jw5vg5OXkqK33YdngV6y6IuOH9fW7vrG
         K6sw==
X-Forwarded-Encrypted: i=1; AHgh+RpBS2JGAXoy8xLBbnAKagF6tR1YRG5521fE2drg0AH3BvD0WLNP4qClkpyiIVuIhR22Z4QiEnToQAb6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/bA4/BWBRnY2dsnxuhZcA3gQbuZjxHJ/OWl6OOBGwnwQFQDTM
	K0JxUMejBgWFjtVLMztmZItdTeTvPgGqJ+SUDW30jkBMwUBOS1riCoMxQoAnlYZpeY5LtgvJamb
	fQx0hBoDwlfSKUR8CtXS0FXnqYgiMfRj+zb4JcWNS3X/I3DaD8cvdJla7LLlT9J4g
X-Gm-Gg: AfdE7cmX9R34M8VQ957gaWP4ogKKU8ytrX+DwlDlwEr9ytwd3g436Ni9Eem6VEVcy8a
	C+Tls3WEd3E5iOFwM2yjibWzUK1kduhkhZsQ/HltHPuYgPd3S76VjFP7Ipckjm9HKjD1Lf+dvJu
	7G+AlssoDgIAgwXuEHiEgJk4ZmREOf9tmNn+CEYG02ZuD2xk/j2HUys5qppowsevFVmfEeD4cNm
	ys1zm9DZveNZ0uybv8GzpwlUeLsjqDRzFnUuwAFBhVkJTE4qArJrSYM6Scfnvbu83nl5B8o/ikG
	rQGEGmGt3HQojA8hTxs2xiXPwM969Vf5y6UUDxR5sp/XQ1gBdk1Dttt+o8Iij0ZkEZ243okBNLi
	NLFXkRLyJzCz8ibl50J7LeKXv6HPRV9tUYG8/x/wmI2sg
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr61764295ad.38.1783578356734;
        Wed, 08 Jul 2026 23:25:56 -0700 (PDT)
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr61763605ad.38.1783578356098;
        Wed, 08 Jul 2026 23:25:56 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:25:55 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:14 +0530
Subject: [PATCH 2/6] serial: 8250: update .pm callbacks to return int
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-2-e85c6ffa8ec4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=7834;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=b2izFxn+4IiiyKp9j0s8vQoNlL/tiuR3/hHtBJpHypk=;
 b=DiGW1ZUts1Plz+MKuKKnKr4MwFWfW5eunK8R4MyGl0ZMAS/6fAayulfFs5o4Ae/dAXTYeNVbK
 +fgruC+Vge8B91yUCFVVeTpTzyXxnoAKhIaokLIyV6nwlSzhKWExJ8e
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX5ELnf6qMkUWB
 0YBrbA8w11lX52XVgDEgDKywNAr5Q9KAt1dFu0qXAY/i65beAT/GDDG8v7nmJ5ajLnl1Rc93/wh
 VvowAvqLb9Ktfq9SL14DgBuzUHRvMvW2bSyebjexj8i6AxZjUuHzAEOKa5x+1XyYHuQf9W2m109
 YEJpZD8C1whwmbVgnYnQPsHN4i1ARrYlTU55f3rxrH84LtWRfMzO92MZNNdXOETE1FK1WMb4Frp
 nGqJPXTwFHolPGTTSsSyGmUdcpz8/MoaCpZs35pfuT0dj+duzz5GtU9rDSpLc/tupjZSnh3d7+Y
 hkxqmI8pE/w/EvSvraQb7BvuaiQGOwl3+SsXh6ykIc6zrperwOzCL7t/T61chTzuAkS8g20Nd5F
 Ep2Mh7zgPTuXZSljiYpTiFvm1ODukszwKARazWZ2u5F7ITHSkdWUdfK35mGxWZ4yWgIcoJeDEpb
 jqzn5uBlh6slMBOZtWw==
X-Proofpoint-GUID: OIbzcrEzJMDbmjQI-J3iO8el-ZQycUUZ
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f3ef5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MdvWXRze9gsMBWCGvMoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: OIbzcrEzJMDbmjQI-J3iO8el-ZQycUUZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX4kfL8mc2zEMi
 9cCZ4VMlntPUzAuIOYzYbEuGDTmpGWOsEifB3otSgYUax2hnB1ys+FEZNPdxMwG+Bpeg9TA/4f/
 BDg9ZFQxNw3EoAa5WBgKt1BPL3zoy1A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090058

The uart_ops.pm and uart_port.pm callback signatures have been changed
from void to int. Update all 8250 .pm implementations to match.

serial8250_do_pm() is the core 8250 power management helper, exported
for use by sub-drivers. Change its return type from void to int and
update its declaration in include/linux/serial_8250.h accordingly.
serial8250_do_pm() always returns 0.

serial8250_pm() is the uart_ops.pm entry point for the 8250 driver. It
delegates to a per-port pm function stored in uart_port.pm or falls back
to serial8250_do_pm(). Both paths are called for their side effects and
the function returns 0.

The remaining sub-driver callbacks perform their PM work through
platform-specific helpers (clocks, runtime PM, GPIO) and currently have
no error paths of their own. Update them to return 0 to satisfy the new
signature; individual error propagation can be added per-driver as
needed.

  8250_exar: exar_pm()
  8250_mtk:  mtk8250_do_pm()
  8250_omap: omap_8250_pm()
  8250_pxa:  serial_pxa_pm()

No functional change intended.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 3 ++-
 drivers/tty/serial/8250/8250_exar.c | 4 +++-
 drivers/tty/serial/8250/8250_mtk.c  | 4 +++-
 drivers/tty/serial/8250/8250_omap.c | 6 ++++--
 drivers/tty/serial/8250/8250_port.c | 9 ++++++---
 drivers/tty/serial/8250/8250_pxa.c  | 6 ++++--
 include/linux/serial_8250.h         | 6 +++---
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..7d5fa11d685f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -458,7 +458,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	return 1;
 }
 
-static void
+static int
 dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
 	if (!state)
@@ -468,6 +468,7 @@ dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 
 	if (state)
 		pm_runtime_put_sync_suspend(port->dev);
+	return 0;
 }
 
 static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c682c0d0dffa..0d0026ea155f 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -419,7 +419,7 @@ static const struct serial_rs485 generic_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
 };
 
-static void exar_pm(struct uart_port *port, unsigned int state, unsigned int old)
+static int exar_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
 	/*
 	 * Exar UARTs have a SLEEP register that enables or disables each UART
@@ -428,6 +428,8 @@ static void exar_pm(struct uart_port *port, unsigned int state, unsigned int old
 	 * the UART channel may only write to the corresponding bit.
 	 */
 	serial_port_out(port, UART_EXAR_SLEEP, state ? 0xff : 0);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index e6a56cf54ae0..9184b1eeddd7 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -452,7 +452,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static void
+static int
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
 	if (!state)
@@ -462,6 +462,8 @@ mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 
 	if (state)
 		pm_runtime_put_sync_suspend(port->dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c552c6b9a037..8f099afd6ff8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -527,8 +527,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 }
 
 /* same as 8250 except that we may have extra flow bits set in EFR */
-static void omap_8250_pm(struct uart_port *port, unsigned int state,
-			 unsigned int oldstate)
+static int omap_8250_pm(struct uart_port *port, unsigned int state,
+			unsigned int oldstate)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	u8 efr;
@@ -546,6 +546,8 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+
+	return 0;
 }
 
 static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 630deb7dd344..315e0a2fcc14 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2848,16 +2848,18 @@ serial8250_set_ldisc(struct uart_port *port, struct ktermios *termios)
 		serial8250_do_set_ldisc(port, termios);
 }
 
-void serial8250_do_pm(struct uart_port *port, unsigned int state,
-		      unsigned int oldstate)
+int serial8250_do_pm(struct uart_port *port, unsigned int state,
+		     unsigned int oldstate)
 {
 	struct uart_8250_port *p = up_to_u8250p(port);
 
 	serial8250_set_sleep(p, state != 0);
+
+	return 0;
 }
 EXPORT_SYMBOL(serial8250_do_pm);
 
-static void
+static int
 serial8250_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
@@ -2865,6 +2867,7 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 		port->pm(port, state, oldstate);
 	else
 		serial8250_do_pm(port, state, oldstate);
+	return 0;
 }
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 6dd0190b4843..02f0037e0a31 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -76,8 +76,8 @@ static void serial_pxa_dl_write(struct uart_8250_port *up, u32 value)
 }
 
 
-static void serial_pxa_pm(struct uart_port *port, unsigned int state,
-	      unsigned int oldstate)
+static int serial_pxa_pm(struct uart_port *port, unsigned int state,
+			 unsigned int oldstate)
 {
 	struct pxa8250_data *data = port->private_data;
 
@@ -85,6 +85,8 @@ static void serial_pxa_pm(struct uart_port *port, unsigned int state,
 		clk_prepare_enable(data->clk);
 	else
 		clk_disable_unprepare(data->clk);
+
+	return 0;
 }
 
 static int serial_pxa_probe(struct platform_device *pdev)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a95b2d143d24..12916189c20c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -57,7 +57,7 @@ struct plat_serial8250_port {
 				     struct ktermios *);
 	unsigned int	(*get_mctrl)(struct uart_port *);
 	int		(*handle_irq)(struct uart_port *);
-	void		(*pm)(struct uart_port *, unsigned int state,
+	int		(*pm)(struct uart_port *port, unsigned int state,
 			      unsigned old);
 	void		(*handle_break)(struct uart_port *);
 };
@@ -189,8 +189,8 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios);
 unsigned int serial8250_do_get_mctrl(struct uart_port *port);
 int serial8250_do_startup(struct uart_port *port);
 void serial8250_do_shutdown(struct uart_port *port);
-void serial8250_do_pm(struct uart_port *port, unsigned int state,
-		      unsigned int oldstate);
+int serial8250_do_pm(struct uart_port *port, unsigned int state,
+		     unsigned int oldstate);
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);

-- 
2.34.1

