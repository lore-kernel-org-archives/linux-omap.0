Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F3347BC6;
	Tue, 29 Sep 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669383; cv=fail; b=L7kdTSgp4kD0RKxwUmjcyxdOmV+3Nzjq+USkPkL0ct/V3K3N/sbjdTAMK9VDqwbxwIXWB6S0P7R9NAlbpKHGOxjf9CF1Ch7RO+quEDERvEOUTbmpAIz3MpAXCEZQIKPhFn66ZzzjcU919Th5vLjSMobD76iffKHZmvIN3u+TMe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669383; c=relaxed/simple;
	bh=JjkXajjjtGfmf9mBCorl2tZb/JaGKVb5t2b3FM9K4m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4QkAI/BOe2HcgErOUpx0fUpnAkRWGQoTbzWSb1wd+pdvORw32bdmBB5Vivb00ujDrqfZRS4fIln7co8UfsNZoVBKp/QKPMkZ+pKppfMatDxs41gYuv0283DwCi4sy+21Q+H3qsMVW9kZE2bkwWJwcMd9JJN4Ca9opHcfMRPY60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JaqeyPnd; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=sPxxcP2g; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JaqeyPnd";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="sPxxcP2g"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7UmGq4192427;
	Tue, 29 Sep 2026 03:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=JjkXajjjtGfmf9mBCorl2tZb/JaGKVb5t2b3FM9K4
	m0=; b=JaqeyPndE8bb0B2BhICzWTiDr1zf774cf7dr3BJisedwy13ZvKK7ow93d
	6ObnwMhMIRYi8B8TYRdq4QSTRHrBfHnjc2U83eHi9OLNRpdeIajHjVtsDgjHjdxG
	0jwZCLriQfIPA0RRh2p7aCVs76XGswaFb0LcJfb5543VZUdfJI+ss3y3JicjBxob
	edF/3g7oGQUvtehMNi/GqD2lUozRUNf0ckdJ3Q2fjJ2A9gZlZ6OMkue57/vjs0J0
	pVA0YUaXml7sn0tjFZMm535fTAIGRa8W+kC0+YzkYEZ44G3BedZeqcbXo5DGps5r
	RKEFwe1WG8+tPsKX+E1vqFuJ72fLg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h02grjh4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 03:09:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQDiisegkvLOvwI9+8V5Hb23HqNhCv/1kkhY1N73n6EFRCl4qCoWzIQnev2+BGJMit8UstR2nvR3L3EtOrMjZtNrkS/H2oCDC9vAeiAizkyIt/s6sRxTPN3Lct5F2wC7yZuZievW0jqCZDLA/wKBDuaKqiMHjMZWj5w2dzyz6+9ZjoyeOKNFsjJCYqRd2e4oZd1cgRZUSUuKol+LBvtsyu5nupKCjgdBr5NGGavCreRyFbBcEWKwL5ea5+D4Iy0QFx6uxIgauw25aC8jhmmnsNCiSL8Ukqg7BDLidL5h7QU9rlNq4OHBQNVexBoClvo3liuoWpN5CVehq4qXBfK1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjkXajjjtGfmf9mBCorl2tZb/JaGKVb5t2b3FM9K4m0=;
 b=vzmMn1qZS+IU1T8LdOkviC1t4Lf9kIoowfnquKGx4RsnOxNKMY9HGk8gy9zit0vuhh4nmwI9OQSH649PquZCaqd7RmCgKBRhwIyXB8mVzW5Lt4fNvVPHzhtqSZiE2a+J0pdmtSjRvnF3rob08UMJyrd40Gh0ak97GOW0JgpkkfVUwfU9KC1dNJETWJXzQLfWNKA04KjRxWp5ZwdXTX5Sh83wm8tBE+gVXTSdu6rfwg6bhcyS9K/uvOtrXFpAh7l0qKKlfWGCuiz5OUF5eaUFHIE9V5i6b5g1kRwN6Q+bZ9w9Tf56QxogvG5CZQaUujHXRe86DCNryn7TGaoFJ73zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjkXajjjtGfmf9mBCorl2tZb/JaGKVb5t2b3FM9K4m0=;
 b=sPxxcP2gas1nflrkzlikmtGFcn1b4yZTqfOWvu2zjadB/dYio3mvgoaEhv7lUbsmvq+MlDcATpV9EOe5rRbLebWGi0hp9EpT+SeFHwtcp0ReLDrF2QJH4LSD43t2zge8T10+9QSOhPQV6rRfEWfWG/AienVAHO5DCpR8KDVxStE=
