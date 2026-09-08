Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC7549364;
	Tue,  8 Sep 2026 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882262; cv=fail; b=sZ4WxzsYDC0Jpaq2kwIP8LqEd5vaEkukZ3Jl1VlGwlA2Dq/F+04oBr/kyyTqBHDDlGXzaXPXd/x+9gg132m5JYPz0LYif8omIU32fzw/JYonJGMT/1tkYPBuZKUYfpbzogdLNW92K0h2p0LpwcinTZ5uzUlww/4WTKr00pi4al0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882262; c=relaxed/simple;
	bh=xmqptpWgefcxNr49jCsqpaWip9K9MjWlTfDc91EvJgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7yKpvmSd/rl43V+dG2RpdszWQRFYKnEVSQlk8AZszgu1Zv/J09X5reTZi1R91xeABhS1JXkmxYPWkaWYzyijQmTj3xN8AtQWWNjXf0CRSFcwvxwSEXMOlGOLPz4x1iCZw21A7a/aB+P9S3RJmDp4Ec5G8z3KCTSfzxPFNF/Mhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PDgwPdUI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YoFeAnAb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="PDgwPdUI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YoFeAnAb"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 688Ek4dw2033099;
	Tue, 8 Sep 2026 10:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=yWKiJkPgyISgf
	pXAg8Zfe+oq7otO5OGE/xaNq9Z+l/s=; b=PDgwPdUIrszGVshk3aemYpm0TJGxp
	EzgCWmxzgnV6t2d5biOvNA3w0bCiL073lPuhX04/3AS2AxtsYhJJHFh5uf4MMMbX
	cPD5VW7GHGb5bvIDYmtAvRS2gUeocnWa/GpxvZh0SPnzjLSr4acWcT5GIvwarXQ2
	PpNSwC5jzv4zEcNN1HwocJYNceg1XotVd5F324U1zcNK8IKLFfOnwW9HKU0QmfG7
	0chcp3knmpes8vOACqIpiKaieO0hH2wGCwTkQCMM9e+UmZ+YE553+EwxVlkP8jYz
	/cIsIQDx8Jvavnqre596ekKn8KrKf3jfnjBzVRx+d2+wr5SpEApcUcvCQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gjffmtbpw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:44:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvenqGfAhGmqGQudPSH/nNbiiUeWzS2G7QtconQgOeKKLU+2awYtpSOBWF0wpFzchwYrcbA+2kuPB7fI40V70QkX5VuOf9rAc/0C9ZvPoqTsHVALybroHFA4fugmpMZnblGtHotU4pNQvW9YKv+4HwqOemEhJswQoFkHTkO/spzWtSY01LPa2bOov2IAlzTUfnYisaYdm0nV+wQ+6kAcN63UuoWd0NXZujITHqQQZTohaHSzicCrcXK2YWxOvuzeFZnTMf+bGBF9d+UURN8thuhh1gMBrfyzzB6xKKYCF5cjMDnPFOZmfbJmBD4JhpQ3dxBdVmU4I9Q/qUoVD9vbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWKiJkPgyISgfpXAg8Zfe+oq7otO5OGE/xaNq9Z+l/s=;
 b=dTmrbskn+gg3QdSYZA1X9iQJEpw10FV9wj+wEJ+Pk58aBcxna0GKoXTly1/i4pmvdiI7I94uGi4yWAxaR+yCf8BdMtWciUPmp75aiUudJoNnErvrfqSNzSIuHL/45MdBOJQ1VVNv9+6HcjPTbqoBKK4V5d6Rt9M4X377G8KeJtv9JgvgZ+DGIh2B0EvonGxeR8R9esWqBYs4bAEbH/sjIyI5az7QhMw6I+rHq3lcAANri/nlarvw+TqXGbs0BkleBES90qbe2JwAcvGcNRNPcVjZMm7hgKT1X4MQP9zlOoIOqALcam7k71bddG1tYVGj/osIoQu08nx22UQ9G0ip9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWKiJkPgyISgfpXAg8Zfe+oq7otO5OGE/xaNq9Z+l/s=;
 b=YoFeAnAb2A7wR6cDjTqUuwpb3sNbC/vXrxdpF4CLTtKFLCHtEvj3V5t8l2JV97hBs0v2GCFI0lAAZquEYzW0p+qMmPGrZU0I89jY9O4hAwDxImLDPeb0jPn1xwF77n2PGWxyUbjNabsLr3USrLa3L8L8cxWMpFsU0h1l4yVPzJg=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by BLAPR10MB4819.namprd10.prod.outlook.com (2603:10b6:208:307::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:43:06 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::2a) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 15:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:43:04 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:24 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:24 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWa3725209;
	Tue, 8 Sep 2026 10:42:24 -0500
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
Subject: [PATCH v2 0/8] OMAP I2C driver cleanups
Date: Tue, 8 Sep 2026 10:42:15 -0500
Message-ID: <20260908154223.116074-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BLAPR10MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4e9673-e060-4144-7fae-08df0dbfdf44
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4rl0SQsuTPlQakJQJcg8GdZ/pXMkkI2oquzgVaEEAs0zRz5dd/u+t4Oj9PK4Eyt4sIUDhaNpSIg/D0WN4rl1+OOdG48eGNLujMEmwslfx8mZ5p4UpFIXJLN+C9ZIhPo1AOwZXiAtTSH5M1AfamABmAvxT5gkIB99zjYqzFHNQaDa768PjPsqRuXgk7uUTnQbMMKTU86R90+lQAcXwA05Ixc2vttMvbVVXerlGQmomRx+3JqSxGF1IFl3TnL8kiYmfjSj7a6kiPxHbpGJlJ5j0LmPdJnE3Q2zqblxZWu60eYF3oMV/u87PKgDgayhklI+yt7OJTzcL2Otoj2MmITtVw3k3ExpaMUQyLv7yYPJfz2H9EJybzVMO9mNatOZ3QRLHpqKVX2LJKNwTDwRW4FdstIxifRctJQHkCRd6ZgVfecmfGMWmHtZE3PcuHs0rmbQUVJH5PfE3P7glBgVpqszvYsNWAOad5UhaYu/wv/lve9k4bLTHYR4LMX17qibK5QsTsXCYLGRg1MlM+2wjNCDlJbsdL0goI6x56LqyT3yj2fZC0ssgYIa5itWz3iYkts+JDSLmv/kKVNFTK0Hd4VjbzStnnUXkVlP60Ci3wS9/qiLhcvyKV1Z6cr+JQLI6GxUx5Z6AL0u5cOHwTMFAw6Sp0LlKA3xByxB2gMMVrvUF2/6yWBqDn2NIsJdQtCf12qeHMORMtwQcFQixi1zanGyow==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NcryBAFSZTR7rCgcsU1PfFGQ4oBYmMA2YhrcrJGppINtcuFnSb943eInm78kY0UNISMrOtDPAZEMWXhMwsJhdFPhgweebCXjXTsoArfUVSbrnkHdLkoiUQYftvPLRrosMbE1GQISnd4SK7ZoBX0ww6Riz4n31dKjv759walejSEKRCS9R+vDnMba9BSAAse71Mhel6F3KqATbjjWwswB4Y+Y+vQiThaGZKuJyAFSXsXrzWWRkgGz6571MVAaxsoXtylodB/RF6fjKK326fpb7qyRprSS3DD0aG3q159d8WL7fDsegflnbhDblJ1vEPQuM3BeC5owYWGxn3r5OgA3I7lH/VwpMemT5ZYgY5F026DLuGb063Ef1ZRkLOm1r+agI8rzYc6vh1iMvKFnKeAme3PLSJgfx1yWm7e8pksjxTgE2YswAxrF4w0emnqZfyYR
X-Exchange-RoutingPolicyChecked:
	0gjXEBVj7be6qOsw7NActn6egMVV9/vNEfS7WFcFy08NLtTFDQGsapEo5dKBJ96Ukw2Xe2z7rkL0A3FoRc+Q+5wP3Fl6N0Vc2GYSKw7r8bOv6/lwYnDorCa9xzpyNYi8sOKqNAbVVvGlSvvhv97hY2jEXY883ZNl2bdw/4+ZzHb4LicZD6pyE/dnmJ+daPODeYMdAfNbvmExL2fujhOKb3cVAwIpk1TTIP3/NzpSsbV7ExCk0DU84JXEd41pnmN1yHIEq3IQE+NeZ3Kevnc0Rsso4TDs57GW/kEoK2B7j7ExPb2tDBYTFmhFtFu3y5XKrnbGuZ7Fso/U/nMFaF0edA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:43:04.3442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e9673-e060-4144-7fae-08df0dbfdf44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4819
