Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8863B1022;
	Fri, 18 Sep 2026 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718396; cv=fail; b=lHtjfCBToMVmbvSKzRevrD/+NTTrmArNGm657JgHH36lzmEMSodXoHSCIWB5uDJn+gpU91zYZi6QHSlTKSy8Lv2/gB9UffYan2lOf4op6SWBSUNiBxHERq63KB1xkuyD2Y9aoFEhHNFJqFZQ19hUAPlhC5/aRQAwfrWa/27Qs/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718396; c=relaxed/simple;
	bh=6nIoZuqZRSXvzfoR/cdJPvMBI5sqFtKkX+4RLQXbvqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cyodbx46nzTe0ke5+odisCuB56HFwKXW1U4mSR+28FOHrpROX1VLIIMbD3idyDhFFLMaBrQu9l0e8dcseL6ZzIqGNqFZ72m8XP0wzKQEyJPgO1eGXvEgVstk8nGFcsNknHgIdMcI4m6xKBmj8VIq2xxz9FXv8AirVyy5V4arl2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=T6T6UENI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rY7gZub4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="T6T6UENI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rY7gZub4"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I6cubw885058;
	Fri, 18 Sep 2026 02:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=QjmfEWWaPDUZ2
	dnwP8uMK+tJaeuzmAVnNgJ3Pds2BjA=; b=T6T6UENISH2Hyafst7YDiLEIlM9p5
	ff/MiDWkGlBLmx7GvmbxYZzRDRQRMd9MFriepnrZWBInGdC3RzJL9Kqaw8NKts5/
	QfzAJDeZwVX/aGMgGzTiNFxMuuzK33B1+qama8l2GQv73Gk32DUsZ6ivPVTm7j2H
	wKP81gkq3rqJJMvrK4dLmGafE//C59hghntoN60+KDzm2I9WvFqVNVOlUPTLR/Ok
	PXpu7o9Dobijxl2mcUiyUZyaM/4AhwXZiOQAiJFMngBFY6RmMtG54rwmEPdz8NlB
	VKEHIb3ByuMfk8Y73C7OGToScDDr1seqcTyvinptdXWxRht0k2peaVA/w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	by m0384305.ppops.net (PPS) with ESMTPS id 4grr9hbdnv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 02:59:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0F+6Ty51f8b15Z4ykYWH49H6Bg5YpgapVspgoqtUfK3BGwFfhXup+C0gFUAIQ/0AxCn5I0vx789wrFUcq9FK+3qTGHCK17r2ArL0aNWwChWM9rgk84fahGY0nGYvij7YbkkQ33xlEZ+d6nKP+IhJgJIK0Ed0h1RWHsHHqP0KnVAi5MjDGNTzT3vz/1E6mpqUPquTHlaNsLSgF8sEkjUTsi2ObN2eLZw/tsqJMvD3Ev+X6X9VQg9fUlJcgfwxMoxNOjiPKfNQ910y32Qn0bBdsSgdQwxYF/KDRJP8mRCEO78OpScfh6M08/HfAP7csyegeh8ucKzp81O9NwoxW7Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjmfEWWaPDUZ2dnwP8uMK+tJaeuzmAVnNgJ3Pds2BjA=;
 b=MwOs6wHjxEkG5o/+PgqIL5QGKuwPkA5l49ZAJZIZ+bWNdcK/50mcj5W/Rmf1ExfjzWDESncOTXD+SZSwpG/lSoMoQMbSvUJSnNyQV0pDpwWKlZNoPFFlH6HSUyhltr3n66e/2TUnA+jiqVrqehWD0uSPpVH6Bi9DfkvFZXNwhlmc9Gsy6SG27NyYXkNybm43+OrOgJ1K0sdIIYsbNUw5TSmKv/Py318eRGbQS2F4n+oOCQ7NVr2p9HMgjSNnNWwufnHbzeaRoR11e92xOgA/+fOISYrGqAiRUgxtvRc0Z3EWhIxZ21W0SoIGvrG/MmHD47wNUCLWvJK8ZtbBZmdImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjmfEWWaPDUZ2dnwP8uMK+tJaeuzmAVnNgJ3Pds2BjA=;
 b=rY7gZub4d5es9lawDX5Ae+s58wnN66WlJJpOw1XAW7gWcAEVBmc09hFiADTbLTkXT9aM3isV/wGdqSzuuyLZiSn5aLtFIvcj1iLG2h3BlRTbWBhDPpDqUPuPxGx+8PvsKW+DhN440UoSOCOwHZZ4MVlWDp7tqbL2Nf0MxvSxqYk=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by DSVPR10MB997889.namprd10.prod.outlook.com (2603:10b6:8:3e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 07:59:33 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::1a) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 07:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:59:32 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 02:59:30 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 02:59:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 02:59:30 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I7xUJu388704;
	Fri, 18 Sep 2026 02:59:30 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.73.69])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68I7xSiA024679;
	Fri, 18 Sep 2026 02:59:29 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Kees Cook
	<kees@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Stefan Wiehler
	<stefan.wiehler@nokia.com>,
        Chintan Vankar <c-vankar@ti.com>, Simon Horman
	<horms@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH net] net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
