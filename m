Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984494718EB;
	Wed, 23 Sep 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152098; cv=fail; b=V/5CZYgDh+cx337BjOEIkArYW1HOiMWV2CYM/Ze1nnFmPonDMP0sTVeRca57BjyIL9qVn7nZH5j2BNG2ybxfpbnN4uVKsPwRVEgK1vfvuon09OqaWGB2xMtNhodAOE/J6BpEyQwM3gIY92VGG7k3CmJkLaHgvOAsDgg1cej79HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152098; c=relaxed/simple;
	bh=5Eb2lqwX2kqyQu2LRg3e7izOAdfAs2Owv7L9nt5cV2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qcs5drHrIfq47Syuqoaz74lWljPGLfvV/JQmgNp4o7tVNBccwfmrBOmfQFY311sWzvwLVAABr7Iczey3Je2M+n5w2ND9mpid6CJG72Qg8i5YDMQY0m5NNT2kIIbu7XKoTRrgnj7YZ+6wuQMPZqDRmhn3rPG7pbBrk9wBh+tpn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LPLJ9+zl; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FxOMNVWq; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LPLJ9+zl";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FxOMNVWq"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8J7UJ299713;
	Wed, 23 Sep 2026 03:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=2vblchCYr0mwgC7sISC+u2FiDXMgxAFMo4CxuP6le
	pc=; b=LPLJ9+zlo3PwemY3oelksjl+Rzci/HdAwFX3QkNe2+brbSF3rArStWqpj
	8EiLwXtIi0EGHjQZoJzXVsy9W3jmWE+3VXnHeTpO7Vfu+5ntXmx/JGa0unW+AvlP
	FbtLjcTOeMH+8MCFJzfqUYxCJpQhocl7XiZtayouyVFZg/A/v0Vm1m/5gIgP1U3N
	3LScBX/tDPUrE3CycuIsaqtFqveMxbLEvI6SdlD1k2S4QKz1B5fN5yg68tOVEjvl
	3P8TSuHpUyKawV3RxHqeNiS8VRz1AT/GfOX8WmzOOQEdc4zYVC2ifhlLuekGobGT
	P06rf9SlW49DBlICfUkfQZI9Rgn1w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gv54tj22r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 03:27:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvprhcaXdBDy2EPJzYAOvwxtFMjODOiKUDkdlezhwA1wrOt7RoeIgRxzy1ZBXqKP94mF1YEN29mQnDve4yoNNCu4yQFrWj8m8JQM/zV/SoghzoMjfMrhrg3vR/HVJufwClzUGQmHgC8bxr0eqx61IaMov8erzT7G0PGPNXAb2iJSv8rkhVZYjDeFIsS9OtMJPVf0XbQQccfuN7NBfk2zxiLqaZIiItIZoKN7xS0tOtMIm2RAJ3ZH0COK6B2YdoSNjbIqXiLVtKd5D8pyAj13tkiPu8WcFOnxZLQs1qWp/iqdm4TQ8fijKhMJMgAe7U0iOrVsKnlTWOXkcuiWLMvKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vblchCYr0mwgC7sISC+u2FiDXMgxAFMo4CxuP6lepc=;
 b=edr4DtBdv6P+eu6LBEzvT0nPN6+D+DY1GggDDPE/aBGFnGHRMaa7P5UUJclnfo95kNasX4B/e9ejKErCXMc4XsBNc2rSbmBPf7zL9V9Cp1gFnrPxZxQ+/V/zXWMgf8EV0ArlLiw1bAyH4GOlnXlOla7SwsiqWkuOpg3Rk80K6LpQE5Qah4rE463Z2QVJzXbJn+r7p7Q9mZSP+ALmWL0qsm/CmcsJcoqeCa40hP+JFKVq665eeblmHPhu4Di8YvBJQFG46wVqR+7QH0sxeVMRxKAFtLKJWwV8kaiGJwjiM7g5BVQ6mMBLmm88va73O1S0uaXRpXKzeSEc0AZVu0rz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vblchCYr0mwgC7sISC+u2FiDXMgxAFMo4CxuP6lepc=;
 b=FxOMNVWqF+nrpCHP6hAz1ANJdO6P8qNhJKBpkTGB1eqFd6lSMFHN2KK0mmUtXMB4XoFB37NEbyQIoYj2VN44X6wjjfRNHfV/kyNlRR6psCp1BSCLTZOJxrAAsVPxYrDhQY24Y4OC6uVOXRU7B9pAn9+cBRTBQdRi7Fb9knvuEKQ=
