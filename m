Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E14AE102;
	Thu,  1 Oct 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845766; cv=fail; b=lE6QmQhJ5w0GJ5Qfl9Ah697HwF27qSXKGBmDhn6SkY1SCeLKLF+SeQKg9wCn2xDGVGMOR3HjmI0HEmrur3TeEAae36vtqlFcF1unvVKv3FiaKS9ZyQm2lfVLrRzqTvaKZ4rofX1d4KLMW2Jqw+Fph+sEy4bEVQlOr2jEFkUBfd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845766; c=relaxed/simple;
	bh=sI6XCRhQ94vaIX4oglOnKs5QIGik3yXHvRsJWZya/Xg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtnVWGjg7CszamuaRWc78q6mqukBYYV+zWHmi/Iu8HEMvvn2JanqMojypFM+cSjOz386T7lfREOfEzKoCqXdtGhRS7IXqv3mQT+OwJS9gvRLO++nZ7jOVSyAru0WbzmT8PvJlUbPrBAOtWNt18VN02q9mj7cPWVpEOdacl5j5iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EIVE5NI9; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=NVsGCbeS; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EIVE5NI9";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="NVsGCbeS"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69171Go5793664;
	Thu, 1 Oct 2026 04:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=LHFH6evBDPDYI
	tVvr646WQ98ei7K9DlBxU7UcT20VTI=; b=EIVE5NI97yopT7lU0P3yVe6cvJTRb
	igjSzu5upgZg4XKpJh5w2AiRciq3mPBhUhVWPDrKvyAl2DXLYFIrrblgytDF8yyc
	0+mFbwd0bpPWiAX+0jRQ/CDAC3m/r8Ka5y1B6qDTXlK4yj4Gif1cHXAn+tEzCUnE
	X28e+Y9GrN4My/NOwfwjSY8HrfEeKzxi5l1pvXcGRJzXKSO9HHkQ4bYtX+gDqmI6
	VG4wXWNv4Ae6FCs9USnM5iu7jTvGxBkZDVmD1LxqvtAkCDfvjAzPdtl5jb977dQS
	phw4oMpgyhvUsI8CLtFnMDrQ3zVg5NshXUqq2uikMpTUs5hYw6i6I4PzQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djv9cw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 04:09:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaH1rC2PitxAC52RJm85azO1Ui1X5DrUVRsZKmDIqgC+h466L/qj47b7HhdA8vboGJoLUOdZV24RJIQ1LPk3rSPdM9d+8eUzVe+Z5uc7TlV7hOXLvzziX7qIDceKe5sEQjOIQXd5NWAQP0xGc1TTzi5fNU1Mf0dDhp5LL+x5pkmiX2wifym2PDipdYaGZgjHcVlUSYkNDkubca7KJSr/DwgrYVPjeONx+qIwECRwVTJ7Wlml+xy87wc61EZZXs3q+DV9iVQU3p1pSx5KkFrIa8Bk3pYHhPjifcXi1NlprxHeg/LiBRqvkidpGEMFxHyEBmJT9qtvLhdK6zlRE0LYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHFH6evBDPDYItVvr646WQ98ei7K9DlBxU7UcT20VTI=;
 b=V3eNuOMMXtTzJW4s418VJQzf5yFsgDkA9eKS3F3TTNBgPZZTr7vw0xWmRBXOIXzVx+SQ0P4Oj/wB1wZsQU821FWKuadccHzkBpzTWO3ezkiXlsPyXnBNw8JbZ/xnQStKiLK2bsdMRnasvmMOjE/O8kidR3zSiPp2daFOfkg84qx5bc/zlF5MfjxJco05KZ2DRKNtXHmhOra2HXEQ+FN0sUn71laLCdIwG2nIuZbUuJKGleuK6QqqoqbeQYezSvWNqpbw8n0J+6HbDhPbep43R58KmIVlHiQXhoTeKNetoWdYPLMeSbJj1euU+Brw9QsiKB8rriwDkWazbv0QIu59oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHFH6evBDPDYItVvr646WQ98ei7K9DlBxU7UcT20VTI=;
 b=NVsGCbeSxMYy2l0tnx6WNK/xWCUUgC5qBzTh3hFeyVfgggg5dvcdhlSUuv8pywRLov8b7dmagAVCS4XB662SDXV9XQ9/pSTrpa/94KhtPPBfsMPyft/iSVpX4rq39y5rY6bqUAdEmOJoU+pr04metdVT35i1bvw+r8mv0cnQHZ8=