Date: Fri, 18 Sep 2026 13:29:26 +0530
Message-ID: <20260918075926.3616434-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|DSVPR10MB997889:EE_
X-MS-Office365-Filtering-Correlation-Id: 95740bc5-9838-437c-9ab7-08df155ac65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|921020|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Oq6GJH8uGPiowclLdeJPDVNe4k/kucAAJFyIw1LHo2y86cQfb45jKPlYHx/zRX3ufQJmcCyk0vgFgMmaVDQrgOp/wwetb7ZYQqTYyICVjRbV4uZr6Yhj/KZaNB/KTjKBehoMqf8mHEQCBtwUvBbBL6EU0UjIAsKSUVSluRXGZH2k3dGNDIOZzt4BKQ1/nYVbwLHCuZj78M21FApA/zmsyB+SLdTdLvxeNMGVgZ0DWyV/rrrkh/Z5XnIPGcWXa3fTe2rJQJ/O6l8PDqgjjYLWumV+8TSUmUB83SzL+gitL8oaDDr1aTqMfZXj10rQOYfcW7r36r0+cL623YhM76vV3/FqWjrhY8uAm2cAgBnC3n2LGU8X0LpsYTTIZo9M9SoGXcZvebuLmotgVv7RlIz42eTJQ3lFH2A6xlGOheC5al6ESUk63wUugirYBnXtIchUo/PJ+eTyYtANl62UfFwvbAWqGl5mMAZSfK6jKQRIOfA56gVEZjBrQnGwgPAh6RUQlY/ZhUA56AnI8iUyHqHu1wN/jGWJEfg3DhL2d9HHE1HJhQ0eZYzUj2TVmn4vzV8uLW+MAysdZb/K/KFiO39bA06lwI3r+8l0eidPt4DwdUe+OBID8ml6VQJqjMWt9wULxB4zV3cnoET2iKw68KSVKNaD9Z9qoaHyQunMNO5pqG19d32XKdEJZsLl5ptyjq8r//mAMGW++38ZKGjSuiCSWJWxv1BMHPJWAqXGmi2k+gy2p0pYKpdKMCnLpQ8H+ux/
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3DVVo4FSLccXtaJpzeDxNUxvK9R56LAoo2GYJ2Fqe2ckyCGD4EfAitgmzOOfQ/ZlyHeuQMwfQAU7y1AS2bIf4q5+tCs3tdPWVxzebKckvnps2oMtcW7YQpUJgztN9C/vznuj/XVyMJtz/FN9IwSVOAWXF7tmgNiDc6YyzCWvB/cVI0Ljyb50/9Evc18h4zTxUjhI4daHJajyBJlAEsfneO3ythxsVytqX7xFI9heCCk86sbQ0Cf0SQySvcMpZ7hmr3rsGDyPj4mXSF0OXm1apGZmUGWaemRSO4MMQbAF6Y0bsnPRWXl0UI0zSYD5uxLo2bKaxpYXdy2IR4/T7pAmIVtyxQBf2uotWJoxSK71b1RB4M4i06rH9qg9Ctph9P0da3OMPqDgThcSJtMl34dtKPLReD44DhxQz4KcXzXWV4+XmCswghBWOrB2Nb/KQkEc
X-Exchange-RoutingPolicyChecked:
	cyF3v3zPhB9QWqQZhpbqc1MAz+NyR3oRQAZPNLz+rwkr8GYsgppsX2MTd7sVg09liHOl9VlKOEqpv8fOODPemkQ3P048cwrECMQCSISNxbyWWzYDW4uR3hVBytXs9r5hbnpbN8aGJbZLFt+KxtF36H5iG38PyFH3sWbUF+Brj/btAi0EbYb2Rycdr3yyvK5hZiY5S2904D16KfSxHbiv8wH27RI67AzGRrUtfCxVVRBF5pRpAL91JfR3w6VFlGjmEy4Vh8cpc9j5DXZ9PFdcoIko+8P54DPxTgmEoChsbJoa89SynfWgVaUgXOVpLHicAN45cXGHo17j1L5tUEfn5A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:59:32.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95740bc5-9838-437c-9ab7-08df155ac65e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997889
