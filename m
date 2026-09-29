Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463B503BC2;
	Tue, 29 Sep 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675373; cv=fail; b=bO8uVC1o9C02DTkANNRj7BrRVmSGXCrOXUE5oie5j7k26j4YFnvJH8IOPOiXORBxCfMBlm3n1cohjFoYjcAcUyqIfo148xobsrnsz7A9O/AznaEMD7d2Al34yaZ6tshVVJRCPB5v5GLELAFyT4V/FTYuh5MArd/C4pDFUiXDeN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675373; c=relaxed/simple;
	bh=2JP8tKBZubL/Eh4/T/ioK0BMCDNx9u8IxjF2VBDlTkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XlpTPJkI6MfaJeZGXJcCYSSi15L6I+gq2lErZ/CSQl7y9KarsQXjcZRScnVvrEuVpbwrOeozbiGhSIJMFIGPCSzVhNA1b1nlM7LHoPcPCv1FgE8MGIKbVJhjjZHLTL5eDPdsii7br48/E8gu8xwH/Dv6+pgihr3U0EOA25eDRQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=e6xH4lRd; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=qZCG1UFW; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="e6xH4lRd";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="qZCG1UFW"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T9Zh0W675500;
	Tue, 29 Sep 2026 04:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=w5nis3cFn8noKArpSPkvL9j/6nmtC/tm8Zu/TQA59
	0M=; b=e6xH4lRd2TluRmcPFjr8ycGPJbw2s8PWPuLqHGEPDFJZcRsVR1hw3umRL
	0mvH6+BZLdXzPkYiZCNVyGz+t0R3pnA/NPY/XD9hcRowLDtii7Xd7vcPj4QDFEAy
	KXxxHtMRF1KgR4tqWMvMpWNILz7wMkbZ1eupdBYrz0prkD08YktFTxLGZzifkjSv
	s1yjli7w9D8vxdi9gOLFov/44c4E5bnEvCTQTYB4TW9nTp8sWNLSJc8rYRxCcTt1
	jZnrQtZXrBTgOguH14+5b3tzxor+drp20ax/fB1heyqZZQ38L2vCdgH8f8ok2QHh
	OwOooue9c+9/FLG77tccsCsHGyqTA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h02j6aycb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 04:49:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO9IUTHw4B9o3jzkbpgBpKSD6lGIbVmq3eWVqGDRJA2ZV/FdBzDNnYc6vKZqK8v4wEWA62Uvp9FG427s9O5qAue8JcLyCZ+q6jqcEMh7+QSh1J78jWC4taTItAR99RsfYndOL9bmziaB7lX2aOGOEsC1M04cUhWyDee1x+vlVwoD1fi8pjY8hqNkxlVC7n16GT+LIh676+6nOtzHpH+cFTJXjoCQshGjAwHq5jkABGL2vOT+fZMpQYbKkbYe2RCtPS7BMlRmlaV+p5EzN+D2vsuXaeQWKBc1B7Ku5Fiy8VaiI9gIxMi2bvD++/n1hCSIzJX818f2OUUswdk/rCIiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5nis3cFn8noKArpSPkvL9j/6nmtC/tm8Zu/TQA590M=;
 b=RzkGTJS+sYTgxMJ0uQj3PXhKth26qciXr9TU+LdTUNUeTvDOcjfkxwO6sjj0frRr7NTGid5EgBqpTz1jIHSXRdNcAiV9S5ljJphm2zfhxuI/7Aqy5msa+kWxGEtIOlc5kVf0Ns4LUQv/5jegsBucle5UeJd1afn/50u7ukzf+fCo9NcgIK2/6NuHxW4RFig8NBubcadRSbUvojUUlnu06GGB1bpokEArFfGJucNJ59vsbTQuDvSHmWvuKJCfaQ2o4VBTtodyA2m1v+5V36pkuzEykg8uSlmAf3y9Aq3xmFoG3On0y1stx9NvVM2o7tmAuYnYuftPmxzi1ybQKCi7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5nis3cFn8noKArpSPkvL9j/6nmtC/tm8Zu/TQA590M=;
 b=qZCG1UFWqNAYG5LdyEWdIpQ9ecDc7y0Zv/UUfUHJHQxZ3xCIN+2seKA9Xxuvy9pOVr8UpwrmoeSC1GYB3u3CKTZ95JWr8UFlB/O4pGXBY9RSrHKUyKONhkxB3neAOwOax8EQ9He0AYer0YbPhMBez4XL9Bt9gvsE33YpRzHJyOk=
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by IA3PR10MB8662.namprd10.prod.outlook.com (2603:10b6:208:570::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:48:59 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::23) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 09:48:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 09:48:59 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 04:48:49 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 04:48:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 04:48:48 -0500
Received: from [10.250.149.129] ([10.250.149.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T9mfLc1687376;
	Tue, 29 Sep 2026 04:48:42 -0500
Message-ID: <10454dbe-1d94-48ed-afa5-5910e6df21ad@ti.com>
Date: Tue, 29 Sep 2026 15:18:40 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <s-vadapalli@ti.com>,
        <rogerq@kernel.org>, <kees@kernel.org>, <arnd@arndb.de>,
        <stefan.wiehler@nokia.com>, <c-vankar@ti.com>, <vigneshr@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20260924052146.594157-1-danishanwar@ti.com>
 <179057463349.3145.13175831323497920715@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <179057463349.3145.13175831323497920715@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA3PR10MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d851618-2adb-4e9d-9ec8-08df1e0ee31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|56012099006|6133799003|10067099003|22082099003|4143699003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	B2ohI0Rl75XP1xSLkiK9bgF59SHOuECAKpH1+NQCNMiyej6IHLTcZkKWmUnhVD2dVSjFYacGqwnm/L23gp87hl9kcwCPx/okeGH6Ju5lq70H0mZFSnHE6PVrJ62QsVet0++a8yGZPs3SvSBRDe++UDdW+nTshcQ3Ndz2yrU94BZCoe6QB5lcE02Cmr9fc/QoBn435Ig/gDCorS61ZMAhilBiG5ejzwnlGKhedVgIi9ngr/NoVcbNHthE0hAjcKFE4Nt4N30fpvoa6bKd1aPMvjDTkxywCLXFq7GNc9yBRjlRdogDuMfdD4Ze5YBotixXeWoSZ9sqnhRlGHOJHRpqBnjr9lVMrUvDc0O0n8YchBP040vMECM3sMfoFyY39norv8BDNWdEsnvFl+QYMgwgebojTywRw4IfRsU5/4+xu1BCDyf9dPILPajA+EFQrDUpD9xh6ySVe2BooABMuW9+Wy4iBoLwssv4x154+ecTPlkUjsICYfrovKjqmX+bjqFYJiWRjaVXbqbBer1qS2uVlDydJrEFSpd7/mQL/mdXV1ZQGEVtzsK2W24ZeNdvu1fn/KB3rZdoMGpoKzy4wi9qhSIoFYZHPV6l0ev9wxFzsbVnDmm8ME55znrnopD5QeqD92Vifzlobm1Dqcv3rWAodpOGufFai/zOnpape2kRlhKs8Vj07EpX5NEThBjErI2DmNyY0r2Lr9nC4hapHPrAbQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(56012099006)(6133799003)(10067099003)(22082099003)(4143699003)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	75wsIMrv2SgAz6GOrec/bTJ9SJltBUaDl4N+VKLSftVS5/9ki6rHjow/3Z3yC63UjITHwp8WQHcjgG8Je24oj63hgGlgZtRLTi+m8NMbnjv/rKA6Ob6MfWhVTS+KE6cULYMNYHDfycp+P852QxuExSFjWDCAYFtc5hcvDUrvHQ5jLvnErGktGo58GeEXDE8LRKqiVNNe9CumVCfSnlJKxKrIjTdsyYGgNSgmH1Pus8XUCn9VNvrGGL4NkUpIqAyAUSbUYjeMgExd2nCeoBbsdfNM9+BzhtT+6Npu0FiwkySBO9LAOSG6R2ytX4wpiX2/6iNwTT0S0/Jo9XDm3Blnfyl8Bt1JwXjwtgEWWTqhZ+r1QIEpNp8WA2IfhTwwWECx+TUnO2IVoCoyJpB/n5eQIYM3SzkgnUpIYiqQ2kKeL+U46tkg1YNi3T4JFffsgwuc
X-Exchange-RoutingPolicyChecked:
	KKuHRvS80EN0L2VGC2K0TmV86/I9vjCLeb9xX/6WGQjOorsSnDPnWntWenPe0V9wouXdsdE7CCUYIv5SUsHRGaKjeK0nvfACoqgwgqTN46Ay4szRY5tvEFs38+E/Frji96pPJaXUMwi8iFCeN7/x6NL45e4oPdIB7g3iQWFESSHffMf+iLiriQHlVLzk883ODv1mH0B6ojWeTiI3luZ8K4yVGRGdryfT/ID0CP8csolNZC8X2r/FiQwmvCjZzWQ3qHWiA3Qz4rSi3g/19YzQqYl7fMwTyt2tigMvclev7Hl/DW9Untjxoj+wSNcRl5cnAWeo4b20SCxqbDLBmxIcsw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:48:59.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d851618-2adb-4e9d-9ec8-08df1e0ee31d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8662
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX88vN75ka7kqB
 dvyTJhrQfnbTvhE+51zHbkHgvfGL9kSRBxfI6r4YLRZy+DrrWCnnfBuXdjaTa9witLx0qV8vegC
 6VH38BY9l21SJWF26jRk50ViHVmGZjs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX36BgenbXAsVt
 Au7YjM1T9R+pRGYK6Zx1DBID9V5Ht4SMdgrieCM2PvjUvwd2bkvsy4zZFKqd1ktFoU8p/YFIuS6
 2b1d1Ls7k7n3A3xc5Kg4NinnQ2z03w5+lqoekVvFjjj6LuIOCc+qHHGsktXN30s9XN3mOFizVup
 PCsd4mzmmMUZqoGAD9YvDVPPx3LkV7ia99vHiofiQf2f4caY5l/9XbVQbYwGssabCv0k+TM6Zwm
 6Lqc80Dlz7pNQWEojAwXeAQ+aZstJ+2H7hxQ3PQjNoUO9eTVaXjgwMfBVUJZr7L4/NWjPDRVvne
 7V9c4Jr2r6hZEjGOYe5uDxvEt3kEzP+9dlYpDR0uf1QM+kGIEoNsCpPfjRnszIbzIGPdonlyZ92
 I0mPng7t6bm5WgS2SmyzQvA9YmlVGHw8im6mbK6C8VD7hdX7MG1apW08ENMNRccydY8vYeQzDua
 DI34X9ehDd3XrdbTLVw==
X-Authority-Analysis: v=2.4 cv=Z4p5j3RA c=1 sm=1 tr=0 ts=6abb8993 cx=c_pps
 a=nAh4yJc8K/mwxcjpRfPwJQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=KOp0U8gsjfxvCJdU-DMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rSOyTg602TUaMv4EexPLJeDkVl88kkdb
X-Proofpoint-ORIG-GUID: rSOyTg602TUaMv4EexPLJeDkVl88kkdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290038



On 28/09/26 11:20 am, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch removes the `!fdb->added_by_user` gate from the
>    SWITCHDEV_FDB_DEL_TO_DEVICE branch of am65_cpsw_switchdev_event_work().
> - [Medium] Before this patch, dynamic DEL_TO_DEVICE events hit the
>    `!fdb->added_by_user` break and never touched hardware.
> 
> Pre-existing issues:
> - [High] cpsw_ale has no internal lock (no spinlock, mutex or lockdep
>    assert in cpsw_ale.c).
> - [Medium] This problem wasn't introduced by this patch, but the older
>    CPSW switchdev driver has the same flush defect.
> 
> --
> 
> net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
> 
> This patch drops the added_by_user gate on SWITCHDEV_FDB_DEL_TO_DEVICE in
> am65-cpsw-switchdev, so dynamic FDB deletes now reach the hardware. It adds
> cpsw_ale_del_ucast_dynamic_by_port(), which walks the ALE and frees
> non-persistent unicast rows that match (addr, port). When vid is 0 it frees
> matching rows in every vid.
> 
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> index 53cdac272b58..0dc681748b0e 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> @@ -397,13 +397,19 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>>   			   fdb->addr, fdb->vid, fdb->added_by_user,
>>   			   fdb->offloaded, port_id);
>>   
>> -		if (!fdb->added_by_user || fdb->is_local)
>> +		if (fdb->is_local)
>>   			break;
> 
> [Severity: Medium]
> 
> With the added_by_user gate removed, does routine bridge software ageing
> now remove live ALE rows as well?
> 
> br_fdb_cleanup() ages out dynamic entries like this:
> 
> br_fdb_cleanup()
>    fdb_delete(br, f, true)
>      fdb_notify(br, f, RTM_DELNEIGH, true)
>        br_switchdev_fdb_notify()
>          -> SWITCHDEV_FDB_DEL_TO_DEVICE, added_by_user = 0
> 
> This driver never reports hardware-learned entries to the bridge (there is
> no SWITCHDEV_FDB_ADD_TO_BRIDGE). Also, am65_cpsw_port_attr_set() does not
> handle SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME. As a result, the bridge only
> refreshes an entry when a frame from that station reaches the CPU.
> 

CPSW driver doesn't support any mechanism to indicate that an entry was 
learned by ALE so SWITCHDEV_FDB_ADD_TO_BRIDGE can't be implemented.

> Take a station whose unicast traffic is switched only in hardware. Its
> bridge entry expires after the default 300 seconds, while traffic keeps
> refreshing its ALE row. The ALE ages out untouched rows after about 30
> seconds (AM65_CPSW_ALE_AGEOUT_DEFAULT with CPSW_ALE_F_HW_AUTOAGING), so any
> row still present at that point is in use.
> 
> cpsw_ale_del_ucast_dynamic_by_port() does not check touched/untouched
> state. With vid == 0 it frees every matching row for that MAC on the port.
> 
> Would traffic to that station then be flooded as unknown unicast until the
> station transmits again? That would happen once per bridge ageing interval,
> with a full ALE walk each time.

Yes, for stations whose traffic never reaches the CPU (pure hardware 
forwarding). The flush fix is the primary goal of this patch; the ageing 
side-effect is a trade-off.

> 
> The commit message only describes this as a flush fix. Should it mention
> the change in ageing behaviour, or should the ageing path be filtered out?
> 

I will update the commit message to mention this change in ageing 
behavior. No code change regarding this in v3.

>>   		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>>   			port_id = HOST_PORT_NUM;
>>   
>> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>> +		if (!fdb->added_by_user)
>> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
>> +							   (u8 *)fdb->addr,
>> +							   port_id,
>> +							   fdb->vid);
> 
> [Severity: Medium]
> 
> Before this patch, dynamic DEL_TO_DEVICE events hit the break before any
> hardware access. Now each one does a full ALE MMIO walk. Does this path
> need a runtime PM reference?
> 
> On port-down the sequence looks like this:
> 
> am65_cpsw_nuss_ndo_slave_stop()
>    am65_cpsw_nuss_common_stop()
>      cpsw_ale_stop()
>    pm_runtime_put(common->dev)
> 
> NETDEV_DOWN then triggers:
> 
> br_stp_disable_port()
>    br_fdb_delete_by_port()
>      -> one SWITCHDEV_FDB_DEL_TO_DEVICE per dynamic entry, added_by_user = 0
> 
> am65_cpsw_switchdev_event_work()
>    cpsw_ale_del_ucast_dynamic_by_port()
>      cpsw_ale_read()   /* writel_relaxed/readl_relaxed of ALE regs */
> 
> When the last port goes down, these work items access the ALE registers
> after the last runtime PM reference has been dropped. Other ALE users in
> am65-cpsw-nuss.c take pm_runtime_resume_and_get() first, for example the
> VLAN add/kill and set_mac_address paths.
> 
> With CONFIG_TI_K3_AM65_CPTS disabled, am65_cpsw_init_cpts() returns before
> it calls pm_runtime_forbid(), so the device can runtime suspend. The comment
> there notes that K3 CPSWxG modules may lose context on ON->OFF transitions.
> 
> Could this access a suspended module?
> 

