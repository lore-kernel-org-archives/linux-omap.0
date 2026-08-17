Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236F3563FA;
	Mon, 17 Aug 2026 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953733; cv=fail; b=awbc7k71wvMrxtjSgT+UGvpElkFCVnJQfBu/2gI8KQU9fnNcANIprk8jMymxwZfOKrIjqciFY0ao4Z2rnr8U84VRbflG/wIaVYqK0lqYXmvkAtauGhASF5j2f9az7S+xuCxuYMrcDojEYLV417wGgzkztnYum4QwHY+8uRqDJiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953733; c=relaxed/simple;
	bh=2l3FApYajw3gdN14kJN//FtoE6SBDxjeKibXLjaQiLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BQRm5hS6Inp6vBMzLuUl2QqUD3QTfeEYREsDfAdckWeg+qqvruGuIkNp7kW6sRBieDfdjVxxSwp1PnC+QsDXM82Woee9JJ5XZ8k3CiZP8ccdOSVRMcMmVVTBeY8R4gy4yaxFWrLnV1qX3WQtk9dVoC4o6jbd7AZAJtJariCG3oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=L7x5XnX8; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z+zhqMxB; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="L7x5XnX8";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z+zhqMxB"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H5HJBx3561258;
	Mon, 17 Aug 2026 03:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=yjRtIviBEk/1bURstdckk3VoaVxgvBjTJcQ8LEwWb
	50=; b=L7x5XnX8PIPPkdeXWp339sOlUYuU+prAxNcOZydCJPzXjyd+m52k3mxs5
	+Pac6miC0kH2RqJMnDiQDGrCxCsCA6N6CfVzoZb72U95vuhe6x+Kq+XBOB1HxLrN
	z4bb8BvCjvxF+n6J5iKGfL/YHW3j0/8EU5C2zAVdf+Zpavpz/amGAlPoIgpagEAV
	VsJdwTXof22ocsW5O1uwZhOZBKg0Hgsgc8EMCjA1/cKVqT1sJz6d0/i5AyvOx2K7
	zFDs+Qh0rf9Ay4vCpI0UEWMiO5fQb+PVoZ1Iqx481b24CMzezMUNTtv/p0FE0LAA
	f1hfSTM5eJf3KG3Bc23jZGwlMXlaw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g37g6my2h-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 03:00:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a64j1cGx2LNPAP3NyLN9JeR1sondheq9OcmVhO+C+bxx/G6kGQf/S1P7B6CMUrRUrrAdsg1wfY9wybIymKu3GPawFxw24P2a1tWcLeippwzBLX79hLTsAVdXna9uO+VGiCjY6bZOkV4SIv6bxW/07bzJYoXtiegENYXgWYOVVeEf00CmREqurun9mms+dHwl6BnpZ7wbbw2GodHS/fpM7uZ0L+SjRBDchqsg+kvQQxD8wa3ailQ0w6T0Rvgsp6dZwMAzTPpZTxUZUU/GGruZhMm4HN0MEpt/sJjg70KXa70cIG6YANIWb3OhF1zx9o/Y+TzCAYnut3iKEF1b7Z7EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjRtIviBEk/1bURstdckk3VoaVxgvBjTJcQ8LEwWb50=;
 b=UW3UDjA7kva9xNSXLJU9w2k5D19WSsuZ2oZzIt7UQDyF50nP0J/zUPVp7A+B2fcF6dVXiwpyY21xcv9XzQy9jd9JcUU5g4jyt3xPY7/FCpSPL1Kbml3o7MZO4NAUiGlx2syI3HGCGOtkjJMMSnAtUz+RiUXLwIrOnpQyFSdecyObsiFPMy+1P8WrUjqxHaGeSikfJPmjE6yOUF9wwc9WMg77hRGm+WNGeLUKnbPuIbYt9rgIq+e9FhmmQ8rfPNlQCbuhWLXQRgCrNiKL4Rpa4bLWQDAXOllUI2+i/QQzvNpQyN4LOV9XI+yArJVuibKeZWAKo/4c5DIoq19AWeoEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=couthit.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjRtIviBEk/1bURstdckk3VoaVxgvBjTJcQ8LEwWb50=;
 b=Z+zhqMxBlG/GfU4hKutLC/+8C/bcCwIXiNNjqE98hBlwWUVtlSwFnUORtfYJcrcr4DX87YweGHHbTAR/UB3vhhyFU3qMvDSD+xrF5ofvgoL528fF295Yq763csKNCfNNnBuYKqauBvF04moKlD+XPGf0vapcaii/4PWS+xJMED0=