X-Proofpoint-ORIG-GUID: ZvXqtB1zeprBxR_WJcWcLWY6Fd1T_Lnf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOCBTYWx0ZWRfX9rfE25d0gcHq
 8flzAKoFBtfmFxypVlNXrbbCsfFzF+CgQh1xJbbZR7Hm81aDD1Qxfz0Qoar38eHeJNr3qigHGbD
 MGlUyjF4yqq0Y7JZuKdVre8vCYctqVwquAQOhAZLxMF9shcyTQWO/lC9ehFypc7zOmAVzScri3N
 fV25e4VOAAQ6VoevkASl6CezUW68mnV2VVWUgdy4JxP2YyH1r/5k+TFB0R6djfO5/BzipjZilzc
 Y0UTvJIvdToowc3ihiXrAH8+ayufkn2NVWvCCRhwQuvlJVp6JXmuiVGHy7oHnZzr7vFIBzJuUHu
 sXsUXVNwecO/9NQvxcO0u5jn79dQYxtkzARP5YusNAqKKSvHsh9Q0Y62VVDpxFJd345VO35L8R1
 Z47oOug+FDC0aXxedZbNho2CHAn4ZPXP0th/ReFNhgyvF6HiOi/QXGQCAI9IIj//pICtvahwTbi
 za6RhLSb7YvDUdmnQYQ==
X-Proofpoint-GUID: ZvXqtB1zeprBxR_WJcWcLWY6Fd1T_Lnf
X-Authority-Analysis: v=2.4 cv=eeCo7LEH c=1 sm=1 tr=0 ts=6aacef69 cx=c_pps
 a=r1suf/lb2duQPz5POPReZg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=y4oAsXJ5e_F-6x_5lpYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOCBTYWx0ZWRfX2M/T8GTfo2d/
 ZyPq93zIx0NsX0CS+Ka+NKN1JpTjfeTZ00hh1EVfXXUMBCyu2t8UCX9Q10jsyGeLXWePpWjRqe4
 0Xrlp7xBFCuw5zq4NCVyOgTEQUKIVCA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180108

On an FDB flush, dynamic ALE entries don't get deleted. They stay stale
until the ALE ages them out on its own ~30 seconds later. Two issues in the
DEL_TO_DEVICE handling cause this.

First, the delete was gated on the same "added_by_user" check used for
ADD, so every dynamic delete was dropped before reaching
cpsw_ale_del_ucast() at all. Drop that gate. Dynamic deletes are the only
way to remove a hardware-learned entry early; the ALE never reports upward
when it ages one out.

Second, dropping the gate alone isn't enough: ALE_VLAN_AWARE is always
on in switch mode, so a dynamic entry is stored under a real, nonzero
vid (possibly several, if the same MAC was learned on more than one
vid on a trunk port). With the bridge's vlan_filtering off, the bridge
core never learns the real vid and reports vid=0 on delete, so
cpsw_ale_del_ucast()'s exact (addr, vid) match never finds the row it
returns -ENOENT and the entry is left in place. For this vid=0-ambiguous
case, use a new cpsw_ale_del_ucast_dynamic_by_port() that matches by (addr,
port) instead of guessing one vid, clearing every dynamic row for that MAC
on that port regardless of vid.

Fixes: 86e8b070b25e ("net: ti: am65-cpsw-nuss: Add switchdev support")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 16 +++++++--
 drivers/net/ethernet/ti/cpsw_ale.c            | 36 ++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h            |  2 ++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 53cdac272b583..8b4640809cf5b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -397,13 +397,23 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 			   fdb->addr, fdb->vid, fdb->added_by_user,
 			   fdb->offloaded, port_id);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
 		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port_id = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		if (!fdb->added_by_user && !fdb->vid)
+			/* vid=0 here just means "bridge doesn't know the
+			 * real vid" (vlan_filtering=0) -- the dynamic entry
+			 * may be stored under any nonzero vid, or several.
+			 * Delete by (addr, port) instead of guessing a vid.
+			 */
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port_id);
+		else
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index e202bba494807..1a2aceda3dbe3 100644
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
@@ -441,6 +441,40 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
 	return -ENOENT;
 }
 
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS];
+	int type, ucast_type, idx;
+	u8 entry_addr[6];
+	int deleted = 0;
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
+
+		memset(ale_entry, 0, sizeof(ale_entry));
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+		cpsw_ale_write(ale, idx, ale_entry);
+		deleted++;
+	}
+
+	return deleted ? 0 : -ENOENT;
+}
+
 static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				 int port_mask)
 {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 87b7d1b3a34a9..69b004cbb1c76 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -166,6 +166,8 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
 int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port);
 int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
 int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
-- 
2.34.1

