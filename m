Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D234A78F;
	Fri,  4 Sep 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527602; cv=fail; b=gquJ782waOZx1EMJmklFCDbNyRdQTI+CydGoDu3Yk+VysCfYFWmEw8TYJmB6eAfKrtydgyY7yd4aLazJ+Gq6iHJjMlBvTK97524VpYe/eLipJpRSUL6zBWKj9DUKcIJvsDe/mILUzQ5FjaQ6iOQ3Ym0RAyRpi0+JUen8Gord8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527602; c=relaxed/simple;
	bh=I97W1ZiOxMU9Clhfb5W0JgnaJjkcMSpf1tjrFbwACAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwO0LWP6sFKv+d7+g/4Tn/qkIaXmqEq4X4Djph6xlbe1H5Jf8akHxACvRG46ZU/EPpagYYE5ceucDLOpBA0FEzp9K+hnjtv7ideNYgo983oxiMZPF869Z1Fd9NeKrWsSUHA8pOV5GkR4BtMzPjoXXvHKqz1N/TC7eYPo3O5SLL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JfiHR81X; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tHDap9ZG; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JfiHR81X";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tHDap9ZG"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHC2i3456741;
	Fri, 4 Sep 2026 08:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lO16gPxRXl7jH/QfB5/83C5ycP63pTzI9gmCVlo6z
	9Q=; b=JfiHR81XUH+tkV1Jy5lWptMTdd67HTt1NMwPAN4p8ta0FPCZfBdZC8R22
	NHrnVAY0YuNkcCHGxI3UDrpuBv1VzWxTlHv7VQBHP+Ku9nnHu379jYlaraeIAePn
	PilKTz0d389jHwVJCFnmnZ9S3GQZP7okXfq9F6ZqytKDEkx5YTvqL5zuvRVlMvkn
	K/aDzXDaKvKIbF3Ey6om2SBcY6DWdv27WjEx4qmoz8OybnBCgQCp9uFbC5CDavDp
	meLC2DCqnxLtD6X2USemL/6Qt4FHXCAYbfWW7c9DMZ/xawISGhrOC4HyxL1W5GjS
	8QUJrpm4bj/x+G+WRsY7tif/On6vA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xv39k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObNCSPEMK4VJ/AGfeCghK9kCqKqKe2kVXkVTSG5QtX6jEAFLmPBdspxqvPfT31zWWgEehfO1PRu0S332gwQ+5K69Wc//HyXeC/nkPy4RU5agLJZqcY7Z4k4QysedvXFOcxcdZt8H42kHbZdIgraSNrX+zPl2vjrIiN2U3RNNn0F9jkGH/ql7saFgwkrgmrcHB1hso9dUiWFtt3nb5OgbqgDhEgJzAMZQWsfeoXTGcO0YoLbckcpWBD/6+e7Za+u/h+HSN6E+aGk6y2+3/wpSleEBFvFeHK8LZ/rE+L+3sz1vPgIa21ThVVWmeZitAeHu5rEutISoFJHBuAa41tQa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO16gPxRXl7jH/QfB5/83C5ycP63pTzI9gmCVlo6z9Q=;
 b=gO2C/RsreFfKqdqCT9lK03LrTXWPDGoYQyJx3LoH0pmgcGhHbduDxWWot+S/diKu5dpuQm96UqpIubvJ5PBdLQSdKjGWPQYYhAweIOL4vN4v21zA1sXKe19XSx7KBS2ajjMhK3jXQNteNWaIqdzxMj5eKEnaj987kvasUXfCMghS8rS6Oh18DGfhRzTo+UuM18e7jjuaFyzHjVs3JvE8TsIEF+IxX7odonwvsvPU213weB1duX2T4c2QuNjVopSkKLpohbrWgJrb4Y5e7KPOltpggtv1qXGl4tnjVcsv977lBKpMW6S4xU+LJLEwoW+f5APoaFoSEwwwJpNblzPLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO16gPxRXl7jH/QfB5/83C5ycP63pTzI9gmCVlo6z9Q=;
 b=tHDap9ZGBr9/RIw8ORN6SX1yAQDveqjO8qMdly2uASXwenq2/oODKmW/QiFlflmjSLXRYZidKEOyB5q/aULkSMFbndJ+n+dc7RHNDpiRqhSgsPeFEfqYl04e7WMIZ9rVihxryXfWhjD/077NWoJf+/ty22P1zpKeOsWZdZwiUSU=
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 SN4PR10MB998047.namprd10.prod.outlook.com (2603:10b6:806:211::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 13:13:00 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::9d) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 13:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 13:13:00 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:54 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:53 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq53371029;
	Fri, 4 Sep 2026 08:12:53 -0500
From: Andrew Davis <afd@ti.com>
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        "Andreas
 Kemnade" <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/8] i2c: omap: Remove unused is_rdr and is_xdr variables
