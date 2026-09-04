Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EC3C2B8D;
	Fri,  4 Sep 2026 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496504; cv=fail; b=Bn6yS4R5aXoyhSSGmRFKe0MGbgKz5Al2DlriI+kj2Bp2wM+w8KIJBIopNZCvR8M1M1BVP8eJSKO/+SrrDniFiXhxxviSrE9lngrI9LLN7tujMLzVjJPioahktd1Ytet/e9sJojrS0xldFP62nRAZs1mGNn7YL0SfOAIeqCA9/xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496504; c=relaxed/simple;
	bh=jLPJP7V/utXL8UdlH/hFZA1fY730HzS+uDkmX5RMbx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECl30fe4I2E2cm2aqrXnGK/AVqHvAYuCHHK4Fqd8isJOUrl3YD9D2oYIBKdnsOFTnNqdY99iX4aViUQRrKB7B8wfv+IrLmr7+kkQmhXx3CbcWvydOiACk6LjYgWtTdMM0UFGjPGCUmv7lfX1+jtemPkWL2cyV46Y/aFujSl1V0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IVcC+fWS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G03DmyUu; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IVcC+fWS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G03DmyUu"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sbJr2373861;
	Thu, 3 Sep 2026 23:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=OpWl0INmzag+lFPLrsa4I8YuhftsitRg3h8swra/a
	9k=; b=IVcC+fWSskK1K4nyYTdtQFA71k6fBKvfKD4mwyXwGQcYDk0B+szT+od/m
	4V5MQFIDZG5/D1enoNfJMPkplEFWShEci+U20Zjgx3vK3TxiWg79rHwZDOtAM7SS
	vBFIyizskJRBmASPZx8/084yD2WEowY+x8qn/O/bejGGQRrBfMyT+/c5xdxRTb0Y
	CeM0BAPTbey3dN/NrBYMnUXMnMxRFhq/u4mWyZjp7b+3kMqnoAzBl/VMRDBcBQay
	XBYOUYji0HfMpwVhdSP70WZ1eWm/Zl4ymn/bhsqUaa1V+xQULOZ6zPiIrP/Fm6Mx
	ZNPBjF9dmdrf4Z3FhekOvABS/PolQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jexa6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:35:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhGzaXvacKNRlIMBOClSJCfvEOCk2TDS1SilzAJdXLtUU5SnyrOabVUEiEYMS6XGvkwZh4mTabS4YfOLnJaAqSZ/4KghmMYOd3AeZJIB9HKRreuCtZ1L67/l+9N2E3dsVtd4XQa713hW1eUrxZvWCnIS9OPs81SsvlNS516Nolo+vFigyESBOTn19xKjgVzZoj8UAqhGsUiZurBIFotO3M1PU98x6iVibB9oj0UvPu4e3b8t/x+0wEMWYZ7Q/POZiZWlnnmZNaykp5zL585iy+RqthWfpfK4CkFFiHqppSejw4Reqad5JV8ktf+XgF8S0r8UodDhDDbtX0IMAVZJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpWl0INmzag+lFPLrsa4I8YuhftsitRg3h8swra/a9k=;
 b=mIxJN8s2bwOFLWjUW0Qd1cHPS9nfmqdT1KdNutTmXReaEK5ltovtUnyxTYE7aEGkvCf51VlT3yER3NT50MDRbqcSL1HrluNbdzqdsprZJUWpAEcl44fVxTYOh+BPSsyKM+9L+JWyTRPUGztVCdLFcTWPSydT9AtqqgFiiWbUhu1Ba3/XFP+w4XSbuK/wKSjjOKX5j55h+NWrFj5DFVoywoAvzHLxhpW9nKxBAmpwlStcnBFuESUjBqw1aJnTxOYfKWfAWtwPtTqXxv5yb0CkCQbCfDl2N8pHrPsEMnIQzshE36i4htN/y0JL5FIAjdGK1PD1hTTfKZDASSgNPZ3QeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpWl0INmzag+lFPLrsa4I8YuhftsitRg3h8swra/a9k=;
 b=G03DmyUul6NhwvXhfoGp1WxVBLzQdMTJn1DHCpY78NWn3NUhzMfq8c+sX2ZVdVOllDpY85paXD8xq3ly9sCrwOoXzBGwd5/9xHlRrEtYM2GHw2QaF+C2kzvZrxxB6aMjkxiQEoqMv0Qjfv+FaLn9EPHujn7Cpdsin1E6XuUyuu4=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by PH8PR10MB6358.namprd10.prod.outlook.com (2603:10b6:510:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Fri, 4 Sep 2026
 04:34:57 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::43) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:34:57 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:56 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:34:56 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1K3831572;
	Thu, 3 Sep 2026 23:34:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
        <mailhol@kernel.org>, <msp@baylibre.com>,
        <florian.fainelli@broadcom.com>, <jonas.gorski@gmail.com>,
        <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <kurt@linutronix.de>, <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
        <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
        <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
        <clement.leger@bootlin.com>, <justin.chen@broadcom.com>,
        <dlan@kernel.org>, <rogerq@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
        <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
        <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
        <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
        <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
        <lgs201920130244@gmail.com>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <spacemit@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH net-next 04/33] can: ifi_canfd: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:10 +0530
