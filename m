Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA1445AE6;
	Fri,  4 Sep 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524336; cv=fail; b=n6DF8lHXgfKD+R/vCfjlvXV/BFDD1fILZDnEZgDiEQGYr83kjO+ytE5J5bQU1oICR8VfQyG4u0TjPl5TnK1qCGxJYFtkE+ddc+XfAardyl8QGv2BEY25I6T05f52SYAp2IkLCFP4/iknoCIBJuUiFF04MWO3bCkCenwDwYyM8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524336; c=relaxed/simple;
	bh=akpT4zFhsHABd2AAgX1K6D5r3BN5XA3SXxCdQG02RMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA/e3D2bisaGQTDSTRoUcNvmAviCmnT507y8zQsVHe0vMQZpiO9lzsiv1TDsd2h8n5eevICUjyqT8MlUU/mxlJj0ShUJxT+JrC1qCRdNOniFdKR8dhSIrQiFy3RqgRegWehlaHomiYGWyRqLzxuRuuLjieNw61AFGwo3y29ObC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Qru1NFes; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=y+mB2nEO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Qru1NFes";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="y+mB2nEO"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6844HU2p2479378;
	Fri, 4 Sep 2026 07:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Sj+5aMY2yuNuOhKyG6
	wLa892Yt3ZhQuKHFnJY1HFgpI=; b=Qru1NFesv7TxZ/zTTndDpvVJ83qYvx+NWV
	/n6VXis/5cbDftXesXCW8rOKZlqNfDlHqSMuAcCWzhBCZjToCDlBubxvpRDEaYu8
	yJonZQKHosU/8An5wJKZV+k7/o6tpSzYYPiH6NC5FeIPOEc20EfPqiYBdyWnldbD
	iIjHDdLLxL1JeKK01Smo78XLjnsRAvt/WSRcfnB7Bb5SVNJlIas1W+nht016MtUB
	GpT/R+PCcRhEc4mmo0se9mudn+LJA4CV33DW/U1VKxne2ukAslBp1dHffE3Zzcff
	SnPM5+0lN0pp/W731bzu7DrRzZpnaqN/L6O5/OQG+ay+nZ4efRfg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazhn15011023.outbound.protection.outlook.com [52.102.140.23])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4geyrqj92b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 07:16:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ+tw183jh9y7Miy+T+ZNneIEB64IT/lK/PA464+eeIyxZSlomLUsb6R67J3W0a9J8uujKRFIk4lwdeaGzeBEWeLUZsRYSZINKaGMM0LOpmuTfbp0MyhHooXgKdos8GYHkuGAtao/ip8q5F3Kc3aAlUdbQ0Z7WeCGI9HN7KMT4yFz/vLT4zJzuSHMPpIdilPzNDs6UWmmYtdwgGq/BdsDF8fEmDySkDcVPQrKTfm62zJjAlzKK904JZoNaAYJneQLHbWmjCW/eRB4rRuqWczNI+TFMhEJCT8KFYjIbDrH4wpMUzbxEWizuUoeCpz+RMPAtRojr3asBcLmZ1AeDexFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj+5aMY2yuNuOhKyG6wLa892Yt3ZhQuKHFnJY1HFgpI=;
 b=VgIqd6ANDksUtbP0oRc72OS3jBJOWka8AaEUx2Hf/IWVcH6EDPBQQRB9wy/hmKeTglTAEgrkv4st9JFbmQJzImjXB1BvE+3irJ0wJWEimNUwUbBmLYS2M4NIrgdpA5goS4ad+fWgrRztzNPJQfDtCYwKhjE7ttzvRSD7PqJ6r7jemyiK0lSQ+e2uQewlRCxbNQB3ZBoHJKNlslOff2/Fhnhqm7Cc6jyTwoKIf0ryyo+4506myJtyFhLNR2AhEg3SN4io3yAl5ebQ+pT0RUDWwZrNUUJpzhubYMioE9IdHZT6qSTBiPUpvTggRQAuPx716zKjiyIMRd4ZvAXyeN/H1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=analog.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj+5aMY2yuNuOhKyG6wLa892Yt3ZhQuKHFnJY1HFgpI=;
 b=y+mB2nEO3q+E0iavWy77RNm86c6aqEzrQvOTwK2YNBofcQ72IvXC1Mc+6V6WCXojaBUWf8/hnRq8qE8MopdG1vQ+IvN7eL2d+jkWQ8wtf1itFblJgmZSbLCGg1KfRbDSIyWggVI+ePwgBhRzvPzEOWg5zDZo/sCE485xE23YjK0=
