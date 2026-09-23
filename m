Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AC3749F5;
	Wed, 23 Sep 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153617; cv=fail; b=CEiLHKn4TstJjR+T3P/njSIJSTBtbuGi3J9UqcjEnzzzXbFQJOTi5rZIgUqhQGNN95Y8i9Gdvf9jxh+hnl8lc/HYFVLnk16rnhBg/NL5Fupgt3He91cg6vBFxxqUR+48OigTX0D0KWJt9X0vfFVZN4KFUxSlX8D0U/BCnQBMCzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153617; c=relaxed/simple;
	bh=uaaSxXPtxjHrblyDqA+XcATHB8WF+tqm8+Q9XzU3RKE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cmhXkWWrPnoJ8UfXhvWDRotFXO5Lgti9FIDIhVym+YGNNegsfJ+ooUevOHfsYVIZm3I3O6RiY4WFvSZrifFdvtPQIGXwtu3Zn6DLK+3VeHYKRcaBYrQt8rKEv/Up4bJ5VX23nBOkP/6qElaDHhn3hWoukLSCv3mI830MnsPdVqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oWzQeMwC; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DI86kqdC; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oWzQeMwC";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DI86kqdC"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JHTc775756;
	Wed, 23 Sep 2026 03:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=xaDxWoEd0opjkIJjLq0i9T6HWDW3WxxIYIWVwQ2yp
	qI=; b=oWzQeMwCTuArT0k8WWrJw3qZ11E1gO+fd/ZKcpJgPrq6WmQLF1zFUVGeX
	aMa440o/Mc3V9SPuLkKWfRlByedtSkFyeX84e4E0qjZN6EpplX1bPR5fgS2DGw/I
	qKTnh8QsHkXyOfGYsqBRVj4Uh/fQH6C77/XbusAVqzvfYBe3Nf/SMhySYRZrXw43
	UXcKg9NaHMQM6W2lx/MlHVFchHTgqmRbp/QW0Htu9DY9E+RKvjyFl+gfFDlWRelk
	nmp0i+B5vJsiNFsZPhxnF3fPwnGmVZwF4ujfIBj66jOSabopz+i/poi+aQ8Ek+Qy
	YFlc6DjjpQje4nC/UiUcBjWDS0I3A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gv2ycttg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 03:53:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSAU86TmfzrjyCMnUhott6RQhMFEQPL+3f3KG481mM90Ob+/Ee7C6btI95arGSKDLA2rNxnUazX43nRIkp+SAoIz6hG2TzjHPH73F5b6cFMREecunTcKdCDEVe0eFy7QF8OwI6qfsZ4FXtZQfQF+RXax1PXGYP2VWq6VBFnfrTWRjNtbYpzUnOzgNrVh5d3w3legu27wLnzcy+7dXyPH+6aw/Ua20eWmmDrL9ebt5N8gychM6vVuTAc+6DXTV/3yOuVknL3sMSE6YnZ06znA9kDdzHVUI8c/B/uVae3Jc7kzGM3HbcntRGHJjcX880e3w/zuHMv1c1TvhLA/siKVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaDxWoEd0opjkIJjLq0i9T6HWDW3WxxIYIWVwQ2ypqI=;
 b=gxdOsNPIqkZ9XSBvmRhfCJHLp4XD4bSZUQup0L+jJfQ8VOx9zghjklrbr8puekgQDWKAfON2l3ySYjE5qPFOKM+/026DuVD3pQbiktpDvS/06oew8WkFW6ygCNinTpivVQ0m1iEh3rLsTaG9oRfjTvLWiPqjZdFU/cvxtXxFG4gqwgOWVs2V8fT2zFkxrqpKfDmIl1u/JyDPetUiE6kjkkN6kEMfgQnseI+s7vlmeQKhkR3Jl+bg6ifyfsX/ydel9CKtk+P9CsaGfIHfbAlep3mxeolNL4UiuBicTP1RN3NFE8so11Ehxcpz8RSlz/g09FvIdeyn4LZF9MfhE/iz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaDxWoEd0opjkIJjLq0i9T6HWDW3WxxIYIWVwQ2ypqI=;
 b=DI86kqdC50KKDOwNsqAL2OsiN+KPN2yHvIvJ2rMAWuyRansOnJJ/H9NYqyWBJ3/O9fv9+1JYBnl6nznjisQBk0eZs4KXlPiGjaHdiZgeIu/9Px6eKqMyqs13PIjV34JDb+T/Fl08bPK9Oofuwh+RGFOtxQ0Q80oOERbXvJpXGtQ=
