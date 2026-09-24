Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A78438488;
	Thu, 24 Sep 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239040; cv=fail; b=eCb8qQKvejAbkTNCFjLEE5GVlM752NCRucjw5/64KLyCiwaxWLU4WxnSqzTZz0cTtBJinNZamfK+r6PQMJTieLNaB7MYu2JnEeNISSJpunnK/Xdnm5so3/DuUMaoCDwJduofvEuRqlF0Ih0rVK5Cq1tFXtRHXDmLlkyoZ55beQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239040; c=relaxed/simple;
	bh=fNb/l3oUs9QGQxBg/J+ubdR273/P3L4Zqu2F4zMLoG0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K5xZbMAaJa+lUA+7+hxjoVhk+9Oc+LkH91toT6R4Xqm5BE+oi56TC2GyckcY+1VXBdYAICoPytpyKUPArveXxhzrt5rmv1YSqZWw8fdo0pZa40dZl1HeAQ0+Itu8zojL7hwh6p5CvQ0roNOdk2A6p71nkwxtR0zHqkO9l6A2hN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bnYwK5WU; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bnYwK5WU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUBIt8PDf3yp3ol5OCLZQAK34NTKwGzj2OM6Tz5rlfs5+XnH0OMw+zRY+8AOWJpBd+IP81qWnxGHjjfpAwgJLStAioolUP3HCJcpL130QI79Ep7hDae2cC30MUENvhmMFE15vjE739F4J7SSQ9uS1PF1jCX8ROk6RPbOpM2U/HVZpmZNL8mdl/nPVyPqJhxQEd+V1eLcFbBQx1blWJtYQ+V2m0KtCo4+IlO2x/fxh/OTuBfsVYszrTFdgm4Wx9le0QFmKU01lEjb6gjKc3inevpWkNUTnF1isnY+oFqlODId3p9HbRZdOT0zkFhoy4/Gpx6HuIPOthraui35L3fkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jnb5qG0uicQ1zU1d75V5ym5jN1mzskufzYIP27DFGI=;
 b=tdBzrkbstiu+QG0ClSzx5kg+yWxAP0fNl3eVH8a4my4fECkZyUubJdIokPK3iA/ndkzLjEQdETkc2+Q8EPSECveWAjiBBgio2BNth+zkL/OnKVA+hC/jkHe/mPQxxcDhP2ILz+0vmypWHTU5OLMycjMMBzkepCN3MtwoXBmOMWivCnCCQRg3p1tl/JGPquH078PgrVxXdXItFCH7Jept5OX9qgdVMx5UdqKz8ubCFuYvsM1LCpkKFdYUgTfs4YDrr8yOfh3ZCGDH+fRg9puzHTqMPvs1tT9VhCv7AIJLLGII/uEct53LDh2u5UMJQTRlIAuOHqL9DV0KlWpO1YrK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jnb5qG0uicQ1zU1d75V5ym5jN1mzskufzYIP27DFGI=;
 b=bnYwK5WUw/PCW4yOOc3V2waqiUyFzRwM5JZNl/9zAl7R6iDAE3/bMh1zrH9SuQA8ModmRkSIvTv820olvDNlu3PijQAKqCwSrpGhRjBa0CB1rdZ0qrkW82MoAPA1cvuxrngbHQQEYeceXvAau6bauV+O+ROJ9zpa1FL6ylrZ3FhWKzoEn2sPM9z4gfSgMNvP3Y16o3nGmLLsD8otMEVN/D9KN1KJd0/lkeapn5z/tsgl0SXk2FQUHc/6vs0FBx4HjWY0VHP6/6juTjsFJ1IYfjbbaw8TF89U0xpgqDhAdWeBi3B3AxOnl6MGqvqeOHmWEqEB19YX1NxaSxHORAbb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:37:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:37:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] counter: ti-ecap-capture: use regmap_assign_bits() for conditional set/clear
