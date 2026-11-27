Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775433;
	b=hQCwJcFnx70aXBx1QoBzsWnrEvbQYAx+f15YtC487O1p3P7iqTTttC3FCMiKGKV5dnFA
	 F1vXnQU6bmPQr/5GIXC0NAxMPBB8nmdZYdiWxl2/+++SPWLe6TnqLD82aNZCNUYKNALCc
	 1sFZzDz14fHJIEyb3vELVB5Ad5hxAJVyqMAUU4IQEgONu7B2X74DUs6eIKyn4KXSM71oy
	 L+CPjnjTjKqzgn+SKLBKOZWVDPsjByDWFc5tOKV1WKNoaxszXNoFN41a8cvdiUo7vjwOA
	 eRI+etrxxAiFY8WpvIPJYGwc0gMJ66p8/f5Gtvb+LzTfQDs0KzD2oQ69HSO5B4PN+PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775433;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Reason;
	bh=wfh4b8sTzieKcfg55CFBoUIehe4p9sJ1Y87YT+pyvqA=;
	b=OyFZTyI4UmjRyMCYF6o20Qrz2gKL9q3C8WvDQ3pn78f4DUqy2tn834qtnaz1ZPIrxFY5
	 PBogifQfNFR21nRfG5Og0bC6vwmBU8vM+VF9y3l0We3E33yAiUMy1ZS6hupY7SD7PzYdF
	 HmpEZiRRr2z3Rhp3t9d4+qGgfK0lu4cf8UuKo/d2tdklfTVMvyqK8ZCSNyjTrj65LsW4+
	 v0AGVwJIfDHWYlJwsJaRyEstgagQ4lJpfvHHG9FUf+4R5d+gAIujjyB/plGYEQNOUM9oT
	 EGqnvWtsmO9AkwCLt7a+tRRIZVv7xuBEdLuXfc3D1bv+wyQYBO1adYQMMj1rv2s1pRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=KWTtjiiN;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WTf2frYd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE29606A31C;
	Fri, 27 Nov 2026 10:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE29606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=KWTtjiiN;
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WTf2frYd
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARA93th621609;
	Fri, 27 Nov 2026 04:30:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=wfh4b8sTzieKcfg55C
	FBoUIehe4p9sJ1Y87YT+pyvqA=; b=KWTtjiiNz+iXAK4Ovc6KyWt6000VQnWDu6
	sq5MoEKwjRqjo191VvaBhhyejSHtLvRjmcEWpsMP765H9zmmvYySuLjtLstBgLki
	+ggWzv3gBLRqxYB5fJ6LI3L/M9tgKqWlU+wNwa8OQaUcefgI+KlthtKiq1fM58DF
	EY3Z0tXPGLm/4dKc9OCEeCMMFoiFDRnsCfitdxeE7NDw6KtYCK1XipW0O+N2PemQ
	vMoKMfjXLAUcGc/imNd3AV8tvHAfnHHdFUwJzLFqhXsTMGSEg0CUj32Z5wluo5wB
	dfJBVWppG2Bk4DmO+BApRk6GvAa88FlMxugnkDASTF3VCT57OlNQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022108.outbound.protection.outlook.com [52.101.53.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4j519jdd56-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 04:30:21 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm57LH/otVmdW7VraMfWB2IXSTWlQDa4pv9TR8UtYZPrGpJZ++vtkb0ACPdNTChNsS1ZpnvzpPjNKmoKCy3XOpAPMRR/dNhM3j71tgIhP0oBkkem5NeDJgMBu4FHLa2eTbLOKxjgTTMM3D0sQ7vq080o+kSePA+XFxcAwvGh0XAjiBQ4AsMVOHCv/j/odsHjlXdu4dORlLVn4Md9uoKnUTTxsltuPrthDXspJpT9wNiDscm8MpHkvqj6tCm3+HRWNQaw1Ev5vY77WC+6K2SVuzDqBSozaFgvTA5QeR9XCPv+EEKRj1jutKUEsDKQRQ8SLzuHLVnSq+uub0dXhMl5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfh4b8sTzieKcfg55CFBoUIehe4p9sJ1Y87YT+pyvqA=;
 b=skaN1PIXLRDMkarZyyc8Kx5fKMd9P4UW7+IOksabyWkQX/NdqjWq/HRPUHg14nwzlhzr4TdRq62ZnuVFIZDYaqYOc4M9Mj8kGGjwiqpXTGHeOacgg5B86WbNV4ifSvzkQAn/Utr/mcQk1WTNT5Y1dyT8obiNsXzIvFpahv6qxdzI/QG3o2ndHrYYN61MaX0ZbFLgaLJYz7JPKfw+1HyD8LBYl7UXIH2N81edxDkMxRoS5cyjVyg+pHAk0aT4GS5lYxhEc5j7EQ1guNi3U6yqZA6KNM7y074pua/i3k+30AWsYFhaVgiNVUxwIqEk5w5xFEFmN8aphUs6wn6/M9cM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=atomide.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfh4b8sTzieKcfg55CFBoUIehe4p9sJ1Y87YT+pyvqA=;
 b=WTf2frYd2gYRj/XETfF+UF0SDMMVXw6/thHJU58jc9IwKME0cbGJQ70U+HClTGs1XYlnwgsdYKU8iZoxUx2RJJ2xBbVCnl2DyGSm8ss9EpDRPLyiX7TxojNMtB3zncQX5uqXrp7kI6amKTgDiXD9WxfQWrUzRSGYRO1TlmqdJLo=
Received: from PH8P221CA0052.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::16)
 by DS4PPF86F4A2197.namprd19.prod.outlook.com (2603:10b6:f:fc00::a2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:27:44 +0000
Received: from MW3PEPF00001653.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::73) by PH8P221CA0052.outlook.office365.com
 (2603:10b6:510:346::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:27:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MW3PEPF00001653.mail.protection.outlook.com (10.167.249.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.2
 via Frontend Transport; Fri, 27 Nov 2026 10:27:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A326B406550;
	Fri, 27 Nov 2026 10:27:40 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9628282024C;
	Fri, 27 Nov 2026 10:27:40 +0000 (UTC)
Date: Fri, 27 Nov 2026 10:27:39 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: shao.mingyin@zte.com.cn
Cc: lee@kernel.org, mfd@lists.linux.dev, tony@atomide.com,
        linux-omap@vger.kernel.org, support.opensource@diasemi.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mfd: arizona: Free only registered diagnostic IRQs
Message-ID: <awlbGwzBhgxJjvaI@opensource.cirrus.com>
References: <20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn>
 <20261127121738923LHjBUaCxdDRPGTYPDZBDV@zte.com.cn>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127121738923LHjBUaCxdDRPGTYPDZBDV@zte.com.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001653:EE_|DS4PPF86F4A2197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d931371-7f10-4d7a-6866-08df4c711233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|61400799027|4143699003|16102099003|18002099003|22082099003|10067099003|11063799006|261028144727099003|56012099006|261022105027099003|261021135927099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ov9vKqJqzDSPhH+NSMciffCnp/4BYu9UvSBYHeix4Q9Db69GODL07YqDiXh05ATsN5WOEH9JbpYKeiCCh9WtXtwFsTFsv852QdNUwo8bUD4T0SRejtzmkYXUIAEfMTyHcoexYaHVw0XsOa9xyRJiigj/itZrTpFUq01T3Tr15tuWX9garKmgXI3PdqWZo4cM59Ulk1OTv8ZpiQn/8csyB2imwo68ZqL6q1b5o3qrw/8L5ZfYNH2MQunvzpBS1uo/6GGxeZoVeS0tWJv6EtjHptDoSQW/HQ5guLGaYOQRh7E5cRWDdfCyhUOGiEszBP52hnHA9E16RQZxuHLjsixiBit3ItEx10HMGMZl/etDOJixgNwr19pDY01dA3/0wqSCn/ZpSzOtPQLUMYzOVvYNX9M5oGGk6dJfQAEDoYRVChklN5jh86eAFtOf24GfsgjhzTT2iPOWoevwZhD+to4Ytd+x+NGPGM5WJUJr2SDHuKPFfgPaQDjVEG4KNRcPAZw0NB3yofuiOGZeyCy1zEMwLqDwgu3KuLdmG/e4D1S1adNq1A/TkEDXB/7a+ZuNL44no1GQllbO3HzA819tsWDe0lBO41C3co6UZV39VMvtxLxB+bFQHhx0lNMdyVvTF6vUUZeUl600qHvVF1GWolEY3aNce3+z1KImUjfGn6y4hba+3n1DbQe+D2UCGe+vmM0l5RJwAKxmspgUvLsLHtL0sA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(61400799027)(4143699003)(16102099003)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261022105027099003)(261021135927099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wOgeS49nBdaQcOPOaJrT0oBJoos53evoWssAHQBhq70WS/Z3+MwuFKGAEW61JS6V05q1Ktf6Z7rT8rXP4sIjegB8vsx82StFmf50Zf2rysGTdfwesTGWKXrEfZAapiE2gdgkWYzE6u1Xinox6JeXdugPp/0JIQhtb0MW3ZvsUThhSyv6oCwMFQObm1fJYqCN+1FgSRnM5D/vpcNIVanAPnxmnG4Js0JqxEAaPPdoBeDwTC9Zesbzp97oh5FXGfBM2iCk0ICaTv7ybL0CavH/fO0mo7JOfEFhg6sknGANnRz/Oar8Y7gsDEYzUL+5HjBAyY5JI/um+oqE0YNFdmSW4eFg+Il5w3EzevgGIJxfpdm/cW5SAg8BmhHnJLszQwFeaJHt2RMS5Z57wUKqx65uJL7GS5JOk2W6JSnMpJTkll9RtHhhO+Gf9EXrAQQBVTiO
X-Exchange-RoutingPolicyChecked:
	jI9T550IA7lpNuTfLCqB59uOfjh39Kc8cnJRMJ+BFW8YxRoXybKJAcDsXIQeK/hi90Q/5qEaB6Ag+lC/bXkSWvq9oKsUy+IhaHPQSQ0OHoONvyLr4c4Rt/Jr6P8jEcvq4QgmXPTqn0lHRR9fwadCTi5dMaLOP1ZY+basapyNdNKXalK5L5bxLOiaqpEV0ukiLG34e8QNXmST5vn57KxHVrfQayYhEwSuDyaeOub7TvCiGj2HwYDeDxjjYHkj4508DQ8eEP/pWy3clb3hbGdwbnDjqC/5dFAObs97JLz7MRL81ezpW1hRw0KpiCk5RY/fMaCFinNK7gdD+azjlzaXHQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:27:42.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d931371-7f10-4d7a-6866-08df4c711233
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW3PEPF00001653.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF86F4A2197
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MSBTYWx0ZWRfX/aP+7goAHmSv
 EX4aNnkGu2jqUY+ZwaEvM4SIObdeqgjRJXBT3rDnHZxwPiZZNHMgIS8axkUlomrU+1qzkCmAiOa
 AZRuG5xt/0J/lkfFZX4icFDYgjNv7VUHSqa2H062ajyUJnrjAwJDMaT1BxlMIKZtTMVg0/phZcL
 9VUVTUkl8Z+1fEws/dB/W5P3vSAYOhHXkCAPuK4Aqf05Sr82zuCmde3FPE3gwLiD/GgFh6EGLIC
 L+CDNzPetwy9pU/5cxyACW0WJDmQ9jhtmOQ6j7/WLQWHYh51j+3F/OhwpZy4mTdX8DG+84UikHn
 6RVvbnKYJKyPE+AS5eAyrtGd+hJ8VScRQGWj9nlVgPDdpgLND4JHS2FUKBV/q7gR5FKif6Oymy4
 Hx4uTUH3doBk2UT6nunxrk1gZT7nF3kPjQe19MN4d2Lx9/srbwmpIRpUCQqTuvJx8KQJ5ttY0xU
 S6WztFUusz+85j3vPvw==
X-Proofpoint-GUID: tAW8-MyLmN9k7ICtAMBp0z-zhXGGhsBW
X-Proofpoint-ORIG-GUID: tAW8-MyLmN9k7ICtAMBp0z-zhXGGhsBW
X-Authority-Analysis: v=2.4 cv=Xf0cX455 c=1 sm=1 tr=0 ts=6b095bbd cx=c_pps
 a=MxHkyKj2cFYSCUcUIFQv8Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=1RTuLK3dAAAA:8 a=w1d2syhTAAAA:8 a=dgr7XZOsTHHp-AbjdCYA:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MSBTYWx0ZWRfXxgG/2w5JogTB
 xTjMyB4nZL/bRg7xt6PetFGjOR/lrrFAgzZhoWOy3eeiJJvWVdjRHBAxwmnh+ifInCZWMrlR1hl
 NIrFHoxzzjyEPNmF9WREdGCWuhNUkFA=
X-Proofpoint-Spam-Reason: safe

On Fri, Nov 27, 2026 at 12:17:38PM +0800, shao.mingyin@zte.com.cn wrote:
> arizona_dev_init() requests three diagnostic IRQs before adding MFD
> children. If adding the children fails after any of those requests
> succeed, the probe error path tears down the IRQ mappings while the
> diagnostic IRQ actions are still registered.
> 
> Record which requests succeed and free those IRQs before IRQ teardown
> on probe failure and on removal. Diagnostic IRQs remain optional, and
> a failed request never leads to a call to free its action.
> 
> Fixes: 3cc729869475 ("mfd: arizona: Core driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Changes in v2:
> - Record successful IRQ requests and share cleanup between probe
>   failure and removal.

Looks fine to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Personally, I probalby wouldn't have bothered to track them :-)
but it doesn't add much code, so if Lee is happy so am I.

Thanks,
Charles