I will add runtime PM reference in v3.

>> +		else
>> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>>   		break;
> 
> [Severity: Medium]
> 
> This is a pre-existing issue that was not introduced by this patch. The
> older CPSW switchdev driver seems to have the same flush problem.
> cpsw_switchdev_event_work() in drivers/net/ethernet/ti/cpsw_switchdev.c
> still has:
> 
> 	if (!fdb->added_by_user || fdb->is_local)
> 		break;
> 	...
> 	cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
> 			   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> 
> cpsw_init_host_port() in cpsw_new.c enables ALE_VLAN_AWARE, so the nonzero
> vid mismatch described in the commit message applies there too.
> cpsw_switchdev_event() queues DEL_TO_DEVICE work without any filtering.
> 
> Should cpsw_switchdev.c also use the new
> cpsw_ale_del_ucast_dynamic_by_port() helper, or is that planned as a
> separate fix?
> 

Sure, I will extend the fix to cpsw_switchdev.c driver as well. This 
will be fixed in v3.

>> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>> index e202bba49480..86bcea5744e0 100644
>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> 
> [ ... ]
> 
>> @@ -441,6 +441,48 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
>>   	return -ENOENT;
>>   }
>>   
>> +int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
>> +				       int port, u16 vid)
>> +{
>> +	u32 ale_entry[ALE_ENTRY_WORDS];
>> +	int type, ucast_type, idx;
>> +	u8 entry_addr[6];
>> +	int deleted = 0;
>> +	int entry_vid;
>> +
>> +	for (idx = 0; idx < ale->params.ale_entries; idx++) {
>> +		cpsw_ale_read(ale, idx, ale_entry);
> 
> [ ... ]
> 
>> +		memset(ale_entry, 0, sizeof(ale_entry));
>> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
>> +		cpsw_ale_write(ale, idx, ale_entry);
> 
> [Severity: High]
> 
> This is a pre-existing issue: the existing switchdev ucast add/del and VLAN
> ops can already race here. This patch adds a new full-table read/write
> walker and runs it much more often.
> 
> ALE table accesses go through a shared indirect window: the index goes into
> ALE_TABLE_CONTROL, then the ALE_TABLE words are read or written.
> cpsw_ale.c has no internal lock. The only thing serializing this loop is
> rtnl_lock() taken by the switchdev work.
> 
> am65_cpsw_nuss_ndo_slave_set_rx_mode() is called on the legacy
> ndo_set_rx_mode path in __dev_set_rx_mode(). It runs under
> netif_addr_lock_bh() without rtnl. It calls cpsw_ale_flush_multicast(),
> which reads every ALE_TYPE_ADDR/ALE_TYPE_VLAN_ADDR row, including unicast
> rows, and always writes it back:
> 
> 	for (idx = 0; idx < ale->params.ale_entries; idx++) {
> 		cpsw_ale_read(ale, idx, ale_entry);
> 		...
> 		cpsw_ale_write(ale, idx, ale_entry);
> 	}
> 
> An unprivileged user can reach that path without rtnl:
> 
> setsockopt(IPV6_ADD_MEMBERSHIP)
>    __ipv6_sock_mc_join()
>      __ipv6_dev_mc_inc()
>        igmp6_group_added()
>          dev_mc_add()
>            __dev_mc_add()
>              __dev_set_rx_mode()
>                am65_cpsw_nuss_ndo_slave_set_rx_mode()
>                  cpsw_ale_flush_multicast()
> 
> Suppose cpsw_ale_flush_multicast() reads row N, this function then frees
> row N, and cpsw_ale_flush_multicast() writes its stale copy back. Doesn't
> the deleted dynamic entry come back?
> 
> The ALE_TABLE_CONTROL writes from the two paths could also interleave.
> Could one path then read another row's contents, or write its words to the
> wrong index? That would free or overwrite an unrelated VLAN, persistent or
> multicast row.
> 
> Should ALE table accesses be serialized by a lock inside cpsw_ale?
> 

This is a valid pre-existing race. Adding a mutex to cpsw_ale would be a 
separate cleanup. The current patch scope is limited to the flush fix 
and pm_runtime. The ALE locking can be addressed in a follow-up patch 
since the race exists independently of this change.

This will not be fixed in v3.

pw-bot: cr

>> +		deleted++;
>> +
>> +		if (vid)
>> +			return 0;
>> +	}
>> +
>> +	return deleted ? 0 : -ENOENT;
>> +}
>> +EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast_dynamic_by_port);
> 
> [ ... ]
> 