Received: from PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::14)
 by PH7PR19MB6088.namprd19.prod.outlook.com (2603:10b6:510:1df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:16:26 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::39) by PH0P220CA0002.outlook.office365.com
 (2603:10b6:510:d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 12:16:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 09554406543;
	Fri,  4 Sep 2026 12:16:23 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DD351820247;
	Fri,  4 Sep 2026 12:16:22 +0000 (UTC)
Date: Fri, 4 Sep 2026 13:16:21 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrei Simion <andrei.simion@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] ASoC: fix typos in comments
Message-ID: <apq2lVTP6tyymn5r@opensource.cirrus.com>
References: <20260904110315.11650-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904110315.11650-1-hemanth.selam@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|PH7PR19MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a3fc7-82fd-4ade-3488-08df0a7e5705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|34020700016|61400799027|22082099003|18002099003|16102099003|56012099006|11063799006|10067099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	fHKxuKve1yQOQtOLE+rm2ltXnt1xN006AlWKeOH2hvAfjAX/cBRtL3fLTnxX/FaSilbMATWJRfZQiOBmwHxSB6CtdsdY4og3zExpR74GW/SOTvh6IHJOjuLLt8x44iwRkQjJ/xUUGTYiM0WJ19kFVgFbh4zTieTuPEuSXXlH+uZMFsgiaucbLf/9Kab7xjHV98rWfsNeF4xIDnaSetYoAV27hYKA4OdEz13Pa38sj4tc0enVE7OWDosBzD7kmWCYDKHyi+OuWbOBI7v7kWD7CW2cqcQGAbQEmvEptTIWWiSo1QYu2sQ/tp6NDU37FPs60LWiw/Jb8hRk/1ovkjRlfHzVKkCd+WUn/iw0HuaNsltea3eDHo5y6q94z9nJbCadvnxZJ8GlEj4n8qB6zs4xFIyS3w6VvkIKszjP1ilrGlcDIUMs5GgW44YUo58GinFwA7NzhL7gcjdo9lGzQISaRlwGyiko06B2LqItWa1zl+M7ZZZoKXMTTtIVvL/b4vMD/qOwDcBugR4p9/drQjhZ2gVg3+8iEBvg/cY/nJoZXBWtS6WEiBzSnVjc5DMQmfe/C32SK0x4mNKo6C2U6E/GEycJ/OzR2d5IkImtNYdvmiQUj8A7qUf2x6gjurpkS16SaWw+06GF3iTiiO9Heo0zmW9uNQD3V3ipG2v1JuCXDl0zGvOIeSpdvKwL/JBEanVmQqqOcvJXACHuSh3zvTMX9w==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(34020700016)(61400799027)(22082099003)(18002099003)(16102099003)(56012099006)(11063799006)(10067099003)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4/UATG3P+x7p3Sqog5oWKvtRIEC+C6ZP1GmjUbN1IKdHf5ApdugGsfi94LJgWzP8QXj6fPD3vx5FB9K4LXb25wUsZ/qyaYxVuqsvpZh1FVPIy/WHBOcfoFW1Qg10v7ZaRzeC61F9j5LGk9AlgHzhBtG4O0fO+xSoAUXRszPWqVAz7wmhG8gvELhF5/0MuHZ3IbGI1YZoxtOTWR8CPtQ+tfNuwq6xULCgQN9YmHcdzOZ0/nEEURKF4WIhZGa9nHjvO43sia/BSoU6jSBsGUucwjIlXsow0exUthlfv0DW7FnGEHn7uuwihnTv0rR4SrbPDDU7YyMfm4MeA+KnKzO1GVWTd8Og0xzX3zqU8givTGQ5AvV0OtPsEs/iH+SQMuFosnijmMUCYrYIYAjFaMmDfwubKijEmfU0+CwOZutBjIwuURCorsNw9DsEb3JAxZvE
X-Exchange-RoutingPolicyChecked:
	M/byfnsx8hh+JhGTvW+i3nMQRkPVY1593nZlvdnTVKKoC40JyP9LWV/VuZrWA54WgaI9/4h4XYQFLorrv1fN3IuuL0ZeME+ycbc9opGmSJSDchi5YQt0x2vgwieX+I2WyUrzvqwiVa+IIqX8HMP/dqdjEOMRDLZQq5WiuhM65tOyqSHawvxkZQ2atlH551TGTL05aGzUGZw+9VrnxA0u0vnAtj6uEChjpCbE3gnksRXQ8ZSdcxHs0oQHgS9wslZG/Dge9/wIFy4JKvtah646cH7/Sewm6fvhKqjOTqeHIGLPtVFrsRCFzgkPC7/m8JAe2PchP5UsokIRS/xFdXMFHg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:16:24.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a3fc7-82fd-4ade-3488-08df0a7e5705
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExMCBTYWx0ZWRfX/5j9x+xsGmKR
 n/bacUt0uIwbopKKrxqwsKmnu0EiwvmVzUkZsx6zpCTCCh/QutPkb7yfItSbqm+oWD2CWCBQB28
 QgAjIQXHFueU+AlNI+zjPayfeyaD3sxK6X4SRG10/aQUzFklkbOAfGeoxDGRBR5QZUKIeRWmXvE
 tzuiHbYhX5Ejxm7yY+wIDanDwOH6fZNUIb9kXzbkIG+4rkr6jRwF8HFY/iYCoTnEBqTC7aG/VS8
 8wxBkrJEqeAqeBP4Z9nPdaZ+Ljx5TusihQriBAxejIaimpXEnjN407yW02WmgfnRfw7ungZ+iEB
 jQzyhigzVv3RDsQrF4XllMtCk8wyDTRsaATDiR3LxPMG/a/qbF4YXDcu/bto3NrppfbiSEaM0bJ
 gqRULXTHNzbaEbgTPKjEDsaCScw/kJxxTJR0XUBXHSPBymAT33qSzijAXUwv+O65Bn16nzkwrcA
 fwpwuKr2IAUFQ+Q63HA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExMCBTYWx0ZWRfX3jZ2QJ111mHm
 f42G0ic4nucJBGgiY1wPiVuDPo9D68RV2RGId+zMJsT4zt4MWfQ/1plv6Ozf+llZhlo9n8DDBZv
 Yu0IwYr/vGVgXxJOE2A4RUpm/bHhAkY=
X-Proofpoint-GUID: g5byBwPivZFQ-pGY8bCAPEq-F02MwuAW
X-Authority-Analysis: v=2.4 cv=A8Nc+aWG c=1 sm=1 tr=0 ts=6a9ab69f cx=c_pps
 a=yICVNc/tqHXuIRF/6KaW8A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=wbSmXUBKm7kmP3h1SjcA:9 a=CjuIK1q_8ugA:10
 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-ORIG-GUID: g5byBwPivZFQ-pGY8bCAPEq-F02MwuAW
X-Proofpoint-Spam-Reason: safe

On Fri, Sep 04, 2026 at 04:33:01PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
