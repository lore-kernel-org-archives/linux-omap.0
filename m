Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CF4766AB;
	Wed, 30 Sep 2026 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807773; cv=fail; b=KG74S0hnWHbXjise5cBTM4Xwbtoq53BoPWIt1v5Dq7Rq/jvUo1BL9XUx/QGurcX2WHtpNL1kIOKlmhu18PCZY3wcyIPayCTwtefbqj8GaAJdtpfZ+bu8RNFjGAzTNTtUlYWLr9uDX3VodpbpNspqci37IQk/DBvdI/W9PGPla1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807773; c=relaxed/simple;
	bh=4vIYJLcCJD2EKL35tymGTWA2NuKWCSIsNbLyDLKEC8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCL79vyjw9NsIFQCozplKfa1QYP/aob5sY9j785qK3/Yvg6Z9FK679HH5O2+mAx4ajeHQaz5zJPe317wHPgK0ZSjZYQ4ioOD4wVbZYEamFWmby1HCJfrvFAMTtkoMPZgP4D4yrqsNnLo+Q5CeIvDh8XpU+L6QBCrVPRxuJwkgfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pRoZD+Y8; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=dSNwE4yd; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pRoZD+Y8";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="dSNwE4yd"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKkQDF130208;
	Wed, 30 Sep 2026 17:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=5ImfINeuOE9iL
	C8UGSBU6gB1KbarjxQhxnlQvxmJHpA=; b=pRoZD+Y82iQtPGQ1Xdsp56ktdWjgH
	1gnEsSSDXlAIrFQOFvwS5Os1L5cKde00JDWqI7bX3vHeiFKGb9POaJHbcpSkoy6C
	Z1AXdIDMpwXBx4Hxc+Cm7/kMODyT7Fir7pDGJAhsa0wcwn02MmEeYnXX3O8sh878
	bhj7n0Rigs8gG1P9I2K0HjxOMlaNpkuJ4e96nQCi4myUJ3lwR8Fa3vWosk0hoiBW
	HaxBFyIHjjmetjId2gtbVNsJi0O2xml0szA+hpf4kmcj8CuzQ/jR742B2ylF7Y+C
	NbRiTuP4JgL1DC81qabCf/EPKW7XgKlKQzSEJz19c8sPpZ6PH+hBG1AJQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0ydvccnf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:36:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjpTY0hhD6DpCOisetPU1ofSIGs+9ImZdyd8cPB5jON4wVjbTGQbAtcNfvo3fFDeoU0a+f2kpHEUmPZq63h8PVksQIx00iLQCiMfqHgkxhI+ZIr+uz0G/J5HoE8+wIeSixHWaqPYGsbcY2tDv4FU8WNZDiZlHLBL4uKjlY/kxHNRlmiyglQSD2iKSGbr/TpWdyKr7QhGtlRc2ueNTJsVBPKEtSN5uecHVnJGPQbX4BaIA2Ui85AQIde0ZW3Dne7yV33H6FJsFtWbqOcRSTPGjnvjbX5Y/y3Yq53TmWrlvMEGUfw/zjjTm58uEL64f6xsHLIF5nfhcin8ahMbXXA7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ImfINeuOE9iLC8UGSBU6gB1KbarjxQhxnlQvxmJHpA=;
 b=MMmIFJ9tLnbJRWoY92C9GyS6ZYsoKxe1JhrV/+4onu4h+xuCCW4yfL90R+G7Z+Q4mLJLzniVNn0TSFEqyHoXF8EbqYkOKUpWx5y7dwZ4YDtsWTUjuEfBDhdVxx20v5AYlPhv7As4vkwtp2myNCPuhs199UbT0rg/v2QpYbsCU2tIMCJjJB3TlELdBqBllFCIiBKMATh36A5fAZtA6qR9xdLSCmabHE8JvfK9eU6chL+UDb0VVQBSPTDZ/k+jlRn+WsGynUZCp8UcJ3D1Muq17PR9N8mWuWuViTfZ+a4zi/6pyhUlxJhP1DN6m74LY+tyrl6UhOPYkLv6XgwIS19hMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ImfINeuOE9iLC8UGSBU6gB1KbarjxQhxnlQvxmJHpA=;
 b=dSNwE4ydd9t573Gs1YUcH8c6jYACdBNvVAtkuYKg0uhkekrQuII72vRPIbuTUNkQBGpHsr+YOpOrukkBx85tOXGs+0hqKHIUqC4bEfwOnczMer1y/FiK8Gm8CZRcrtDEiknd9KADAjgC5+qGnsVAFPyEgg0wQSLd9XNmEi8Odjk=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:35:41 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::34) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:35:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:39 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:04 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:03 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tq3969567;
	Wed, 30 Sep 2026 17:35:03 -0500
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
Subject: [uL RFC PATCH v3 0/8] OMAP I2C driver cleanups
Date: Wed, 30 Sep 2026 17:34:55 -0500
Message-ID: <20260930223503.616776-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: d4600a3d-37e2-4352-042a-08df1f43276f
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Teoj0J1mNXQ33jM223iWkj2x+TX4VDxkn261sGa//wXCdZs9QCn73JiuH81zcfYK1JJZVdr84aQzqZQ1vIVjRlsS2MMuIXj2zpQWZMg72zuNL4IUC1G85HZ6LWfWwnnvBrD2gECrgSj5T1mAhj7xZvZQT8CSHpGBXpZo2QU2NkLFlE7QrOCW98mJLVp0wsiv7F2C/lydmYeBYbNs5GXkNxnyJS66Muq9iZ9dVi8EYg4RamPCoshLHS+l62FD5RqPL2w2RsWz5MJ/zsvmqDvs8SBerqiCX1FLVgHoS8Wo70Wx8j2qU7kuNrZt8s4MwIjekxLbntxOHqeDLyrpK+i66IwlCqW/LjMVkRmrFI/ZdmrYyxwm4dF3OqnODinYMWbAxtmY1JROv+Z6qzjvtpOfXh/KZO7KD5nhWrrINxcyxodZYOnCfhHjsJBTKVS8rwyYvOAWq6zGdC5SBddMUlSRS+JgicMcsnxed7QsHzMshmImgROOmeLG5/GjEIZU7cPMge+Cb8R2RIqUukZZD/q1asuIcv8FDd2ygmrV33Kr+vEPIDS+WVIrc2qjYlzLoaTLkMqqAQ9NFVKYxImuCdJeKiLWtxyn5+Yqk2hO7jjvjN4D++xbj7Fr9GDr78OTqDyGt0mBX3xPcdZ95uCk+oH3obWSrn4yo5FVWqZ+v+RcsV2c0HdLd4nNTqUXtpyBo7zYq88UYo1qVdJKlgEFhhY7RA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	41SPLaGgQ8LiNawSNi/mldYFXMJPaGyc53eC0gldpO5yYqTYXE2lnD5a57q72hXL+qXYRxpqqEK4jf1qMv2rNcrfXCmIddiY3XuQw/8yIVhammVzf+yrj1FFv63TMzFuj2JJtuHFtiKoHH95faZZM0rqK80MVR37uvO6SHr1d9cpoKKYutvDC0o2oWURqF3j87hT0oHi2QM23pVHvCyfAGW3bP4XMhclQvw/XMGmvXfPHMMtTckmHtL4LHRhGxip9YweN1eqKX7Tddb7kWV5EWtnNZV8S+F4BU1yTpQ7XBlN8zMyforJDNKScKzQRv3IqqoW5sbkIvRzsGUGuafuid0J07LMZM/bDQB14NDkRH2XTmaMg/FUloSOXhDD+kkABWL3JsOmc2rvv4pPVutw/0bkTGtsu0TjuMjeCWtW9BKXlO6q5zRrJhIlIJx1+C6K
X-Exchange-RoutingPolicyChecked:
	uVLA+AWiLWKN8CGhSXzgNc10zm/pxWKB6x5/zc7VnAByVOJtB8CSGlQhx3RF9aCGwfaOqnagKGNn2eabvRRVw0W1qe8v3FbOhCGP9zRwOQ9pa1gz4n3rh4M4AxL0zcnX58vM3iXrvhNM1wSUvVFj9B31CN8gC6H7AZorbMH37Zi8gyxlFlqdwC/IJ27wCqxT4ftISrMl15J5JviErHCQtnT5bf6gTV4nya0/GiWtanF7khjs27x9kb7rSSarvX4FY+tCYBmXE6NIVEkSB0w1BF/97HKFIYMdSLgiRHp6pXu93SAD+mE6gPuXbFsxLDNiievUoUvXIek0aCd4fJISZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:39.3547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4600a3d-37e2-4352-042a-08df1f43276f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX5Egd24xALRKZ
 oa1rStYZ17xdJLW0C87Vw4EptxsgjfQ9Cij59CpYOEAXyWLvjXLM1k+92J5WFgjA3SRI7BML/3S
 f6QcXSrHlA7Cozn7o0gNMTy0ICLM5oA=
