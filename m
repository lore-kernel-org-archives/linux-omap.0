Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849F37F00F;
	Fri,  4 Sep 2026 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496450; cv=fail; b=Amr+g0blJHqC7udJKR958ls4y/8nPbjXxkxZBe72rGnmOGajxi2M7r/6YUJwrJ8ckBeTvGCxEhRatUlBRi5Uik5+TPjYu5GmNP3ef+O3rR6uaLigZbZFDF5OkE1dGHdearaM6IRLr40Nwa7x82hSQmPt4KFeRESsH84BoMqRM+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496450; c=relaxed/simple;
	bh=5zaltnXr9kUr0nM4chsdfXVwtGh+SzXknGjlcJ0YprE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVwWlLoluEm9WuWCcYSr/XJg4asG19L3Jc6FUxB+F+EIiCuWt27mgdOsdKkV320eHT6YK0a+y5nOFLuPqB2L3xzoB4PaNqcMA+/Z85gGfbatMTg7IE9CZUpzMyw/ElIo01yf20v+HvYVmYieAormWJFUPv4focodHfpN0jvx28U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=f84JNZRP; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OWEzgFOv; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="f84JNZRP";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OWEzgFOv"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842t6a01101474;
	Thu, 3 Sep 2026 23:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=RT3UH0kQJ0P/e
	JCVcoXFU5wF/HzNhyvZpDkx9m30zSw=; b=f84JNZRPd5UL80McEEEvBBT1zKLLR
	8mWZxVnzrjxurlNgiE0+UgIm9fg+ACY4h4RCK+vyQUaMHXsUhwdgY5f4mejtctXd
	Wo25+ta2tqQ+WDDSUD/yi1tZRN2FqIfk4i2KP9Y0IdehDhYUjh/EiCziP7+SccCi
	5iHL2nFQjTcHKXHRUQF2U0xYJt05JFxs/n+Cl890RDMwm4QHP6cF5WdLU3Z4uM6h
	jVcEWj/vF5HFERYj3/bepCcvHtdE2K4To7xxISNVlz1DkT8JL8gVShKCbT9R6ptI
	6u3r3F6G2bI0TvOdARz/HNhymjcF5lA0w3iQednXvTltT/xGRK9cLJWng==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8n3t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:34:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bq5hQ/x3nWEwD7TKCV65lAiirPyQBpLBQ3cW41s6aDLnaF4UIKbwixQQok7k/4YMPVDztPi0Ra8I3RDCnOsqhWXKGOxQJLSuRP7SpUKegquRdOltLmOVeoxsei0eOmnSgpQIJ/jtJ7ZXJFdoe0rQrVsqA77Vq7DnLROEo9I82kyyokBxryH0695u3up97kt8gkhIaKuIRsxTcs/I1oSN0a0c8pzBnd9wo2K/apf2zNN7MYQzlTSW8sRoBYEi29ntTzcekahmHaRv0eLwcP/kWM3N+gGaAbx3nGg6qVst4g6sLoCpnxvGFcRjzCzE1UXk0Y8Bz/fpGMKIe91n+CDjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT3UH0kQJ0P/eJCVcoXFU5wF/HzNhyvZpDkx9m30zSw=;
 b=F44jol/bEd6QEgsbcJ+oK1TfNaSGAaYFewc6YcZKccP2TRS4MLolT3JcDqhLKTk9GNA811FIHhtd5hHUMi16I3gstng/ULp3bMfwYUbHjqCG/pZuIir5UQyZRi4Ki7wSeZB/z9eQwAcdETbmgHQbcp9ryHDEfRCDyo70/7c7oUvc44yj2nXtGyKCcCp87rZ/8VbWm//ioeeZ1RBc41D7QAS5fzQdBqBZSca2z8WjTSsHx+zO/EoUwLIoCyKXCkkGYtt5RKdi9jNMVe45ZwXPTTHOuTWV8yj8h19mqFH8sxONt4Vq4LB+Le2lP8NI2bEd4XDKyEjbEYhXitgQ00PK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT3UH0kQJ0P/eJCVcoXFU5wF/HzNhyvZpDkx9m30zSw=;
 b=OWEzgFOv0zmisydXQ9Ba1K7WwsIE9ZGXhL4WoXHWwVJf9QbPf7tB/cJIPD24NyJJsS8I9VsF3ZQZJbbu/itDKSyeA1CKsIi7EQYpSETeM9dDDns3BSgx1x1bNJ0/UtVvsdgTMDVPT5U10Mb1kH1CiOPXHXLTp6/GRJ2aI39Ui/I=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:34:00 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::a2) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:34:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 04:34:00 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:33:58 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:33:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:33:58 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1G3831572;
	Thu, 3 Sep 2026 23:33:43 -0500
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
Subject: [PATCH net-next 00/33] Remove comma after sentinel entries in match table
Date: Fri, 4 Sep 2026 10:06:06 +0530
Message-ID: <20260904043724.2955444-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|BN0PR10MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec6af4b-8091-445f-d0f2-08df0a3dbdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|921020|13003099007|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dSxkknKsltO8PRbd0alMZM3b/Wioe1DDb50EgD8FRTp+M1VNwWdP9m6NRRF4yLomxDt/EAuv3DgOlWJimNJbNoRjNXhCzwCR5VRNc5QIue7gy34AdQrOpzMi8nSa8jYIqOr49V5UrZh4oXyo/fBFhsPSk6FElcVg9mlh3CWdKUxgV9+a6DJphBIJpU/DZbSDPmbTyTYrwBzngUa2sqlawhgNcfm5OObqR1yvdoPLeqZVZLbrIKV3WqoNkd97El+Zl6TErCKWYdwCsc6kRZ9vdseq0adQ33ox2512W3/XqwpcgMWuzgkyK6Tf/6XcS6akfeR6WJk+Y3srf8Q/jyVmL+lw//nnbhzEtKV7/B55Gl0y3dhLBgJHTWJ+2NEK6luOFDjAQSfssFYjnIjjuxzTWK0OLj96YdfI26OTlxmzKShWli53uONdElha6jF68zxgKLWcdKNUhW8wCUGk67N9s8en8grdpwWiktiFd7F4HRwo7mUciWKhDwDcRlOsE9OlI6hlSbNkecIaY/7Zs9r8c4g99lB9T9Q12M0EHhu42Tbp+eMBq9+MJb9eXe/iharxq46gt0QvLX5rQpKXV8f5738fZrNmLC5gIiT5DPdAQwMFrKNChnfCq6BkcyGXnigW/V2fMR76bMUCIJd5gfuX3YYbBBMhNXUgq3t2Ce/NDsyZmyTgdx0F9rjLJwKEISLhzoWkziXps4Wu7rvFsEDmRw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(921020)(13003099007)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SfsW+l6Ufjq4sz3XQ1Bvvrfrb6vA6AvIKLrBlqQDA1K5Uu8Vd6XHJiiklm9DRWB3AdTByHH+zBu95xFgZmPYHxn5lY3UvduCsV8jD0AgQWUTejq5v+/F9n4+0SDE1ebjbeOtwRK9BcPrb3+iypifhPxD69Enr9d5/l52TzhU+4+EaUmIA2wea+FLCKaPla+Nrk2MyWNdi94kE5uZIMG8K71FPQoW5vXtKDAzivM5foDkzLYGlB+UHA/U/V9/2JRim2C5dejNKJx1RlvmK/DxfmhiMl+M7+UPMM+nzWk9QGKoa9PmEkUauF6RD1IvrGgsc8703/d743tqL7zrgpzwfYwPsdmgIrGVSSlbL26bNTncn03RRZKqXPrV1BuabPMwapyuvrDti8aakG063YWa0I4CrlfWDgaOTy1VWqUJ881iRBn1NO+Ou3LFJE2Vjt3Y
X-Exchange-RoutingPolicyChecked:
	CAbb3Bl+XY/byuRqWhvqBrkhj2dc7MmGV6l4jLypw/J8V+1kP47t0JA8m05kjTm5W+o0vYeh/hEvFjS8e02woUR7BdA/NPmBU5hPvvFwP6o8AnJ3iFJeTkrEZDShGO2Z+4RTI6Zz3RqbUOytkr4zW4k3UCskA1UkIAB9ddGkBXspfRLpu7t0LMdeJO0NdCorEgZBwIJHp1qob3nuwZk+aThdmdcq2CaaP1L+UkWUoZm713pxc9TVHatEtePjU6buTXcNq7LavykEvVVS5R/vK956EEOUNgaJh3342PxvdE8mMfDhLouoTolDgs8oeX4wRb5m1K5lgm6P7flx4AI9vA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:34:00.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec6af4b-8091-445f-d0f2-08df0a3dbdbf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAzOSBTYWx0ZWRfXyGyDNPgy5mLk
 8IoJqSwEwZUIWUogxSB3Vf5BjzRCqCBQow9xcrg8ai+Ow7JwmnvnvaV3FEQlexRHnsmEpKqz0mq
 UnSEc20AQRF4G1dl0ECsgBVSy/uVDCU=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4a3b cx=c_pps
 a=TuEuCTxUJaX1tclN0RLokw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Bt1NjzTRiCgrIjd4xQkA:9
