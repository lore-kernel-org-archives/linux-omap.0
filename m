Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B726550DBE;
	Tue,  8 Sep 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882184; cv=fail; b=GVc67Xhg7BvQKDFUfT6JVamKhdL4lD+ZPj/dZcihxPfGiv7D0BJgdmrNaupr2L/ennhPSu2H2GTAQiYf/jcxhVqdAVy6nUZ/eJpXB/QhEmTGoFzE/A5MKUYxZQPzG+PsC6NGL/sj/5Cw7OyhtPXgJh57Pr+NYt1kyVLyAl/isRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882184; c=relaxed/simple;
	bh=uTIWTSTNrzdW3ZDoyKyYEiuNBtsYxb9rLWm1k7/Xxgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnE5pGokUQYxymzx6wlxFokcSd6p5peAfJCG2yFJwGRy3GVkv3Irc5UaxrYgHniKpuQ9X7DOcDEnjb8m/HaFa73lGrDu3XPdLsZt7xOJGrK82mzqLcpL+mD5jrI3qjJD5VBMNf1wKn3g4s1FmrNw7/NXSio7hrEeFtFA5CzGGuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=XrWJudpd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kh8TO2kL; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="XrWJudpd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kh8TO2kL"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 688EkN57173179;
	Tue, 8 Sep 2026 10:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0zQflQX0fDaSlqZZtd4N/a73J+VEAQJY8T0SCdlZv
	uY=; b=XrWJudpdYC/X75EU/UBXwRgne4w5EA6t13nQvkR0jWxVnYEzleJzMumrl
	fADprezuCs1Fm2ww7sW7Q7MVw+wfSNfWvC9NO1uQl7iAVhLPc+MFdG1w7qmHwdEu
	DVbg2z1S5cbF9RsXRC1Wwd7GOXopZ34iguwoV5IXTatVYtCdLZVWhwl24JrGSguG
	K2RYWXUZVRICuRf4JXqTRt/v5b3wrmx7rtaL5FIDTctQcDAWGtoCgwDLzyXL4nDa
	AMI2xz9HHQ2xrSc+9l87tn75lP0rd2mbNoBucvUtIRShH+8BTkEJRa7yF4kyJWwd
	SV3RwGXH5rC0DEVrziXMtulHdF+fw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gjkdmryj7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:42:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhWdlgtec1oCacENwpPzJm/nrsBG6pcK0i3M7GYjAMLUjQOxqtDV9pcn6d7m3F6L0YW0Nl+muBGB6lyH4ClYoARWt8xD/S+GPGWRYmEhJsPmrmWHLvYdy19uFvIgrP32160vORc+jdIiMcP399K4Ym8k2dMY4KkciTHMfp6NCgufZu7TSRJbl8GS0qR6Chma4kQyDlYUufSqW+mrPg/fCRDpqEgpSfir7QOH1wuYhlZXsYORj9SW22fnlry2TmheoEkVMjxovklBAO06BoU/Vm3b1Uh4h5VnSH2Q3aKuKIPWQ+OTQdAuZbk4KfabXhYiZunmZEVOPkrBv7TLFiUM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zQflQX0fDaSlqZZtd4N/a73J+VEAQJY8T0SCdlZvuY=;
 b=QOQGXwbg5PZEmuG1vA9i7VmuIs4LzzkXkQD7sRN606bEHVjLO5IidOgdjxkmShoiiVW3MVEy8QrSEeIeKrBy2FpK+fr9Dtl2HFf9fAP6Ru/NGaXBrdGP4XH5xzQM/EMTDio9PGCO5rwgVQku0hyX+M/kGGFojB/QKYFHWQdz25S067D2DPPrF62OS4bI0O7FSsbyaKBzeEszYWxYAjOmDxTgKrpnDJHfBQ4FZYbnrNNLoNuXyj2gh1aFTGFr+Y6bOm7gK4VM9wljh7k7F6a1rbYoBPm7v7fWleFjFuylRbpLuBwB1GGB6Duu316j/PPfm2CvJIyqXfN2d7wZDDLa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zQflQX0fDaSlqZZtd4N/a73J+VEAQJY8T0SCdlZvuY=;
 b=kh8TO2kLcbnClNcU8YIbI+mxmzxOKRJRkvw2hfJJPEGsmJTlNT56Cnx6s0j4/jb70dKXfVRSnuWygP6ZkaORgWAG/peOgk+UCNuQkmaxIN0uIt47pj5oLGfMMIxD64vwM1aV6s0XiVgohYsmBIghjDsXGZMj/g20hU+vK8asUE4=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by DSVPR10MB998078.namprd10.prod.outlook.com (2603:10b6:8:41d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:42:36 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::3a) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 15:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:35 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:25 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:24 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWb3725209;
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
Subject: [PATCH v2 1/8] i2c: omap: Drop bit shift for I2C register addresses
Date: Tue, 8 Sep 2026 10:42:16 -0500
Message-ID: <20260908154223.116074-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260908154223.116074-1-afd@ti.com>
References: <20260908154223.116074-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DSVPR10MB998078:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b85913-900d-4246-0620-08df0dbfce47
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R8XxHRNPMvfqXs8jH7Z022lpPly3W3tvHeBXftUAc83P3sc3XXVDV9bLaP9dD6etrAj8lP5pV9vwNfM4wn0GMmbhVk3cm3hFeEUVRMgiUvlVp5CGGvRcap7HNmnHtUZRJXi4OJ4oVbz8O86ft0kPhw3rLpRAWt9s7KyoQDngx2/nLtG5vFjytwnawkfFj0D1pRI9GXN6zIYAwxI4QorEhlpqvryLZysS4S4A0KuVesVhIyl48bqEQTWPHnt9oH0Fz43VoLvOW592DQgqT66zXRln0ImqWcHObVFtSLbJIREs5QXjGms29i7YW/s8bG6ECNfS+JedOopMjDhP2+g+1ht7gISBVtorH1RmTECo/FnuMK0SmPtXEXC/tHd8yho8KtjW+tMIfEO0TuHUeoWVgIsFDCPYoAYKgU/sTO3yw5CE4jfTxSpqEH/9PdUTTjb7w3Ogbz5Bb1e5kCBBRbW3SfewF8h0f+wEXZQe+hI/IQMgwIZbOMNVaMNp+SzoO+2nzIGmvHlJ+Hrgt0MzzWcff0MwtIpaB22Mb6Qs2A0MxFctfgiKM1bKqDd8RHxCSrl2DpVRRR8RW7Np1y5wWWh6HDgDbjxrDoqRI713YxjzxJLdbFq20Kkl8TjZjGGIoGXtI5dSniUTmOrZ5DITW+u+dB1Mjc8Ld0IxJmx52yAT1NdxPKa/o+yU/UZtVFSIlBULgFdx68Gz1NOSrK6krZESng==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sLFYH6tC+R0z4AwWUDmmZo1sYtetS/QWT/rb40Ta9dP7ucmpKjHntQeuBIBCIneD+ZlTLNE1JfYPu32KgZeZy+lSiyrKt6wc2jM9viMxg58zFbHECqjJAtjrwU21gu/c5TsE4421D1PzIbWGsKBGx96q0twSLvLYUo8Een4qGhFGU5uR1ZvsFwzOITxVeev9TGBNyN8i4PO1PIhVJHYVPPiert17SrtJaBdHxIytOIgZQyDtKYyLfCuNUI+4UBYu5VJYmi7TNnLUHTUrfhGcJYUZDgL6ad9OxZe30r1+y4o72xTVEDQ7Lz/tKOIN7APZMPHnuJbVjOWCSR3a6GxdyQBfCgy7nEYkFEWBXDckF87wISpFSUYRl1jBlbKFU/xldstrK+sqNzX9xCXPedqsgughishpVyZsHCYprD6pbRDCxLiJPVq72O1G9ygUOuct
X-Exchange-RoutingPolicyChecked:
	ZxBQh0Ge8xFnpHrIC8JCUIZSUoBZP8R+h3pae3zVkZ1OpNSvxRV92sqoMc0jWFH7DQTPXdLz9/NBbWyjwwKbaZrUiZtzfy9qB7bMY/iLt7BQ8gguQ01jpg75Y7eDnE4KB1uEEO6TdSSsUNNYSbo4PFcMs4oARRUaa807ZitSjTBIUESHVX7wILN2jubuwc2ovC5Dx8c4FlkDjoG09rlwkZo8YExLDB57fZmYooL617ruPJ3pGpM/XwIQHMal1jiRpU4T2g97hCLnhWwpS+AbfUfsAzViwG3naB7CZByQfULZ3JwxGIpb4QeMSEQYKEjrobxTE6j7zFD+NrlsOxU1Ew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:35.9575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b85913-900d-4246-0620-08df0dbfce47
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB998078
X-Proofpoint-ORIG-GUID: Dv-6RvVj8i02343KpVAAsvnmwzTnGGHH
X-Authority-Analysis: v=2.4 cv=KpZ9H2WN c=1 sm=1 tr=0 ts=6aa02cf0 cx=c_pps
 a=s6FLI2cSFE2dV00WXjZlDQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=50gAi1W1AAAA:8
 a=miE_aGblqCwIs2vhnBUA:9 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX1WGhCh+qR2bJ
 fA8X4QvKVQ9eiADjmwh/6zVuOk5HOb7MvEIKEYZ0m93CORAs1DsUjkrv7DU3/+2wDGxDmIZ7xjz
 a5isSucPyWPBB6o+vk9t9rtfK3bx30M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfXz6FKF93wqUCP
 dZOAIXLlV6QiP/Bak2Mzy8AeXLcjWbRChCN1QgIFBX/MFiREh6pBnUNyYDbZD8OHFWXUx3r3Jt8
 8uxdtPEKHezsZWx2vMKnGYFDeB7w3XRcRiIC9pH9jhsOjTAJ1qWv2BCF1isv20MT9RSUUVNqNnk
 ib+8OkjyoH9hwRcIlrF54ZbSHpSfcri3wtoneOJGRo8BaoTZLAMhG6pl82E5VtakJ2N+eX+Gxj+
 MFWm39c9A2rptXkThoPZULRSY1uBnI4ra0JoEB+CTcrB+RZcxh+Kew7zk7UdXrZe/kyjD3O8eE2
 OSwtntF70GS+NnXPVrxJJz6R21NrnxrTZcQhTH0FxWgmG2KcrcQBSWIHVEZem8xuAK+g/N7nZzQ
 9Gk/xCRk7LZaJI0MGLkEKF7LKxtHw0JQxiNX1ol/aZpCKFKykM2gt0TnfhZ+PUuvAQybfZ0tE2K
 kpcborNqNSOGuWEMQEg==
