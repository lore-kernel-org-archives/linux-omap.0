Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795050004;
	b=f7H2MdbCdLg25zsIthBaHy6mHpicYiUpwghhytMIE0twJusWXkwYXGBtYpAFpa6ZBlbY
	 2o2mh5iVh54i+6SaEq3KLm7P7bSEoJlYR1LLPt2Z4e0/bAotgBP/XfUyKZX9UF3nULqcH
	 dLT5DMhhjyNhwOnrcQ+1BZvwtPDeqxVdnpfMGIvSbHzasFUR2XF20brcGDfTjsWNuUBZV
	 BgkL5BzdhwmJ0g4Nbp+Bb0vEnf7Emkes7wEOr+LXe/gm/q0Vkz1IXmy6O8fFOrwuEMON7
	 0avKi3ES6gXp8Ux4BnDQQwHDHdXprIeJRWKgn9eagkrLBy5hi1+v7kgLZp/RwBzATfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050004;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=eahWfYKAQE1SKcfDFOYiIu3G1OgACjghKKPwSsaj4Qg=;
	b=0m1g+XQhnT2pmPLBAdH9pu1oYvfsTN9UP/URGyzSUIwaVAMJ9iOn7+4CQQzPFfZz0oHp
	 SO3c3n0ZnNU05/z+erImMAofzJQ3ONnntRhPt+/pcCKq2G9yBbu2iKFyZByZj9x5vlHgN
	 aBPTg6IQYBD9gkNZJCLraRHR+dCe9TCOejjhFx66ZQ8NZxNduEXwdBgKveKXRXTDIEW+u
	 pxfIjq75+Ql6MAvEmKGqKNJ0jgFZ/7YMeD0u+nmme8sLieKishB3pUzfAmvgZgAv/syXl
	 qxIzgp0pPrQMLRgrVURAFx0FlJIpmdOmPJq7cKupL2SvcRKC2cvSbves3vBUFEJLeFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FO9TXHox;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ptzHvTin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34C606A33A;
	Thu, 19 Nov 2026 01:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B34C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FO9TXHox;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ptzHvTin
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AINxng53633726;
	Wed, 18 Nov 2026 18:59:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=eahWfYKAQE1SKcfDFOYiIu3G1OgACjghKKPwSsaj4
	Qg=; b=FO9TXHoxSNGb7agsys/4IoHJS0DdCUylXsZoC93Vur1m4KzXc0Qncku2N
	fqE0s0ZzRw8CCYsZIcMS309AEUgEY5EsU9Hu+N9GRfUdi5sfqf3/rwJQDJiyNn0Z
	flE0ylg757bb9fvE/HWu+N/vLvnmVFzEgORBKz1UZ3xn4GP0LkvyF+KV1RDljzyc
	oFASEwMbW1L42O6oIwfYrgSr6aD06ojsZucKZkj2hZJfuzX3sA03BXauL2hyQRcj
	IJzMZZZV1XkjwuQtM325Hesf2yV+YZUA9W8kINnnJIOvETqY0FbSBmixIXQwyQY2
	O4gqqHEHE9Ma5trWblZnKec5rPEKA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j1p6d0850-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:59:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gnf7x0g0uF0+NHbULC+tvieyAiPIHivrULhkNjxhK7pVoGo6zORtIJBexRHun6C8rOu9piuZscKLFjqCAb4MLKLBTVPCbJzuGtlhs6PJTSP5CQcCoeNdGGHAcpH4O9A4Al7SEcPhOT04DHmDijVKWI4bpD+jp52ESzQPA0mK/AR1z7Tnd3H0h7xSZ/1PRaBHsnnBjUjVSDh0BGKbF/s4/31VfYW40n1n/x537J0DTNY5QgHeYl07mjhBtde3b/EgkEK0S7g+hdBO2BGO+XCHBrKYcn3zDGHQ9c096unwoF0Nh39my4t8lQ5dVGLuWFxeuQnQP7XVzvrSPlwFI/Zleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eahWfYKAQE1SKcfDFOYiIu3G1OgACjghKKPwSsaj4Qg=;
 b=sY4e/ZPvSYI7LqK0em2FByrysihhOTwx8h58ULwHaWbg9hoHFxiWB5SEB5BNEvMoPpF3fRCeJSSNPR2HJHJi/IQgKlwmWXB/K9TtUqADuIpPSOL20/mnN+rtp+3zFdTc5+S8LoB8VjJTRhuOlUrnD+35UC5wNRvuSE2L8mZKyFqvlRiUUCiYOm2leogFxTbmveRBWSrjGlB9KuYuMvVWCpr+/482rf2c5LZUWt1bPmfcWp+/39WA7kv8Xd4s2j9uBup94AXWiabKTKUs2ENk8x8ZagzeD9p4zhjCBWeY2itNklinFQiasrAM0NNOFYD/JbBCjNEAn9522o5NI9EKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.linaro.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eahWfYKAQE1SKcfDFOYiIu3G1OgACjghKKPwSsaj4Qg=;
 b=ptzHvTinq3SMgQp7XEm3/IJGPoALV9GV6bG32Gu+q50fwrbrp7Nk5UwRSy36ol1jlWlBlGKIfweH9m/Gn9bmjRUzOln1HE3yMXxzk7F5Kdanb0Sj/0EtOvIDBG7Ov6F2Jg9c9Oc2OCHmwrq68yfHBgSb5VizqxjRFfKQzg9G1HI=