X-Proofpoint-GUID: wLs0pMu7OUr3Q82zq8rN0zh1Ul4Wq8yg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAzOSBTYWx0ZWRfX82fOd8DBmr9o
 j2syTGn877FLMLCiX9ccgFrrpLxHOj6INjVLYkM082IW7zE8FhMtWWHXJuID1Jwkybq8hgF0yLI
 vhn81y/h1mvoAHGvlImQFvo+m/c5NK++D3nS4s/a+wZEeoffqrVe/uAH3p2IcqIc5DQ+f0AMsvq
 YeACsRkHVzRfwo7b3YU7WdzFCjhnByCI8rIBBh+KHyig+zVVrSTna9wD4FAudorQdnOz0aFUagx
 +j+mWV1eCGqnnC+TM5AMvRIHKvX+spMzgwZTcBKparKN8z5qOZu59I37fFe6Osjjy8qoo5MGWmF
 8UpEbI2NQ2Oc5Mb2VLBRLulREn5YZyCHlarHdNnYAgbJZ2MFvS2LRt6wAuec7aG9ahyFaQKvjlk
 cqVxGYkls0CCf5ytJjivTZAWsDTWIbLaSBFkWJb5BJk9NuULqUb6vOn2c31o0MKN8JVLddu3h+v
 FV4Uy928E0oQG1uDuRQ==