Received: from SA0PR11CA0176.namprd11.prod.outlook.com (2603:10b6:806:1bb::31)
 by PH7PR10MB7851.namprd10.prod.outlook.com (2603:10b6:510:30d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.4; Wed, 23 Sep
 2026 08:53:05 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::35) by SA0PR11CA0176.outlook.office365.com
 (2603:10b6:806:1bb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:53:03 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 03:52:33 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 03:52:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 03:52:32 -0500
Received: from [10.249.132.125] ([10.249.132.125])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68N8qQs02593320;
	Wed, 23 Sep 2026 03:52:27 -0500
Message-ID: <01376ced-000a-415b-8e33-bc2041357a2d@ti.com>
Date: Wed, 23 Sep 2026 14:22:25 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
From: MD Danish Anwar <danishanwar@ti.com>
To: <netdev-bot+sashiko@kernel.org>, Danish <danishanwar@ti.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <s-vadapalli@ti.com>,
        <rogerq@kernel.org>, <kees@kernel.org>, <stefan.wiehler@nokia.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <arnd@arndb.de>,
        <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20260918075926.3616434-1-danishanwar@ti.com>
 <179006497666.2160803.14768308117153644313@kernel.org>
 <156f54e9-a0d2-46f4-99e1-f43f02f58673@ti.com>
Content-Language: en-US
In-Reply-To: <156f54e9-a0d2-46f4-99e1-f43f02f58673@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 63460a61-8b0e-4c1c-4ad2-08df1950146b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	fQ+foLIldkfECkTLeGX9B+6AxRDUj53LCSKUMlVGqQdgWbIrpYOzcNc85qd4TRqvYwHxHqULgXIn9X5gdDm15Jt019+eppaRS/fikRuzg1FtGDZ795/uOsktNsmlgsgQHYamnfgxlpokWczUDq57bVrYpp5Iex0S1dIXSVX2AHziXh2q6qMQkqrX0sYpqLLHqa911bCIsl7GB/118k+JqmmsbGpcwbG/4/2vnUPmOOTu7E8dDd/6YvItYpOB75c0tSyGGIu+6E5iea1JbQrxWqvEBJMIQED+8z8eNcQ8Luj0rN7nOtyzQ1RB2aJu32/VxD4XLTNCSUZOHxy+Qt2TchjgG5ifQp8uNdUZ/NSFz8rDre4yJHcZWIa+HlPT1aLdVLm4nep1SkWqe1XKu2Chl3/QBoVwbMQ+T4qYasRvE2Su80MSexiwE7scM3wiLzd7oYIOgWLULKcoR66v1g+mZ47nKnN24vKoZPtlWbV9qaLqQfo1XVjSoxUNQV+SyGW8Q/+OeKTPXj4rn/cAP/gHyHpAMHkWxzO2Sm17/hO37sEE05dUC2z+fSRSKHs1a7iYm7GlMJFIyI39PAzVYVpSyXsy8//xEh1M7jeDnePz5N2M0NDC5RNsrxb4DgtGvvSCu4pJMUNGovaYvVtWuVv22bAZc4Qi3IVq8v95vdqAAoihsmG0j9s5Fn3g7ofvak7dLoE0ECh/MdEw8RXuXIQ3TQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XgC8AgfkfQE1etePe/EreVQAy7bDkXdasMyVw/qEvbRWF9SMGji9jnExybPDESPvioRNk+4YHWgNpdJb6X9a1lxzkgxiwElrImFnGO31H9UZG313Vdpb/+t2EpVc5LRXov3hstK1A7XB8Dnwb2Ix/d4ZcLAzZarXbECNmHgeMp4hL7JmF1X0gBJyucsHCnsDeATnzYckuufBAY7Xomyw+Jq2eIRAULDKVKfyoJH511D44AvjvRtycfENQT6Y/0KvKUucV2oplY4IvNc1Xeof7RoQSHNuT9T1eg6PWxCTpWrCaJuNySGJpt+g3CcrdNBFakoVT9FYXtitPuM1Jegc/Ol+cJk66nCeCyzp8gwHWKGZ3EPYwsSxCkg2QY+s0wpUBz8152p2CZmzUh+n7FhWHKSavE0+4lUQI+B6tz7Y2E9D7Ib4losrsgoDUyw15Ce/
X-Exchange-RoutingPolicyChecked:
	xybv8mULSc+88j3HgBavIg3e27qkkNv4GUMoSyGXIh6OosUpF0vc0MzZ5qb/910/9r9y+tOnFHpWnwYvcDdBs8CQjOuoEIzeDJKZw5yVSJz998if2XDCYlFo2QACERRh1loJR0azxvbsV47iaQrQZ5fs/HYDpcnTTv97AEStaHuKWVMxAelP9jaX3traQLWqzw0alGCYKatSb31lANo/nKpuP7QSiPWbFSWWcEcfMSk1TT0UvJrZGvpZX5TZQgT+cshVNX1zHIhgU6U+mzu+FYoD30AjQyaYQD7sz0IctEbfiv0TMdgeZLJLHMnnoSZx0RjMQxsZEQ0z1Fp2Z1S4Fg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:53:03.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63460a61-8b0e-4c1c-4ad2-08df1950146b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7851
X-Proofpoint-GUID: WVTz_kb5eaas93VtXewtSXo1KtiR5FKw
X-Authority-Analysis: v=2.4 cv=WZKZ+EhX c=1 sm=1 tr=0 ts=6ab39376 cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=BZt5ZaBZ-fJhPgm30WUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX6W3FuCucrOMv
 joRTlzJ4sW1RXjTC9RPPoDJ88Pqxly+XbEd9eWoJhUBHoZ0SYUTivxzhzrxRQMt/UQrn7gCoS07
 Ps5QVLq53hbmjMlFcbn0pyz6fyIYtSRoebVq4S6HcRiYzIsA3H8hIx9670irmq//pt75TcABSJu
 YrIVnxKRbXMBn93E7Vg5rkuPrRDClJEYa1jU1AF3qHgvHTTPV1atOwaFcWiZr5jMC07FajEnuao
 ywIEtizmorBJkATc7evhRC+fj/RDZ53vvVGOzbSFzd4Y+b9wv3g5pwqwk/1Nqob7POnszVtaAya
 LFkOg3zZewSzNoffuS+/3+97xuqnTLA6yhEwRR74+yzwGHETwzxQcxifN4ySyYK21ljrdF2HOnh
 0Ti8M6Mns7+cF9YyaDVKKJ18kP0S7qGM+wrkek80vkwduiNR6skr8yw8YPPUd7RFfDipy3FV8a8
 Oux+LPSFg0WFgm/0gpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX0+j6tn9WXn8M
 n9h8jeDAXXhYGRIuio81sitK/zX22nVRdGkLM7ZTyrLN0Yj3FLBrYFDWq/s/kd+1jeV0dyRr9Bl
 1C9EzM/bOipajCesNWIsGXmLu30CwiQ=
X-Proofpoint-ORIG-GUID: WVTz_kb5eaas93VtXewtSXo1KtiR5FKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230035



On 23/09/26 1:57 pm, MD Danish Anwar wrote:
> 
> 
> On 22/09/26 1:46 pm, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0 (1)
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply
>> (one such reply per series is enough).
>>
>> - [High] New cross-module ALE helper
>>    `cpsw_ale_del_ucast_dynamic_by_port()` is added to…
>> - [Medium] In am65_cpsw_switchdev_event_work() the `!fdb->added_by_user`
>>    gate is dropped for SWITCHDEV_FDB_DEL_TO_DEVICE, but only the `vid ==…
>> - [Medium] Dropping the `!fdb->added_by_user` gate makes every hardware-
>>    learned (dynamic) bridge FDB delete run an unbounded full ALE table…
>>
>> Pre-existing issues:
>> - [Medium] cpsw_ale_del_ucast_dynamic_by_port() performs a full-table
>>    read-modify-write walk over the ALE indirect access window…
>> - [Low] The identical stale-dynamic-FDB defect remains in the sibling
>>    legacy switchdev driver drivers/net/ethernet/ti/cpsw_switchdev.c…
>>
>> -- 
>>
>> net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
>>
>> The patch drops the added_by_user gate in the SWITCHDEV_FDB_DEL_TO_DEVICE
>> arm of am65_cpsw_switchdev_event_work() so dynamic FDB deletes reach the
>> ALE, and adds cpsw_ale_del_ucast_dynamic_by_port() to clear dynamic rows
>> for a MAC on a port regardless of vid when the bridge reports vid=0.
>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/ 
>>> net/ethernet/ti/am65-cpsw-switchdev.c
>>> index 53cdac272b58..8b4640809cf5 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>>> @@ -397,13 +397,23 @@ static void 
>>> am65_cpsw_switchdev_event_work(struct work_struct *work)
>>>                  fdb->addr, fdb->vid, fdb->added_by_user,
>>>                  fdb->offloaded, port_id);
>>> -        if (!fdb->added_by_user || fdb->is_local)
>>> +        if (fdb->is_local)
>>>               break;
>>>           if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) 
>>> == 0)
>>>               port_id = HOST_PORT_NUM;
>>> -        cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>>> -                   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>>> +        if (!fdb->added_by_user && !fdb->vid)
>>> +            /* vid=0 here just means "bridge doesn't know the
>>> +             * real vid" (vlan_filtering=0) -- the dynamic entry
>>> +             * may be stored under any nonzero vid, or several.
>>> +             * Delete by (addr, port) instead of guessing a vid.
>>> +             */
>>> +            cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
>>> +                               (u8 *)fdb->addr,
>>> +                               port_id);
>>> +        else
>>> +            cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>>> +                       fdb->vid ? ALE_VLAN : 0, fdb->vid);
>>
>> [Severity: Medium]
>> What happens to dynamic deletes that carry a nonzero vid (bridge with
>> vlan_filtering=1)?  They now land in the else arm, and
>> cpsw_ale_del_ucast() resolves the row through cpsw_ale_match_addr(),
>> which compares only entry type, vlan_id and MAC:
>>
>> drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_match_addr() {
>>     ...
>>         if (cpsw_ale_get_vlan_id(ale_entry) != vid)
>>             continue;
>>         cpsw_ale_get_addr(ale_entry, entry_addr);
>>         if (ether_addr_equal(entry_addr, addr))
>>             return idx;
>>     ...
>> }
>>
>> The port argument of cpsw_ale_del_ucast() is never used, and no
>> ucast_type filtering happens, so the row that gets blanked may belong to
>> a different port or be an ALE_UCAST_PERSISTANT row.
>>
>> The MAC roaming case looks reachable: br_fdb_update() emits a dynamic
>> RTM_DELNEIGH for the old port while the ALE has already re-learned the
>> MAC on the new port:
>>
>> net/bridge/br_fdb.c:br_fdb_update() {
>>     ...
>>             if (unlikely(source != READ_ONCE(fdb->dst) &&
>>                      !test_bit(BR_FDB_STICKY, &fdb->flags))) {
>>                 br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
>>                 WRITE_ONCE(fdb->dst, source);
>>     ...
>> }
>>
>> The ADD arm still keeps its added_by_user gate, so nothing reprograms the
>> row afterwards.  Before this patch the gate made that path unreachable
>> for dynamic entries.
>>
>> Should the vid != 0 dynamic case also go through a port-aware and
>> ucast_type-aware delete, so both arms of the new conditional agree on
>> which rows a dynamic delete may clear?
> 
> This is a valid issue and I will fix this in v2. The fix would be to 
> pass vid also to cpsw_ale_del_ucast_dynamic_by_port and if vid=0 delete 
> all entries of a mac. if vid!=0 only delete the entry matching the vid.
> 
> The else path would remain unchanged as it will be only hit for user 
> added entries.
> 
> if (!fdb->added_by_user)
>      cpsw_ale_del_ucast_dynamic_by_port(cpsw>ale, (u8 *)fdb->addr, 
> port_id, fdb->vid);
> 
> else
>      cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>                  fdb->vid ? ALE_VLAN : 0, fdb->vid);
> 
>>
>> [Severity: Medium]
>> With the added_by_user gate gone, every hardware-learned delete now runs
>> a full ALE table walk in cpsw_ale_del_ucast_dynamic_by_port() while the
>> rtnl_lock() taken at the top of am65_cpsw_switchdev_event_work() is held.
>> The helper has no early exit, since it deliberately clears rows under all
>> vids, so each event costs ale_entries times six MMIO accesses (64 entries
>> on cpsw2g, 512 on am64-cpswxg, more on j721e-cpswxg).
>>
>> The event rate is driven by network traffic: learning, ageing, flush and
>> especially roaming, where one RTM_DELNEIGH is emitted per roam.  An
>> off-box host can keep this going by sourcing frames with the MAC of a
>> host known on another bridge port.
>>
>> Is the added rtnl hold time and MMIO load per untrusted FDB event
>> acceptable here, or would an early exit / bounded search be preferable?
> 
> The cost associated with full ALE walk is accepetable here. The ALE size 
> is small (max 512 entries on the largest supported device) and the event 
> rate driven by normal bridge learning/ageing/roaming is modest, so the 
> added MMIO load and lock hold time are acceptable.
> 
> This is acceptable and doesn't need to be addressed in v2.
> 
>>
>> [Severity: Low]
>> This isn't a bug introduced by this patch, but the legacy sibling driver
>> drivers/net/ethernet/ti/cpsw_switchdev.c still has the exact code this
>> patch replaces in its SWITCHDEV_FDB_DEL_TO_DEVICE arm:
>>
>> drivers/net/ethernet/ti/cpsw_switchdev.c:cpsw_switchdev_event_work() {
>>     ...
>>         if (!fdb->added_by_user || fdb->is_local)
>>             break;
>>     ...
>>         cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
>>                    fdb->vid ? ALE_VLAN : 0, fdb->vid);
>>     ...
>> }
>>
>> cpsw_new.c also sets ALE_VLAN_AWARE unconditionally in switch mode, so
>> both premises stated in the changelog seem to hold there as well.  Since
>> the new helper is declared in the shared cpsw_ale.h consumed by both
>> drivers, was leaving cpsw_switchdev.c unconverted intentional?  A note in
>> the changelog about the scope would help.
>>
> 
> This is intentional and unrelated to this patch. Can be added later if 
> needed.
> 
>>>           break;
>>>       default:
>>>           break;
>>> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ 
>>> ethernet/ti/cpsw_ale.c
>>> index e202bba49480..1a2aceda3dbe 100644
>>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
>>
>> [ ... ]
>>
>>> @@ -441,6 +441,40 @@ static int cpsw_ale_find_ageable(struct cpsw_ale 
>>> *ale)
>>>       return -ENOENT;
>>>   }
>>> +int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const 
>>> u8 *addr,
>>> +                       int port)
>>> +{
>>> +    u32 ale_entry[ALE_ENTRY_WORDS];
>>> +    int type, ucast_type, idx;
>>> +    u8 entry_addr[6];
>>> +    int deleted = 0;
>>> +
>>> +    for (idx = 0; idx < ale->params.ale_entries; idx++) {
>>> +        cpsw_ale_read(ale, idx, ale_entry);
>>
>> [Severity: Medium]
>> This is a pre-existing property of cpsw_ale.c rather than something the
>> patch introduces, but the new helper adds one more unlocked
>> read-modify-write walk over the shared ALE indirect access window:
>>
>> drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_read() {
>>     writel_relaxed(idx, ale->params.ale_regs + ALE_TABLE_CONTROL);
>>     for (i = 0; i < ALE_ENTRY_WORDS; i++)
>>         ale_entry[i] = readl_relaxed(ale->params.ale_regs +
>>                          ALE_TABLE + 4 * i);
>>     ...
>> }
>>
>> There are no locks anywhere in cpsw_ale.c, and other table transactions
>> such as am65_cpsw_nuss_ndo_slave_set_rx_mode() ->
>> cpsw_ale_flush_multicast() run under netif_addr_lock_bh() rather than the
>> rtnl_lock held by the switchdev worker.  Should anything ever interleave,
>> one transaction's staged words can be committed under the other's index,
>> and cpsw_ale_flush_multicast() writes back every ADDR/VLAN_ADDR row it
>> reads, which could restore a row this helper just cleared.
>>
>> Is there an assumption documented somewhere that all ALE table accessors
>> run under rtnl?
>>
>>> +        type = cpsw_ale_get_entry_type(ale_entry);
>>> +        if (type != ALE_TYPE_ADDR && type != ALE_TYPE_VLAN_ADDR)
>>> +            continue;
>>> +        if (cpsw_ale_get_mcast(ale_entry))
>>> +            continue;
>>> +        ucast_type = cpsw_ale_get_ucast_type(ale_entry);
>>> +        if (ucast_type == ALE_UCAST_PERSISTANT ||
>>> +            ucast_type == ALE_UCAST_OUI)
>>> +            continue;
>>> +        if (cpsw_ale_get_port_num(ale_entry, ale->port_num_bits) != 
>>> port)
>>> +            continue;
>>> +        cpsw_ale_get_addr(ale_entry, entry_addr);
>>> +        if (!ether_addr_equal(entry_addr, addr))
>>> +            continue;
>>> +
>>> +        memset(ale_entry, 0, sizeof(ale_entry));
>>> +        cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
>>> +        cpsw_ale_write(ale, idx, ale_entry);
>>> +        deleted++;
>>> +    }
>>> +
>>> +    return deleted ? 0 : -ENOENT;
>>> +}
>>
>> [Severity: High]
>> Is an EXPORT_SYMBOL_GPL() missing here?  The neighbouring ALE entry
>> points used across module boundaries all have one:
>>
>> drivers/net/ethernet/ti/cpsw_ale.c
>>     EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
>>     ...
>>     EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);
>>
>> The only caller, am65_cpsw_switchdev_event_work() in
>> am65-cpsw-switchdev.c, is linked into a different module than
>> cpsw_ale.o:
>>
>> drivers/net/ethernet/ti/Makefile
>>     ti-cpsw-ale-y += cpsw_ale.o
>>     ...
>>     obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o ti-cpsw- 
>> sl.o ti-cpsw-ale.o
>>     ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o am65-cpsw-ethtool.o
>>     ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65- 
>> cpsw-switchdev.o
>>
>> With CONFIG_TI_K3_AM65_CPSW_NUSS=m and
>> CONFIG_TI_K3_AM65_CPSW_SWITCHDEV=y, does modpost report
>> "cpsw_ale_del_ucast_dynamic_by_port" [drivers/net/ethernet/ti/ti-am65- 
>> cpsw-nuss.ko]
>> undefined?  Built-in configurations would hide this.
>>
> 
> This will be fixed in v2.
> 
>>>   static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
>>>                    int port_mask)
>>>   {
>>
>> [ ... ]
>>
> 

pw-bot: cr

