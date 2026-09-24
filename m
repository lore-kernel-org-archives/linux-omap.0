Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569638DC7F;
	Thu, 24 Sep 2026 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227354; cv=fail; b=L1isnlaWgoubmem6J4QlfnfdPGDxHQbUbjY+ekvcatWzc1LW0SRtDUAZcKg/f9HYwGDD7yntrmMqXGy/3AnWbDKYCxWohqHn3BmlBB5VzWohfetEwgn16SUvpfiwEEdFO2Birye8usMQkIUwR8htmYBQujFFjlwcXQdEi52qJ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227354; c=relaxed/simple;
	bh=aFbVdasiQJAuxRDBv4qjJ4ZbpOm8enaq7a08hdyTv7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VE6OwJl0drPylRpg3kEKDustolxmWv51tGkuVEJaVCWXwPuQ+LrF+2kKSjAYaENeRKmOwxpda7TYRThuuZ+KheafBisxROuFPDOtCanLbGEfdq8/lUwH3uxcHrS4I8to+qJPlNZVIVBggZk4KFXsnRj5pEfdLIHVT1+g+ykND30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=mdBFsgsW; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EjKteIYF; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="mdBFsgsW";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjKteIYF"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2LdF22841680;
	Thu, 24 Sep 2026 00:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=fXr6KJVwuOIw8
	jo7gOAQ9NZnO0Wt/t8fTrKKsenIZvs=; b=mdBFsgsWwGBqdHb+6ChlgsQMQjg5U
	S7cVS8Z79C7YFwtmRE0O/qvh28brd3MITBhde9tDpEEsDHQNnQmsnHnJoHWguHoo
	Vn8lz38QEYBoIYS8woYTJNDxQjoaLDcgHsS6knFexrg4r1wtGXHkgY52GQn8lFvN
	JL74NAG7DXqzfYnmJiTgS7HUuCBwMUKAGjwz4Dp5s5VrlNMKMKv3b+GZkpuoVrcv
	ng0kuMl8NzrJ6OesJzWzLZ/ZqO49mM91LMI70OmhRVH2IA/y1qOTKmJd4k7iu6tn
	mJo6CZslL6I+Ok2Q7y60h/GMbceMK2Y8Z08DL5WNRF4GpS7qTB+gc/jGg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gvt5d94hg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 00:22:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hin9u2Rf2O8gjs2x4knOh3lPwJnT41Y+SkaNf5AFID+ks7vofAFbm3jxNaPFzmn+AgF11Z71z1mYqw2chjykK6hGpkHJkWlB6yKOVXzHPk/WOc5w1NtFL94aCuXF0VJKj70sBbSucJJc0MK28lZWHA9D24J0dZdbT/Px/vLb4R+dsy47zMQLnRcgWpETbVIPnUA0hnJW37xiTflgYuMzodC7sD0WaSbRKO4LPVU2EdvV8R6Hrr/r8btZJbVdW28UuG18hAPoddjMa9WxzWK2RMLHadEfdn6Bll781IkzgLApzXBK51+W5suNe8sa3vErKZ89Z4MulX4dWJ0VoISzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXr6KJVwuOIw8jo7gOAQ9NZnO0Wt/t8fTrKKsenIZvs=;
 b=ChegFQ4Yzx7y0ruiqk2uxsuN9BXJH2tnEtsXUqjNFRfnrDXUMc59Zji8h+O6NzOGrJhfvpM4qDh3aTFDx7tv8DQ/O4XFxNG8TaQQGN0wxgo6fNZLMXU7pOyk59VzO/6ulZt0/Ts1o0Y/+Zm5vaXZkklieZvmaDi3aWyi47aMLz36bgsn2n052JPP/UZS1g7cATkYAB6RxHNb3IefsZaUc2/x0jeCxEMCuHgVWON02cveYhWnPMERJngcV2jAfQxARO475aBWQXI3eBfDQ8eTON4EcD7CVaMeBSkCNWh7PgtcPW/GRAIIfH4ZhtInW4u4zq0mYmZ2uVVaIkvJbFvRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXr6KJVwuOIw8jo7gOAQ9NZnO0Wt/t8fTrKKsenIZvs=;
 b=EjKteIYF6QDgY+mVqVeQp5ZjGPn3pYPUDaiDJ7Pop5HiV46iW8nbU+PHmXPoDCPTt6V8R1cNYhWjHjRF0sZNfAne/Bnb3QV7ueT3ekL4B46cQEWftwHlGua+VQngIh1aODaaHxmSg9ul+BPcEl5FVPa7+Uqy0hKVyroGG2EI800=