X-Proofpoint-GUID: Dv-6RvVj8i02343KpVAAsvnmwzTnGGHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

The OMAP7xx devices used a register address shift of 1, but this device
has long since been removed from the kernel. So now no remaining board
device uses a shift other than 2, and no DT supported platform ever did.
We can drop this flag and use the pre-shifted register addresses. This
simplifies the register access.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap1/i2c.c              |  4 ---
 drivers/i2c/busses/i2c-omap.c          | 50 +++++++++++---------------
 include/linux/platform_data/i2c-omap.h |  5 ---
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 94d3e7883e027..bc7828a858941 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -61,10 +61,6 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 		       OMAP_I2C_FLAG_16BIT_DATA_REG |
 		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
 
-	/* how the cpu bus is wired up differs for 7xx only */
-
-	pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
-
 	pdev->dev.platform_data = pdata;
 
 	return platform_device_register(pdev);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a6..72f979eec7311 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -180,7 +180,6 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
-	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
@@ -217,23 +216,23 @@ struct omap_i2c_dev {
 
 static const u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
-	[OMAP_I2C_IE_REG] = 0x01,
-	[OMAP_I2C_STAT_REG] = 0x02,
-	[OMAP_I2C_IV_REG] = 0x03,
-	[OMAP_I2C_WE_REG] = 0x03,
-	[OMAP_I2C_SYSS_REG] = 0x04,
-	[OMAP_I2C_BUF_REG] = 0x05,
-	[OMAP_I2C_CNT_REG] = 0x06,
-	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
-	[OMAP_I2C_CON_REG] = 0x09,
-	[OMAP_I2C_OA_REG] = 0x0a,
-	[OMAP_I2C_SA_REG] = 0x0b,
-	[OMAP_I2C_PSC_REG] = 0x0c,
-	[OMAP_I2C_SCLL_REG] = 0x0d,
-	[OMAP_I2C_SCLH_REG] = 0x0e,
-	[OMAP_I2C_SYSTEST_REG] = 0x0f,
-	[OMAP_I2C_BUFSTAT_REG] = 0x10,
+	[OMAP_I2C_IE_REG] = 0x04,
+	[OMAP_I2C_STAT_REG] = 0x0c,
+	[OMAP_I2C_IV_REG] = 0x0c,
+	[OMAP_I2C_WE_REG] = 0x0c,
+	[OMAP_I2C_SYSS_REG] = 0x10,
+	[OMAP_I2C_BUF_REG] = 0x14,
+	[OMAP_I2C_CNT_REG] = 0x18,
+	[OMAP_I2C_DATA_REG] = 0x1c,
+	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_CON_REG] = 0x24,
+	[OMAP_I2C_OA_REG] = 0x28,
+	[OMAP_I2C_SA_REG] = 0x2c,
+	[OMAP_I2C_PSC_REG] = 0x30,
+	[OMAP_I2C_SCLL_REG] = 0x34,
+	[OMAP_I2C_SCLH_REG] = 0x38,
+	[OMAP_I2C_SYSTEST_REG] = 0x3c,
+	[OMAP_I2C_BUFSTAT_REG] = 0x40,
 };
 
 static const u8 reg_map_ip_v2[] = {
@@ -267,14 +266,12 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
 				      int reg, u16 val)
 {
-	writew_relaxed(val, omap->base +
-			(omap->regs[reg] << omap->reg_shift));
+	writew_relaxed(val, omap->base + omap->regs[reg]);
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *omap, int reg)
 {
-	return readw_relaxed(omap->base +
-				(omap->regs[reg] << omap->reg_shift));
+	return readw_relaxed(omap->base + omap->regs[reg]);
 }
 
 static void __omap_i2c_init(struct omap_i2c_dev *omap)