Received: from BN9PR03CA0553.namprd03.prod.outlook.com (2603:10b6:408:138::18)
 by CH3PR10MB7495.namprd10.prod.outlook.com (2603:10b6:610:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 09:09:03 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::19) by BN9PR03CA0553.outlook.office365.com
 (2603:10b6:408:138::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Thu, 1
 Oct 2026 09:09:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 09:09:01 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 04:08:23 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 04:08:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 04:08:23 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69198Nrs673029;
	Thu, 1 Oct 2026 04:08:23 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.73.69])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 69198MSD004143;
	Thu, 1 Oct 2026 04:08:23 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>, Kees Cook <kees@kernel.org>,
        Stefan Wiehler
	<stefan.wiehler@nokia.com>,
        Arnd Bergmann <arnd@arndb.de>, Simon Horman
	<horms@kernel.org>,
        Chintan Vankar <c-vankar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH net v3] net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
Date: Thu, 1 Oct 2026 14:38:19 +0530
Message-ID: <20261001090820.1605711-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|CH3PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8928421d-80f4-4f4b-7aad-08df1f9ba262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|7416014|56012099006|13003099007|921020|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P6DpzvzF0j4PYDo3XJdg5nLXd3gL0FwaG6e8pK745kGdmDMiPJtGv2vfwM/KjdKa+kz+MMTw5hzFc72g0+nJkiElmx+EAJ89VMvmmLmn7ZR+dP3tx/ZGDrGtH0WpKhQZpVjLYmRIZXt9O4a06w0RbmYg946rHYk+UEARVRrjXcaaGJ90+rIJw8fszsCUbbZl46lBWGoG9LL3rSQkDmFr1GemrY2woZPu5mkBfLnz0okWt1dfkajP5Vu0dkV6ESZsZVcgfLJi0xqJYVlMaHFbH52xqWU4/gK/KlBCJtsC4O2Cnbr1uWBUn4FpkZ7amdCtGiN8Xkj05eJb8X4OSrtrlKXjqbmJiUUlVtJWxVqSgZB4GOqh2XGtGdSwPhSBxKUo64MSCsBe75m6CF+bF9Zf/WH72o7YlIpl5o0MZEj72Lmh4kDa/GK2RpEcK6LxAhJVrjSHPKePLSgNzXUHaQuxGlYneeTR2JDtMw1rufpsp4eM/0QEUJu8dzfQDLi6xZYNhdmAQCJ3vmXVzeYXIScSNaEzrP9qS/NdyUAgAykzHzo/Ex8YdIUDViC2IjNACii6ebHd67MtvC2s4lQFp9iuLqpCDbXn7VKZbF4FXUz1aaKo/hv9afSkSg87QXHCtatKchcfyN9OIvuNhJv4JL90SVVVj8olCNSeWlm02KDkTv1JGbI5EvRt/OHwo/LGgVRBJJ4q2XOIeENq+2ZG5N/atg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(7416014)(56012099006)(13003099007)(921020)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uR3H3fHCvR/IQSmuGuF2/iVjIkdvHm5CYTp/vmU4hYedUwgF8vjMDuJ/tMssWjU3yRcfamoE7nQvlQM8+6P7SBLs2cZq9WWg7INLVBadjpcJzin5yCTqMwmfOHsV0JlnSxXhZ2RofdZbrK4/7a9hDWIQS9CLwdV+Pbf8wDiI6y9n88zQLv8Zo9yNMVYMPpFS1APE7wRcNbrzPtlLsqjT3AinyilupaCmYau2JPDdsTZZ0kdwSSYhAv65X4XSPifjhUjmnijoGheayJzp4ueW9fzdOSWlQjyjbwect07/GRZEk39aDPax4O0FvNpuSLw4oQ6wwusGEtF5M3YxzoZpvykppcWvVKPL8D4/egqOj9mZDUNdDCTbROpuG5+PcM2T7X1n5SZw9PjfBQlZW5zgbau+CXG0yquwtps22ck/21cvEobRhZ7GGVLmwkB0qwA0
X-Exchange-RoutingPolicyChecked:
	vPrM/6yDwvBwYETMiFnP5ceHWBkQNSZIgL+ju3m9Fhl1RaYruaqP8201lN/AfVTc61lUI4QqcQ8CZqWJjrNnjr9F7+PkqRhbHxzIgfQ7AxYcFM6MTTfBgZAPlx6aJV69jCkuzGycdHynw1gbIxRGeLxYOkIolaxKpIeHWsIbdi7ABvb4jZoT/bh/0JkVBgqltA/NiS16aWhcK1xUs75ppbiaCmFCQBwFaxUQtTJnX8npUi9m6WWv2me4pO/OddbASa/ymiEPGdhpHkcpaNXC6ozD9QIuA0b/AYoMJS1KgyA5szyiQsNBq3zwgrxI8kKucF1XfHwGmrsIQOGEbntNWA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:09:01.3520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8928421d-80f4-4f4b-7aad-08df1f9ba262
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7495
X-Proofpoint-GUID: brcJdi1--0oeHiI9_ZO2jBvOy--mli0_
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abe2334 cx=c_pps
 a=EtrKi/+kAVY73poqiPL3VQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=ww3g1lXzp7vuzeEaaqwA:9
