Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793793004;
	b=5n03eATHSbTjaBSgVseQ4lhHMvkNqVoYeIUjO/Yfe16kh428IuKlwgTVLn9ATQJab0fg
	 +jlO+MrckPzpcY5Sxy5suYr7ptE5qr3Fy//mKMjQtl7jkSAHi+qf6PdS7yvQFimEidPs6
	 8sOVZyQIUZ9Z/S+U2MVElkz00y0vaV61VeYsUXTP+uBPCPbMIuOzPO/wE5h1gXQ6GqY+A
	 DuSNBR9U4ICvYUoy2HkPeehJrlSWLqs8AXJ4Z7saPSnPWfq0ahFkR+NUApXXrZUc5GrBt
	 Nrg2IPYjy5GwjVWBAKGTNiadbdlH1iIDfKY5mjiIvfKNqKjZzCBzTOIrCwenOusb6SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793004;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Reason;
	bh=qpxhZOx4efRVENm72uewc9+HnXaz9IGLNzatp1qVUxk=;
	b=pnnI1OSqMKqV1GA3pqmy/zSIVcW+GMdnghEWQQY94QjlF4bY+bUR84v3dNTGSPA+3T+W
	 3O7E1mYFvrHdu4MwvCoJmxLZipJsjv7Si6X+tSM0EKUAmLw+te598z94NtJQ+fCU8ehFl
	 kz5z35rWjOHerUSkdPGjgwLWqy+wt4tusCxfe2A1/llYEobpIEwS0C4Rrgudv4uq34/J/
	 xmbGMA3Rc4PWzn26wIdUVQhjQmVncGo5gcqmk4qgPAJVC19kBlv9+jVkDY6fyIHPJEriH
	 yA3rWDc9gq7u4fnoH2OCx0MQaekHd1InKe9NduAnTO8HnwKDa9MpffC897UcIHpBlXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qVYHJtVE;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=sy4xN+gF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AE606A31B;
	Wed,  4 Nov 2026 11:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707AE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qVYHJtVE;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=sy4xN+gF
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A43voB62527180;
	Wed, 4 Nov 2026 05:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=qpxhZOx4efRVENm72u
	ewc9+HnXaz9IGLNzatp1qVUxk=; b=qVYHJtVEf5xrE8uZGXw6iiF6K9/gwthKc8
	UiRanq5VW8w4xZMmldq3OWXKQRAFHTIcqM/ecUOIa28sa1SqefBQXi5sqmwNbJ8L
	shJLvz4TsFlgSzNeMGTjsrkRDMDCshQ9w4KMpNk1a6WKE0m4hInQ6hs52wVVQzVQ
	7FfAYBbUQ4QEw3JYTNJ1BSPzkMy0ZytD/+rCuGhQJSAJPosO2SBb1XbKkZllXGOQ
	HAgzNQg2QsgyKLFDcIF7xfU8tMNDWu/hahjH4N4MRoGhOh84IKLdb8SsWMYm0a/H
	SuNKZxAy0kocWjoWQW4Tk/XJQzYBnBz4XTdpfhTl5ZbTM/c5ggzw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022131.outbound.protection.outlook.com [52.101.53.131])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hncrfwhq6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 05:49:39 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/gOPTve5EITpFBopZagu8HAEAsdF3KB949DHLU7Ps+FtLfssY1eDfdGHCkCTW0BvmR3EHBos5qrjFhVS+FlW0guHfArILe2WzQbfeFc/OHbwA0nJ/1Cukf+Z1d3acpcPYsErUrBSpk84of+enTxhmcFEfq70dF5W6LLDyZoG1JS5V3ytXJkfHxlrhJWiCQy+Tns9G6PZl3A6bHCKkQheSqEhPcKXxmBu3UqN3mxLQFi0/lVSFIoJbbV/dJOl5u2FA3VSu4f0SLl9KnnKOodyxbotJTOtuTfVZQarNW47gK8Ub85UM4/FvXzvgVCqb5tIErDIO+7c4x5tLoEEj6OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpxhZOx4efRVENm72uewc9+HnXaz9IGLNzatp1qVUxk=;
 b=kABjKDt16OUnQa1WCprcgg+Gh7FAmdN/vnEfq92H5M21LzO2E6rbXJJRreHz0cQpHE1yqoAA7gGpSczZCFQJkcjdNPViQy9CHMpBF9co9Xap8yIPplHctPqSCOD/v8SuYFd+jqbGfPY/dYvc53579DwDrt7wywmOF/jPVeFB0ZdmSurGVYCYLwL1UMP0sGm0ymS0BbwAb4hPqqrAQuvSeHGFtXpkNQWe6IKIZxWR6kqT7ivq9r+abJS7KpaJXY733CzYd3ahPNqn77RZ+4Wm1mwQXOyTQED+JLATxMpFK72UlPOZYFvB6s/XKAOG55aZwrMYjxn55lV7Dyu5dRW6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=atomide.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxhZOx4efRVENm72uewc9+HnXaz9IGLNzatp1qVUxk=;
 b=sy4xN+gFpqyE7BNrxSnvdgCDnqnvJzVg4oPP3MWfQeQAsq/X7rsvjma9RUUVCfO1PC+Q0vfdWYd1h1f8fSVPWvM/RqWhUAAcG5ekTgdf34GkTlz+tc9yrjkf4vRAupisRSP1UzWlfpGqn1a1FPiyURWYhG7zkZFgBUqRN7ep7AA=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by CO6PR19MB5369.namprd19.prod.outlook.com (2603:10b6:303:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:49:35 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::1) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 11:49:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Wed, 4 Nov 2026 11:49:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C8162406544;
	Wed,  4 Nov 2026 11:49:31 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B5EC7820273;
	Wed,  4 Nov 2026 11:49:31 +0000 (UTC)
