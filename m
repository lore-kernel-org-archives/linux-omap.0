Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620F42087C;
	Wed,  8 Jul 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512959; cv=fail; b=Z3XNyWKHXZc9BLv17+UImeaL9fxBVuPikllT6b6IoXTdtzfEFMlkc9hiAY4DaNeAXTf018g/hUWcrKXcfvAUJXBHFPI/jZdbzIZjsXXBVO9RzcMbRHvINKYKlMyzr1Y02kLueTVt9ENw7jc9SRw5gnaxxpMs+FgfbG8nl9ywQqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512959; c=relaxed/simple;
	bh=WadGoo/z8M3xoV0WEaR4Im4A5Ig7zsryQjibUau7Ia4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9ze30iS8Y0EnRTkf09l+GR68xtbWa9PWgppk0o/4PcNtq0Yygitb4HnPYGc3F65HkMR5UnM9fAHbl7gwY/D5IuieCKzHftcDCxgsQPBg/pxA3VlJeP2hrvZSkHzWLYAj1SY9+n8GgRo1vVmviZxpaPXGr9PxQC4mD6ImrR/DNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RXgnr3gU; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=COvSP91u reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RXgnr3gU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="COvSP91u"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6684m76x1629049;
	Wed, 8 Jul 2026 07:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UyzSKOh33z0Xb6QBUNhSpEuixH3Bke9MJC14m5KKS9A=; b=
	RXgnr3gU2xTMaynK+3RVHT9prWhWLb1yilil10GY+YGH1Yk8ZhPwwbFqLrTIIxg7
	oGnfPDTNwJSitRs+KUIZcHmg4P04CkwYjjWQV8TIqqANTmruthamXqYGUCeuND1h
	pwAx+T5mxPlKXknAoaVzjHK3DxeKLR1R2RQCVYenyS7WLbFQRHkuhN8Ug8sKvfli
	CfsVvuEOJxXZx+v+jG+hsGLUPBr7WnnTG7jiljIIKT9USTWXc+Ofu5ri1QIRQuHI
	MRf9jm1wvH4BXKYUyjrUXRWvZ7GJ4P0vqk55cSKzcsy8xgWdZltjb5UdHBaPy1wL
	oa3XgzSA9wcO4kH8lMFfXg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023089.outbound.protection.outlook.com [40.93.196.89])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4f6xkjp6bk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 07:15:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8peVUPNjDHW97J4YtK9jVS0njYdJwcspJmanSFTQzLlDI3SYBItG3cXi1/b6fKxw0t2ltihqPoPlepHR46iIRrDGIZiZ/p8T/KzCFkYshrjVq1I1pU0nc288tsDd6Pm2jfdryqbiId+f22YQWyQmRrjTgjSay+2qmjX/TlPrG2epG9iZitKoF++sBjpcSxdb7UbRoNdvnVIis5PkPYTEewMmTDeF3yO+dgeHHayjtfKShfFjtYEaXYhhm5yXpTqVN4X8xJrk/NmMELfc6LmwseRgzenruQqiI32w7Qjch6gGURgxIR1hMdCcuiUqzJnyFvU2vLo9tpmejSWua/1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBTT5l/zKJZRxmEBtniorPLqmXm4GmYCcfKW+0cfZfw=;
 b=R1fEnjhaWb2AU6r5qTU+fJkAldjq0m59y6gde70/HcVM8P+9gBv0vem+0miZfB+Wd3Liwzxv+8DQAQ+AM9zqV2JEkjpLYBybC4ZSEg5busaWUqt5S3zPA2Abr1ugyjVp6mXfB8kOM4PMPsKNFY/e+62FwGKR/baaiacrkhGtAm5s9OwS4lMSpXBGMzQCtbmBQGieJ4j72degGx0w88VHqW2Wz8lnoTuAGkbd0wyRnkU0Tn+U+F+T77G359qlLPz5TRqJ6hgGdg0Pw1oghXaN1arZAsCXATiwqnqx1EDw4Xk0WDRsjqYHBLK+8n/9fs5bkvW8at99EioW5hBca5zFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=atomide.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBTT5l/zKJZRxmEBtniorPLqmXm4GmYCcfKW+0cfZfw=;
 b=COvSP91uNmAhs1SDIoLt/X/ocu1XLMaEcOvg9fQqJ420EkhZ+fHVUAyFsCYCpYnWUzDcWUxK0bGdIwrS+PsvWP1agcGg03PUCfps5UT2UGwsygFFeCpjpy/QfW9et4t3t0Bsi2UZgtmCSuQioR3LD1KSFdlj+m1Xg1PbP/6beeU=