Received: from CH2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:610:5b::40)
 by DM3PPFC82B87818.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Thu, 24 Sep
 2026 05:22:06 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::34) by CH2PR07CA0066.outlook.office365.com
 (2603:10b6:610:5b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 05:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 05:22:05 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 00:22:00 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 00:22:00 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 00:22:00 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68O5M0p92557410;
	Thu, 24 Sep 2026 00:22:00 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.73.69])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68O5LxGo005805;
	Thu, 24 Sep 2026 00:21:59 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>, Kees Cook <kees@kernel.org>,
        Arnd Bergmann
	<arnd@arndb.de>,
        Stefan Wiehler <stefan.wiehler@nokia.com>,
        Chintan Vankar
	<c-vankar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH net v2] net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
Date: Thu, 24 Sep 2026 10:51:46 +0530
Message-ID: <20260924052146.594157-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DM3PPFC82B87818:EE_
X-MS-Office365-Filtering-Correlation-Id: 222b5061-02c0-496f-a1b8-08df19fbc5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|7416014|10067099003|18002099003|56012099006|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	z6Na4ByeiY0ZsxwijnEjvH6gho/Y372TtrhX5bPKTeBJ0O4L8uJf7Xuw7j1TDRRd71rkCWuJqOQRNlyaCz4s5JJfyHngdo42gP425erUKarwLhy+K3Vp3fx5ds5OPCKz2tUCngdnw2bkQXAK4iKLhqdiKgV1poLXwZREtbSmzBDTH3Jc6Li/0i/ncTzyrjxudE1WIqYhv0sx9dVcAlSG04rFzo9ExMmG4fwWVHlwuksUjXDfsKqW47DK9D4ChofpSC6uC8rV0qBiO5nD/6Bv3sBDjzh+LAHIILtQxC9in50CfECNTxAB0rHYZ8TBKxJp7wEkk1IRvirJbPU138C1FGtylz81q1V6s4EsxFr/umYMw0jZGNQoO+TB4p9tQ+SGtD+LEtmftNWtRSLNsgioJVbtPJr5yG6WccG9XURkqqY22j0MfwoF7/WM2GyKWfd2uEAxI1inGpZQzSg3G3jRspvbV3Ldk7T7ZW0tMiKJHO+Bzlbc8x2PbR/v/Xx7icf8dkEMfGS4Wmt/TOBdIaqyPfWfhsAd4DcX5VMMNBGOtXyynOi/nNdPB3O4X/m8Rf99JWEmAJngCxa/CylePHeAZQV1Su9JrDUggPRQuy39AmUoh5NKAASiUuwnx/P9mJRWXahb31mex0QVtA8lX58Ek2QUXfMSDtXRgiT2yGuvQ3KPR7MV7XjI5tv/Ex35QMcWNOdnfPgPp92DE1xwTUEi/Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(7416014)(10067099003)(18002099003)(56012099006)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oC70mQWFRgnGIbOXl08Kx4iX9xRBSyeiXxnDGCR397i6LnN91dh1c/JJ0l4gwfwMLI7sJMLXFtcAGlHHFuqEi8JTIYTgdxEuppK+ly6tHgAUemKqlCneDl3+UPUKv0UTHfo//NNfD3iyvqhUY0d6HXZuT7gJIEKtHAmas0Ehqqe0UpQpZt5L4b/qghQI+rTQYPfUG1uZS3a9mcSnYWxb4VJUyQcBbYaRPKO5Dl+g2F5RGrFMyWyr8CygKmsVw3ozn15a14IZrT0wTty9J6rjih7u1fCFlCeW+0uQXqTNP2v72vrVOBrYhWVIFCb9kHivsgGeC2vsaf8cFhwcVt3tJGDZtaaqB77BE8AFkCDlBtNSC9uH1vKX9mDSbR3sqF/ZIpAzOzV5dNHnSAIn+PQvKR0twWcd/Rx5DdzGHcz1lgJDbLhIAoZCbnYRY33M1nNv
X-Exchange-RoutingPolicyChecked:
	uDbJFDEOAv34sVS+H8bmCVwrxSTvynZ1ieBR+NTMjwImEgVq7AxjXqS8yz16RUwOuEg2GcZT8ZRw64XuKJdUCOqJ7XYxVGkqa4QAhzMrIv/cfTisMeXP2C+5OFCJGpi6PXBxZ+o+CL4smNBN5RwyAw4Y6k/BPRQbVP9jzgdvnhR0OzmqilbnQd4WddyG/F6iZU9nzicXzv0MLAkbnxgJQkgI58TFCllFRnwxX9t7ExpdZNhNkc8Y3HOd314gTJHar/MYVVsOQ8daWMUIZXpWG/ELs8q2YoNPrWLr1HryiyJ4QVs9jUuWhtt1WnRGrF8zlp3S1m78L76CU+S5sM/NGA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:22:05.5319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b5061-02c0-496f-a1b8-08df19fbc5d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC82B87818