Message-ID: <20260904043724.2955444-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904043724.2955444-1-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH8PR10MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: ea40feb0-a8d5-4e5e-ccc3-08df0a3ddfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|10067099003|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	NpygSPcFAMjnlEhJjx9nb2Y5tnNYwcKb/fvTBXQzRu2BjMzzTn96hyJ55PI5YX1DpXqLv+fc45FU2KweCr7ed1OXpadc6xogjVaA6bHNMWDvhyNv0HtuK3lJgMekl00gWXBwwY7C159Q1D1JXwcTba6arnHC2FYXpcZCXYq1UwqjBwHZ/7Mlc7pAu93kWTomR6EIHRQXeWYrhlOiSNcdE7u8m/7V9ELt4XqWNRwHVXekBXK4IKIYJ2Ckbf8QyYyo+NVF6aeU5f9xLMFmR7znbvlL/jmdnnXO8fu8/rIJfRYVLw+gF0jX80yvHP4HYjPCOV4RJtckxUefOsDvpKHYVnUKqzX5AITWqPE62AMySqa6DyeVI/TdpFl9SySVlJuX6/p0vTag6JpEqXYQahhTXsEqrhxgFA2gQro17BzC3MEDtXaG9Ks3+cotR8fYvo3Fy7EIcZOQ7txNSTy59h/RhR1GZFeT2XqA5lcfu5gRENwFt++xmPqSvAJFm/HcMkgI85rvA9NiXnGesWX25Ua0ck93tKJmQYOcO4NydIAd+ljmMKO49lQHm8Knhed5HN/VdCULqzFE2IaWz2WU1YPn7qQ5hK+tB/rLD7gIAjqvobUmRQgNrUvwFZdYfsYNzWXHVWceU2aFHsdWZ+DAa6LeW8SbCPLIc6rLf5SjI0VTGIcPUIW2aqH77BHLYMoJBsqR3hORiREHVYQE7C9jVvq2Bu6Mhv1k2XLLzdSRfhFJvHADeNsCAQTcZrj49pZlw1S7
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9wRw+3rgvZbtWCtO661gShVqgqrYGzJggx7ZYlc3yEqXLYRdnZ0HmJhXmsRrSciHStOuhRlpaAJlyUZ0/lHqmHoTcylvXqbVMK/kbTBiJmHRua5xdQgNKbx0nqs8ba4eaJEEzmAxSyW/FXlDcc1LI68IpgTWHPrEZsiUxSqLl4ZZ4fRxJ05WHa7DDVTU2wzHVr90HojM8i7oEp0iKAag2pvLS2vxzxMDPoV+wdFzTX/045Tzv5JKoTID0bry4AF+anB0nJQEAZyE6bXl/0RSD5Up8XLnYJ+t8le5kLO4T9U2gzytxNt4hxQV6srSkNwEHxusu5+a71r45EvbZyzS5EyVUO2p0IfWuTMaRg12iex3NQD1EppWkL7KpwVuQ4MIZxKL3m4hNFaN/SrqP7rq0P3RSAkbI+cpszV4E0NmuWVD04jBrPzdnT8t+FLqVQFB
X-Exchange-RoutingPolicyChecked:
	fYIy2d/IkYfI0DFLj1kdEVynji6MzC8oraE0AjaSs9LzXb0183jVAGY7IfIwa+qly7pawtdTImIMN134rlfQhwmxMAHhnKXN71DdeBSoCTOXCYNFMcQEa3E0E7qNJ/tUbEhtNsIPuPBU+j5Xr+A16d4990ljgu61X7m6LS4WqB+oEApQt+OLr5SHhNi7c1neFC2Z+gjBm79ojuFVpMqqMaCrmrlOgYMcqOzJVnniZgdDqcR+eh/wt/cJdNT2WKj23jgHsXN9GfdOnS5cjEI8JtQrjWfa+0+I/VH8Pkr+3vSJXgzf73xj5R9D6WlFLM/q/PsSVDv0JWnlWAbTqQZ9gw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:34:57.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea40feb0-a8d5-4e5e-ccc3-08df0a3ddfb5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6358
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4a75 cx=c_pps
 a=F5APu9G2MQgGAPAZFPwQAQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: YmkNNXJ-SFytkPpMXiEPwdyQe7AMaFOo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX9BUUi/iwOGC8
 dlVY8cHiN+aSCVCSQE7eNZATsg9E6Kzs5MK9v19AcaBcGo5rZSEgURSilJBfvxr/yz7+vPtX7eq
 dnGr8/jAAmpj57a3YAiUCqifC3pgA5wheKLoGzw+wrrxQ4tSYCtbl9zCSCV+hViUfKa556jbvbB
 XbAX2xDhtQvN9iHVcABjS2EYHGLlPSilVWYrCBwsGLsO0P770tDhO6z+7+IqMoM0ii1+zJPwB1w
 d6K1Xi0IQJf0LOiyofF+aYvN317RL0qj0ALaID0xqdGxD+huCpJRIKBIIaXMoCy26ZHrrCcUvrF
 ad3JwfU6KM1G8nRanxsa5cXLS3xJbBAFWDNdgWkjCdvKnU7e52PaF8ccd2F4mYOqD93UhM74VNy
 WUZ74PpBXfCaAjq8ikfpzVt+KAehYaNIZAlba98rGSTVQaSu4GlHiszwZZy1h9CnObs6+g9X0eP
 pRNJiRp7M485pDBX6PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXyLJctDaaeagh
 Vhdl3EpEbkfhb3aigVkK6+epOT6pf8AaPd7vsjw/Vor44t8wvrLq0WHYVcbwZwZTbLM+x+fWt/S
 LI5hBENj7+Bhce/KQBZXNZAqogU/loY=
X-Proofpoint-GUID: YmkNNXJ-SFytkPpMXiEPwdyQe7AMaFOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 0f83335e4d07..9eecfe5a87bd 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -1044,7 +1044,7 @@ static void ifi_canfd_plat_remove(struct platform_device *pdev)
 
 static const struct of_device_id ifi_canfd_of_table[] = {
 	{ .compatible = "ifi,canfd-1.0", .data = NULL },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ifi_canfd_of_table);
 
-- 
2.51.1

