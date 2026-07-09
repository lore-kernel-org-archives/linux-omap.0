Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E73C2762
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578413; cv=none; b=TK8PliKDgfZnpbgSWwhvDc4UgOLQHZ6zcRSe4d5AL+n91MSM0H3BE7jPUY2dmPFuzWoF0HbxFXQYEPupU9QImDh0G53p1o5sRraapamzrF1no0ti58PloGrysQbF0AJYHVYtX9+eWPBVvnX7rFjT60A7qd9bUsWhACDEpUdI0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578413; c=relaxed/simple;
	bh=aLKsWDAwz2GNv0and/N/QxAf4HluEjygqicLIneo6A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8udzioCyu+ff9+jdWCFMbXzYRu97HRWhAzBddQy70FJy2kdc7A3KEddZyFs4e3VOVnqV5R37bu3dRRaWoD/RIOivm5U23oRgchbHqzTzZ4UEg/JVpVhT3hdgS9XuaqrBaaFg3GC6u64bJNZrDFheofkIKJApSRurHIi8r/N4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TO/+YiWH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BvQFJSxS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TO/+YiWH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BvQFJSxS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960IPm972678
	for <linux-omap@vger.kernel.org>; Thu, 9 Jul 2026 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=; b=TO/+YiWHz6cxuFqq
	qzv+0B/gddlxjqw7W5u6QCi1+Q5k7D63FXxoFjj3t8O5SZsGfAp8aaF/BMzqjznH
	/0XgRQPo8+dmjJw6HU0nFMFl1NGXVT/G+NG6pAQW7ZepcQjzKr4KZI/cmcxp/3z/
	URT5MLHK4BjfJR0WyIzO+4iDnxM/yxuDsXKDylNQlXfixTpLeIT4Qi5M5YiiWdxB
	q3p0z4G/ZWfnUmdky0Elzu6CqhWcrdafuMKBiH0UzjXrMBF1WsSQV+aDeY3hzKVO
	xEXKkRTV6KNjNkAA+Tcd7H4+mAM7DrCWVvRm6E85kQrm6DeB4uDJrBJ1bKiCV4b8
	7aXVVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vt5t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 06:26:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso12352265ad.0
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 23:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578404; x=1784183204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=;
        b=BvQFJSxSvhYnyTc71TMsJ03yaggkDLpbcsC2+XZwCU+yJMJ3lh4WyaCNkzNNFspLnV
         LnuJOB2tlkYZ47Slx07OycRZDAYuI25CWA5aDmswbkqYZrgQtXUVCLzRB+GuSFfQlKUr
         mPfZEyXduxod+cgPqBN16cEeA6mXcVBkMBHM7S8hsicyaCSGmjbH9+KX+xOm93ELg/dL
         2DltPGrUY1QFcyBJ412L4wZK56NwYweambtVgR1oAtiMgQK2ekT2p0HBX+1aZZbVumPw
         8+cSrGMol4PpH4sOk3tBNiLQlRin9m1WWNS7/dy2EMRq1Ia7RnoqVUMWoE8fXp6m8xO+
         S83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578404; x=1784183204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=;
        b=N3eQ6AaMj0tJw70250NvaNaP7mtenibHjTtW7+/5rKueGCAsbVxn24Hb5dZ3mSQNOG
         Lwjm11tlZ6bms7nb1xY79laRnpYbhY4VqpGb25Iqr1eAsHIIDB1vfEVATiMs+RrxdgTx
         BD3o5t3QMT/Lje31YJ1CyMqtF3M9RaO/iWeCetyrmraUIvwARHHoA64ivpX6oHbGQVN+
         ewlVrCTs5v8PywTXsVvuXSIs5gUxNPmmd0pSU7Ed4md2DyVa+/iS2O91hCkzVdU6Blso
         74SBoocUC+TcYNwIz2tn3kbR1e5rOCNpH6GKfrUyHCwgY44Y5Ku+nKwIgGJIXIp+L4Ng
         Z3Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqXwX68NuWqOxHZwdUQP9h97t8UsUSB4cDEnuriLz1D9EJ0Ubbnojxy7Z2ty6gd4Ls6Cs7ZfcnTshhd@vger.kernel.org
X-Gm-Message-State: AOJu0YzMi7vZkRfLEO8AFT6kGta6+hSeRRQh4gFC2fW4zzH+8MhU/g1i
	/Qz+LAQm4u7BrQuxjYQUHY6iQ/PmgbjAU7M896PvNxaIBtllHtoO15hfyKMYQyunqjollqsR3fc
	JUsv6AGEFzpal8FUJgX1SLhSbl+6uvLEkTSFn2lQ7TA1bWDZsBY67P/H5t6vFT5BQ