X-Proofpoint-ORIG-GUID: wLs0pMu7OUr3Q82zq8rN0zh1Ul4Wq8yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040039

Hello,

This series removes the comma present after sentinel entries in the match
tables across all networking subsystem drivers, with the exception of the
davinci_mdio.c driver, for which, the patch posted by Geert at:
https://lore.kernel.org/r/e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be/
does the same.

Since I inquired about a cleanup across the entire networking subsystem but
didn't get a response:
https://lore.kernel.org/r/b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com/
I decided to post this series. Given that Andrew Lunn acknowledged the
cleanup of the davinci_mdio driver:
https://lore.kernel.org/r/abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch/
and I don't see why the cleanup is specific to davinci_mdio driver alone,
I am hoping that this series is treated identically to the patch that
Geert had posted for the davinci_mdio driver.

Series is based on commit
6ebcf5074cff net: openvswitch: don't schedule rebalancing if there are no datapaths
of the 'main' branch of the net-next tree.

Regards,
Siddharth.

Siddharth Vadapalli (33):
  can: bxcan: Remove comma after sentinel-entry in match-table
  can: c_can: Remove comma after sentinel-entry in match-table
  can: flexcan: Remove comma after sentinel-entry in match-table
  can: ifi_canfd: Remove comma after sentinel-entry in match-table
  can: m_can: Remove comma after sentinel-entry in match-table
  can: sja1000: f81601: Remove comma after sentinel-entry in match-table
  can: sja1000_platform: Remove comma after sentinel-entry in
    match-table
  net: dsa: b53: mdio: Remove comma after sentinel-entry in match-table
  net: dsa: b53: srab: Remove comma after sentinel-entry in match-table
  net: dsa: bcm_sf2: Remove comma after sentinel-entry in match-table
  net: dsa: hellcreek: Remove comma after sentinel-entry in match-table
  net: dsa: lan9303: i2c: Remove comma after sentinel-entry in
    match-table
  net: dsa: lan9303: mdio: Remove comma after sentinel-entry in
    match-table
  net: dsa: mxl-gsw1xx: Remove comma after sentinel-entry in match-table
  net: dsa: mt7530: mdio: Remove comma after sentinel-entry in
    match-table
  net: dsa: mt7530: mmio: Remove comma after sentinel-entry in
    match-table
  net: dsa: mv88e6060: Remove comma after sentinel-entry in match-table
  net: dsa: mv88e6xxx: Remove comma after sentinel-entry in match-table
  net: dsa: qca8k: Remove comma after sentinel-entry in match-table
  net: dsa: realtek: rtl8365mb: Remove comma after sentinel-entry in
    match-table
  net: dsa: realtek: rtl8366rb: Remove comma after sentinel-entry in
    match-table
  net: dsa: rzn1_a5psw: Remove comma after sentinel-entry in match-table
  net: dsa: sja1105: Remove comma after sentinel-entry in match-table
  net: bcmasp: Remove comma after sentinel-entry in match-table
  net: spacemit: k1_emac: Remove comma after sentinel-entry in
    match-table
  net: ti: am65-cpsw-nuss: Remove comma after sentinel-entry in
    match-table
  net: ethernet: ti: cpsw: Remove comma after sentinel-entry in
    match-table
  net: ethernet: ti: cpsw_new: Remove comma after sentinel-entry in
    match-table
  net: mdio: bcm-iproc: Remove comma after sentinel-entry in match-table
  net: mdio: bcm-unimac: Remove comma after sentinel-entry in
    match-table
  net: pcs: xpcs-plat: Remove comma after sentinel-entry in match-table
  net: phy: nxp-c45-tja11xx: Remove comma after sentinel-entry in
    match-table
  net: wan: slic_ds26522: Remove comma after sentinel-entry in
    match-table

 drivers/net/can/bxcan.c                     | 2 +-
 drivers/net/can/c_can/c_can_platform.c      | 4 ++--
 drivers/net/can/flexcan/flexcan-core.c      | 2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c       | 2 +-
 drivers/net/can/m_can/m_can_platform.c      | 2 +-
 drivers/net/can/sja1000/f81601.c            | 2 +-
 drivers/net/can/sja1000/sja1000_platform.c  | 2 +-
 drivers/net/dsa/b53/b53_mdio.c              | 2 +-
 drivers/net/dsa/b53/b53_srab.c              | 2 +-
 drivers/net/dsa/bcm_sf2.c                   | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.c      | 2 +-
 drivers/net/dsa/lan9303_i2c.c               | 2 +-
 drivers/net/dsa/lan9303_mdio.c              | 2 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.c         | 2 +-
 drivers/net/dsa/mt7530-mdio.c               | 2 +-
 drivers/net/dsa/mt7530-mmio.c               | 2 +-
 drivers/net/dsa/mv88e6060.c                 | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.c            | 2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c            | 2 +-
 drivers/net/dsa/realtek/rtl8365mb_main.c    | 2 +-
 drivers/net/dsa/realtek/rtl8366rb.c         | 2 +-
 drivers/net/dsa/rzn1_a5psw.c                | 2 +-
 drivers/net/dsa/sja1105/sja1105_main.c      | 2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
 drivers/net/ethernet/spacemit/k1_emac.c     | 4 ++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 2 +-
 drivers/net/ethernet/ti/cpsw.c              | 2 +-
 drivers/net/ethernet/ti/cpsw_new.c          | 2 +-
 drivers/net/mdio/mdio-bcm-iproc.c           | 2 +-
 drivers/net/mdio/mdio-bcm-unimac.c          | 2 +-
 drivers/net/pcs/pcs-xpcs-plat.c             | 2 +-
 drivers/net/phy/nxp-c45-tja11xx.c           | 2 +-
 drivers/net/wan/slic_ds26522.c              | 2 +-
 33 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.51.1