Received: from PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::7)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 08:09:27 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::33) by PH5P222CA0004.outlook.office365.com
 (2603:10b6:510:34b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 08:09:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 08:09:27 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 03:08:49 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 03:08:48 -0500
Received: from DFLE200.ent.ti.com ([fe80::424f:de1:cbbf:d828]) by
 DFLE200.ent.ti.com ([fe80::424f:de1:cbbf:d828%12]) with mapi id
 15.02.2562.045; Tue, 29 Sep 2026 03:08:48 -0500
From: "J, KEERTHY" <j-keerthy@ti.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Weigang He
	<geoffreyhe2@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael
 J . Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
CC: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal/drivers/ti-soc-thermal: Cancel pending alert work
 on remove
Thread-Topic: [PATCH] thermal/drivers/ti-soc-thermal: Cancel pending alert
 work on remove
Thread-Index: AQHdTbWA07QStOv0MUGb/kFJ7mWAV7blfPWA//+6pZA=
Date: Tue, 29 Sep 2026 08:08:48 +0000
Message-ID: <56fa2a1273ec4be0b8bb91afa04e4e61@ti.com>
References: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
 <4005518f-5ca7-4849-a256-5c3fd481f2f0@oss.qualcomm.com>
In-Reply-To: <4005518f-5ca7-4849-a256-5c3fd481f2f0@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ac0920-5f65-4abc-60ba-08df1e00fb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|18002099003|22082099003|6133799003|10067099003|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	a4IvBO3v6saZrBd+vMwdggDkA0NfLx2iEwfRgCEQjSlzt+ph6GRqVsoj0NYdRHMhQIltJORVIC9oFsY2PRXLdRqoThXiGgs/8O2UtJnP1+UEOECDUjHemibJVJjtYbjtmr4oUBmJGpmi3C+LAK78sVhIkOYuPV9Od+l6Kny2VGXU9XMWju2mI2QbP2h6WVU50FNq1JwrfotuHzImi+u/saSKwDo93UlDSw57B8s6ohWFifdElz305Sm76kLaNqy7YxrmCZRhUCvw9LZ8HyX7ieAC7yqxtBYH5Xlo0TBm+M1DwjzlY2w1rW60glbm8DCM4JuTuru1hMllBLMzeiAjyS4hsqodz7/7nLfG0o3+4DOFdY0GX5lSwoz7vBrn2awfICU7ntsz3U2HOZZKPKpUNhH2xC8fvJk9/vlzGLhNVGureggNgqYSVzBvB4JN3+WKArs/AWG4I7CbTazJSX2aQejdYx38fp4riOBIw6uYVHfGk10mDw5kIINjKGp6eJXebq2PsNZ+z3i13pF1Tj22/r3z5JbmnUeQRBMqGYn/Km7bwiGQfFCjC/tvHlF5Pa7OIXS2V75AsMKf286aU253XyCWEtUdev9WZKW75JmkBa6M7F1OucxdzSQZrIjxoMtsYtkeOJGq0dpbrxOO40OaRqL/4CRwi5wLlCRw0uR9hfDO8lQ0a4+3gSL59EX9fvbIeIjXL3kyyVSNZpUx4qW6CQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	StUSVCEOkwk5cJkP6BU5/6z/oCd6G/T6wqKXHb3YvnKTny9YkPWwvV0neHJUMIrj8Wvr6n14DDwO35Hz8a0ZhxGnrcRhnjESAAq6I6lJJLF3QCadCurRjlDWUVtlWwcSYZ8WIN7G4gU64jAlGxxNKuq0Aqv9K3O1WFbF80GypClJethX8W2G/rWiElRE75lZcteCXFyTqvFJe2tcdDgGJLj5ZgglQ82TDby4kXsuZwLbdofk5L4zqD5LGS2WEbi/GQsAo4U7JRtUG5WHijAEVyI5PUF+2Pj/HSUHJqwBHnCfNzF4T2YXoVp7YxO36LG5EOcRiT0RZMJRsx2Q51AgYYXkJ1xTx+6muo+w3VAPRSpFOESPANnwYIdv57LFmpLSfIGvOC0E47j31wVR2am5P3XebMQ5Et5CIKdP5JtQ4sAlOrb3sPgey/+THk8c2cvd
X-Exchange-RoutingPolicyChecked:
	y59TwiS5QHWcPzOC+HBZIogxUEIM4wlc26giTfzzcGk8SACjG01RAxBfh5HLSRZYKfHKjmDeFt/lYX6AytTxOF1VI84HsPM1eb4gD2QxaySAPMhWbwKJZWH15ueh1tXdtKvCgzK9fg8HJw8rEyFOy9ZNhUXND41GSF/hQoxZW/KqNzXIqGwE150mevvC+A6yoJzNejklHTu4++uCtvGyFEkC7FuLUDy7K6bQvTCtCohm+ypN/H3HFW6Vfq0CKHy2G5bAMJS2edJMrQoxK1jpJOMTMhVQd/YsZWe6ySGxsZNuyYVICq48mbvstTQD2K11nJyGnD6JOPyY9PCjV/6J6A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:09:27.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ac0920-5f65-4abc-60ba-08df1e00fb32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Authority-Analysis: v=2.4 cv=SsEFe/O0 c=1 sm=1 tr=0 ts=6abb723b cx=c_pps
 a=TuEuCTxUJaX1tclN0RLokw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=xqWC_Br6kY4A:10 a=mjpAGsxZlKUA:10
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=Gp3nFK667NRgKAZ9PkAA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: UN8tCRjIXB3DgmF3n0lsh_jmgCRKp-lt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfX5i7Z4BNcSw9e
 uo17KXX1cs/eFRqpBcnWe0bZ4Rz59zAoTAiAH4OuaYQlT8N2ORAsudVAz+EsfZWjIDxA2zkttdY
 dG00eksZL/SGA2mZeoMKbwI75nkDlTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfX9XcteVdnOg+n
 KbPHpO6MR7ggRfPkPh2zi5RZBYH+l0wO8wvuI7g98QXUwmu9z1xb9S/efcTln3ru7AMG20gM52k
 FWLjuIP6EFoe0r4A3HzxItaOHH9cwC6MhsmcaQWe7AUTKstHmEyR6rBakeNmuWY+H3DdOqcJmwt
 kVVSCCOtT3u3GYs7X8l+2fkX1wGkodqT4HfKYDdV751DANA6z6PKZb7QLY+YKVek+o+qzKIHVZS
 YhPuOShD7OHz1H+QiWfDwklGQ6qCwbvVY9Lfa4dS/Ge0TasWWEWJiItVEguvw9LN6x8Z+KJzQnh
 is/7702UwxX4wYdTqOs2m9GEcqyvcMsOH5oZv+Hf7hOG96l7v8BGoNcpPYCyExO65cwBAowixRg
 n8Nv/hT/p03jfaH7L+58hKYIbqwu1uVwrs4WLpjrWfQMRiKkDSUDUifcJQhqDeo4fSI9a4g7A5K
 691ndQyL85wylBOZQiA==
X-Proofpoint-GUID: UN8tCRjIXB3DgmF3n0lsh_jmgCRKp-lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290032

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9Ab3NzLnF1YWxjb21tLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjksIDIwMjYgMTI6NDUgUE0NClRvOiBXZWlnYW5nIEhlIDxnZW9mZnJleWhlMkBnbWFpbC5jb20+
OyBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9Aa2VybmVsLm9yZz47IFJhZmFlbCBKIC4g
V3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBFZHVhcmRvIFZhbGVudGluIDxlZHViZXp2YWxA
Z21haWwuY29tPjsgSiwgS0VFUlRIWSA8ai1rZWVydGh5QHRpLmNvbT4NCkNjOiBaaGFuZyBSdWkg
PHJ1aS56aGFuZ0BpbnRlbC5jb20+OyBMdWthc3ogTHViYSA8bHVrYXN6Lmx1YmFAYXJtLmNvbT47
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWwv
ZHJpdmVycy90aS1zb2MtdGhlcm1hbDogQ2FuY2VsIHBlbmRpbmcgYWxlcnQgd29yayBvbiByZW1v
dmUNCg0KT24gOS8yNi8yNiAxNDo0OSwgV2VpZ2FuZyBIZSB3cm90ZToNCj4gT24gYSB0aHJlc2hv
bGQgY3Jvc3NpbmcsIHRoZSB0YWxlcnQgSVJRIGhhbmRsZXIgY2FsbHMgDQo+IHRpX3RoZXJtYWxf
cmVwb3J0X3NlbnNvcl90ZW1wZXJhdHVyZSgpLCB3aGljaCBxdWV1ZXMgdGhlIHdvcmsgZW1iZWRk
ZWQgDQo+IGluIHRoZSBzZW5zb3IncyB0aV90aGVybWFsX2RhdGEgb24gdGhlIHN5c3RlbSB3b3Jr
cXVldWUuIE5vdGhpbmcgZXZlciANCj4gY2FuY2VscyBvciBmbHVzaGVzIHRoYXQgd29yay4NCj4g
DQo+IHRpX2JhbmRnYXBfcmVtb3ZlKCkgZnJlZXMgdGhlIHRhbGVydCBJUlEgbGFzdC4gZnJlZV9p
cnEoKSB3YWl0cyBmb3IgYSANCj4gcnVubmluZyBoYW5kbGVyLCBidXQgbm90IGZvciB0aGUgd29y
ayB0aGUgaGFuZGxlciBoYXMgcXVldWVkLiBXaGVuIA0KPiByZW1vdmUgcmV0dXJucywgZGV2cmVz
IHVucmVnaXN0ZXJzIGFuZCBmcmVlcyB0aGUgdGhlcm1hbCB6b25lcyBhbmQgDQo+IHRoZW4gZnJl
ZXMgdGhlIGRldm0tYWxsb2NhdGVkIHRpX3RoZXJtYWxfZGF0YSwgc28gYSB3b3JrIGl0ZW0gdGhh
dCBpcyANCj4gc3RpbGwgcGVuZGluZyBydW5zIHRpX3RoZXJtYWxfd29yaygpIG9uIGZyZWVkIG1l
bW9yeToNCj4gDQo+IAl0aV90aGVybWFsX3dvcmsoKQ0KPiAJICBkYXRhID0gY29udGFpbmVyX29m
KHdvcmssIHN0cnVjdCB0aV90aGVybWFsX2RhdGEsIHRoZXJtYWxfd3EpOw0KPiAJICB0aGVybWFs
X3pvbmVfZGV2aWNlX3VwZGF0ZShkYXRhLT50aV90aGVybWFsLCAuLi4pOw0KPiANCj4gRnJlZSB0
aGUgdGFsZXJ0IElSUSBiZWZvcmUgcmVtb3ZpbmcgdGhlIHNlbnNvcnMsIHNvIHRoYXQgbm8gbmV3
IHdvcmsgDQo+IGNhbiBiZSBxdWV1ZWQsIGFuZCBjYW5jZWwgdGhlIHdvcmsgaW4gdGlfdGhlcm1h
bF9yZW1vdmVfc2Vuc29yKCkuDQo+IA0KPiBUaGlzIG5lZWRzIGFuIE9NQVA0NDYwLzQ0NzAgb3Ig
T01BUDUgU29DIChEUkE3IGhhcyBUQUxFUlQgYnV0IG5vDQo+IC0+cmVwb3J0X3RlbXBlcmF0dXJl
LCBzbyBpdCBuZXZlciBxdWV1ZXMgdGhlIHdvcmspLCBhIHRocmVzaG9sZCANCj4gLT5jcm9zc2lu
Zw0KPiBqdXN0IGJlZm9yZSB0aGUgZHJpdmVyIGlzIHVuYm91bmQgb3IgdW5sb2FkZWQsIGFuZCB0
aGUgd29yayBzdGlsbCANCj4gcGVuZGluZyB3aGVuIGRldnJlcyBmcmVlcyB0aGUgZGF0YS4NCj4g
DQo+IEZvdW5kIGJ5IHN0YXRpYyBhbmFseXNpcyB0b29sIENvZGVRTC4NCj4gDQo+IEZpeGVzOiA0
NDVlYWY4NzFiZjkgKCJzdGFnaW5nOiBvbWFwLXRoZXJtYWw6IGNvbW1vbiBjb2RlIHRvIGV4cG9z
ZSANCj4gZHJpdmVyIHRvIHRoZXJtYWwgZnJhbWV3b3JrIikNCj4gQXNzaXN0ZWQtYnk6IExMTSBj
b2RlcWwNCj4gU2lnbmVkLW9mZi1ieTogV2VpZ2FuZyBIZSA8Z2VvZmZyZXloZTJAZ21haWwuY29t
Pg0KPiAtLS0NClNvdW5kcyBjb3JyZWN0IHRvIG1lLCBzbyBpZiBub2JvZHkgaXMgYWdhaW5zdCB0
aGlzIGNoYW5nZSBJJ2xsIGFwcGx5IGl0DQoNCj4gRldJVzogQWNrZWQtYnk6IEtlZXJ0aHkgPGot
a2VlcnRoeUB0aS5jb20+DQoNClRoYW5rcw0K