X-Authority-Analysis: v=2.4 cv=a/elZkSF c=1 sm=1 tr=0 ts=6ab4b383 cx=c_pps
 a=QRdqWuRaZ29IqTB7rU1R+Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=A3A_rWoD_ZMtxe8CPQgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMyBTYWx0ZWRfXwLuC+hP2rGdt
 xu89z9WZylPX6/E4aj3rF3f2+5TdBt14tln0WQL3ZOMWso60WyZigYdfHaFc9uJQ9/HjMyQn0Za
 xIHWjfFqYYmlAWCgBgHGS8G7yTVhHTg=
X-Proofpoint-GUID: Ip9Y0KOBDWCOWQLbs3NQz_NizYIZZg8_
X-Proofpoint-ORIG-GUID: Ip9Y0KOBDWCOWQLbs3NQz_NizYIZZg8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMyBTYWx0ZWRfX0Q5nuB2rrzLZ
 IgMIFUbKX+lE8qLxDQFNQQSqq6t+t4hgaEZU57Jf5GBhB51xEE93Q6H8Z83iYJy1vwSyWQb1+NC
 eZOjBqMro1cNgxet5gYk4gf119eJQtaPYKDOQbRQONhZX/BR9lhOExAtyWeVpDJ0vaUoWCZQbNp
 xp13v8PPvlzKk1OSFzQS+NXS3AB02WLw1lGvuKlaqjmpO672yVzyomAwUKHWxGOWNYZScijLTD4
 /r7+GEIyyQx4VmJkPZoM8NxzQdRj3OricnLO7mDg5zcSHHe+8OkcycgOjBKb9Y0LG8nXRZUiHCb
 EQHZeB2q3oenW0BLugjR4amdvlwYAk5ugUC1vjWOdu4aK+JfMdMKE5SqY2TrvYxQPDsQHNwmbwX
 UE3f5Igwx3XP2jqfAXcNeOoxGoOG6uzfwEdVztP6eiN2cNhn0FOJEnBXHcPLDeHLg7uwCq16dST
 lyHTrOyJmwvdWGiWp1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240023

On an FDB flush, dynamic ALE entries don't get deleted. They stay stale
until the ALE ages them out on its own ~30 seconds later. Two issues in the
DEL_TO_DEVICE handling cause this.

First, the delete was gated on the same "added_by_user" check used for
ADD, so every dynamic delete was dropped before reaching
cpsw_ale_del_ucast() at all. Drop that gate. Dynamic deletes are the only
way to remove a hardware-learned entry early.

Second, dropping the gate alone isn't enough: ALE_VLAN_AWARE is always
on in switch mode, so a dynamic entry is stored under a real, nonzero
vid (possibly several, if the same MAC was learned on more than one
vid on a trunk port). With the bridge's vlan_filtering off, the bridge
core never learns the real vid and reports vid=0 on delete, so
cpsw_ale_del_ucast()'s exact (addr, vid) match never finds the row it
returns -ENOENT and the entry is left in place. To solve this use a new
cpsw_ale_del_ucast_dynamic_by_port() that matches by (addr, port). If vid
is 0, it clears every dynamic row for that MAC on that port regardless of
vid. If vid!=0 it only clears the entry matching both MAC and vid on
that port.

Handling of the user added entries remains unaffected as the changes
made are only for dynamic learned entries.

