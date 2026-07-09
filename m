Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624C3B9D9E
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578394; cv=none; b=i8D7IhFLyA4aW1YHmYaqmMIaTTlPWHhjrtI+/5YWSChg0qIAn0Q0a8MTc5FBvOEMMggHJHs9/wx+5U2oIFdVls8iUxwrJbrc5gD3rIz0PoWpAks5Q5IHmI7sxa6bSul/rE2K/RVK63oTzbwVirgKcUTPndf+mcLRFBVWq7s+XJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578394; c=relaxed/simple;
	bh=ICa2ixYXQCQShcbLWiANred4DfWKjbRwuNEMyfbpR5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXTbagOdE5T0u3ZHtvakMrn4C3xnnJpa0zGuuOsZFtOcK8sxnH2fGynOKFNsZaxS0h0xUSWZDaHQiQ6Whz6ZnxPGNLH9rZJrf03rGJlbc8eylcyewZcalTa521DWqnm+K6GAsN7rAzrFa4Bx1smIp05WtR5kE+C2Tvjs3zheHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mkog3pYJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3Bzu1EG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mkog3pYJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3Bzu1EG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960ESO931900
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2026 06:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TnjvUz+tLyUI32WEpJbsvsuJ+c/cX/I/b+xJ3yrgkM4=; b=Mkog3pYJ7tn+zULJ
	/fo3Qw4k4eJPYDjH2q/dFwCBWtPnM9WhyDO4TrahAY2DyjQ0R92BRwz8BJTwDiEv
	5m78QVX5wPfAokWCYhjEylaSPfV7EY3kdMzHE1ltpMS8qtzGADMUGX8br4SsVHab
	AomcKTPm4hNZ3UtEFAoOM+nNEwY3TBKEhKHhbQNMuS2C1S8awHurYL4fQ89L4vi/
	7GylYylnGfHZ64eH/lYr6WIHsmzFhzxYIFQhY9E7po+mMDyCKpsfGsUqtA5C2ONm
	My0pMQO1XGNi+OAXeoMIP7+hMh/OdHbVHWv1FuctA18OEvxe6FDjoHat385USL3f
	RHfwRQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsaq3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 06:26:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce406883eso15526995ad.2
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578380; x=1784183180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnjvUz+tLyUI32WEpJbsvsuJ+c/cX/I/b+xJ3yrgkM4=;
        b=C3Bzu1EGa2hBpWErkVaSFKl4A9qMIopBIws1FPlS4rGk5LIdRiX021hWaMQBQ18W6Q
         3xjm+trhrPkJ/9e+QcVs6ErFSWNUza6LmPZ5OZE4mr9w89ZvNRuMr5RQn/8E0lerN8HD
         /7lzsQLGSfN1irGFCfubruNH9C8aNkRAnMG2Ur5sAH3vKyj9Fax29oedDi7lDTM6Fwd8
         0v1ZpYLbgVHENwEQtC4zUc+amQJKBOWEQhZDJvwiG11cflb7B2DLhuTSAJEnvHD3KThT
         +OVs7t6uiujvY7O0cj+21eIt1LPQbvzV199T2oXsjF18FN7M4akcqJAIOhnGdsVR925y
         CLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578380; x=1784183180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnjvUz+tLyUI32WEpJbsvsuJ+c/cX/I/b+xJ3yrgkM4=;
        b=k5Wqbtjuwp+dEnJRq5dfN7mGRQR7V0um5GgbNPxrYucezYHvF8UVh6JntYIyLMyDPk
         fF/4h4h1LHNo2hNdF0p9zBNM5zG6Z3WMQp7C9wWAMwPSQq9QYgSmhqXEHAjvPL/YgWq7
         3IgNy5qI95lyXDZzXhSfpOkuUp/7JGt8bvpcfewN+8beCnkWaOCG76w/QYP2fl6H8Vru
         sm6qpYfnvYny9R/Ked+ih0Huno3aMqACP1SOMKHDlcGZvgFRYSHQU0Sbw6BfwQCCZ+uK
         A6CXjsLKZ/lX/p0zLsyqThgmrmBDT5PmULkbMr22ds8ng36BRUkNAu639qhD4k3hgNL1
         Ys1A==
