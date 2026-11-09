Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223486;
	b=ntEB8+as9SdGfonmxLgJ3cNo+Vk7+RgjyeEhXtWRkmv3rIjOc6nSAff1EO9KbBs9EVx4
	 OTrMOc6lqRmlIpqv6hGzSxb0+Fw56IgUyCmap4S0xxLaEm+SFFQuCk1Gf9dT8Mh0GKI9e
	 j+A2RbQSd5wWJFQGHrAPo8+bMvyu/Zf39DUVz0ydKf9zxkrIE2q0AQDtquXdvOv0g/vna
	 fPz5f8MvGJFKdEVyTc09wLv4YxVkvIq4U9k3DJhNbi+aa1MRBvi9/ttaqIiJIbeWzkl22
	 Al+0ADWR71eOYJ95BkjDUfq+a9ZriX1UFDiZ7G6aMrTpCElhaG6qvRkRrK+cvF6+zbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223486;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Reason;
	bh=JWsLf0z4/bJbEGa4fsCVPJMZWegU4TwB+3u7z3glpMk=;
	b=f2GsADkTM3EueNDrkfiuNRF57SFu8egFw0tp4uGXHjNuKNsnhHfR1zgh95bQsc7owgNf
	 lgWD1wJbyI7Fh5CEJmq2VkAtdrtcqB8HwSF9OwvVFAxy10/7Feb7KEFQsNK2XUvbXLTuk
	 MSdj1gK6zLjEc1lB2Om6kNsTOeSlD0fIryvXstu8bGrgQ+1XlQFP/wnZrQlTAY8oYms6m
	 dJpytykpjNxjaLdXbhtVop2Qx/sLgM/WenWlvdsiXAT0bSqu4kC+0jQEI24ulS/ihAuy8
	 6SwjlHMf0b6xoRKRCahe95ZHRuuLj5thbPpVG2IX9gfyCtT1/E2ayATJprZij3ZSMEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b="LP/rbgDv";
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=pwviLrpr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447C606A321;
	Mon,  9 Nov 2026 11:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C447C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=LP/rbgDv;
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=pwviLrpr
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9BCoVE2879798;
	Mon, 9 Nov 2026 05:24:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=JWsLf0z4/bJbEGa4fs
	CVPJMZWegU4TwB+3u7z3glpMk=; b=LP/rbgDvAqLgMmxbfealQAd6Ku4kfBFCNe
	bdw+W6iSf/2j5jU2L0RXGLE7gWEblmqOAoaDfy3WLp7jsyA9kAQLzGEEc9ySM/Pi
	mTQAty3Fwnco7bHVK1KOpp9qtgSGMcvI8aA9bgdnTENV40bJjz2QhbsnHGBzDwPI
	EJqAj2FrX5gl+oyHf+/VPUxF1ykTZuOcGt4jfJSvKZsr+iierHuYhFVFDYeqNS1K
	8x7GLTdXpWrFr4aKD/xowJbMSa9GWLLVFpzlIX43TrAPHdluQRVrSC5URYM/Ua4P
	F3W+jum1f1FavEZikk43vYxRRtx2Z7f3nH89H4AKE+7oF2ANPvUA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ht19p9yn1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 05:24:23 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdrRQBdhoTkpusc4eWBfPUd45h4E19883WzN9eFY8S9vw2dRW+GDiR0xBBUvVaMwN0jcM+S2aN8MC0EF9f1W0PUB2liK7OpdeuehliXmpj8UFFO84wvG8mwjxh0tryZuY2iYb75pgMNDxEl2TOnCLZqfeQ+hMFXh6+USFFmUyl4J7bXmKBCkqEI7iq1iBwYMMGJWcH00V19x5afunliDDL3SwLU4n/VWprBVWBPwds1KmjVIptfdkeshstkqph1CRbfy5Xu9qKf03PakO3cJnNF/UoUH/KoIqOIDJ2BIj4zRodkxSBpvxFMVApgxH4EB42S4wJ+0COwo6jLDZz7Q1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWsLf0z4/bJbEGa4fsCVPJMZWegU4TwB+3u7z3glpMk=;
 b=BJi3L+ZBkmTBW0pqyInSC2tH+fBsFHNTxLY9/HHrXB03CmuBz/1jjeWw6q8J2tsGhncru+8yKO3ExASkQ2qlVMr12cvzkQ+vFielwY1bL7LPrlR8HzFaDS1ZWSmMjdMb7LajdELbMp9msIV+nQrEwJhXyffrsWqmVLePPMa+MQxxta9bEgoJC9vncn8XbzfLKYuqwL65eat02BlLTiwJ0Fx0Gh/PYoe1iZn4VsyVc8D2I5/XzNPEwM2X/fLLCV7IsJsOx7A4wEyCMF1WyODc2X/mrvTlFyvSqUFe2zAb1oWND6m8P5302BNuNE7n7j01usT1seNhlX7raJe9XOmeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=atomide.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWsLf0z4/bJbEGa4fsCVPJMZWegU4TwB+3u7z3glpMk=;
 b=pwviLrpr14+gPYKd+qSdy5m5CGpKcBnSume5zkGStsAloxG04zpPEiLgwHtcwx4aIRNcPt5tL242wryfrJE/AY4v1UOIZcm2NhGEeJEGBoUr2DVCcL+vJSDfZRw7UdPswUXHosjRFfHe6SZTx78lXrPKokcjPBtza+Z8NjjZEI8=
