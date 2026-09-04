Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CE3F86F8;
	Fri,  4 Sep 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496904; cv=fail; b=jR9A9ukvmz1B8LtbEAsO39YZ//VTZSFC/B5ctOOPIfF83r+Bib2jpkfarRhxnf9DnYIHZkyNbPHYXtV6P2JxNaWGt+MyWfyB+2/sov1HqZ6kPcLzacxoySLywq2u6ws5TcF4o/LVB2W31cD6G+5lqjOFKJY0E3Tl8zme5Os7xcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496904; c=relaxed/simple;
	bh=rF+MjW0RbKkrXzQ+uKVDc85lYbaJ7AWVXhIQd2DEcLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ2KfD1eNh+MtjhyvpcR0GCWGVLDD0o6AGInnR9t4b56OfmmtFN3T7Gb9jMqk3e17vRaLjFEVe0eUFFF2nOjSlNRM4DzWCxARssl1E+av+lijuaOKtIaIijtUOXZdEW8cNsMyrFYwRJ3CeO1UaHMya9aDVO3pojyjApTPp6of4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=iCb/M5jE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wf/wTKgu; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="iCb/M5jE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wf/wTKgu"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sgVw2373995;
	Thu, 3 Sep 2026 23:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=cicy7DTupo0y76LQjnIH5Qoh0xXL10rSbYWbNjz2w
	Hk=; b=iCb/M5jEIkEHsyE1qRtaXNhaLxrZC/9CMQuHwRgeGAh1PUORiVyXTgvC+
	pfrpM77WaakDU0P/De9Jt5U8NV+kpKz94e7LpHtAjhcMQ33qs9F7/rtRJHmfkXht
	gzcfKIbvy6caX56+8p3D8z2vzx+Kno5R74HmrIorPZ+9ayOtS9/SYpsbEnM5t2tv
	czMpB/qn2/5+3tWNANuSCx8fKxSK7C+GMDR7OWd42cV7jNBRHBJ071uYnM9pzu5G
	VuwAch8UEJpxIfk8PXMH+Ct0Ceyy9yOWr+1Q2h3TIDEbMdp1U75m7NTe9dIMuqiJ
	I7S/A+AZiXaTWQtAITXv5BjN4rrrw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jey66-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:41:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1YqDTXs61apHBdEWa7Iqf9WNhRqOz9X3e3+ebmaLaOBI/mdWc2etdhO3ya0pluR8SuQ4bbe9UDgcQS4jPKzUtf2HfBI21Fb0Rkkp7XgqiFsmC50KuJSrS8JpLUnIqPbGsBMmtmFzSmZrS0gc2haqtF367Mwaxo/Q35cbEzcF1HTl7JVPK6Rwk+a7iAlsPvd86py4svMZ7RSRyNmPAV2dFLrWy0J3A6CNhqBuffcFkMhmpj1v1PvWxk2PlK1hPccvBeS5VRedVonE05c33O2IKUDNCXkl6sK1p/KWLzzrnTEOaHGA5OuG8ssL4boPn3KMA2aQ7LwzbxyYHuh6IKWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cicy7DTupo0y76LQjnIH5Qoh0xXL10rSbYWbNjz2wHk=;
 b=J7x3LEIjL7fUq0gT+bWAfpdnd1WCH45HatAydq3WnhDI8fFDVLSitiwcjDnV706IDBszGpwuh5NYvBblOf2KZc6mbBr0VqnbWE0i5dJSqVBqVhGM56gwV6OgnlruKz8ZK1WRgUpmAz6oS4E1B+eiaehHbTnhzYv7P78fTIwE1O2ZMnmv+9gvMtiytP3mHJe/X8Z7N9dMEbLJjltfsripzevwGlCdHRbBx2LFmNwCe5XVtxNF954/Ygg41TI0Q1kQYay7eduiC9f/f8AFw5cLsbCg3B0vrLD3hFmOcedKKh+YWWbFxoN7nU7g+iW00dsB0eB8BVCg+4xelxAZ3TLH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cicy7DTupo0y76LQjnIH5Qoh0xXL10rSbYWbNjz2wHk=;
 b=wf/wTKguL53ek/q8KtKX4gZPpNGPL+wW5O6/lJNtj0tjjOLc08WUsFz59mbu2ylevQ8YYO1B8YSBVNpGb36kAOKNHh0+xgU0k/Fc65uC+kxqe0vmRzpeilmeGNvwiXgVZNefSCxRPaEbuNngwU7RNhgvu/eRe2cHQcup42fvfhA=
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:41:37 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::8) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:41:34 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:01 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:41:01 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1j3831572;
	Thu, 3 Sep 2026 23:40:47 -0500
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
Subject: [PATCH net-next 29/33] net: mdio: bcm-iproc: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:35 +0530
Message-ID: <20260904043724.2955444-30-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH0PR10MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb06a60-e3d1-41e9-8945-08df0a3eccce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|22082099003|56012099006|10067099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	9Dh05nVvOH2oUbt+gFoCxCmwdhNzYGAt9t34Etc+S1mQfNet9UX2kloMcrHTeZlSstP+8MA2/yytfFFUOgRRkw0OxFP66Vt9B8X/+LWJOYzi9JSZfV0bVvzrx94pczLC1qKlU3Bmi2yCPhe9uNUWQarweuDqqH5hOE+dYDtA7XaOUkEkJBpdkPRdgKPZTFfaBa5haAM75P/DGpfkH1Nmef/F6vkM6eV8Vntix7sUGHAGgLfpu3LU9b14S7Mnb2I0Mh0J+d9WhfF+haPVvbuo6SiA3PRnaMZmvea0p7CFSHoxJ62kSMf5bupQlA5cjJMHa/uEzKFeb7XbWNu6tPeeVPxQfeJg0mLppkrDaX70Enzr8rHmsJ40AQmcnYQcFxzeeAW2dlVeBl9M50Tddt0he+McAASy4XSUoIcZHSUkuES8FLwzBdrexpgMt9Pgen6eT9jBB7B5hGUw3jwNg06Vbso1GSscGm2XSmW5pnw+qB6PM82Thme4dEFh8NhCfRAgnSmJsevWozLwe7MO+Jx30R85fuIs+WWwhqqfz3RqsQfTp3V7e5uc84YpbBmv4f2vOs1n3TJ4Lgs6TIvxNqIds34mPwo2EJsOAkecBrSerWAM90PomTqIuBOcFY6du0aVQvQ3HfyFJNPz1H5N8HNeW0gZlZy6zRGEO22TQZ37mM+ZtIfQ0nPxO2AxyGNup8L+/h8drpciZ8FPdp3IR04QU7WxGtGRCnV0LliKaMIfpf6rISY8XKuY2yQRNYrt5TxK
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(56012099006)(10067099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K0kTPbhWpZnFavuIQFHBKR5oLTv+psl4b837mmq07zPfjM47Irc5ujVVoRJZSsI0L3vBFtuxJGo+y/LBZTWkjvKWt1DEPkzKUID8SPYDJhqf2kfAdSRnlEbNyzW72BCmDpplwDNawk/9/8jxiN5lfZK1MNF0kIlMBEmOQar9LzagzgeJKFt1Puq9LNl9YIoLIQqRkP53Q5dR9TimMgRzYwGHaXk8558pu2+3+gXyxQ6YupIUzlFAr2iBPPH/+kyKhaxQEUaIbE2s28zOwQPqeqta2O9HF7RAZRo/9gDTfnqop4FWtZ6F3LU7vV7XuS9w1FgpvC+ZTBU0DwGz0w/3SZroFaF1/LULW74gI1XijUyOdq0WmjAFslu0YRrrYIR7/NmwefLNIGh1Y2futNh1rpgn9vR25vIcFx1yLJDjeGOLafrnL/dIiVtJbctm4ovY
X-Exchange-RoutingPolicyChecked:
	xZdCVLgkFMK/WaknvXMTrJtrL7KGmH/MWRswovdwB7z6vPMRV6zidweWp+X5H/IBit5mfEJfQx6pQy0Ex80dR7Dm76HX77Jx9hNBarRlMLxc5mU/KNbs3PRdJ5NX2HsolzMlmpx/6Nm/mZl+hFjNGezD/e0rksWRrgN7yo9qTejT4UED2a+3IMLbvVB6VTQ/sGweQTuld4HshSUI76Q2I7aRY9FlxLRqPwBjl3gGlIJ9Ro3FF58VHQiGXb6w/MXLeghMswmapxxYXaryIifiSTvhYwrVd32G6o0VNk4lAUBlV0YjDPOqKyuqXUdo3t4d+6/J01pFybBoaJtM8Y6mZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:41:34.9431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb06a60-e3d1-41e9-8945-08df0a3eccce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7080
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4c05 cx=c_pps
 a=8LlSNZ/L86USH+wcAhsXzg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: g9adO_Zg0MBf8w_pYbptfT7CYWkrG7zM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXwBnkJU3yuthE
 iV0Xeipsz9LP7hYO14N/sf4yRRSKWx9hwZd/dElRKTImDaUl7OJfM0CQk6CBKuEbvFmyzrSo3yp
 kYxPEr2PbPoohZBP7hAJ2bcpwxcOLSER4WND0w1FrnVJXxH02iTB22tFKKeeBRL5dIHtTzmR9qX
 7qXJpvlF0fN0FWQ+mucRY96rw91IoIZa89T353K7cqo7zZaffRmygU/ACviWwOuHyDx3L1F68g2
 n5YnitBHdXAunHsrvOFzX8Ke2F0My+Zx1arIeRwDJaSkyS1zHYlDC/tmCoKDScQozy7GNApqd1g
 QNN5xSPhOWoVgoErk2026saLRggyf3FhINsNQC99+knXo1YdWDxGW/+QumHbwEaa6+ijuUKn5N4
 lap8s5cd+CR7mmzFUq/OQjYB/FmdGxJXrhvxb/H8hFi2lK/Nvjz4/PEtS5t8wDTH6nlXqX1BWJX
 W1lZtK1c6KjkZhIUWew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX/z/32I1z5Pky
 7wWmH20+rPn/GmalJMacs73C3DOpILJKWfNv2nt6Zv6GsA0AfnSPDfOrXT5uu9E635ZnQ5A+9Qh
 GEybO2zkfnilcRt3P7OYSgalqGoyEbc=
X-Proofpoint-GUID: g9adO_Zg0MBf8w_pYbptfT7CYWkrG7zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040041

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/mdio/mdio-bcm-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-bcm-iproc.c b/drivers/net/mdio/mdio-bcm-iproc.c
index 91690b496793..22473c988e3b 100644
--- a/drivers/net/mdio/mdio-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-bcm-iproc.c
@@ -195,7 +195,7 @@ static const struct dev_pm_ops iproc_mdio_pm_ops = {
 
 static const struct of_device_id iproc_mdio_of_match[] = {
 	{ .compatible = "brcm,iproc-mdio", },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, iproc_mdio_of_match);
 
-- 
2.51.1