Date: Wed, 4 Nov 2026 11:49:30 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: Convert to subsys_platform_driver()
Message-ID: <ausbyudwbhRhitMa@opensource.cirrus.com>
References: <20261104113352.1634237-1-peng.fan@oss.nxp.com>
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
In-Reply-To: <20261104113352.1634237-1-peng.fan@oss.nxp.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|CO6PR19MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a170451-eefd-495f-ffd5-08df3a69b170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|61400799027|82310400026|36860700016|11063799006|56012099006|261009223027099003|261022075727099003|10067099003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	5tvthz8DW5PedvBjX3CmJKySDqOArdl+HKT1S/4WMtGtwf54gvH+XAAh1TvFR2Y0FkonweNbeokUZeCemdvti6YArMH4tKDr+UbcZVHagJ/GU0o6AlqDaiP/Z1kciYNbLWoyhFhMKeD3o+IJuBKKyEIomezbCESLTBwQzxl8CbCcOadobCJ4GflMkLL/wGSY3OBCzplEPyZ3leRh5OYklNlv/WKR1hW6jW2C3vWfjaVjFvTFjRX92WPRPKJS3p4AKQ/qsz7M2TYTNCSHZXG6eG7W3FYENxhYp+fyKDu9OlDBhNFwB3+OkRtOFIZk3xx91MXwVWFPxAexeQLYxlXFwrArVZaXuh1FSEmrETuMKKtkkYr5Di5H54KTbgdEtv76pJXgRMndeLhnZXPGMYWgcFJAlaKibeTJ4qPv+v1rdrR8sNhw12qLf+TC9gOKqaPRh9/QOyRiLDxcxJkf67mhsXLzmbYsjZ4Lm1CEKRH8BKBgMiHmuXNvuYwKOm1GrL77EQE7TH57nvLka3evD0f7Yw8RtCM5PPDqzNTLVfo8YoHrLcuoJa52Phexb9pcnuLMYTtH7N+yaf2LdiV7Tp9SPjKlHAmqmTZNpB82u4jKyWC0w1na+uQsKu3kzM5PsdLVzmeL+Cp875L9f51xaWP61dKbL3BhD39g+uq4a0joQK1vCMatXVJae4l8oOBqn9IhIbsfC4lydUTwFV40a4h32g==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(61400799027)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kTwlq6u+U6GCitwP0O625/Yux6R2NwRkXiO79TjfbkXSK8g3wRgNtwZW2lJIv3vS4wyPAAX8rlaEBT608DZsVlSPf4saHh0HdRs60lUrfE4bwl+zSpIGiMYZFX0N+NvbO/8fV4RABw4LvoHaHix2DWym9TR1zyvhMW3OGrLVdnRfomC8XSVJrLE8y0G1iTQEzvdLONRtIO1os95xglcxgnhlAv0GhGMUoPvF2dOPv0RneOrHzJuS89yzEoyJSBV5+VhGS29sZssv4g82fCLo2n44iIrG0BEf4MGgbxQTgsoWmcqo5jTkQ/oeMhquPzXoj2KI3IQQGsHZxhrVf4LfebbhA0DWKw11sfoPDNV9dGrqlgupolOAzgBJxck1PRe1d4iYLncRIHbpPqc2JIT+OlKSN+fyO7SkPI4YMvZuGu7zgv7TCM8O636gNS7iYDh/
X-Exchange-RoutingPolicyChecked:
	uZL9BHMP851KsbxtMvG3gJfJEU3FbmdiLGfcP3ne4V2vtGoa0WSTOrJUmz81W8ls4IeSvZoRWIDK5mmlKcuSBbfEceO29lVgXF2wJznBp/BrGg4730OGa12ZsT36UoXY2uacy9DYLpcVtslWRMyPJpPSTqZDttC7VB6pvyglLnUaHClbQ8exXQimXzFNsdviM5ups094OCXNf74h2r7QjNGZAXDfcCTKMnHos7lSz1OrwvB/7eFa0N4FoYf4mrO12RFWqv5/zDYymIAHiM26d/KQp1seqFLm9i0KdNPNdF7L9Z7xFj+CXikh1i3WwuEi97lcqbix5fJBSKrmgJDVLQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:49:33.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a170451-eefd-495f-ffd5-08df3a69b170
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5369
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NiBTYWx0ZWRfXySnB0AvXK7nC
 YCd+elv1Qfw8tlw3DjTdsJq+veHlYXZzBr/SIU15wVXI8JAwQgCSqWPz8L3irli481mV5RSlCzr
 eDk/dr4um7ipUaNU6QGJr9jm8uazgXgC6au6Xo89mP/Cd5YXOarPRFmvNkId0e/BVgbYYT4opV9
 Ivy206MWX4DmE3/kvyp7MpTGwpeY5So4WYnHxlFMHnQkD89Sk30O8UUJpT+r8xkm++Q09xNLS+g
 8XPcpeHB38Z3LOBlrT5fgdxeaqqAEDGiC8B3T5hMpYFbbrDl9ziOLbohr0ApMrKtJ3QndUPWi2f
 0LUqEqcVjhAzFCSdufm5/y4ZUVy4l0DRZg5TSR/OyNZKOnORWmk1wJbtE0dMq5dvuoPcGW41zHD
 RWFxO92maQtpYK8r5DfojPYLY+pNO6ajzyaRIy/d/nVf1R0tg6S3YP8X85FdQb1ArpKEE981X5a
 xa9QZ4ZL+HtB5TZ3jYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NiBTYWx0ZWRfX1RycVD7qIrNJ
 t39s12lgaiOQA6wc2eqiubhF6qupZgvG7YIZTvPzJGW3EGyJfRB2LVyLLKOHg1pvblTSjPB2Fmp
 oijwqczoI20IJCgAl/1cJ0W8g4Z9UTc=
X-Authority-Analysis: v=2.4 cv=LtgHWXdc c=1 sm=1 tr=0 ts=6aeb1bd3 cx=c_pps
 a=6tOaaN1fXmJE/LdyR88bKQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=8AirrxEcAAAA:8 a=w1d2syhTAAAA:8 a=DqZYlRkov0yPPlpfqKoA:9 a=CjuIK1q_8ugA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: DIk2z8pe_RT4YxUge7ivohxFHlpU7iyM
X-Proofpoint-ORIG-GUID: DIk2z8pe_RT4YxUge7ivohxFHlpU7iyM
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 04, 2026 at 07:33:52PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/regulator/wm8350-regulator.c   | 13 +------------
>  drivers/regulator/wm8400-regulator.c   | 13 +------------

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