@@ -1214,19 +1211,16 @@ static struct omap_i2c_bus_platform_data omap2420_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_NO_FIFO |
 			OMAP_I2C_FLAG_SIMPLE_CLOCK |
-			OMAP_I2C_FLAG_16BIT_DATA_REG |
-			OMAP_I2C_FLAG_BUS_SHIFT_2,
+			OMAP_I2C_FLAG_16BIT_DATA_REG,
 };
 
 static struct omap_i2c_bus_platform_data omap2430_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2 |
-			OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
+	.flags = OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
@@ -1384,8 +1378,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	init_completion(&omap->cmd_complete);
 
-	omap->reg_shift = (omap->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
-
 	pm_runtime_enable(omap->dev);
 	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(omap->dev);
diff --git a/include/linux/platform_data/i2c-omap.h b/include/linux/platform_data/i2c-omap.h
index 3444265ee8ee7..fe6753cd17bf5 100644
--- a/include/linux/platform_data/i2c-omap.h
+++ b/include/linux/platform_data/i2c-omap.h
@@ -23,11 +23,6 @@
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
-/* how the CPU address bus must be translated for I2C unit access */
-#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
-#define OMAP_I2C_FLAG_BUS_SHIFT_1		BIT(7)
-#define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
-#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
-- 
2.39.2