Fixes: 86e8b070b25e ("net: ti: am65-cpsw-nuss: Add switchdev support")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v2 - v1:
Address comments recieved from Sashiko [1]

Sashiko had 1 High and 2 Medium comments on v1. 1 High and 1 medium is addressed
in this patch. 1 Medium is a acceptable behaviour and not an actual issue.
Sashiko also had 1 Low and 1 Medium pre-existing issues. Those two
pre-existing issues are still there and can be planned to fix later but
not as part of this patch.

Addressed comments
1) Dynamic delete with non zero vid was going through cpsw_ale_del_ucast()
doesn't use port based matching and no ucast_type filtering happens, so
the row that gets blanked may belong to a different port or be an
ALE_UCAST_PERSISTANT row. This is fixed by calling
cpsw_ale_del_ucast_dynamic_by_port() for all dynamic entries. vid handling
is taken care by this API.

2) Added EXPORT_SYMBOL_GPL() for cpsw_ale_del_ucast_dynamic_by_port()

3) There was a comment about cost associated with full ALE walk for each
dynamic delete. The ALE size is small (max 512 entries on the largest
supported device), so no change is done here.

[1] https://lore.kernel.org/all/179006497666.2160803.14768308117153644313@kernel.org/
v1 https://lore.kernel.org/all/20260918075926.3616434-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 12 +++--
 drivers/net/ethernet/ti/cpsw_ale.c            | 44 ++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h            |  2 +
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 53cdac272b583..0dc681748b0e3 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -397,13 +397,19 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 			   fdb->addr, fdb->vid, fdb->added_by_user,
 			   fdb->offloaded, port_id);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
 		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port_id = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		if (!fdb->added_by_user)
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port_id,
+							   fdb->vid);
+		else
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index e202bba494807..86bcea5744e01 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -249,7 +249,7 @@ DEFINE_ALE_FIELD_SET(mcast_state,	62,	2)
 DEFINE_ALE_FIELD1(port_mask,		66)
 DEFINE_ALE_FIELD(super,			65,	1)
 DEFINE_ALE_FIELD(ucast_type,		62,     2)
-DEFINE_ALE_FIELD1_SET(port_num,		66)
+DEFINE_ALE_FIELD1(port_num,		66)
 DEFINE_ALE_FIELD_SET(blocked,		65,     1)
 DEFINE_ALE_FIELD_SET(secure,		64,     1)
 DEFINE_ALE_FIELD_GET(mcast,		40,	1)
@@ -441,6 +441,48 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
 	return -ENOENT;
 }
 
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port, u16 vid)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS];
+	int type, ucast_type, idx;
+	u8 entry_addr[6];
+	int deleted = 0;
+	int entry_vid;
+
+	for (idx = 0; idx < ale->params.ale_entries; idx++) {
+		cpsw_ale_read(ale, idx, ale_entry);
+		type = cpsw_ale_get_entry_type(ale_entry);
+		if (type != ALE_TYPE_ADDR && type != ALE_TYPE_VLAN_ADDR)
+			continue;
+		if (cpsw_ale_get_mcast(ale_entry))
+			continue;
+		ucast_type = cpsw_ale_get_ucast_type(ale_entry);
+		if (ucast_type == ALE_UCAST_PERSISTANT ||
+		    ucast_type == ALE_UCAST_OUI)
+			continue;
+		if (cpsw_ale_get_port_num(ale_entry, ale->port_num_bits) != port)
+			continue;
+		cpsw_ale_get_addr(ale_entry, entry_addr);
+		if (!ether_addr_equal(entry_addr, addr))
+			continue;
+		entry_vid = cpsw_ale_get_vlan_id(ale_entry);
+		if (vid && entry_vid != vid)
+			continue;
+
+		memset(ale_entry, 0, sizeof(ale_entry));
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+		cpsw_ale_write(ale, idx, ale_entry);
+		deleted++;
+
+		if (vid)
+			return 0;
+	}
+
+	return deleted ? 0 : -ENOENT;
+}
+EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast_dynamic_by_port);
+
 static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				 int port_mask)
 {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 87b7d1b3a34a9..3c48e4da18202 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -166,6 +166,8 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
 int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port, u16 vid);
 int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
 int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
-- 
2.34.1

