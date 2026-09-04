Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE02D94BA;
	Fri,  4 Sep 2026 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496743; cv=fail; b=WnnvCeyZCQrXWB9Rgn1hGahCf8n8TF9ZO6NRGZ37mDP0C0wMhfkVXsvmvWwvJUMTN96u8ZEhqWSpuTJ7exr8CWkoAig3fFFaePlDUCPv8hI3FQpoEX55xYt1w3eZxgLu/fyyurTh+VN0JQ6ceDea8mw+LNyRzXWgkTVuk5zCfrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496743; c=relaxed/simple;
	bh=nTXPIqm0eEtOVdtYhxXIosqoxkIWackJ457P2Qw1uSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umtFuusbsbPOWa7qzes0tL/KVX3yx9KXmNLxFI/ueS+ajYMOILT398OFhfKcy2+Psefnqp8WcGNHjFBR5vxwC7Lvh9aJaUtJ70rnZc4xOAgMrr1Bmu0YD1PYuV3Gl34VlRiYMmEybzmKl5Pf7VNbUaLPPWpdFUV6JpfuzKCibKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kQOmevb8; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XhWk0cHw; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kQOmevb8";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XhWk0cHw"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT4w2586805;
	Thu, 3 Sep 2026 23:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=kXw/urcGGCCopT5YEWWX8XNd/pLmTURjfdSCszUau
	EA=; b=kQOmevb8j5o43I6j5tfmocS29EXEjWGwQL7ie8V00ls+g7BrrV8gdEuJ1
	IhwAfbX3rDQsoVpHuMX7LBmHJY0hptWcRJOxx7EmNRJ8iqrTo7fizLxeLcURb08s
	efGvRSVXpaQO7VPqhQ5aE2PQhq88k1WmwhPBxdLO+/in0N9JfY+Nt/3T/nvawIG9
	ssQwhZAzuM5YWwGt7vOI4Wx8WVqnRPITVqNiKVpbpqO/E/Nn4C+3L33LOrptyhza
	tybg7biaD97FV+MFnmgGTlmB6EGX7H9CBoxAFzWXmtvymbVgB8oIbAHbLLvCxkee
	d89qQre89z+6XJ+8VOcCXDpb7X6rw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs8xy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:39:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGO4nqVu6hYp2zJxJxJPRbBStc+FK2hRvysjltOT1XGL8Azio99IJNcTYch+pXlDFN4DL9kbw/7zI1M6OrYfCX1csAUzGZRpnPVT8foyn2L6NwfutdQYMDTpS/mIyKM23FD4mYAuFVN+kWAjv+3MEREJh37HMtQiN3FnXDe3sFkdJzY9ehKRVWrfmVmrMzbVECzY9c1w+Fnf7X6FIFG/yO73QzoN65bLYiQYLkXUtUFWCjcbMxBeDE/uYQ/JaUykHkjhPTdcU+jLQ+1P6AITYecyRWrv3uxmDR/3IxAbXg/Nbj8GMhIFJeOVo8hiX1H8Kh4s4zhAlx0jI07GpNEF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXw/urcGGCCopT5YEWWX8XNd/pLmTURjfdSCszUauEA=;
 b=NcTNw/OW2emEsLiZ3BDtp5nrTamLxcxN2sJI/6KS4IXyaqhLaNPlYuVXfJasHiR94hwN+y9v3FdcXl6K+/ymnFj7CfvPHyc6GGvXIxCSaYZseZMzfEdZoCPe3+IS3kc24BsNLH3qL65rmggFKN1FsQFT/YvF+YvFOKaq0Wz+jWQK7qXw15d1OrFCBOvcYfCE1RornSO7QovZJy7k1uX/aPc76LqhkmLhvyXF9nrHCdOGCNieuZwLQ+CGQW2gT12qQ9Jf5dpWJtl1/3yyEbdJ/6tHYTzOaRBYjcxgBt7GeqgoIuc0tFOSC+fmmQFPwdgxHg7gDhyY+w8keAE343pSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXw/urcGGCCopT5YEWWX8XNd/pLmTURjfdSCszUauEA=;
 b=XhWk0cHw7ZrY7V1i0EgYYA6ZoIplLSLPY8I38e8f5f0ieqLIM0vlt+C7VA4RkYD0Uf0IYzfTQZFbXQkzv4xedxt4w4uHnmsEp6HXzL5mJMaG91YHWPPcBaVYIdYD8NIbQzP+sBZ51Jl52g/QbPgsThPDE6D3lxqapRaBJpQWeIQ=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by PH0PR10MB5779.namprd10.prod.outlook.com (2603:10b6:510:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:38:57 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2e) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Fri, 4
 Sep 2026 04:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:38:55 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:38:50 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:38:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:38:50 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1a3831572;
	Thu, 3 Sep 2026 23:38:36 -0500
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
Subject: [PATCH net-next 20/33] net: dsa: realtek: rtl8365mb: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:26 +0530
Message-ID: <20260904043724.2955444-21-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH0PR10MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3a3136-7698-4f81-c9ff-08df0a3e6de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	vBMQrGz90k4vCjMr5YWX4fIBvuM4LQkpM5DpoF1WoaffBZaV4Oi8ABEW6oIsGUN2+6n/kfKgpnv8kWQCs1zYua1t4mEANXF7lMQjhlXRWrpsvXn0vZeg1Jl0itUj3BxTUFSVXSaTpJ/LUWQMKfuQsRDO9heSK9m2xy8fPyVMb8w4cHZsLBcQ00oATp4xuZc4AO/Yz5xXL7qrxzqYIQeE0Kf6p+zeFa3+4lxJu8RK9xxy/5kKpogJ0HImR8FEM9lYhj7+RfPW0ivIMlYxZo66mpbEdV2lOMXflYtJQahGu5YrAkCsqrMlFj9MkSo4Le2XT1zi6nPVZkH+7RY9i/OGzQfv+zDhI8QNso/r/AVSmBlSQoYt8YuPagEDYQKDOfu2L0zMqfcyHrlZiSyW91eZpVRjAn569ThCBi+xSzCG5isJQ0zIBKPtkDi/iUSO944i+HOAOIYXAH+HAmb6EwuskxTzp8oMUXTyx4DijfBXua3s5mEp00xpQ9igVp6JVmIoqYyvmnSqqLVlRgfCzBgFHvGxGoM26ZPQ9NJ19BzxT004vkpCBSZoE4N0k0VtEcEdOY0bON6G3PWAwMWy05iZxy6PNEsoYaNAu0PO/QXDmxPOEJX3q0Yve4MGpt4VIR4NWT5mnPcTb/2GCOTEpNT+lUWqh+3dn3SeusAZVNcmUERTfy0stHOMgQ16JkXAYODq+9uMlNCqAtzRFe/aV9jrsA5kxy7Fl4Dm+xOWF4ZOP+OsR/CHVkSVKqxSu0nGb2Sa
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J0DOATVyI19YUBMhd23tfxh6L6eXs/USgXoYjCOqPKSm5hnr+V75DAf9glp3vSNRhf6cMMuWtx7iSLDFgQfnsBungo75PiAXgaQew8tybCCZzOYiMZJVm/mhN9sokrc0u+ZE6HYWYYQpdNgz6VyvHqiEAeS0101IX4fmbyvueidU1HA3GZfiTaGUK7y4D1ZqQHuWXPlYHscLCH9vC+Z6U2H8rvV8+8c1Quy+HS/mUud1zVQFxBrjbpEL/6dx22Q1FdnpDVAUKJAxTM31kqlYKhrBAwGSHdctmisX9h+9fENvHMavlIoEt7e+AHsyMyFChAD/Pu2MFM5H4Csw9sDGkPGIjKNwCNtp3HzJTPJWk1cqN5GQbovedzihgmAIptpKeg+5vixqdPmVdcbbCy7NQAPoGrePM34rof8oRv9swrXDKyFFM832u/xDPn62f5q/
X-Exchange-RoutingPolicyChecked:
	LJMw4qMmt/IGfCAG1iFSV+Tvkh5ilG8mSQTjza3WG38Q9jLmJXjdu0+FMt6ISdA4W96O5X4gbKTtqnEAIdAYGBgXeFJMaP/5TB+vPiyUIgiJGuVWNvFp4It12+zVxMnxDmOc2RQQ90a1YJWooD+YR8qIl/Pq+18mxIhENsXRp7PGszKHj7XjYkMbhk+6QhJMT3j06Z6oWLt45+2tEjSfRinTQFMRxd6h2DNayT8XeDexEf/wshqTfVn2l09uwX/lxQQcijQneCXXRJ1x8oBtBUKIDoGiE4Jpej2dtU3kFYD2CNjXlZ+iOQOyuvn/tgOGEjr5ywpP3w37ti7XCvAdQQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:38:55.6863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3a3136-7698-4f81-c9ff-08df0a3e6de3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5779
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX6TuhUoHviXFF
 0AG0vHwZ9TD4i3Wv/CEACemp3xCWxGnjgmyUOQPgQAfBX2Ko67c3rgyjwc/TPKeWgIc6EEcDD1E
 1dYKGiDskXzt0hdo5cva75ZwrBiThFs=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4b65 cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: s8HxYC7Y4TqI5ib8Wbv-UsSWzdjT_paF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX9iTfst2GHGGd
 p0/s7Yni7rYfPDViwpTFUykS3gPyuENccsxjP7u8dGphV+BDth622iaFB1bx6x6oQ83T32TvTEn
 P1fij/Ikd4t9rIcLlQ9uGND4P6764kbFypN9fPHnpz767fd9s3j7A8XtLttmf7JwHPLz0z56Dpw
 wAQIYVBvTFC2+c1iWYbXMOFnjKhT2EEJprgt9uS3+uF2+ZNPFqCe9BcP/hwHnVQFhc8tMYJuE57
 zRQ5RGFum5NfszvA2BdDBrhfC0fnpzYO6t/PWfPE8DBrtKG7VTEKKcJxsNCeMrhQiClba0w/mAy
 WyDAvfP6IW5Xg9IZ7DmiibHIozVVx4ZYp7XJnkHKNMu2aZS3H8BjIBuEORJxVwGuNO1GZuQVE4h
 R0lRLEDQu1Gyw/gsjA9fo+tGfja6voj95ymjXvxddz9kSYnsaYVj41q5hIjBbrYMRypLc3woL1E
 TueZE64R43B7gaZ3Hdg==
X-Proofpoint-ORIG-GUID: s8HxYC7Y4TqI5ib8Wbv-UsSWzdjT_paF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 4c305756116c..f8220d832e46 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3352,7 +3352,7 @@ const struct realtek_variant rtl8365mb_variant = {
 
 static const struct of_device_id rtl8365mb_of_match[] = {
 	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
 
-- 
2.51.1

