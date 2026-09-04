Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DD3D9521;
	Fri,  4 Sep 2026 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496698; cv=fail; b=Yx10vcZ9RlM4Ut+odr7Rr1TgPzFrFVASRKygRO1PvABk+iXk1mKhwMlqo48fumTKyBGW0puOS2fA3o2vGq1NjblIncToMad9LyudiY21DihIpa9Rm/8OtEM+tEfitgnE4ILAQlYwS6pYR70t9nJNgSxr7FdZDDgEfxNq3JkyZ2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496698; c=relaxed/simple;
	bh=sXRTEE6ulJMaPsR7bvqDgosYu2tEf2WMgcw5AtRK6Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfDy8hbQUrQ58L25s/OY8+M8uZXXnEc4xoXmjBLcYD2IFXqA82X+uUgicXfv+aT4UKqg/V9ms1wL8he5ml9T9AUEirRbhWljaZvKjtEf03j2eeU7QBTa0HWnTTgTQe6lNrhCRttmxZTqFBhMPVTk8r0UaL8Hvmy8nC9vTXUmCfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LtdnhbW5; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UdjW0XFf; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LtdnhbW5";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UdjW0XFf"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sd6g2738017;
	Thu, 3 Sep 2026 23:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=l7wUd5e4mUXmYBGitxcNzsx/WpaxX9KO8hogC97dy
	CU=; b=LtdnhbW5X0f+5heXrPGxrohBZlxlWycU8CEZo8oXJGEzJtEIBuDBk1oY+
	d4UCJmTrila91oL7FQShXTORfAVsF04IKYuBNjvb7FPkWywnTCYf6eQfhtNme/t1
	dhxZB8BQnvoGetz3UeD4qgfSWNymHxdnh0eF9N6pCUvb+skk68mgPOrby3bgy5MU
	dpIDFRxK5jmVvn/s1KmQTMHCSJ/f08ZK4GXgJ1Ya9P4cNsfiUJsrbwz1gKGojkhe
	8bDu4YCwhJKVrUtksTdP9uCGJaPwHtqbMjkvo50HECnAcANbWyK0nOy5pdvNOnKU
	gLaYbdHZvOIU2lF2v8xt31pgDD8WA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3n44-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:38:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=act1M6yNOpW64HFXldyKDZBqU5hw1/5s0SZUvkX6OgZJqaX6XCRGETFFfNb0854Y6TnPOf2gYAq5sbYp0OsTXGXuEAUGTGxpOndIfP/wr9DA/EFKgBS2yycWj31+w2IL3575XHJWZc2NPJ+oGxjdV4iKT/T/1I2tOEkDCImrtlCcMnJpDzXhdXYyyenDb+r23asQAX9vLh743SJ4wzQhoTCjoQkuXMC38UCpRvbAD0KWJJ9dsmQ7GJRXiojSfCOmnUx4PsyCsOufcgEjWsj9OH8j9GO/W22VoViq9J9xLafltzXvCLWSNEpQsAyMO9OQc+I+0dk6VZPC45bcgct3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7wUd5e4mUXmYBGitxcNzsx/WpaxX9KO8hogC97dyCU=;
 b=SZ4CYB89giLlYsLn5eGgpHeeaHxG5D9Y+S7WXlxWcUvmfqXB/ecHCZKbGdzx8RdwmfRM0HbEvaO/WU5B0nVHlR6FJPPLiE/qloNFrSeNFwryycSahZ4ZCH0udHLURT5voNK2fjBdnZOarOjblI5qK5xn8LoJjfDTcJFLumRalLaL3g2GzYwgtHXBPTAFQFJPXSDJN+Zw2W8IiwfEM+Lkcokzqax6Ypq0HFhrLOnWzAIlG8PDuBeD73oLKjTPWxF9Lb/S5C7fyFG8y+HhU24rzZHe117G5MkV0V4LcgwdfxFZr9xvNRk25B8mAz+/gO58HMqDZvidRKjCblggNCl+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7wUd5e4mUXmYBGitxcNzsx/WpaxX9KO8hogC97dyCU=;
 b=UdjW0XFfXdoxvrDEPWSxwK8TUT0C9g26SpsaWZzgpabBCEKuIkmEnG3ZDnBPBhiuZ/joBdEa/TYJ7jMslf0E91oCbuXfYcMSvl8SVzv+I1M8tuUFieYILy9bigbhf1utL5Sjd01Pqdvdzyz2tZXSJ9gS6g/S2ZUZFkf9fRUwmu8=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by BLAPR10MB5155.namprd10.prod.outlook.com (2603:10b6:208:320::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:38:12 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::76) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:38:11 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:37:28 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:37:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:37:22 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1U3831572;
	Thu, 3 Sep 2026 23:37:08 -0500
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
Subject: [PATCH net-next 14/33] net: dsa: mxl-gsw1xx: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:20 +0530
Message-ID: <20260904043724.2955444-15-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BLAPR10MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 106d8cd1-d9c8-4dcd-61d4-08df0a3e5382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cH0Yxp8e/8f11WIdBREj67ei1uV0F2g+F/XnGQlxpDxZqgE4ghFcezOoEvSIJOVNTPHNuW2rQNs3pPIdVrJ1FQ0NdzYgTh737K4dl6hoSity20ZrIy4oOOG1AxV6AZ2y9kHByenT11wsO9wOL+ns+T/uiB6LmbcrsGlpQbYYDpixlf+1CqxsCLayxKoX0P2a3tMNMpa+F1eCKow7HEGN4Idob/QksDSY0e8zq/jco9WzHQShh1UbIP4O/yHS9iGb/NjubXFHQmp+Zmsb8MBkx4bkNA71yqfc7DMMcopGz0tWQr6wqahrqLCtF8O5X3x+L6/cr60JFnX0sH/UT3cVuq/zepxD0INLxGrlO+O3s0+pO9STi/jS1pVyvGHDrSmQgRHr5wBH2kpfsDyCdNRQbW7TqRbTjWmvpQaiz0tfP5X2WJdBZ7Lb8Y7haHVAhZBCcuOcKj+jcGyg2/X8hTPiDmBMYPNnSoj56DzhB+V/AUP3rAqjKkPxnprn2pFPBsNr4uCFyJdgunkQ3Fo9lN0zcStSGnR3fwsKbO2VoRrIrH+3lHsMS700RXqvNIawn4X3YKnBfWFydoFBBgwaqPx+CrDuhYXH9AqU8F8Zg/HeVHlPiI2NRzovK0EUG8N/vOrRZvgfnZwziDdvC4wvdDA6qoGQ7dfrLPFyS7GNZPrNsFaSvR4lw5qcCf1ONuT7+mzZGotNy8dG3w58iQ2Cbe6DX7hoWL751JEPMgWqpGIJuqQzIFDgnTERaEYsrQCnOv6m
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pkXLIjs7wo7DfhV+HRLeFsHor/lWQJ066pGS9wYSx6cGFSmEB190dF+uxE++2s1fSiSfQ2ONdeYF1M3tQJrIbnrMxo2sNDVOE279J4aY7qcZcAMl9wPGrWtnOC/tl3uw2U44KrojUD3cFD3FFdbEUH2rXaz6mo7Jb+1eUIFLmjiRnvxyeFOUArihKPXEMiJuxCBkrvJnssDqvrm4UxjMnYPc3BR4xcz8p90iA0mkTVeZLxGS1pNWXSTZ6QNOTMb/G9yhl50ZWAyxcCmqmdE8z+cXyA2eiH1hQXOZrrrtSvX6A27rFGv6hpi1kZ258iyvm2aaOxOIId2FHSupHPAZWgWYDsY1Gk5vvquFOF56zJa9YtqOPtrOT8ntiCwNkqr+3JshoUmTF6YSBcUI4617YDLBZQ8sQy8o8O9zkH7Rgn/SYg9fVErY8LiepruaEGbf
X-Exchange-RoutingPolicyChecked:
	cov+xeqiHj1dS3Vt8FHlae5HKWL75XKfrIOn34jVGlrXvFl9JHsSS44yWW7hCajnd+mtXyilUa+ps0o8yE85Z7b1BQoSXON984s9SITZ7q7CBJxCUm4q0jGk/fUZJPl1gEPbP9LMhhW3nNlPiR8GKom4g2OzoQ3HKNc5fOD9zOmDWCFIcXfhF4Lx8NYcn3qERx6KYUnUnrty9uI93nj0cODKPi7UlETJVxvPBnZoNLXnv0J7F76rE454m/28AJiRlwOd72mJPIGnKDxnmZd/LsxQUDZQzvdSbyU2f4V43/5h+JsZh15QaL+hEMNwiL+Ep/vI8Q7IQ+X+QUnULPC6QQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:38:11.4214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106d8cd1-d9c8-4dcd-61d4-08df0a3e5382
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5155
X-Proofpoint-GUID: q_giVeagfwypD35rYgIGw_0JVTPQGAyL
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4b37 cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX9i8CK1JHpCSs
 zi/qhD0zgeh8TyXzfQ93ZRvHHgzxr+6Pe1xCG+vMPKXb9gSTKApOAARWzjxlDwnkKV+p0IkbDp0
 rf/aDCzuxFeQFLdwFKZsIJ/+1fOA6bx5kYPhJZOqfwFD8209qwI/o6AzzbZS0Ke5lCgBzW8at1Z
 tW9/lhsbOhFpQBRcWpt7/QHrp3Y8dHbQsobtNjJzh/2Q6w988gPpU6QhhftrCwlLV9Hpo/M4/Kj
 PPt35iMXQW7DKmdn0oX0h6vNrVAJLo5LPDWwq7I7H4kOXZ26RYt3vkOxdd6zyEOXtglHBQOC36q
 VK5kwUiyoabOzdDgQ9jKoJ0l0LDm6kzqtzFS2MmMFEAJTWbw/U7RGIR4jxVv6JjkYmGX6IUDF9h
 iIy4S0s/ocwNDtu3UriUHZewZm/1BqtnwEhP6+P2cuJMDswHLoBSbturQw07aSeezU1hPMvUEuI
 RKrQG0WQCGjrOUCWRJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX8u9QD1UDm7IP
 znV6OVfdo51Mz4SKhsP2mbcasIUJp7syq3UItVAWShFjDqYSBlc8u3K3VGNUz6o6b2a4v6X8ZY/
 yF6Tq1oFGOmHzN2q3139chnU4o0lBnY=
X-Proofpoint-ORIG-GUID: q_giVeagfwypD35rYgIGw_0JVTPQGAyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a1104b2f92a9..347e16e9fdc1 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -918,7 +918,7 @@ static const struct of_device_id gsw1xx_of_match[] = {
 	{ .compatible = "maxlinear,gsw140", .data = &gsw140_data },
 	{ .compatible = "maxlinear,gsw141", .data = &gsw141_data },
 	{ .compatible = "maxlinear,gsw145", .data = &gsw140_data },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, gsw1xx_of_match);
-- 
2.51.1