X-Forwarded-Encrypted: i=1; AHgh+Rp46LU2J0FLj/i5R/bewtHhc0RUpUq4XCgJhW8jPVTlNrmTBMppIvgPBnGKQpGBXFXbhbEjCxhRIoRZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp42cQ4uj97MBG7c+pEgm3c4U2pm9O09pWBJOTYC0qYNMcteXi
	Zw/WaHYCaXoNKNOWRo63GJHbEZdmZCiKq/AH4rmhuZrkx7EXlw6Ym7LDOCuYRi7u2swWb+Nmaw0
	z4bPIHHSp0xObovxerxgzUk1txTbfMiQ6bGH/TTv0JJBcdeKjEifTI0S2SSuf7jcj
X-Gm-Gg: AfdE7cmdEIxhKroI70eydeQjdT+4nTPMPGvH2APR0FAvB9Ve4IdHIYMeDWHBLUnYYP4
	GbBQYIKeBiwIH+pUbqG3/D4jZbO5HQ1remV6Tk0hqOBJCodRaxrms7LCe9+5RD7MRS83IBOx6wk
	0MigegjkekYOw99vMyr8V6dNtV+H86LC51A0ewxFUd0hRX6mRFCpamfF+GcRbRDhMTJG1aLndDp
	fxSM60esJMfW4sw0DHW712xbLJrKTAB3WalAbJ+n8B9nOCDtf/wZGA3bMk8uDBPUoqjoiwuHi9y
	6tKvzEpB/b0K4mWr0gKL5WotoynNpeMB3/MouAEwAphXaI5rLUbd2xhdp+cUYvrMhsrMFijuP1g
	wFkwKuZvG6+uSdZoIL6r+Z4bs7Fr+3XaJp4srha0cGho9
X-Received: by 2002:a17:902:ce0d:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2ccea3b5089mr59094025ad.16.1783578379918;
        Wed, 08 Jul 2026 23:26:19 -0700 (PDT)
X-Received: by 2002:a17:902:ce0d:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2ccea3b5089mr59093555ad.16.1783578379292;
        Wed, 08 Jul 2026 23:26:19 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:18 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:16 +0530
Subject: [PATCH 4/6] arch: update uart pm callbacks to return int
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-4-e85c6ffa8ec4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=5267;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ICa2ixYXQCQShcbLWiANred4DfWKjbRwuNEMyfbpR5M=;
 b=CBJQcr1StBfCKgCiFExqiQ7M8QhGHy52FU0kMlsvUYVyqZjr7DQWWJDaIF8hjah1SmBoEdoNw
 jckAiu0TkLbBx+pz4ekuZMMx6564yLJV/1h1ccPX1qXYkBxB0kccnis
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX+ogYbfzo82cy
 gYuVTPa3SSkJsKLiUpzPPHE1nQ2wQy0hRQ9a6fot6oiYQElnJcGqAu/WU+61HDuxVan299MKpVv
 c2buUAdDGQs+C7bb57u5ja+42IjV1Kg=
X-Proofpoint-GUID: BAmRTbxDlzb1wW2sVSlUvy3U0B2QgVTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXwLUc9z5bmDxu
 ao6TEFbdhiFzYweNyIWlOQCL1X+e8foR7FNdClsKGlofi4zadDD2ZRKNY2QooEuD/5Y5m9SCzFf
 vKdgX6yF9aWtG/9GqcfZIqnQhBmKQd7RvWOrU6mJPdyPoKZR1Ra+8q9/KvVLgGoj0KrfN9tp3vO
 wi+PIsrl/dghlUfI3NJ3n4dzhPApd7TqYkE5Vwv3ARoM8qtcU99YTt8WfJXo/n9/pthSwFZGMZC
 sg2xBsJd/us1vtkO4dKeHU2m5S/mUxWpEvRBsLXG+xy7Sy3jwq1w/PleihU51haHg9qQlJO3kaQ
 IH49tNCMsQLQi4BkZfJsrncoFjKdbXZQclaIr+o9Inx42yqjJgi79m8sYC7kYPNRZoIUwn2qK0D
 SV1Rmua5HQI6IqUqOHWNj8acSfxI51k1wA4Jwd2+vsmeTurVseMe6eyLmYGmHTx3yunhJ9qciuX
 Yfu+87jAQLzENLBS8Iw==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f3f0c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=B5ILv1Qk_D0jGc0hQdkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: BAmRTbxDlzb1wW2sVSlUvy3U0B2QgVTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

