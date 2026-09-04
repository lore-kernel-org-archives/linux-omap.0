Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704434A77D;
	Fri,  4 Sep 2026 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496460; cv=fail; b=KLUMFHy5ndaqNh9ueBkHiSB29gAMMeOwaCd7XDVXKxRpbv0Zopwjhmtzbfc3LN97hlKnguJjBcPD+ajIqc6OQdEh9TTcj9xKLs7ZCISqLX6B+bBJaAfKD2Hr3DvBCo8AmOvobl9fW/oPQh6TD3/mV2rRGfkecVLtDAT6OYFmDgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496460; c=relaxed/simple;
	bh=VQrY57kwcXOOWbavPWvrbrP7cTs4HIXMF7X6wZ94rhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1qHtKKRAepeDZqP0NJ8sSlQib6/5x0frFlVJbf1vEStVUMwuAX0sQPtQgJnduGUYGxIgu3m4yvuFgn9YM4UNp+J0CdDr4550MVGHn/OCyAipJIUSaV2ew5nNvNMcXRD2bsySF1KT2uDr4h50mMNobfm4ObqC2uXAEedxw7ZvVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Td3KE/nz; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dZWCs0fG; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Td3KE/nz";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dZWCs0fG"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT6B1100045;
	Thu, 3 Sep 2026 23:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mO5xQaZj6u4TBt8A/FD+zc11mmNwC1ikHTOnR9Ktt
	Wg=; b=Td3KE/nzOGakCtn3VKUiCx88kDZKymjdhl8Pmgz3WK1bO6GWznEuaRXHn
	kE2iY36D6fQkubUcfiVT/LzRXMSw/OpiyWT2VIx7hF1QHyWEp6g57GdXaRLXAL2p
	KorILOmSWf/kp2K6G9zSchglwp4UQ3xoMTAvIPa3/cQtmhP3S9Ylhvs+tqmaYZoL
	FHqRtLyYQow67e3UsYsGitjw+hcbpO7s4ZJTKu0bigbIEkjvUNuYQQxaH7aEBCVm
	PxnjqfJpD8QjJvWg6LnlM20fnTJhjdTU7HF0Re+fJL2UdCY+wOpLmMS8xx+PWlX9
	0X/MVmXdDsDCrQ31zp5t6KhyMSYbA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8n53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:34:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKvwsRJbf475LJOwCBHRosu5t/WCH0CRsGslzO+z8MYAPeqGQ3P2S9IEB4vAFgXOvSAvs3nDS/h8diVEHv4yt+Sr43jlK7Iz0pvZyR4sg5CK0g+S0THRcSlgmfb899BzZ7S1Ba0jWme5IsqsppHc10mIVuMottcaaUcKHscNChzEBw2HImE5pxHopZZAwQ+oDQl2KDFovaUtl32UO3sxxuNYPD04TcqtopcRfxNBf8C2buYplgk4Ax3z6b5dkSysqKpfpFL26QiCGJciFAxdFeLEPRrLtdSn57juyu4c0DuVRkBhefg400G49efS4pMH71dvbIYQHZi6iGVqZ3OKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO5xQaZj6u4TBt8A/FD+zc11mmNwC1ikHTOnR9KttWg=;
 b=s+DpR/mH/1cOFEP4FeKTYXU0Am9ak+F6B8B85xB6IENZGlzLI4veQnTAtjdaAQVLM5b5X/AaQBjnMjrJiM5q0PpG2XH7RMDNYcao0vYD3reYnZ1ey8bo3aOweS385zbeQTm+MHovTmxk7gP14eZ/5IHltK34XkAKz/zI0DfyVDG2MbGBukBqi4FZWwQEm5Nv1bXzWHj2VY+dc/ldAQ7HG8U5s16wD6MF1x9lqY0m5z5c1R+ixKnHDrZFbsvgkc4H0y6WrY34tcbd33YaZUPBYhD+WsGZoHzu0wKc9rhJZdecRKoqIPgvYA5aIruxsl0sASPjloMTQxfqraZrrBSe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO5xQaZj6u4TBt8A/FD+zc11mmNwC1ikHTOnR9KttWg=;
 b=dZWCs0fG3VdLdeOe5J0xCPs4GwMO82IF1Q6pw0VO7fO5zuu+9m16Nu7rSkubIOAZP/5FLXlZcdCm6Qb02aCv098nClGDmr4q8L3vU5uNXdINS3uc50oflWAHXMWcMPnCUKoJMk8rxcUc+YnoLxj6FCf8d7HteERE2yq3zO0xeY0=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by CY5PR10MB5916.namprd10.prod.outlook.com (2603:10b6:930:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:34:14 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::35) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:34:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Fri, 4 Sep 2026 04:34:14 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:12 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:34:12 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1H3831572;
	Thu, 3 Sep 2026 23:33:58 -0500
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
Subject: [PATCH net-next 01/33] can: bxcan: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:07 +0530
Message-ID: <20260904043724.2955444-2-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CY5PR10MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d0ec47-dff6-485a-ba2f-08df0a3dc633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	009uTKOu/+7W2NqrG5eDh7VFZm80dmOtpYa+FPYg8fR7RklwYe2x6+cWoR3GrrGFixPKJnYCqmfSijNw1vlyMKyNLJq62Zf9BakSONaUh5ZdNaJDfaf/yto+dIFKSVN4uKQVetLCUGeI6A4bZsfPxbzO8QsrScdEfXVSfvApDHTZ55s0T7qhOn52JRXsM+evxtKIBkjclda7Frcwg5g9YK5tnTuB+K9CRyy1Xtmer2c6GQvEWpCUIQINZ1LMQx6bAoqnq+9zh2AVWh25iVL46c4/8h6C+Kdh+M8ebNdnMWO9Fn8i1/VALossgi6A4L6UZNo8D/vveS5qju4dyGi3Dc3ojN0xVJQRTUNiQCvX5Z1vUR6jjVDBE2mqXgVM2UQO/PpnfVSTMqhQldLfXhXtWbedf4GSOErB6JsRUJv7MIazFPtzJYuFblDqaPlz5sB3eeDu25u5FzRa8TOK4ZJCDiIo6np3VrGPANXmJToh7mo0P2sZxXXWmjrLInommnbYVhKzhvcAKRwf9DJNYZOJKtSC9ovMxSNXs76NNVK4eWzMa7gh9RK1/XQma6haEVd+NpBSyAmAPEdc4ILs01/HRig7WjAUXgzEh7hlg3kBNQqqDtoegpGGkCBQK/1bMQ/o8g3yr0R+23LXRfxokoDeeYP+ltZ1RaK2AXNnELxk4RSJZYZfCtVpEBGIkv5MShWEscoZIT2weQNOuq8oV40X+ls2i6hKMp+zl4avUinICdGA88hUW7axSOwWDWVe87X/
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	no/zPQKaUkwNrwfZGkvFzQGjZY+bC4XyZ8sx2nscEkcdJazShj2cA1Rt5Qfhm3knk24GyNNiCbdE8NUS5sdv7PFVFW+DJngweeYEK1kGb3ugsMFaTQBuvPKH4B5SHICkhWc7jQs4An6HBlzJzT0RX+1BUMk8PmcXqQcKehqeixFf7ISslJ9Z85BG8ggl7AU4bCXWuLkG3FbYbc0Y9yyure32Psw0ESyDyiLZ6Fi6ZnAaOgB4vaBXWvAjHrdlcFsfXxRXBKo7jQcMds7+FaG015QA205sXaPj4Pkga7yMHscvSYOBIMYxmX6ckFygBCwmWTLxI2B60en4/geVLAnEqoWv24e8fe3JFlq59eznCN+vbtYVYpo0N+Ls/daLfJ0eOxsaTfnz3wKtzCgcLjoNCNX+yLG5QO5VBhvMMO8gVCwZbaEzuzLy8nRcp5ZKLze2
X-Exchange-RoutingPolicyChecked:
	4Bk8EFsyHEngbX5Hl+Swvqw1auYxbavS3LOalpPeCn4G4rlf9TGPlYo3R3VG6h3zjUx3XIgWIqfHI06oDq4PwruTpfoe1LiMnpXjdXsaF5+ze2S6SP8kKAOwZC/UpTSQ9F0W2yxLP4xumB1e9W2NN033Vzt7FYy0Opx/qSDAc/XvAOx7lKHto/7Bcqi9qeqjfd9OugjDiKzfQQD9K9TB36Rk3XcfFH8rRrqR1c5ccZsAADz8z3haTkh+YakiRy7/qG3HKSqgVA8JjJ+k5M+WaKBOnpuFaWFoEuMDusXyWUrCbA/7psJ1A8iwNehCDRCkXUDypdxp2tQyzALMS2ylUw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:34:14.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d0ec47-dff6-485a-ba2f-08df0a3dc633
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5916
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX6ITMVTERyD0y
 mk7XDGhbQDobnxjkHnAXK1FQHXN2GJcaNh/V+dIX5nkjaaCgKUOnjjJUTIGqu3Rd6WNkD44fWiD
 J2/IidxuB6tTQ7EQ112WsqdlML5bEyo=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4a4a cx=c_pps
 a=DEJEzXtY41/hIaqkAZCRpw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: KixRttyvGMyHVPKfNwf4LgX1_bUXrTFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX4ytMjjpTtgXZ
 cR0BxwogdFDTH1nNLsZXoZTQR/33HuyOEGN4zBDN2n3mAij9bgNcXgj1mkdjWgkZbMiCL7OWumg
 CNoVqEuXYachkQ36fz4iz4a1mZHjsMBSonlbTtswjFtT49BGqiXnJLQUVD2R26CWUYFw9areY5N
 oaEPKSoUKjkvxc1/SFgj0VcU140BT/6vVE0WfBxRGVeS72tjyJhls2XAsEo3jKXk6Tf5VuMP2BU
 s13igyWZxil8jgL9CBmhQczafHBpVSSBhDxId+43Pn1xoiPrQSBTMXl+70r5w/02CkXBuaGbgKT
 6o136TkReh8eY7JTGNeCxDOH0uwOiHQI89VG8tp3IziWJWI5VxStGjlGzNn074yy0gI9gEdyDXK
 rWqQHzegY393JWDw4G6cHEf/rRcmgSs+gmrvxnfxjhlOcONCbKXNm1VOsMPZ0b4fgUbFJ0CBIwW
 9WXYFUn6Sa3+aShuv3A==
X-Proofpoint-ORIG-GUID: KixRttyvGMyHVPKfNwf4LgX1_bUXrTFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/bxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index baf494d20bef..4bddd015775b 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -1080,7 +1080,7 @@ static SIMPLE_DEV_PM_OPS(bxcan_pm_ops, bxcan_suspend, bxcan_resume);
 
 static const struct of_device_id bxcan_of_match[] = {
 	{.compatible = "st,stm32f4-bxcan"},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bxcan_of_match);
 
-- 
2.51.1