X-Proofpoint-GUID: Yt7v6neINtwuTISOU9NvuBED9z-SLRQN
X-Authority-Analysis: v=2.4 cv=TegDJhQh c=1 sm=1 tr=0 ts=6abd8ed2 cx=c_pps
 a=6BiUERe1gyZkJgaADwpG2w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=eAOsfQ8bo_TvZWU5rFEA:9
X-Proofpoint-ORIG-GUID: Yt7v6neINtwuTISOU9NvuBED9z-SLRQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX72bUgdzc75oJ
 2Q9D+maRkWZXj6iq/vzRIcudKTpN2HRnk7Sa3aqjX2iJQ0RVEJfhw9cEOXwtjeJLCLCNBZoeqEd
 arX4SCU/GCRbOoSeU4SyIVYul8k5QCjQ4/1NvMQocNCjgkmFh7VcOZ4Q7IXykh73uVl7Mxlxlhj
 2eEZzPISKoNStqqtCL8DrcqNxR5jcw3XZr/i7nlS30oH3hCiB0BfPhmhxyMCyXcVCQoRdq5egFi
 VvLBC+JvWS6vZE5ryBKwz588UlBH6j+qUtNiZLeJHPiPiaP4g6XCjmNHqFdXeWg7gs/DZOJfS4N
 I/s8S+Jv+T4offlXe2l6TGZmgb/gKCtWylZTY0s/Xr4lDvt4olQPWQQYqqiC5/cdnROEi2WgFZ3
 L73LjRGnRa0OnCw4R9QUZ8MJrmiq35NL3g6o7boxoogl7tI3GWPfzKYqAVsLQfEvXqttzaq0Pnt
 kV2XiVS3ixk6adCLnag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

Hello all,

Some hopefully simple cleanups and updates found while using this driver
as reference when porting the same over to Zephyr. No functional changes.

Thanks,
Andrew

Changes for v3:
 - Fix OMAP_I2C_STAT_REG value in [1/8] (Sashiko)
 - Add Acked-by tag

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