Received: from CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::19)
 by LV3PR10MB7963.namprd10.prod.outlook.com (2603:10b6:408:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.4; Wed, 23 Sep
 2026 08:27:48 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::55) by CH0P221CA0018.outlook.office365.com
 (2603:10b6:610:11c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:27:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:27:46 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 03:27:12 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 03:27:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 03:27:12 -0500
Received: from [10.249.132.125] ([10.249.132.125])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68N8R4ik2552648;
	Wed, 23 Sep 2026 03:27:05 -0500
Message-ID: <156f54e9-a0d2-46f4-99e1-f43f02f58673@ti.com>
Date: Wed, 23 Sep 2026 13:57:03 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: am65-cpsw-switchdev: flush dynamic FDB
 entries by port on delete
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <s-vadapalli@ti.com>,
        <rogerq@kernel.org>, <kees@kernel.org>, <stefan.wiehler@nokia.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <arnd@arndb.de>,
        <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20260918075926.3616434-1-danishanwar@ti.com>
 <179006497666.2160803.14768308117153644313@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <179006497666.2160803.14768308117153644313@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|LV3PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: c275f1b2-592c-47f2-7639-08df194c8c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|1800799024|36860700016|4143699003|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uKzYkIpkbjglFANKgr1zKaSX9jumPgMqOn3rFb9xv0QTxOZDCo19Gr+Zv2NF4cRPoZRc5opZhs7xHvrJmYxtTftTf14RVxABgOY45+lqqav34wK2809qEkHi7wZh45wpAX020GV+4jY5xA7nAT22YLs6iM9f5OV3rk0//NBXYhh8s9UIdpwwxmj1ykvDOu7XbJCdLRe45pvLaK2f3jlrIBf+Xi7NZ+zvs0POe4vuU15b/sB7qFJDY+7tHTY1n+mFKwo9rbFVSfJjMOOb5kj6hIWdvLnGpbdLf9rdVdmUmobcP0bTFGzBqEq0Z3ImcFg5JFNiZA1QT9VT8ka3I4ErJ9jcEcU8r/jiN2aejK2t5+qOD9AL2+bK5+3JJ4XsxxgwCZqewbs4xkoDY2a+mqHu5rYy/gdPxIp3JHw0m2UqrUbDYh3m7+QcmY2PqatMSxYrZhQHO8oYOz7/guFwyKShIvxD9ZW1m4H4Sx96EO64jV3nPg1DkidfgFk0hDLkcER3Qc6mA+IiKRRYR5FF1rKk3dCiqlBiDjjqDI+D4TfgdLyzTSptamh/HALKuAVNKZle2VJBz9Coi589Ngh0qK0omxGEnfctVaCYpI+42eIpGf6tA/HRKwAKJ4191sir8d6LZoDXcqvz4cjYFZaooedQ3d7ZuV6FZKuEp5NrxY+u8QHDhjkb3xs1a5mZaTBjgaRB/7k8E+ATMWy8/OWEdxHnqw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(1800799024)(36860700016)(4143699003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B250O1HAkXXQYN2FotAkywKbHR4sB0p1HsvhpaS6U8gk8VR+xAjiGjHF/3xGsqmU+CI4WKqLO88Oss/QE0ziVORHgaVu3T6DrWghw5OZMYcBFe8yNc2xvvAAI+VIm7MKmPZ/GEYUi1+U1QqgUMYqXuOoAM4C2aMz7k7XKZdQY8U0D6mqIJKgwRxsfo6xFQbIa0cwTN2y8G4VND84+iZHyClo/zQCCR2wcnlXJsmoZlhfmFkTSPy99c+pJ6a/tZTxQz/fw+XRAKy1ApGpVzI1pKWkd7zzYuVOhURyjxnEZOT57Ry4ogogu29f+qN7JszgQMttaswIKUpEqfWuslI9xx4t3ZjNfbAuXBsak2Y+u7gwcwPu0zts71O2uzahbz3YiFFIB8GlarSNqd0AP3eXziHCrfy3s9bh4NU//HFEpQKAzPQst+EtY+QaobJBGV8R
X-Exchange-RoutingPolicyChecked:
	IgcDmE/bAoNmO3Cfts6y0cF57YHJnvwJ+phfzEAGCvTQZF56cg5hTz+8zSEAdfssP5JeYauNv57pFwU4W6CJtzhOMs09NR4FQqD1YkEJ69TDq2Icy06TYat8cqlxet5DB14hWmYGLoVJrOHN1WBRPElxnDwoBkEXny7DL6GADqpvBE6Wp8T5K775zm+NJ9D4vMBJYYDX8Y13VC/5dQ/ecTRCrKGBwiOiT0A9cnqgW+liIVOClGVUB8/71SasnANzdmr75vND3jAC3RQxpB1rK2Up7TmOlTHM86vVp+9ljh0//3lCZM6SsP5JQ7UdjrgIawh93Rs12XM58ZzBJJOLbQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:27:46.7295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c275f1b2-592c-47f2-7639-08df194c8c15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7963
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMiBTYWx0ZWRfXxTAZuti0lKbt
 VPC2F84GYeqTiD0PfYKOg95Mf22DpfXG9gbJtuU29QNNtB33tSsojImnGfKrXrYd2LY9PaKmWus
 zLqPXm0kcrM6WevwJNdOMNau8mDk8u8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMiBTYWx0ZWRfX/HPrF6TFjmQ5
 wagnqoXQuve5l9wqXhIeF4JIuOni2OisMzlQGXkaJhBLNR45zUWS++5QtoP4m8rXu6y69d6orzF
 RUcpE5f/XuxmNQxdJ7BmJx6XIIw7IBMbxCX1rgISYDniGdBAk5+Apts4qF8NULZxyulhBs4jLMH
 cSunSJ75Nd9EP42yIcqHV3ZoI1cRD2uDsl2L3lgkbIMxVzm43UqiZuptIo4qup6OcSlXpiNl+X8
 MEVsae0bR2DibVmQVdsDRd1qfLtYyBpKo21F4zx/2gQLHQzpEOEhwMNMT9Kf7w9E80pixWqHASd
 sehbbEAITL5Akhw3FCJRtt/0Or66gEoE9lFh1IA6Y0sOrInW4pKwJe/qCU3IayM5jo3pG2uwX53
 zJODd+xIGltnMUbI7/ibPQwe9PEfuHDCAZulK3JJmoydb4waQrXjLp5EfBWCNva/BOowg4sKtS/
 DhaHRV1eQEAIZJAsy4g==
X-Proofpoint-ORIG-GUID: 3HIv0uaj9q-JbUfKaI8tQ089-j7SqaIv
X-Authority-Analysis: v=2.4 cv=TpFzFzXh c=1 sm=1 tr=0 ts=6ab38d88 cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=Ppr_wtXj0_oOf0MM0u4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3HIv0uaj9q-JbUfKaI8tQ089-j7SqaIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230032



On 22/09/26 1:46 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] New cross-module ALE helper
>    `cpsw_ale_del_ucast_dynamic_by_port()` is added to…
> - [Medium] In am65_cpsw_switchdev_event_work() the `!fdb->added_by_user`
>    gate is dropped for SWITCHDEV_FDB_DEL_TO_DEVICE, but only the `vid ==…
> - [Medium] Dropping the `!fdb->added_by_user` gate makes every hardware-
>    learned (dynamic) bridge FDB delete run an unbounded full ALE table…
> 
> Pre-existing issues:
> - [Medium] cpsw_ale_del_ucast_dynamic_by_port() performs a full-table
>    read-modify-write walk over the ALE indirect access window…
> - [Low] The identical stale-dynamic-FDB defect remains in the sibling
>    legacy switchdev driver drivers/net/ethernet/ti/cpsw_switchdev.c…
> 
> --
> 
> net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
> 
> The patch drops the added_by_user gate in the SWITCHDEV_FDB_DEL_TO_DEVICE
> arm of am65_cpsw_switchdev_event_work() so dynamic FDB deletes reach the
> ALE, and adds cpsw_ale_del_ucast_dynamic_by_port() to clear dynamic rows
> for a MAC on a port regardless of vid when the bridge reports vid=0.
> 
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> index 53cdac272b58..8b4640809cf5 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
>> @@ -397,13 +397,23 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
>>   			   fdb->addr, fdb->vid, fdb->added_by_user,
>>   			   fdb->offloaded, port_id);
>>   
>> -		if (!fdb->added_by_user || fdb->is_local)
>> +		if (fdb->is_local)
>>   			break;
>>   		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>>   			port_id = HOST_PORT_NUM;
>>   
>> -		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>> -				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
>> +		if (!fdb->added_by_user && !fdb->vid)
>> +			/* vid=0 here just means "bridge doesn't know the
>> +			 * real vid" (vlan_filtering=0) -- the dynamic entry
>> +			 * may be stored under any nonzero vid, or several.
>> +			 * Delete by (addr, port) instead of guessing a vid.
>> +			 */
>> +			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
>> +							   (u8 *)fdb->addr,
>> +							   port_id);
>> +		else
>> +			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
>> +					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> 
> [Severity: Medium]
> What happens to dynamic deletes that carry a nonzero vid (bridge with
> vlan_filtering=1)?  They now land in the else arm, and
> cpsw_ale_del_ucast() resolves the row through cpsw_ale_match_addr(),
> which compares only entry type, vlan_id and MAC:
> 
> drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_match_addr() {
> 	...
> 		if (cpsw_ale_get_vlan_id(ale_entry) != vid)
> 			continue;
> 		cpsw_ale_get_addr(ale_entry, entry_addr);
> 		if (ether_addr_equal(entry_addr, addr))
> 			return idx;
> 	...
> }
> 
> The port argument of cpsw_ale_del_ucast() is never used, and no
> ucast_type filtering happens, so the row that gets blanked may belong to
> a different port or be an ALE_UCAST_PERSISTANT row.
> 
> The MAC roaming case looks reachable: br_fdb_update() emits a dynamic
> RTM_DELNEIGH for the old port while the ALE has already re-learned the
> MAC on the new port:
> 
> net/bridge/br_fdb.c:br_fdb_update() {
> 	...
> 			if (unlikely(source != READ_ONCE(fdb->dst) &&
> 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
> 				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> 				WRITE_ONCE(fdb->dst, source);
> 	...
> }
> 
> The ADD arm still keeps its added_by_user gate, so nothing reprograms the
> row afterwards.  Before this patch the gate made that path unreachable
> for dynamic entries.
> 
> Should the vid != 0 dynamic case also go through a port-aware and
> ucast_type-aware delete, so both arms of the new conditional agree on
> which rows a dynamic delete may clear?

This is a valid issue and I will fix this in v2. The fix would be to 
pass vid also to cpsw_ale_del_ucast_dynamic_by_port and if vid=0 delete 
all entries of a mac. if vid!=0 only delete the entry matching the vid.

The else path would remain unchanged as it will be only hit for user 
added entries.

if (!fdb->added_by_user)
	cpsw_ale_del_ucast_dynamic_by_port(cpsw>ale, (u8 *)fdb->addr, port_id, 
fdb->vid);

else
	cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
				fdb->vid ? ALE_VLAN : 0, fdb->vid);

> 
> [Severity: Medium]
> With the added_by_user gate gone, every hardware-learned delete now runs
> a full ALE table walk in cpsw_ale_del_ucast_dynamic_by_port() while the
> rtnl_lock() taken at the top of am65_cpsw_switchdev_event_work() is held.
> The helper has no early exit, since it deliberately clears rows under all
> vids, so each event costs ale_entries times six MMIO accesses (64 entries
> on cpsw2g, 512 on am64-cpswxg, more on j721e-cpswxg).
> 
> The event rate is driven by network traffic: learning, ageing, flush and
> especially roaming, where one RTM_DELNEIGH is emitted per roam.  An
> off-box host can keep this going by sourcing frames with the MAC of a
> host known on another bridge port.
> 
> Is the added rtnl hold time and MMIO load per untrusted FDB event
> acceptable here, or would an early exit / bounded search be preferable?

The cost associated with full ALE walk is accepetable here. The ALE size 
is small (max 512 entries on the largest supported device) and the event 
rate driven by normal bridge learning/ageing/roaming is modest, so the 
added MMIO load and lock hold time are acceptable.

This is acceptable and doesn't need to be addressed in v2.

> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but the legacy sibling driver
> drivers/net/ethernet/ti/cpsw_switchdev.c still has the exact code this
> patch replaces in its SWITCHDEV_FDB_DEL_TO_DEVICE arm:
> 
> drivers/net/ethernet/ti/cpsw_switchdev.c:cpsw_switchdev_event_work() {
> 	...
> 		if (!fdb->added_by_user || fdb->is_local)
> 			break;
> 	...
> 		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
> 				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
> 	...
> }
> 
> cpsw_new.c also sets ALE_VLAN_AWARE unconditionally in switch mode, so
> both premises stated in the changelog seem to hold there as well.  Since
> the new helper is declared in the shared cpsw_ale.h consumed by both
> drivers, was leaving cpsw_switchdev.c unconverted intentional?  A note in
> the changelog about the scope would help.
> 

This is intentional and unrelated to this patch. Can be added later if 
needed.

>>   		break;
>>   	default:
>>   		break;
>> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>> index e202bba49480..1a2aceda3dbe 100644
>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> 
> [ ... ]
> 
>> @@ -441,6 +441,40 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
>>   	return -ENOENT;
>>   }
>>   
>> +int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
>> +				       int port)
>> +{
>> +	u32 ale_entry[ALE_ENTRY_WORDS];
>> +	int type, ucast_type, idx;
>> +	u8 entry_addr[6];
>> +	int deleted = 0;
>> +
>> +	for (idx = 0; idx < ale->params.ale_entries; idx++) {
>> +		cpsw_ale_read(ale, idx, ale_entry);
> 
> [Severity: Medium]
> This is a pre-existing property of cpsw_ale.c rather than something the
> patch introduces, but the new helper adds one more unlocked
> read-modify-write walk over the shared ALE indirect access window:
> 
> drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_read() {
> 	writel_relaxed(idx, ale->params.ale_regs + ALE_TABLE_CONTROL);
> 	for (i = 0; i < ALE_ENTRY_WORDS; i++)
> 		ale_entry[i] = readl_relaxed(ale->params.ale_regs +
> 					     ALE_TABLE + 4 * i);
> 	...
> }
> 
> There are no locks anywhere in cpsw_ale.c, and other table transactions
> such as am65_cpsw_nuss_ndo_slave_set_rx_mode() ->
> cpsw_ale_flush_multicast() run under netif_addr_lock_bh() rather than the
> rtnl_lock held by the switchdev worker.  Should anything ever interleave,
> one transaction's staged words can be committed under the other's index,
> and cpsw_ale_flush_multicast() writes back every ADDR/VLAN_ADDR row it
> reads, which could restore a row this helper just cleared.
> 
> Is there an assumption documented somewhere that all ALE table accessors
> run under rtnl?
> 
>> +		type = cpsw_ale_get_entry_type(ale_entry);
>> +		if (type != ALE_TYPE_ADDR && type != ALE_TYPE_VLAN_ADDR)
>> +			continue;
>> +		if (cpsw_ale_get_mcast(ale_entry))
>> +			continue;
>> +		ucast_type = cpsw_ale_get_ucast_type(ale_entry);
>> +		if (ucast_type == ALE_UCAST_PERSISTANT ||
>> +		    ucast_type == ALE_UCAST_OUI)
>> +			continue;
>> +		if (cpsw_ale_get_port_num(ale_entry, ale->port_num_bits) != port)
>> +			continue;
>> +		cpsw_ale_get_addr(ale_entry, entry_addr);
>> +		if (!ether_addr_equal(entry_addr, addr))
>> +			continue;
>> +
>> +		memset(ale_entry, 0, sizeof(ale_entry));
>> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
>> +		cpsw_ale_write(ale, idx, ale_entry);
>> +		deleted++;
>> +	}
>> +
>> +	return deleted ? 0 : -ENOENT;
>> +}
> 
> [Severity: High]
> Is an EXPORT_SYMBOL_GPL() missing here?  The neighbouring ALE entry
> points used across module boundaries all have one:
> 
> drivers/net/ethernet/ti/cpsw_ale.c
> 	EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
> 	...
> 	EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);
> 
> The only caller, am65_cpsw_switchdev_event_work() in
> am65-cpsw-switchdev.c, is linked into a different module than
> cpsw_ale.o:
> 
> drivers/net/ethernet/ti/Makefile
> 	ti-cpsw-ale-y += cpsw_ale.o
> 	...
> 	obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o ti-cpsw-sl.o ti-cpsw-ale.o
> 	ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o am65-cpsw-ethtool.o
> 	ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
> 
> With CONFIG_TI_K3_AM65_CPSW_NUSS=m and
> CONFIG_TI_K3_AM65_CPSW_SWITCHDEV=y, does modpost report
> "cpsw_ale_del_ucast_dynamic_by_port" [drivers/net/ethernet/ti/ti-am65-cpsw-nuss.ko]
> undefined?  Built-in configurations would hide this.
> 

This will be fixed in v2.

>>   
>>   static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
>>   				 int port_mask)
>>   {
> 
> [ ... ]
> 