The uart_ops.pm and plat_serial8250_port.pm callback signatures have
been changed from void to int. Update all arch-level implementations
that register a uart pm callback to match.

SA1100 (arch/arm/mach-sa1100/):
  Update sa1100_port_fns.pm in include/linux/platform_data/sa11x0-serial.h
  to return int. Update the two board-level implementations:
    assabet.c: assabet_uart_pm() - controls RS-232 transceiver via GPIO
    h3xxx.c:   h3xxx_uart_pm()   - controls RS-232 transceiver via GPIO
  Both have no error path; they return 0.

OMAP1 (arch/arm/mach-omap1/board-ams-delta.c):
  modem_pm() controls a regulator and already captures the regulator
  enable/disable return value. Update it to return int and propagate
  the regulator error instead of only logging it.

Alchemy MIPS (arch/mips/alchemy/common/platform.c):
  alchemy_8250_pm() wraps serial8250_do_pm() with UART clock gating.
  Update it to return int; return 0 since the clock and pm operations
  have no error path here.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 arch/arm/mach-omap1/board-ams-delta.c       | 10 ++++++----
 arch/arm/mach-sa1100/assabet.c              |  3 ++-
 arch/arm/mach-sa1100/h3xxx.c                |  3 ++-
 arch/mips/alchemy/common/platform.c         |  5 +++--
 include/linux/platform_data/sa11x0-serial.h |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1bec4fa0bd5e..5cc8274013b1 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -758,19 +758,20 @@ static void __init ams_delta_init(void)
 	omapfb_set_lcd_config(&ams_delta_lcd_config);
 }
 
-static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
+static int modem_pm(struct uart_port *port, unsigned int state,
+		    unsigned int old)
 {
 	struct modem_private_data *priv = port->private_data;
 	int ret;
 
 	if (!priv)
-		return;
+		return 0;
 
 	if (IS_ERR(priv->regulator))
-		return;
+		return 0;
 
 	if (state == old)
-		return;
+		return 0;
 
 	if (state == 0)
 		ret = regulator_enable(priv->regulator);
@@ -783,6 +784,7 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 		dev_warn(port->dev,
 			 "ams_delta modem_pm: failed to %sable regulator: %d\n",
 			 state ? "dis" : "en", ret);
+	return ret;
 }
 
 static struct plat_serial8250_port ams_delta_modem_ports[] = {
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 2b833aa0212b..48c3372a0f4f 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -649,7 +649,7 @@ fixup_assabet(struct tag *tags, char **cmdline)
 }
 
 
-static void assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
+static int assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser1UTCR0) {
 		if (state)
@@ -657,6 +657,7 @@ static void assabet_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 		else
 			ASSABET_BCR_set(ASSABET_BCR_RS232EN);
 	}
+	return 0;
 }
 
 static struct sa1100_port_fns assabet_port_fns __initdata = {
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index d685f03f51f3..8a307c7ad9de 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -83,7 +83,7 @@ static struct resource h3xxx_flash_resource =
 /*
  * H3xxx uart support
  */
-static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
+static int h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser3UTCR0) {
 		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
@@ -94,6 +94,7 @@ static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 				__func__);
 		}
 	}
+	return 0;
 }
 
 /*
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 02bf02164752..ef39cf52b168 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -28,8 +28,8 @@
 
 #include <prom.h>
 
-static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
-			    unsigned int old_state)
+static int alchemy_8250_pm(struct uart_port *port, unsigned int state,
+			   unsigned int old_state)
 {
 #ifdef CONFIG_SERIAL_8250
 	switch (state) {
@@ -46,6 +46,7 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 		break;
 	}
 #endif
+	return 0;
 }
 
 #define PORT(_base, _irq)					\
diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
index a88096bc74e4..be14a0152787 100644
--- a/include/linux/platform_data/sa11x0-serial.h
+++ b/include/linux/platform_data/sa11x0-serial.h
@@ -18,7 +18,7 @@ struct uart_port;
 struct sa1100_port_fns {
 	void	(*set_mctrl)(struct uart_port *, u_int);
 	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
+	int	(*pm)(struct uart_port *port, u_int state, u_int oldstate);
 	int	(*set_wake)(struct uart_port *, u_int);
 };
 

-- 
2.34.1