Received: from CH5PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:1ed::13)
 by PH0PR19MB4758.namprd19.prod.outlook.com (2603:10b6:510:20::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 12:15:35 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::1b) by CH5PR02CA0016.outlook.office365.com
 (2603:10b6:610:1ed::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 12:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 8 Jul 2026 12:15:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 39EC9406541;
	Wed,  8 Jul 2026 12:15:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 28F3A82025A;
	Wed,  8 Jul 2026 12:15:33 +0000 (UTC)
Date: Wed, 8 Jul 2026 13:15:32 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>,
        James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 20/23] mfd: Unify style of i2c_device_id arrays
Message-ID: <ak4/ZDSvc4bz/Lg9@opensource.cirrus.com>
References: <cover.1783507945.git.u.kleine-koenig@baylibre.com>
 <9c8fe48a1f971d75191c636f2b6d3ef1c68a26e2.1783507945.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c8fe48a1f971d75191c636f2b6d3ef1c68a26e2.1783507945.git.u.kleine-koenig@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH0PR19MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4ffe70-9fdd-4dc8-10c5-08dedcea9d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|7416014|82310400026|376014|23010399003|18002099003|22082099003|16102099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Y5fq1pj1Eaaujzq8ViJNTsbnyenC27/+rDblm2+x87a/+v2jPkHsWVQnCOLA/OEO+ERrPtEanMylC1xMA9hg9JJ/KZp28J4BRMFFx14x4mQDgifpT9b+wIcUZBD0ScS7rPBeEueFnpH4r3RnWktvMvCOU/uGpPie/0c1a0DOncb1Zu374dAJ2GeBDg3yXck1PFQ34U0Ztek5Cml2oAIdpzEzQjLrCRh3Bu2aYOAmsLU/WHLXAUy+eFW7A5qgtyOimmbDJBlWpIJKY34zQKBGT/bPwmMpqE89XCUOU3VCcWIFgket03C4KIabPd1W3jFluzCXH3x4OEgrNDM+V6ZIkXmWatTnarYRcYavr1h5dg6U/z4aZNIYLvTwuUUVq2tEpcs6gaqb3F1VGWmywNXqA4dEyDx7w6LSQipe0+iA87lzwwrvF8eCQjugpyK1PPR0pE8cRu8SxhoJwgJzr3/eXSzSAWcDb6xLn9SAi/Tc3hpWnepdlXzEqBGgxCla+1C3bO1XbnQvK8DZd5OMdpVuuqzvJrBHK9f6/S74REc5SvXSMdVEbnzyjzXzNMV9837yGZSCXvMUE9ypfrX7t5lbLc77doUHtBSDApLWP/JHliHPBLcbV8Jy3qcFVh1KLbl5DjpMkFBQ/SXCcItpUguzuM5Qy6OOOQTd/g88LxHV0B4PnksvdcN/Q8XjOyw48TNMbwH1C8cDLJ2v/LX97Jwv4Q==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(7416014)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(16102099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TTCtH1eTVjZLwGhHz/VwhHQxmcfZHSxF92RPv4YWNzg163NltUVnlBcNK2fbH17Y6L32h9yTvRP66ORblXDfLooHMtgnb6aQKX6Dls6EZhECk+p37HN+WpMyew6b/5P1HsR/JwtboCIGt98zWjMA+3A6t5X9esBxvvlS4pVcss7ePMDMDqnGnNxpO1gvEq2GfSa7m1Dbn99FznnVO0B5y50CmowJw7cdSZd9QbPVqY6IHnlEQ5Gv3IANL7m1rVaFvydF314yvcviyKWwi5MU42ZhnIUvfSKfCXlLce0Xn/bjctSykkO8+MEoIe0NwUIa2tDsLG5JISR+uIVDdPCqtKeLUPG/OhUoOB20P9TKAlKd4KdHM8h4DL6k1popGlhGZK2gVN1ywkb6Qabgu9K+6xufWhW+79agLfW8hZONN4Ta/CiDgTNihM6OTOLnfyiB
X-Exchange-RoutingPolicyChecked:
	W/gkv3bT0bbBaC7V9zGbggoxvI8oyPnIWKDqKmcBtaHTF7TFsiFS60YqMD9w/5ArwspzFVr7gbxRaAsDsJPjwXx8QivQLe9Evls144HMsd0TBd4zg9dF1JQcfzFY2pULdVZF2ztUyCzET87tkeZ7bYLpovmtqEjAqWecGIyv6ZVhZ6AhEa32zvhsfxM/wuNvrWPGkY+GkWmV9Ds/xwjzFafi+7Qdt0svM1Uktjm6dC/AfJNR5flAT85J2Fh9oAuStieQY4N7qaODKiuUW92gKEItZbF3VOI+U/cnCBv5OcVJITUK0JcVe9+qAb3PoB0u/d3v1THRQTpWmoPwwNI9pw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:15:34.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4ffe70-9fdd-4dc8-10c5-08dedcea9d1b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4758
X-Proofpoint-ORIG-GUID: 62pfYdDdD8pXj-NUICWwMRfX2hE6MXez
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfX+BjbrzguE/+M
 dsPY930dSPuplxSI1+Qd/FulvKDU0nwvolpTf+sBAfLj9Cp0Dcu4hnnozlITYkp0+SpwK7zhDpx
 zcSXKw1HBGhZNkzXoMj3tOC/8v3FRxk=
X-Authority-Analysis: v=2.4 cv=YYiNIQRf c=1 sm=1 tr=0 ts=6a4e3f6a cx=c_pps
 a=M4UlfGjtkVVPzxF0Cn8jVA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=IpJZQVW2AAAA:8 a=w1d2syhTAAAA:8 a=F4wxPZVc1jiR1BN_hbcA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExOSBTYWx0ZWRfX2c6Ell5+j0Zb
 lHxh+rdTwkZkO5iyeFr8Q8dyshBcol/IVEjGYvknhmW0d9lEvE0TcAA5iHdFXs2W+Bqt26OvG/z
 n8z9F3MyMJRNzDV//VUR+kJzTDdjGjJKvw4O0npisEAbXsLEhxrYStJCcOuAU/7oP3aGMIdVtHI
 C6HrciXoJLP8pQI1yFdD6thtF7rFTObqklW73Ck+BrzBE2FcMzdkwrOd/H/fm4bA9ys2cVzUDl5
 djnvKK1IulaGsLlSaj9r4WOoPVvvrqeM4UaBl6XgVc5/0xOavFtGSFCTRDau/juSvF1v6YlEiIp
 1w0rv/CewNeFwHpOi/9TbuX1Sp7ST21344/EPCwx+FO6kZYp9fHYFHAkhM9XRlAcvzc4+54Mf0A
 Sbc9u2eY02Pl8PFCYP11qhCBc1mLhuelWsBHAxnNKtGzB4IvbjHXLVSkcdN8q4WNKkyAUmCB82W
 pn0TrfdaJXwsBPSpFYQ==
X-Proofpoint-GUID: 62pfYdDdD8pXj-NUICWwMRfX2hE6MXez
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 08, 2026 at 01:15:27PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Most of these arrays already mostly match the most used and
> generally recommended coding style. That is:
> 
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
> 
> Adapt the few offenders accordingly and also use tabs for indention for
> two drivers.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/mfd/cs40l50-i2c.c   | 2 +-
>  drivers/mfd/wm8400-core.c   | 4 ++--

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