Date: Fri, 4 Sep 2026 08:12:46 -0500
Message-ID: <20260904131252.2126353-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260904131252.2126353-1-afd@ti.com>
References: <20260904131252.2126353-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SN4PR10MB998047:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb08e27-2f27-4583-fea8-08df0a863eb6
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iDz4VOEz8GAdlEzXcrjpMSCtpwT/FjEbhHeyjEWD6ySPhgT3tLw0A4ijEer4oYyMXwEGuBmBqv9GqKbZ4Ha/ewS3eHYyK8qlvhfMTLkmaQuBEhOFhjjLVSAEOlZKNOrkGYiw6Ef9dwA310xW8yddMBoCuPtVIU3zrb0oXdRRFGtFOXuY+WVxPGItEhExULiO61OIPvrqQsVdwm/6VObwGLn/HBEV0KdLJAtJNh3HmdUOVdtuj2bRgNg05mGMfiI8EKLS8ZVq5x4AtovbXsnSpmFW5L/Id4K8xgSIhCOBzM8KX9yvROSEjHpbOrnfZwJg6lXesZJj/t8l0HxR2mR6BAlJjoqiuJCuzD0dZKsB6lDcU1B2HYglmIL7y3lAeaefWfHnQEkBcrzAK60xJ8cvXq57tYDZK+3q/fQLIaFjZJDz/znqI2z40VvitI0dd/GIvPfHmZqQb67j4eTH6qjFk4K3FUq2moL72j043Lrei8pHB2Rgndi8x+VkJ6LKMdU54SEGHwBhCLPjRrrO+3jSDus7vpK3SakOQVAEoWCzRpY+Y4xgARiW8LK9iqxcKAbEgiPiUjw1ilgJytPYjrpJZahfDhLTuv83yQ6CtdjYxonE5b5trwhjFstw90ySVh0GgYLjGdp1W+kUAjh+1x7PZF55hPSMrBZTtrXDvcqB21QR4AQhs4fthS+7EEnbdGQDQ28uUUqxmdGQ29mP8Gjq/A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+NCCaUggvDaoODafJn72Brkb+2lK2XhqD/Vgv41nZsgcqh9NElY8acRGzUXt5VJqSUcWrFUfpPZwOWA8NxCi+oD7MFxAXViYfNtX7Vy4ATyW7Vr31OsKnu0czhfGcYgrPO3Tf9UaTVdzjWBWS7e2w9NUM8QBE8u4LXAwHkxe4jkfLCRpVFzv4vT+TPN8vdBu/+942P23n5eDi2zlSELK6g4ZT9wN+zWqJn0/Epth8Col31tvAl2MXfewEtjf1g0z+Xtwj8TWLVKXpeB8nPwmj4OrxgBu7mV180Kew9Y+u2XMK15/1n2AbjfA+xZr/jvUQKmTpMn60AEiqHydupU/rzG4ASv30iD5v/e/pJOmwyARRusSuTGoPeXtRV1VIvfo/nFJam7u8LW9Bxiqyg2lQP4mXib7YRHa8oaqIC22mi86GTnj6npnzYENeniN/tnO
X-Exchange-RoutingPolicyChecked:
	yiveW4XTHXLr479+Jb26h18KnLySH1X4KuBfSnYI87LmqefqFjWPE1Zs8P4i3MFXR5ewDC1mnx808qE3HnBjn3267JlvtKqPDWT2T+C9YqZLCl3VePz2HsGijoAjzR9UiHQLUeTzqX1mLOZrHPtcKDoFbOMoXvTVqvdWo780V4zh9oC/8pDfs7kQtVNQXlq/OWJvRH9XP2bAx6+xF2GRsRW1NspRoDMVwAf3FA7F29czXDqAXsuDbaEKiGQvKdFs0LSzphO6dXeU6Ygpz+kXQTyYIgIYjiOYsIKYY3bgSQH713ZvuA9X4yUCvN0GFLsM4WppRbv++nh4WHhK0yrc2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:00.2991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb08e27-2f27-4583-fea8-08df0a863eb6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB998047
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfXyAJ45xJd8yao
 sRUn2r+Q+dPa1u3e9SAszSQsUf8UIfsEB7RwvxsXEcy94w1NuhpCCNzY25GQLB8Qc6qFkv3NoTP
 HuB9y0Pc+EJ+Ul1BMNF+qlg8y8IP/u4=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ac3e2 cx=c_pps
 a=+8K2uRBjRfMG8L7NFMG7mA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=eUdvuMK_en-A6lLaKTEA:9
X-Proofpoint-GUID: oFYRla1w7VqEUVuvGK5JBFec_099yZav
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfXxKuVR3Q3+AWG
 gh3WyfqkUhrZ7Pp2N9h2BJw1cPYJBviGjczu70h4sYusDKCJ2Y2nGOZjYi+A4pEIuxJx9oG644Y
 z/TraDssBked7rOKQArc0RFAL+85cptYEXDILDjB1cMaEH29M9H9AdMs+sT7heORPSeN2xJmXnc
 AG5gwe7o0ikio0lI8Af5HNf648D4h+PaJz0rGHg5TTFQ932+imEnGK1/4vcXwTozIj8QA2/c2L0
 HaFJ52i5l3vA8nP5tCVBR5ESLUEselv9xdQZEz9W2g77nRlXf2mqdRpr7AFQJQeU1PgUyCfsHtD
 No7i6j/dFqXg5qT9KOrH9kYIq9ZlTkS2322EM/sG5qMUFZX9304rF+icYEhvPxr2rnF8qznTNfQ
 YoYHX3QtrNJdCbnnmaH6Q2+1dV3w5CWELCtWzhnXFabhyy52vQ5rPvQ8tFpPAdyDc1FhmbDCqY8
 QlLGyjCHj4xNGcQnB4g==
X-Proofpoint-ORIG-GUID: oFYRla1w7VqEUVuvGK5JBFec_099yZav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040119

These are passed into omap_i2c_{receive,transmit}_data() but are never
used, remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 72f979eec7311..68b0a043f1e51 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,8 +993,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1014,8 +1013,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1119,7 +1117,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1130,7 +1128,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1142,7 +1140,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1157,7 +1155,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.39.2