X-Proofpoint-ORIG-GUID: brcJdi1--0oeHiI9_ZO2jBvOy--mli0_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX0zjCwPT5eaf8
 QwAfugXeWBPt1v9enMBU0JT8PYvP10o1FLx6MWF5DRQZJR5f5WvOuBqFkrupP9/RoWunGADYiiP
 hS8Un4qyqCS03rBhbnWn5U/RZn1q0jQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfXxPZVKoOPshrY
 q7HNneza/EsgLAETc+2fbY63p/8ZsiVa0JJWMioSfripMBDWFQCFcoIAQvI+BkGsTRa3ScwFd9d
 SUi4miOSeiFwXlG7CZ6B1pjqxVVYKCesj2jDvBQDNP5nU42QRsAr0feUNSmzDIFHxOCFEvaKEHH
 7+E3YRT7qXzevJOiDiyG9RyLcRnspZdMFsszujqAmLI68Q6bMpuhnSvaUonNNZPxmi3SYL8DG83
 GALJk0YtYGbRCDwMTv3VNdEPqgpEEXcO2UTJygV4+dLc5zIu308i562Y+y1IO2DLIJj+35iwyWs
 9R4HuSc8sIj2ZFAwASarxNT3URaQ3wMgCePPWI9qRrXq38yTR91SgNjnCSc303PbIVoSxU1Sr51
 UwNXWOaBWIlO5sOiwtVs7PJmPT/bOQ75gSecZIkE6PA3doIbzZmz3RUeBjPsCj9KLAeeh4MIoYP
 kDhPilpLsXYF8+r8PNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010036

Dynamic (hardware-learned) ALE entries are not removed on FDB flush and
sit stale until the ALE hardware ages them out ~30 seconds later.

The delete path gated on added_by_user, the same check used for ADD, so
every dynamic delete was dropped before reaching cpsw_ale_del_ucast().
Dynamic deletes are the only way to remove a hardware-learned entry
early, so drop that gate for the delete path.

Removing the gate alone is not enough: ALE_VLAN_AWARE is always on in
switch mode, so a dynamic entry is stored under its real, nonzero vid.
With the bridge's vlan_filtering off, the bridge core never learns that
vid and reports vid=0 on delete. cpsw_ale_del_ucast()'s exact (addr, vid)
match then never finds the row, returns -ENOENT, and the entry stays.

Add cpsw_ale_del_ucast_dynamic_by_port(), which matches by (addr, port)
instead of the usual (addr, vid). When the caller passes vid=0 it is
treated as "no vid filter" and deletes every dynamic entry for that MAC
on that port across all VLANs. vid=0 is only ever passed when
vlan_filtering is off, and in that case which vid the entry was learned
under does not matter since the bridge is not separating traffic by
VLAN anyway. When vlan_filtering is on and a trunk port learns the same
MAC under multiple VLANs, the delete call comes with the real, nonzero
vid, so only that one entry is removed. User-added entries are
unaffected and keep using the existing exact-match cpsw_ale_del_ucast();
this change only touches dynamic learned entries.

The host-MAC-to-HOST_PORT_NUM remap used to run before this new by-port
lookup, so a dynamically learned copy of the port's own slave MAC (e.g.
from a loop) would get redirected to the host port instead of the port
that actually learned it. Move the remap into the user-added branch
only.

Take a runtime PM reference around the ALE accesses in the switchdev
event work. On port-down these work items can run after the last PM
reference has been dropped, so an ADD/DEL that reaches the ALE needs its
own reference; log if the resume fails. The reference is taken only
after the is_local check, since is_local events never touch the ALE and
do not need to resume the device.

Apply the same fix to cpsw_switchdev.c (older CPSW driver), which has
the identical issue.