X-Authority-Analysis: v=2.4 cv=FewHAp+6 c=1 sm=1 tr=0 ts=6aa02d48 cx=c_pps
 a=Os0crU6ZVxYeJaTskmJGZw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=nnOhH74F2ekBJhm_1bsA:9
X-Proofpoint-ORIG-GUID: ppyUnsJrMEr1iEwg307YohZpyeK1sVKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfXwrY0A9zYIcJ8
 nb/qeaqus7w+/YXGD3iRF3RfIyiVqcVjsL15JIvpiX4d1lG+Ypf/N7Plrd3TkQ+30sc3xJIjL7U
 GjPm+vEBZ/r42MQ4EDah2820YD7bUQNLsDT4mTRIxVMp7uUoR3QvAAAJ5tJeVGU/k2B5CabbqZF
 9PQQjlYDddebN1k5c26lBaMsHone+NykSNtZGd2LMIuku02uZcKroPz49tFPcxyTrvr6G2LwMfY
 nwKcIFHSOgGUNtZS3jPAYbz46TdwtoDtrbr6AMkCb6ezYNGggnU4TM6thXY3KRifKlmD0KlmcHl
 7rXnR5FXMsYakGiBmhKkKib/eNvNmiEbnfO2hino6B6JpsK6crSD1pOfrAfQLfxYn9NY1DHcmg+
 2FkofeZtne/NcMPZ6kGky6ccXwPsahqyDGsB3FuiMWXkJlPVODShRkfAaCjBNQ/wXW8G4CczEy3
 azQh3LsawJ2MYqTq+mA==