Received: from PH3PEPF000040A5.namprd05.prod.outlook.com (2603:10b6:518:1::54)
 by SA1PR10MB997655.namprd10.prod.outlook.com (2603:10b6:806:4b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:00:20 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH3PEPF000040A5.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Mon, 17
 Aug 2026 08:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 08:00:19 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 03:00:03 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 03:00:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 03:00:02 -0500
Received: from [10.24.73.69] (danish-tpc.dhcp.ti.com [10.24.73.69])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67H7xtEQ3268650;
	Mon, 17 Aug 2026 02:59:55 -0500
Message-ID: <047fdf50-1d4e-40a3-a191-129b6dd005eb@ti.com>
Date: Mon, 17 Aug 2026 13:29:54 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: ti: Add device tree nodes for PRU-ICSS1
 instance on AM571x
To: Parvathi Pudi <parvathi@couthit.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <aaro.koskinen@iki.fi>, <andreas@kemnade.info>,
        <khilman@baylibre.com>, <rogerq@kernel.org>, <tony@atomide.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <richardcochran@gmail.com>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pratheesh@ti.com>, <j-rameshbabu@ti.com>, <praneeth@ti.com>,
        <srk@ti.com>, <rogerq@ti.com>, <krishna@couthit.com>,
        <mohan@couthit.com>, <pmohan@couthit.com>, <basharath@couthit.com>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <20260723102041.372148-1-parvathi@couthit.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260723102041.372148-1-parvathi@couthit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SA1PR10MB997655:EE_
X-MS-Office365-Filtering-Correlation-Id: 080ab586-e47c-489e-cec3-08defc35952a
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|921020|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
 CunVgaNUbQWqw3Mh6vmoUvVz33GcOERxJghsVqv8WMWR2p678rodqKCG8E6rHFzvIcHIrOGLNwVU54Qn0z1p+h4E3Ee30bL2Ofr5GXeMWEB5z7nZf9poMSAXAxg4kbdPlMGUr1Iq9MX9iWt/RJbXbMN6PjMIsn2jaOa2Gh0lznJsMPrWgGNzcscN9rpjFFrw+71i8y5gGkzUAqyEklfux+wY7Kn28AFmXhhMEHT0sYh9Dyh4Lpt3BR/+sYd2DJk0/sdk13RHC2I0I6tEAN+9gMMj/uNQhUoc81WZc3fxxOsX9IxXPS+10uJA01wABsMc9LQAAg5pfAPHRGE7Y55ENH1M4zcgqU0+FnY/fW7msEK9UYl/JmUKcQZrlLweZ5jxW76cgr5NhUuaGpNZFinHqgXtAzyruZva1ntuLQuOmukO7IIEUnUxqm3ELmpN4fDMaEoOJH46kEb/+F4N7GFo9Rfu3gr/Ngbcc46r393lw7bN/En6aXSmHOT2P8hF59IwqIfLp9zKkblPnSNAzqLi/IUfvF0JeDnGJSEZfdc82Ww9B8ybxw/BFJOMPnlYg1LHVl8uFA3/nN/poFp/jJA2lI6y97Hf9exiAtHAh55AY0/wmbtW3of1XZaP/vCFBp1GChOWm+dGoJMY4hTUP/HKIv3rsD2DuCRtgyoAhnU1h7C1N/chYg86ADj4cxUX3dMdhcczOgYFmXSHlA8B6AtEFrvh1XJRJ51K9W+i2KFiDFnP2vxUTUKqgl67rkCatSVh
X-Forefront-Antispam-Report:
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(921020)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 LBUF63TPWOwFpJKPNbpPEJUUh7GhQY+JWt7BdahxRQ8LurqtuTmRAf6RhpmbDf10kP4gP22YqJnZG1xRAHzSf1w1LxrfQ2hAwv9n8wHZeZlEMMBGfo7drQg0K/Nu8oh/Zn5e+EJIpPpMN0NgVCwN4WQwet78fb9q3YE+ql5NTza3R/oKqMTpYsdvZXscKdRYeb20m9CBXj7o94dwlq7U7aVxy+BmzOkAdEE88WuUL2OAn/pZuM/sj75seEevBIeyHEct8Npt6z4I5JOTeftVnmaMGRCEoxEiF7TrNQZSYtZ+7D7qPmnJOOGE+hE4GVmrxTPuOkB5O76BbR4g8cJZ1l+PikiWcyccsJF6fm2MRsep/iWSeC9j/NSztGE+/LyaYBsQHL8zJ3zbP2OhbaPc/u+X7LCLgv3mMibcZhmz5b9aIA376ZVKwHAPi6MicyKT
X-Exchange-RoutingPolicyChecked:
	oQMuvROKLYLjgzKOLDQidd4/ajEEgUIzMYlNNBSfiVHvHNRJcjdckNdzpeAfmzqfg/bsKXFYDBTfu3oKvW6wb9hFuvGUh+C0rcBQWyWuvSHxIahd2sWNDD1FcxNkj5YRNKp2h0Blo7PyP/UEQGqDEzKkTq2lWM4ab4PUR+50KDatxeKqtBwEZ4mkoBiUqlC+9WKINCNirtz53WfWUTZKUmkPB2YVlDEZYKkU0MJ4eyf/FlR0nQSzjnUBZJp1XpnKPihWDN/qEaAQVD6uvUUnGS3XZ8XhjmEavLEHl5AlB5Ov/6WWNBH6UgnmuHjWoKeRBskZRmYhtDWywzkrois3Hg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:00:19.8605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080ab586-e47c-489e-cec3-08defc35952a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997655
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OCBTYWx0ZWRfX8b0/jsIsHYb3
 QkF5RtXjTGdRCSfJZN+27+eoejwnY17PJ60aRnvVeZyRMWN5XO6m73riIk4z9GtLfIMAjpupvE3
 W+kVZ7FhC0n7jaD0g5qQrk8EAlgLdVSXZc1vWDtfLnjIZUWFtgtQF0gHh3Mg50ZH7wXDG3xGFUQ
 NUpHipZgeI4qGEy1juWc0xwrN0gLM8IQWnuqTgOX2wi0k+srOZIfUO6kzqC8KS3RZy9eJG8eTr8
 Fmc9VE70it/LtzBuAE3iJw5Z8JtaDzxWtUiWrqINzTU6g/AI7QxB8iufDmwAAKseI0uxT20Cy0V
 f4Oh63DmGc8jKHXE9O/Yb3hxTuIhw53GjASaWZmajOipxo014FuXG+iACu8s09clbdcMCSBdKv6
 F+WTrJgRBkQ86K+doIuk9cuEE7fqtlADvorCarApj+nRoQFZipkypWL+XbYOYayS7tb7VWpzKfL
 1vLQCy+HvYhOhqOZrmA==
X-Proofpoint-ORIG-GUID: jpUNlp7V23mhB6c-X5cqfitGVZC7Nfdw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OCBTYWx0ZWRfX+rZc9cJD6Drh
 2fruBsfQ3NYTVl174wDLKzCLHlHLJYnDCMFvMp0KJNUll7ps5iAlndWFjIe7ChIZVu4da3O2GHt
 DMqu95JZDtgDRvTSvIgdQ3BXkT8Rt9I=
X-Proofpoint-GUID: jpUNlp7V23mhB6c-X5cqfitGVZC7Nfdw
X-Authority-Analysis: v=2.4 cv=WpQb99fv c=1 sm=1 tr=0 ts=6a82bf98 cx=c_pps
 a=JQIjQaBRt2POjw1IEeT7Rg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=uMrLXzhIAAAA:8
 a=MLazI_4zTlizGiZzHSQA:9 a=QEXdDO2ut3YA:10 a=jlbCQfFxfIo9zxDJvpnn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170058



On 23/07/26 3:47 pm, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> The TI Sitara AM571x device has two PRU-ICSS subsystems: PRU-ICSS1 and
> PRU-ICSS2. DUAL-MAC Ethernet support is already available on PRU-ICSS2.
> This patch adds device tree support to enable DUAL-MAC mode on PRU-ICSS1
> for the AM571x IDK board.
> 
> Each PRU-ICSS contains two PRU cores and several peripherals, including
> the Interrupt Controller, IEP, MII_RT, MDIO, and eCAP. This patch also adds
> the IEP and eCAP child nodes for PRU-ICSS1, making its layout consistent
> with PRU-ICSS2.
> 
> am57-pruss.dtsi: Adds the IEP and eCAP child nodes for PRU-ICSS1.
> 
> am571x-idk.dts: Adds the PRU-ICSS1 DUAL-MAC Ethernet node, enables the
> PRU-ICSS1 MDIO bus, adds the two external PHYs, and configures the required
> pin multiplexing and interrupts.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