Received: from PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::6)
 by LV2PR19MB5933.namprd19.prod.outlook.com (2603:10b6:408:172::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 11:24:19 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:34b:cafe::6f) by PH5P222CA0006.outlook.office365.com
 (2603:10b6:510:34b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 11:24:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 11:24:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 622A140654E;
	Mon,  9 Nov 2026 11:24:17 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 46B80820273;
	Mon,  9 Nov 2026 11:24:17 +0000 (UTC)
Date: Mon, 9 Nov 2026 11:24:16 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: convert to subsys_platform_driver()
Message-ID: <avGtYN8dDGEr8FAi@opensource.cirrus.com>
References: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
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
In-Reply-To: <20261106-regulator-subsys-v1-1-1f91f4204bf5@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|LV2PR19MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b1d398-2bd8-435c-b93e-08df3e53feec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|23010399003|7416014|376014|16102099003|18002099003|22082099003|10067099003|11063799006|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	OQvptx7r4ISACPbCVKaRPFmmbxNQ11I69wxN5lxQV2tGpM4o4Gy64koR5RR7pmZfGEMlNXi7MkG62s2b4MLkmKHeAVhRyuB+NqfUKq39DqxtE99AXFp6gMBPTNzhALftTQkN/suNWcxfCJ4E5B1mScIYfd1ghsi4oLUqJK016Kn4UHofrawq9RlBBn8+WnKhr2fvKf6Rgbgy67U5xMTAAZ7U/PJN/n18zwSljM0MmoxZ3rX2RoFXExfWcmgmJkYNli6g7Lx8UzhGW61c+P38wRQHDlQFlD2kfAkF7Z9MspiOnN0ZKGDV1OYr9iPJcml8uaskbjIMBJsL7ETN6jVOJXDgDlTFLK0uH7alLxGfPOyyybRbAWaXanzaHA/nFLzlTbH3pEFcFi8sirBensy6TymL6XRM39y3egGpTYC9e46YlHto39uw/wKMUj5AV6mxkYAOcy6/hF3CozVCnJp1EDgvq4T2srSUApp9o69Qu1DScwnhni7hhfvB8QwPLQH/fnANKArYiNNDDJ+j5ZbeJSdelwMnI5chKsNUHkf215d+UoZBxPWZPf0BOszoSh7h0OXNo49fVuE2zzGDRAkfbVhgtcr8j6LCfXYXhzQEYZVXZ74PeIzt95ToV/hUCsRwrm0rvYD9bUN1VbR25sadR0nOwQupTlALgCBQDXn/k6A4lBfZoGxTU3Mr8u2F8s4nOPzbBxCY+lnVJBZH+ZZZAQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(23010399003)(7416014)(376014)(16102099003)(18002099003)(22082099003)(10067099003)(11063799006)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SMQDmgMRnCNb4/RI2KtssZxFheM6A0sNrTDOzm/ieYjqnFW4VV+gUnQPZtSFZSu9WXizRadRYMPyOoZB2g/H2vCv7/ASjKvMXXShzYAKrpy7vat/YQ5Hio397ix4ZcMrDqxo/bQDg97aAB9leVY6RmKoO2JFoEvIfM19abZ50b2Vr25kJE1mdYMQLMNwf8Xr6xK2G5xsLXTi/NBqqtTOXjOBA5ic0N4SeJO5quwR+87O6+LU7Bpv6P6LAgtQ+Su1b1sUdHsLEXhRDxRPFD4JvBGzSnJKD3A09ro5H8APVZ6EA03Sh06pVMJUReF0QVPifTkhDqnxSfIBhspK1Wru7yQnmTFWfUVWtK38okxullhz7FIJiygjr9vswjA7EFAmeaPQvF9kdUWkSzeh6Vcw+yspzAy2Zlko1QsrmbmCbRwGE36CK3GgcZ53s95+S7KV
X-Exchange-RoutingPolicyChecked:
	N+dEW2UboQ5/EUSvfnepzdD/jD+MCh3nXI1997HwotTP5TUunTpeTSs7GkmIqI4M2RYmBEt6OwHLjnCazkm8cUqLp/ehBDHFj2nonCeEPgmXGRmABwKkkLOZp0D77U7UQ7xmL6vhQLlRvGVZzXQg/slfo9xZo5URup7EeLGLh+lVSygJ9+25BzpKciuUUS7Hoi6LP0V/Pun/P47rWnBq5pVOLuHS/y9gzDUM3JDXDU/C/So58p6idl9OJYT/+oZeav5/QRA3KCza+Nrawr+oqcYKyfA21z+Cvame4K5NttLFP1aG9X7NLr82iSNkeI8/4SxtR4v5d3ew4eJQnyqI2A==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:24:18.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b1d398-2bd8-435c-b93e-08df3e53feec
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5933
X-Proofpoint-GUID: Uii0I1uHRqKThN8bOUotPESxlu9Tyou-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NSBTYWx0ZWRfX7zFj/QS49GKA
 NvUY9hFB6ZeU/c2+ffeq613i6jYfgqmf0lxkE5IqrxBiNum3xuwzO2034QAsFwniE5B1QccZ9iK
 oHNsZdXLhyE/AXFQmESPxqqNkl5FU+Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NSBTYWx0ZWRfXzcoVCPflOfFf
 9bM4UbWbDbv4K2+LynmAgq7ABdqlLC3sKLhx+pkRd9up6vhOMo6K0vtWCF++2dy6TXKeIX/9Igi
 hSJzJHpfPGDHj8GtebARWPcj4ueyPNSNA+AZY1xRua0T3F/vp5dkOrUbp9Mj/Fc2TL0sAILpWp3
 x99505TQ44juFYTgpspVqdCJAvf4YncrgJ+MC0R1sIy5NhtMmoqJDsUGeAD7FnEJvsaSvk302d3
 U74gefLs9FCCTlOw2kIIqBoZsGbi2/n7oz+/+515p91aPgleLE/wpu6l+TcmkoJ4BKN4gdHK0Z+
 DmVaIhiTgvMbgEVMWDn0IzEt4Zg0O3Qz0u5uB2LQz9PdRiBIGZpDZwh/HmWo1fm6AZxE9e1LPyE
 7jp2h73esXevPiKvwCOv7rRpt76b8zucjwuorQYGuiyaNPnX/f/Tm/WR0+scuQGJSlGPS574ExE
 LuAs/WICwqHNEbgwKUA==
X-Proofpoint-ORIG-GUID: Uii0I1uHRqKThN8bOUotPESxlu9Tyou-
X-Authority-Analysis: v=2.4 cv=NK5AaE6g c=1 sm=1 tr=0 ts=6af1ad67 cx=c_pps
 a=wnlGNIUL0AhmB29u2vspYA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=20KFwNOVAAAA:8 a=w1d2syhTAAAA:8 a=2mfksfQnj69i5T-jYpIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Fri, Nov 06, 2026 at 07:28:46PM -0500, Brian Masney wrote:
> Reduce boilerplate code in these drivers and convert them over to use
> the macro subsys_platform_driver().
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/regulator/wm8350-regulator.c   | 12 +-----------
>  drivers/regulator/wm8400-regulator.c   | 12 +-----------

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
