Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904043BE620;
	Fri,  4 Sep 2026 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496636; cv=fail; b=MLy+1MxovbbjreHQobDQZNtD3X2+GzuaTMlNgydtbqbqg9VbY4QOXEiiaoWiE+YKMAoEgRexLJaTFK0zpTO7seVAoOvRi+HXTPK8QiOju4Z3y4v194MUQI9egFN65kSSZXdgDrxmC6pblIFxMdO6kuIjNfFui6xrd613PhcbP70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496636; c=relaxed/simple;
	bh=UYeFqPkdMqOBO9ZJZLLwV1DxxoPqKRHynqCUMYMcfYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyZNjAGqKzv5q4IfxMdL2dowXGzVMylpR7vpRyG1gqwSdQfv17XUIp5VuKmkVUqxm/D2YwQQe5kOrnsSTgVgnXHAY5LWHGk+P3xu0vVJnucW1nQm9+uCFZekY8bl4qUT96C6AbJb8ndGael/VIGEM5XeCcXeOiGtd9ki+2dbHCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=iQ8Mj/0H; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iOS3QNY/; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="iQ8Mj/0H";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iOS3QNY/"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT501100057;
	Thu, 3 Sep 2026 23:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0ajZTL3U5me+Gn4wJlhy0+0zCbB3zwRZCinL3+9os
	l4=; b=iQ8Mj/0HLFSxCT3lrR5lzgdBhDWM7j0cGwE+9RzbU6fun+288cYC2Cmed
	hyv8RdTiqD5B5cwnFxTNwPG+TdmZg5KmwXVRgrxOpmdOPxk1jrLpLMfBVUtlih4Y
	qFDV9Qv5emZdd1jT+o4m3CDeWKBxKie1zsFdE5flfT6JoGfn8uU6kNeM3VQuRVj6
	T2YjdK2epdT4+1aR3oyHsdw6padLhGKdOhAxHAiyodwY8L7APa8oF8nuUKAVIip7
	faXNxQf4vFPj0bJdVVZOuYt0mi5CKdK27KrkUeyL5IFHC2BT1ldRbV87MsxRzYkL
	4wSqO8dZ1Pbod9NZ7MnQjCi5mZsUw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8nge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:37:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWfgZ9ful7g014MWSdd7HoWnIFtVekqRIzCwUM+lQMMHB1MfEIBbtmdR8AytxT4GI73CQDKa3wu7QOQ+uS8FEfSkAncVrXEr5ITLDo5/7vndy7zE0ABKdKGmIp8aNXjKUNYpnJzy3nab6Wl9MjbLQOV65T3s5lSwCxpUYecp0yVMMdtiNvxfhCoiEUFXGfsTeGP6BktuFc+/CKuZKAEpjIpMJUMrC2xNeKuyeyu+JQP/W1smKZGfIueiafJZDEnJjD+8Dq7TMFC953gNmTbd41Y4KR/1n36r3D+L7uNBK6RigeTdv2lpvulmbbi3o1588SmN6yOEvgiGTDdw6fDewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ajZTL3U5me+Gn4wJlhy0+0zCbB3zwRZCinL3+9osl4=;
 b=ww8w43eFl2a/5dxEW4xMtFAO9sjfbYjD8rieiYpGFPpCxNPn5up6dcBSgQDhNIlnaGkM6ItxkDuXIEinbPkTwIKuwM6JOvbOZ2z8W5Vi4JTXut49O7qec5KTkSuOpNtFX7Y8g2R5MTKotz22uqMwZY63b+8RVjSHBIVmpgJ54nWQGhGc0COEvOCaKUpddmqa1TCJ0qE64DilR33KVCZOPzmCW487lXgjZZbSkIXcmWiVurb+sebhEjA4jazFDA4zS32NqeD6So0aM6lmUjXNpqr+f+U6PmROKdCQhlApz071w0oKGjmsIfpcwj7I8prXDCvp7B+hlTGRJEJdr0CONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ajZTL3U5me+Gn4wJlhy0+0zCbB3zwRZCinL3+9osl4=;
 b=iOS3QNY/sUqTEs4sqQF6SrjfT7EX5zyyV42uiyBYl0oqhbbgjax6wNut16VboXhGLS/bARlyh6Jp5XiYVW/iyb4QnmYkgHAVdZjlA/tSGQMS8nnwz5R6MA152iQeNV7UgNtXOdjvS3Wzt/gN29Gaqw9AD4PDiXm7o6oGV3TqV8Q=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by IA4PR10MB8609.namprd10.prod.outlook.com (2603:10b6:208:560::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:37:05 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a1) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:37:04 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:24 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:36:24 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1Q3831572;
	Thu, 3 Sep 2026 23:36:10 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
        <mailhol@kernel.org>, <msp@baylibre.com>,
        <florian.fainelli@broadcom.com>, <jonas.gorski@gmail.com>,
        <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <kurt@linutronix.de>, <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
        <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
        <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
        <clement.leger@bootlin.com>, <justin.chen@broadcom.com>,
        <dlan@kernel.org>, <rogerq@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
        <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
        <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
        <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
        <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
        <lgs201920130244@gmail.com>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <spacemit@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH net-next 10/33] net: dsa: bcm_sf2: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:16 +0530