Fixes: 86e8b070b25e ("net: ti: am65-cpsw-nuss: Add switchdev support")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v3 - v2:
Addressed comments from Sashiko [1]
Sashiko gave 2 medium genuine comments, 1 pre-existing high and 1 pre-existing
medium comment.

Addressed comments
1) This patch exposes a ageing related side effect, which is a trade-off.
The same has been documented in the commit message.
2) Runtime PM reference has been added.
3) The same fix has been extended to cpsw_switchdev.c driver as well.
4) A pre-existing race was highlighted by Sashiko, that has not been fixed
and can be done via a follow up patch.
5) Local testing with Sashiko highlighted some changes which has been added
to the commit.

v2 - v1:
Address comments recieved from Sashiko [2]

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

[1] https://lore.kernel.org/all/179057463349.3145.13175831323497920715@kernel.org/
[2] https://lore.kernel.org/all/179006497666.2160803.14768308117153644313@kernel.org/
v1 https://lore.kernel.org/all/20260918075926.3616434-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20260924052146.594157-1-danishanwar@ti.com/#t

 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 34 +++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c            | 49 ++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h            |  3 ++
 drivers/net/ethernet/ti/cpsw_switchdev.c      | 34 +++++++++++--
 4 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 53cdac272b583..bc4e19e2373f5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -9,6 +9,7 @@
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
 #include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <net/switchdev.h>
 
 #include "am65-cpsw-nuss.h"
@@ -371,6 +372,7 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 	struct switchdev_notifier_fdb_info *fdb;
 	struct am65_cpsw_common *cpsw = port->common;
 	int port_id = port->port_id;
+	int ret;
 
 	rtnl_lock();
 	switch (switchdev_work->event) {
@@ -383,12 +385,20 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 
 		if (!fdb->added_by_user || fdb->is_local)
 			break;
+
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
 		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port_id = HOST_PORT_NUM;
 
 		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
 				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		am65_cpsw_fdb_offload_notify(port->ndev, fdb);
+		pm_runtime_put(cpsw->dev);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb = &switchdev_work->fdb_info;
@@ -397,13 +407,27 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 			   fdb->addr, fdb->vid, fdb->added_by_user,
 			   fdb->offloaded, port_id);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
-		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
-			port_id = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
+		if (!fdb->added_by_user) {
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port_id,
+							   fdb->vid);
+		} else {
+			if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+				port_id = HOST_PORT_NUM;
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		}
+		pm_runtime_put(cpsw->dev);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index e202bba494807..d3d6a1ef894ac 100644
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
@@ -441,6 +441,53 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
 	return -ENOENT;
 }
 
+/* Delete dynamic ucast entries matching addr+port. vid is an exact match
+ * when nonzero; vid == 0 is a wildcard that deletes every matching dynamic
+ * entry for addr+port across all vlans, instead of matching vlan id 0
+ * literally.
+ */
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
+			break;
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
index 87b7d1b3a34a9..ed1921b428e50 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -166,6 +166,9 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
 int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
+/* vid == 0 wildcards across all vlans; see cpsw_ale.c for details */
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port, u16 vid);
 int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
 int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
index 7e06aac388a60..7fbebe666da81 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.c
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -10,6 +10,7 @@
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
 #include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <net/switchdev.h>
 
 #include "cpsw.h"
@@ -381,6 +382,7 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 	struct switchdev_notifier_fdb_info *fdb;
 	struct cpsw_common *cpsw = priv->cpsw;
 	int port = priv->emac_port;
+	int ret;
 
 	rtnl_lock();
 	switch (switchdev_work->event) {
@@ -393,12 +395,20 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 
 		if (!fdb->added_by_user || fdb->is_local)
 			break;
+
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			dev_err(cpsw->dev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
 		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port = HOST_PORT_NUM;
 
 		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port,
 				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		cpsw_fdb_offload_notify(priv->ndev, fdb);
+		pm_runtime_put(cpsw->dev);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb = &switchdev_work->fdb_info;
@@ -407,13 +417,27 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 			fdb->addr, fdb->vid, fdb->added_by_user,
 			fdb->offloaded, port);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
-		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
-			port = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			dev_err(cpsw->dev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
+		if (!fdb->added_by_user) {
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port,
+							   fdb->vid);
+		} else {
+			if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+				port = HOST_PORT_NUM;
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		}
+		pm_runtime_put(cpsw->dev);
 		break;
 	default:
 		break;

base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
-- 
2.34.1