Date: Thu, 24 Sep 2026 16:34:47 +0800
Message-ID: <20260924083448.461792-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e67bb0-b54b-4453-fc70-08df1a1709cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	nzgizk+/P30uJW4JoEpFPD6IOE+YzAJ8kcIJpQNYpeRvQRM8o/O5+m4SCYXu0TaG4ybD4wTmYcc0BF35vS4ldqlfv0P1JFWJzSg7Dy7+8pPArpd6hEnuMc/5aEacF0S9Z9J+p0wY2i391U/H0vpcYE0hOA+GWP9gCEheopLb6onsFlrjUQLrmCcU8KnNPbZEtW/5Sm7ypwrJS1wLvsxHHDi+Rf/2U4EdApOgA0r18zd8wXk/O+oKa2XbdVfXw+hkxHHYGDRMYCKkiTruUHa58fo2cEMRok/qclQVIlnQIBUDQM4U7sZi+bgpmErh3JyuUUK80QK159e948/JiWqxWZ7d4SwCbBa/sqCjeXKMBiEn2eEiCrwBFoRTBx54AVHRHnhyWypsVatTaSKNlzBsmTt22RmYFTsqLWxIntS7w2k81qO827DyoBAHk8/mdLwDKMisiukFZyr6RMYW5OuIRynWuBR8oECiCYPFSYkpl0d/IQNcDjZOHM+qjYr1TC3662B+TPLIpcKi7gxDIzQH3JBiq1i8ZEbhb+/Ry5jPpao/4A1IO1OKwsKA+vx9QfFel0rzW9x2qK94PFbm7Nvj+/oGYIc7h/nJQdSasVsKmxDDr9skkRgysF7KuCQdNWRzgKYUXzEpeqshTMP38/OhfgLwUSaEEsQPKyQiO/nHSd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2UvVBTrKzlLRKJOpxkYFhJuqd4hkXE5lj9X+aaD/aSKc0SDRMgXKb2wEN3g?=
 =?us-ascii?Q?Jg7mZFY9/TcKMOtCJatsq+PgilVZQMpoh/QanEBXzWWDylCZpgFvanlr8zWS?=
 =?us-ascii?Q?HxsqmbA3ths0mpTVoM7w2qoN/qiR0I+2hxvcsxpbXIHVdeXcS1ZMgijTOPUC?=
 =?us-ascii?Q?8g54eESHseUhlfBfvDNKmVlOJ1tnGjg8stPBD1mLonZsaJGNGAebUXMgQqVz?=
 =?us-ascii?Q?Xk7XjQWY8SZqM1iiMOalcHESsBEShHRLlq0r+kSjijeXt3Q+GiB3sTVl0YXX?=
 =?us-ascii?Q?z/2ZjjlQFnUINPR8Zyq++7b01Wln0kmZrK4p0zCschppJ3XkSEWkihKIQL2N?=
 =?us-ascii?Q?Y7Q82V/rbmqbX0XI1oq77mABqttWRlQ1Q5lCKKJ15VF6PiUP2UsdYwgFlTpg?=
 =?us-ascii?Q?T+M3ixkxeoN5SgQ7MbYquwcJkO6Ml3s4n3DgB/rstq7cDKMMAlxEVtBbnHcH?=
 =?us-ascii?Q?WQqmdmbGBubAL9hDAJxIHl/Q7pfcLLIhQ7motozpqUaltiLfAdNieSGo+nf8?=
 =?us-ascii?Q?z9SkV2u82DdlevOiVo9tb8uFAQf4hplkY93ou8xePKOXUB/0hKILSpH5KwEo?=
 =?us-ascii?Q?yKLpYNn9OluBUbVQBcXpq7VT65vMtHcCawRi0YH/TRQ8tFpDYUybYM7gXqM1?=
 =?us-ascii?Q?hpFNAw8P5IPskWlJUxw732UcFVUOHoz26RiXHD1s4QW4aBulHjYQinGYRvIA?=
 =?us-ascii?Q?3FfelP+4IUx6AKDG+O212TS4DLWWyGWsNeJeYVFl/Yo6wFjif7y4cOR9xEfn?=
 =?us-ascii?Q?a04pzYfV6isYwSa2WG8ZYZQES8pz+iy7VbV8JV6G3c5fVY6PbohNTn+leb3s?=
 =?us-ascii?Q?my3CTPC+5khraTG1UucWpz/d6Lg+ZUL9daxzSXlU5pXJpY28xdw0b4EMTyOX?=
 =?us-ascii?Q?EVWVozjVfor13quz2fhoY9kUBrEc+NvxTpjo+TLo7CJnKFagT2i8uT0Vn0c9?=
 =?us-ascii?Q?xSImGZVSwTGam0y96ebMrEmwrCPQ34cHoXnEvqUAZBrlEP8RQXa8cyH3VLYz?=
 =?us-ascii?Q?o9xkZZXw6U+JO2HBHQDvinEgoGFGS6Z76iJTW1HZt9lVH+e81DKlXcDBbvTi?=
 =?us-ascii?Q?sGAwLhOQ0VoyP7PnllmoCh2VZBU7+6lbJEqFMYPGsHG9b/CiTCdB6u9zPvHE?=
 =?us-ascii?Q?a4zud7aMObS4Oh5KBsQhT5LSn2EXIxNonVfv6/vUZ0s2i35+61Pbi2RPVI5j?=
 =?us-ascii?Q?Zlt1uUrWwA3YcOdY3Tfnc3TiVb2KC+xRe42odllyRpiUjEyYji37qlHRnKn3?=
 =?us-ascii?Q?LPSbktjZcsDPijrfYB1tgj8G9Me0U/m9j7c+rwBFUMTdiWc5cWiMiDUk5K2Q?=
 =?us-ascii?Q?Pa5YyLiMK+gVatQO2LbgLRj6XOnJlqcp1QYvPu8ShV9DuY32K1qvElTsKYRH?=
 =?us-ascii?Q?ESnqQJWGV5VcZlL4MlkFycksN0Qv4X/2fcaI82SETznu4cU8hyBgLJll+WzL?=
 =?us-ascii?Q?6RPPUgNICWAfMMeU48CWQ+GuJtIvUlysZ32v7MLMapoqlDsQ3A8qx4nDrp8G?=
 =?us-ascii?Q?eOtsgJVKTsktYUkWOeVOBvoICoIceIMEnylaBHXyxCRrpkt4SSOTqe/tCkU5?=
 =?us-ascii?Q?fcOU42WgnYG2QzLV+Il5VmYdtuc2cp91anu4VE5ZyhinkX5QnwyyAZirSliq?=
 =?us-ascii?Q?P2dMKBRy++wO5Ar4ZmXrqCzSC5YjRyedtrlXlLJDU40jb0/ok/75ZCZXCc9I?=
 =?us-ascii?Q?FwV6k2KGMfA0hRyopFDw+jsFYLarWGVEVnFLgB3TUZI9RZcHhZXPg5BtWpom?=
 =?us-ascii?Q?cVDop3swZJESNiPqw/WJeMPLWqiJ+wAtNIb2h7ShejEI3RzfZEtA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e67bb0-b54b-4453-fc70-08df1a1709cd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:37:16.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QffIp+RK5MHF+K7ngqpqAaRawFdTt+2pIzOPitCNW1pnzVykLRL8/uyTafnyfER6VSQLS67IE8IELmZhzmLsWcJJfgMUWktHC1zu3oDvytH49Kd2F5Lo3SLh4Gh3h3KA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937

From: Peng Fan <peng.fan@nxp.com>

Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
the simpler regmap_assign_bits() call.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/counter/ti-ecap-capture.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index d77a256f0ed31..1b79031544646 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -254,10 +254,8 @@ static int ecap_cnt_pol_write(struct counter_device *counter,
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
 
 	pm_runtime_get_sync(counter->parent);
-	if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
-		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
-	else
-		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
+	regmap_assign_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx),
+			   pol == COUNTER_SIGNAL_POLARITY_NEGATIVE);
 	pm_runtime_put_sync(counter->parent);
 
 	return 0;
-- 
2.50.1