X-Proofpoint-GUID: ppyUnsJrMEr1iEwg307YohZpyeK1sVKf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MCBTYWx0ZWRfXz8ZSSORJAvbX
 XRyrozoLnwumCfslf40AoyOGPlp9NuP9yv0/yqIJ81l/Ia+kvgCGnbVNQGPpHVkgbQDiRD+q89Y
 i/qTR6ss/FdEvcdczOm3a3pslvwNTGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080170

Hello all,

Some hopefully simple cleanups and updates found while using this driver
as reference when porting the same over to Zephyr. No functional changes.

Thanks,
Andrew

Changes for v2:
 - Seems bitfield.h is not indirectly included for all archs, include
   it explicitly in patch [8/8]
 - Add Reviewed-by tags

Andrew Davis (8):
  i2c: omap: Drop bit shift for I2C register addresses
  i2c: omap: Remove unused is_rdr and is_xdr variables
  i2c: omap: Use devm_pm_runtime_enable() helper
  i2c: omap: Combine event flags register definitions
  i2c: omap: Use bool for flag values
  i2c: omap: Make reset bit name match register name
  i2c: omap: Switch to using BIT and GENMASK
  i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions

 arch/arm/mach-omap1/i2c.c              |   4 -
 drivers/i2c/busses/i2c-omap.c          | 255 +++++++++++--------------
 include/linux/platform_data/i2c-omap.h |   5 -
 3 files changed, 113 insertions(+), 151 deletions(-)

-- 
2.39.2