Received: from CH2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:610:60::34)
 by CC6PR10MB079336.namprd10.prod.outlook.com (2603:10b6:170:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 00:59:26 +0000
Received: from CH01EPF000BE94C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::9) by CH2PR14CA0024.outlook.office365.com
 (2603:10b6:610:60::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 00:59:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH01EPF000BE94C.mail.protection.outlook.com (10.167.244.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 00:59:23 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 18:58:32 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 18:58:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 18 Nov 2026 18:58:31 -0600
Received: from [10.249.36.95] ([10.249.36.95])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AJ0wV8f3089779;
	Wed, 18 Nov 2026 18:58:31 -0600
Message-ID: <d84aab69-c5b8-4718-90ce-7b6abcb9e9a2@ti.com>
Date: Wed, 18 Nov 2026 18:58:30 -0600
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] i2c: omap: remove unused is_rdr and is_xdr
 function arguments
To: Antoni Pokusinski <apokusinski01@gmail.com>, <vigneshr@ti.com>,
        <andi.shyti@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <aaro.koskinen@iki.fi>, <andreas@kemnade.info>,
        <khilman@baylibre.com>, <rogerq@kernel.org>, <tony@atomide.com>,
        <jmkrzyszt@gmail.com>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <phasta@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
 <20261118205213.88778-4-apokusinski01@gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261118205213.88778-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94C:EE_|CC6PR10MB079336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a69420e-6bcf-4ff1-7c04-08df45d85a59
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|7416014|921020|261021123027099003|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WufKj3qLnDWGs/+N2I7CmkujS7fuaaIkQQjbdWhAqnZE6qeQRQywm6lG8g6mPZtjvs8lDGOu+d2hH0oBNzO2+vaka3exvFgkCUw8XZCX3Q/c1DxU+ie6q9Nd5ssWm2dsI5S7gYVQIEVPVWZmoQYxaodzzIlbt9sAEvvQwnLpu09SiVYXpSOiCb93fCjhPpNfkVJ1t/Kjm15LyN2gseJRKGbKlOS0qaz26+jBd7ffw/QOS44uqX0oEO0L4smEkYwxbScePkUiluuOJUYOKRhbRlx5ecLmHQRSmX6dbRV6BbDYTKDN72fAm5+PHBOf2GPH5U1I4EVxIBEvatbvKh9CoiEr3F5w9jODLNPLspmlLyL1LFwERwH+CCV96NjoIo7aWl+LGAyf/kqU1PklT1hnCbgHunk21xvZzy+Lqfl2dqzi+K55RUc6vaMecyKpGC94VH+L0x1eRtSjEkOUUhL7sY7gDLwRdY5qOkGynKlJ7sj6W+m/mqzmAkv7maz2HgvEQzuksB7MjexcBGodmYVbo1GI21dtYAJnhE15nCMHhbdIHMKP7/6UWbRUQs6Akh+DgF5ht8FO0IYpVnau04EGUar9Y9TzFbC5wY7xp3kVzrwP7qVsYUaQZJ6XD2YZ+W6Xi8WaAydVY4/O2aW0RJqfm6yn/toaR3nFQLWaGrmS8+qrSZ5GA1w2++aeWXj2XTOCYxOP/9erqkCNytS+osuU+Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(7416014)(921020)(261021123027099003)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tlpR2uBCDNQDgarGCe0bTv0vxPyvHpBukoAPJpf/RmM1JCGL3Qz8YvDgYkwRTggZZXmRDc/TioWL/rCOI93qO5U2uOKI6PKtWs+sIsRp6witRJrOe8urk6UqJIbuTVbPfNLfcXa68q+k8iLsdhCn1I0JJWHf3H3HYgh8vr39OyRDmZFbrIuJtQqNbo0o7fKrx2x+OBMeqU9KUvpG+KKsaMGwoqWP/GDINy3+E/qQLi90W8Ck3RXo/y0wqU2tgqUhOHi4GDQ/ANsLTtWAnuHV48aJwLc/sKWKyaOmhsYUzC2BtH+wCz/dX8+2BhUVsPvU2YOKXIhwOkzqYbbLHzS66YOfT15UeEkz/+McAhpqKYqf1HcGjCqO3yhUEe85ABdxf16Se1Npy9m3s/zXnv18kzGlOdjRSvlRcirSgSWwEp2JWFwLgTcugqgBibEo+IdE
X-Exchange-RoutingPolicyChecked:
	rGlSkVpZ4QZ21TsQ7dX+AoDKNaFPeXvlAP1TzvCyD4QI+WX091w3kC46E8FYomiBjAdBx/l4NQpcNjFw3eXw7dMdHd8UJU85P7h5/Z+A3Z0zmfqDrfQv+SYrFOfH3I6y4nHHJg+HAYQDo12i0mV0K/j7VToDe/3GTjMcRdXR2UqRh5vhOkmOS74Y9IBhGlwF9btvz9WZc9biGcvaj5OpXrM8T5ECg0ik1bpyrpS6jkdv8pyM+I2HM4d0m24mrNtBcdOB19jgZBYIoo/+V6IQFU3N3dhv8soBsYX0TpJfPxXNWJFv/q7Mows/HEO8NbEVlI8JCleZDCB+y0A9SdkMqw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 00:59:23.9948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a69420e-6bcf-4ff1-7c04-08df45d85a59
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB079336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAwMyBTYWx0ZWRfXzrzEY6rqvCcs
 DwInC8fOhX7is8luLLKigi8zK1RplRxt/YFLNb2rlLC8t6EC+8YT6hg3oJQttCOZgQAtT48IIJI
 CQ2j6ZJthfe2Y4jPGJIJwzIXUzhJO7Ejei5FH7ZniKU5g4MEFpapaomxo2eJisBoCHbv3bHZNAa
 2MxsUrpcY8umLO0Ej/EqCWAWqC5TSFpT+wtOuFivwIomP3DGDlUdkEnhfvlRm7rfnhZHdVi7CiP
 Ht9Zj1DmuhAKJo/jgDVq3C7PnyANxemU3DjhHZkklkQ82RykigMSaYbHTDEIaOOxfZVf8wHPqjO
 JmcLUBsG5vGXF9X3nm2GNArTtzfvimwtSG9j62/bjoErSE5vLrKUMv8N6hts0T4ZPEsO8LU4REj
 vE2OFtpWrw2GboYkqe1EcHplPbywyIvYFoZ/JAnIgdfFlti/8B7BCsiY3MYx9xkMsaiiA95DBMP
 1QSNTeRgjN0LrSOS/Cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAwMyBTYWx0ZWRfX6msHdQzeQ3C7
 AxCD7wyy8Ycq+2b0G+OrS2gagH3p/9hw+Pgj1pBVVpErmJGyqEX3w7go2p0fbakeTxjOebfgtyV
 e0+5o561zHqe2LmcHpdVvs28zzpIsLY=
X-Authority-Analysis: v=2.4 cv=Qc/zLcbv c=1 sm=1 tr=0 ts=6afe49f4 cx=c_pps
 a=tq6IV6p/3TsKmbatKbZ8qw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8
 a=qvwmucmvtkvDEqhzDi8A:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: WsAkDz89yCaaHgMAa0J5fppT4tb8udJK
X-Proofpoint-ORIG-GUID: WsAkDz89yCaaHgMAa0J5fppT4tb8udJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190003

On 11/18/26 2:52 PM, Antoni Pokusinski wrote:
> Both functions omap_i2c_{receive|transmit}_data() have unused arguments
> is_{r|x}dr which can be deleted.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---

I sent this same patch a few months ago..

https://patchwork.ozlabs.org/project/linux-i2c/patch/20260908154223.116074-3-afd@ti.com/

>   drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f02d294db42a..3f7060d57a86 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -996,8 +996,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
>   	return 0;
>   }
>   
> -static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
> -		bool is_rdr)
> +static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
>   {
>   	u16		w;
>   
> @@ -1017,8 +1016,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
>   	}
>   }
>   
> -static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
> -		bool is_xdr)
> +static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
>   {
>   	u16		w;
>   
> @@ -1122,7 +1120,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>   					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
>   			}
>   
> -			omap_i2c_receive_data(omap, num_bytes, true);
> +			omap_i2c_receive_data(omap, num_bytes);
>   			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
>   			continue;
>   		}
> @@ -1133,7 +1131,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>   			if (omap->threshold)
>   				num_bytes = omap->threshold;
>   
> -			omap_i2c_receive_data(omap, num_bytes, false);
> +			omap_i2c_receive_data(omap, num_bytes);
>   			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
>   			continue;
>   		}
> @@ -1145,7 +1143,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>   			if (omap->fifo_size)
>   				num_bytes = omap->buf_len;
>   
> -			ret = omap_i2c_transmit_data(omap, num_bytes, true);
> +			ret = omap_i2c_transmit_data(omap, num_bytes);
>   			if (ret < 0)
>   				break;
>   
> @@ -1160,7 +1158,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
>   			if (omap->threshold)
>   				num_bytes = omap->threshold;
>   
> -			ret = omap_i2c_transmit_data(omap, num_bytes, false);
> +			ret = omap_i2c_transmit_data(omap, num_bytes);
>   			if (ret < 0)
>   				break;
>   