Message-ID: <20260904043724.2955444-11-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904043724.2955444-1-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA4PR10MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 63330d75-db5c-4477-dfda-08df0a3e2b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|23010399003|376014|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	46A8AOABaxh9ur/m6zj48V+DqDpxzdZR04VaIzaw8+oc1fmg2PDK3JUux0YFadvs+lYj+BhS3IIvcld2ZnVJ5tgzKW6p4/Vcbc1M9/icBL1qcueNiAcQUUDhwAGcdz2JZUl5nggxJXad5iSo/h+eGSqsjLQItGexpSW6NRUYco0bZnTDqBxucqiyXzGBNPdeXvYbi1BHh/OZtc5CBESQWOy9xZdkSP7A4P7Kvh1+CgNMWirYip5kbQ2YOs0dTfm3AEIH3GQQEsPymxSFPtZYOLmBjOEW9IZmlY8a1UMBs0g/1MvPqvcjuAeG1cUKmNZqV3Luq2C5dFE9oYXrRxl0eMf995v5bd+NOb/lO58MWl0bFk/zzGx4psyNz3qepGydY4iWXZeTQDgaWehfKB+iH8HFQsMnz/jYy5pmO36Rl5Xqcouc/PcNv5NBSDG0+dnJ43JOJkFbYp1AJFJpX67dJy6FyJPIPpHjglqP1U/8FvbstKbZIJxZMmH9m+kWhVUJIhLayJB6rvkI5OlQODvGrX7mqb/kRoIhl2W2TtI7a/RJOSLGhefFuidMLPAbbY0vmz5TDpyAgFp0vwdXEGg4ah8mqlMDHyUbYzGGVgEX6hmRGfOih6AJW91K8x5dRwJiwQ236FYYgvCnSw195ja3L4CiP8JFqCWRGeiPjpZYXxXc+Cru8gn/IMVPXX8pijZbWzp46JV84kzFUgt+EKP2u66eVCZJw+j/Lkzpn71CivExP0D55nOO9ybLnjPsvCpu
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WprlWCQ+36f/Q6LMbmzBOdew3BcRuh6KITK40kPahPRDtnfGBz+Q3CZ3GASXLKuyHK9n1u1xtS/e8TQc50vvXnJdWJbHzcipG6HI0bwqX4ok3VJHStONzVgoS/9TcXLAsOcvoURUaEytAjzaZNMp+1PbjnLKh5tjK53IDDWZsDUtfxRe4pifbqtctCMgPsR6lW9P4fhq9hPa5mLgwQXxkN1SbMMcOiKyRuBimFnE2j0aGjWWID5xs2b5pw8olbFF8ibA8Z2S2i70CXOEIVHUjLx6g16NqbqpOfXTwIrCxAy9Q4eU18j/o0FprPSdKcktKzWr5lovQ0Ni8xdVGTAWshJNBM1zAVGGsuzKnKjUxFYaYDLcsPZoK1d9oN5zR0KVZssRuB+aQh53i5ElBe8OvMnbhJ13jk7+il3RbUuupgswpBuxV3KVElmHhTvhztJC
X-Exchange-RoutingPolicyChecked:
	yselKgRuIWyIRVWJUWLARsbyeW8sHGasEsLmh3w8uH/od/o926y3lRwKt6PC0ExnQOo15Oa4PrE00Q951d+Rmih+mzEjQ4xdRn6zO3IF1k9h0GRoYBWlCWHOvYiCKk8iypCGPdUTr9TeyWorFTUtVInbaZfG+ai4u2bGjAfx3+dz+CTSAWseQgzoywoNxYGge4mim5HqxO4Rs1QB8Q5WTWCMyUC0+Erl7LnPPblkH72HNnEfENTvOgLDjL2Jwu5XChggAatsAeKJid/BwdreeHKpk6X7+e3PnJmc3m5rIGZnVwlbq4ajD7FKbf4Q/6e2Wlw2FLBPp0oHfMD5c/8jog==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:37:04.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63330d75-db5c-4477-dfda-08df0a3e2b73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8609
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX6BOoHnd3rLEw
 45zhfY0XvvxhlBGVt+j6/6N2sK3xdnrS84FsHXvPq4yhT9EEoCAGgmjl17grJ3rmJsmTkZt1dpH
 GKCk+qVgIjBRqnLPGMWLMxqpI7/3axw=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4afa cx=c_pps
 a=NjM7+/ez9qG7m02rljsF/A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: SAk5Ypw7_SLSq-w4skvayIhB29pNvif5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX4JiHkcqg0GS3
 FTuqFJErycux239hFrnJy06gdjAGITYgUxmRWCVBvpwJrBzpKCYsJ5Q3QOyiPzCYiEdzp2uCIjh
 NaIs3yHxp2g0kHt5TtWjI7tCZbBp5dZY6RMZhBJvMYMrhbvGJipwggAd3fi0TOq0dwisPWnVaeo
 CaKwc+Ym9ZSwoC4ZdAnhZNRM95I0wYX8qVla1p1Wudk19Jha5QB2VF584hhEtFMjxuDUHqwQsYd
 Uj3wc4Ojdqjc0xC7W1yZJX9SqJy5rSbS+9sUsUUq9bRiq013evrDvchNCEv21ELcYs6g740HOXY
 8lt4m0ANF2F1QfkDN93gCUjUezBIODpYR7oVxIXwuDAVx/yfk4owNXvL8YfGXK43Tid9oLJj6RI
 of3gpjP+faX7PAy4qTuqUXvXdaHdUdlVOXmQsi0qSRjXm15jBXQxDrGdOv1QsvUqOGZ78i/ARVI
 /2GoKcSO2OUq+bpyYAg==
X-Proofpoint-ORIG-GUID: SAk5Ypw7_SLSq-w4skvayIhB29pNvif5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/bcm_sf2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index de3efa3ce9a7..9e5713015187 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1358,7 +1358,7 @@ static const struct of_device_id bcm_sf2_of_match[] = {
 	{ .compatible = "brcm,bcm7278-switch-v4.8",
 	  .data = &bcm_sf2_7278_data
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm_sf2_of_match);
 
-- 
2.51.1