X-Gm-Gg: AfdE7clzJnEmBgBxVHDVeJCJQIVYO1UUQwL9ydpooQrEz3vBCLJKY3ymbWN6KvE1JYH
	kIvBJi+fKRHAQ1Iu/jQYvRjQM+HjwjVSD+IXJFZKcgid2z06fUrzzhwD8ShqAomgXrM0jOz/6Qs
	7G31Bw4wJTm7RUkJtwwPBqehp/4Qcn9DGaMvp0a8JfRkseTfW64BT/3RbNG0PnYXCXUvqVIxLFW
	fZhMhq1fgX6F1+OpL5HGRq0YxYu8yTGSl6vipE9HjkTu/xhQTm2ooU6gqiCwENdORb5E5olApSa
	jnDJsxwqCpvrqogYzUmw474zS/g8opFaYj4Z1IsmtTCKYeYj3QI/v93ojatdT137IAxZyKRt62v
	t6KQIwoMHOUZYGJ/zLs3uZlsQ+xUts0qAYXwedtaGfaKs
X-Received: by 2002:a17:902:ec87:b0:2ca:16:c169 with SMTP id d9443c01a7336-2cdd8a8446bmr16030115ad.12.1783578403719;
        Wed, 08 Jul 2026 23:26:43 -0700 (PDT)
X-Received: by 2002:a17:902:ec87:b0:2ca:16:c169 with SMTP id d9443c01a7336-2cdd8a8446bmr16029695ad.12.1783578403107;
        Wed, 08 Jul 2026 23:26:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:42 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:18 +0530
Subject: [PATCH 6/6] serial: qcom-geni: check return value of
 pm_runtime_resume_and_get()
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-6-e85c6ffa8ec4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=1832;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=aLKsWDAwz2GNv0and/N/QxAf4HluEjygqicLIneo6A8=;
 b=Hx8QUSLFIpbdbLJRMgaFZQcfWKI4SYHgH+sbG/r5N+1eUuprXpiRnOv/uNONREm1aauXqcg5E
 vvr6LWy+bUWDhuqdCnrvTyC5LuYYyp0okWLAMvA7Bc49vRU5kMASEqP
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: p_dHN7CgTcq1VNbUsXUam98MwB9lmCrb
X-Proofpoint-ORIG-GUID: p_dHN7CgTcq1VNbUsXUam98MwB9lmCrb
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f3f24 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=f88WUc_itYv57WQCX9cA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXy6WVpW/vzTOT
 tycTwwmQxWzV8VhVtYZyI1EEQUErqGCnaD/Ybcj9hz0CKg5ptntR1Di4Vyp/88RRORNS3W0fNcc
 +SO6L34TGPFoc2jg8epCRUmHoJkUunPNsfSkaZ7Bt022e3S5OalOLopEONF6vGa4btaWEmOmqxq
 a2NptW1uibSVTqTKEdFb1V8Cz1//EAYIVEwbjj0bgbAB8Epeev6RyV/wNQKz2pQh+144Wi7d+W5
 vPO4+cFOngkzj0xoowT90DHEvPzVKq0cfIJXCvvEMPH9Rhgzu8HR1zH8pTJHvyCq+qQ1UGW3bG8
 Mr0v4xiF9AaUmIh1bd3bqPLy+xDFo+RqV0iICv3a3eHBapYZ6xfP6Qv7CnNC1GNYK92wTtZEz2v
 o/hX64a568bZUhWHrOTrnZhbaeDWB1jmFiPJMh9M93CGK06nVnbCRjxbex4V8EbGB0yqAsRPGDP
 a9Ag4CIDro6y22PCa5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXxBL3b4lDp2zS
 uBbSa8Kxd90QQcNNlvQJjNYNs9wUJHmgDmNsxJiQFB86sFZa5KwD0RcvxBhWQUDU3mTiSeOri7N
 TJW5402fWRsRQZ6LBVrezyFGIKgGHbM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

The .pm uart_ops callback calls pm_runtime_resume_and_get() but
discards its return value.  Failures such as -EAGAIN or -EACCES go
unnoticed and the driver continues as though the device is active,
which can lead to register accesses on an unsuspended device.

Check the return value and propagate the error to the caller.  The
.pm callback now returns int (since commit 6ffcacf023cb ("tty: serial:
change uart_ops.pm callback to return int")), so returning the error
code is sufficient for the serial core to handle the failure.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 17ab8acb3b8e..1ed09ac0af0c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1727,14 +1727,19 @@ static int geni_serial_resource_init(struct uart_port *uport)
 static int qcom_geni_serial_pm(struct uart_port *uport,
 			       unsigned int new_state, unsigned int old_state)
 {
+	int ret;
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		pm_runtime_resume_and_get(uport->dev);
-	else if (new_state == UART_PM_STATE_OFF &&
+	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
+		ret = pm_runtime_resume_and_get(uport->dev);
+		if (ret < 0) {
+			dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+			return ret;
+		}
+	} else if (new_state == UART_PM_STATE_OFF &&
 		 old_state == UART_PM_STATE_ON)
 		pm_runtime_put_sync(uport->dev);
 

-- 
2.34.1

