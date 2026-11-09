Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223842;
	b=ANkUgGjFgd866uN4Du94gxXmXCyxvhdhptp0e5bA1RJy77K7AZwCnjR4WsLc9JaUTWmQ
	 sUSMfstlIE77yF/4U877fyKFJXAm00kyVoBCIL7piBOEPiCM/RqmOV7W0QMMNRXKalXls
	 N9NDzu9iud6WHhF/GnT/lTLPNGliGMfkr2UFxyfJH0atMKzuStu6Fqaw0D23g2g94sjZq
	 +jYqDKiB88hV0zz5s83KRFLW1LS1G1FI1svY+X1uR96Boo6OQiFtDxbK2RGO3kb1TTxyJ
	 E3GdgnEYqa1KltdJx08TNnsvspBOU4EWLUGhYu4pfEWKsN3ozUPptxjsgIv7Aq6nQtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Reason;
	bh=SfTcdT6NTDwGT8NW2TAFwEbyWvD8+8HZV+MRv6TDMHk=;
	b=WGQMhtFE2kYh0vUeSTh4IlUedgW/Wfg4azV30epEm/CTwWdnr2xeZG9crJkAw7G5nBwm
	 tAEFjdOvMFYTo1R3NLlJBK88zXLaxFJb3maleHh3L3QZoFbJFWeA+PcZEFpa/7pEKUzYJ
	 lA8ZcwSkgbeDZ+5UoN/VmIqpEfvqPj1znWvZBFYbJveaIqzhzNpv7Chr+/1Twq4WFqmpJ
	 0WKTSyZdfaclIaKzaEdVHqm1eYxcUtO1MJ1LZWYW28qNnL+aRhbqnThOJuSvLLAYz8FTI
	 F4EiwX3D1ny+42jstam8Shb4+BAVG+C/T8hIfYjmNRbhz7+b6cxdhHdVT/eAuMk3X8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Bu5gN1af;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=jwweP1w5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C762606A330;
	Mon,  9 Nov 2026 11:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C762606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=Bu5gN1af;
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=jwweP1w5
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9BN2Ei2230009;
	Mon, 9 Nov 2026 05:30:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=SfTcdT6NTDwGT8NW2T
	AFwEbyWvD8+8HZV+MRv6TDMHk=; b=Bu5gN1afrZ5U+XYz/kXoqP94ICiRPu6hSk
	/IAaUs/65pnDpnB7pIVlafi4MX/Wg3GrlZWdwBkKWJ/1i9Zpjx1H+NsLAIX6m5On
	U/VAH4YVqeacBBl1IZ++aHjiFGXCRWvo26em03Wa/DOH9JNkh02/Nw72eZQkVLtr
	Y15yjXOIb8/GIuJJC/YNRbbT/LyAJQODXuHjzlywQTnzsQSBLUC9NK7DHcGuTkOC
	YCyGCi5lLiM2uKgqWSTMwaaGI0m0v0OMDetQLsXl2ImfoskOgHIEuUJmKpq4w/hT
	O9+VetFS/aDbEhlEyOj9orC4Vcs/jRHdDkubIf2ZWzU2EYjikLcQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020088.outbound.protection.outlook.com [52.101.193.88])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4ht29h9w5u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 05:30:32 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPx5lRYzpensgC6dD+CLBQNx9CXX2buAE9SV0WUmQXsVDjOpSPMTUuNb28AY+a70XtOA0lFnqFTP0RvUcXwBTGkiU/aqFPr/+FCYTzfMIiIAzMqoVI2+7jFH9KNgE+E605BOPVVl/VOPapOvCJRjFbg83mfnvg0PTf/DICHcyL7nU282EvOziG5GfImtaIoqWPuXcHguqfmjIxh2hMobZCcqtu7AMTmUKYfLKCkt71Eaer5PSxh/vKjDc3hTqOOcWMMNYeXFVK1qhQFYPCE+KqNmZlUwP6ra5ru67BXz/7W8xS7CtSAxmp65y5KgGZ9L9gGEkciZs888qlGQBBg2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfTcdT6NTDwGT8NW2TAFwEbyWvD8+8HZV+MRv6TDMHk=;
 b=HiGFHbsShprNAq0kp91FvjXT2y3n2vn6e4CZeM9tEZNHlwzvC/dmUE+nohnTVEpWA+mrDcRtxtxWufFfoutkvOEpJxI6PZzw4xjWxVk4e0Dykb2EwsYL++EjZteC+n92b6l8q76efJhuo85jv3PhHmWyt8WL84AchBobdxXA8FGpgi2vIov6nAN03HySyuakOCueb+mrPpyXFzKl/vFMthvb8SgVyY5UNexGHWh0jDE1uWQPqApS+p3NkzgH68SPvo+C8bQgpu5xGGZB8uwFZlJuKVJsbDddR1fR+4EOy5gGAuxdqnb6NHp4W1AgGEehwyGtuqmNiYxGpC5Yj4ql6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=atomide.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfTcdT6NTDwGT8NW2TAFwEbyWvD8+8HZV+MRv6TDMHk=;
 b=jwweP1w59/u0AhDG+AzCZOR/l9+e5W27iUpISO6auvZnkQjw/aAYO5rH8YGWdSO1bZUSMiuTrk7PeZB7x+kwvAQa3pmqYe56zUcV5iou09P43VOPhtWA9/YfSNpKnRwKbvtkH53g+NA2BZwvFWed+w5aS/AeGKumr75428UI5r4=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by SA1PR19MB4973.namprd19.prod.outlook.com (2603:10b6:806:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:30:27 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::e) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Mon, 9
 Nov 2026 11:30:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 11:30:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BE5FD40654E;
	Mon,  9 Nov 2026 11:30:24 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A6C9A820273;
	Mon,  9 Nov 2026 11:30:24 +0000 (UTC)
Date: Mon, 9 Nov 2026 11:30:23 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: shao.mingyin@zte.com.cn
Cc: lee@kernel.org, mfd@lists.linux.dev, tony@atomide.com,
        linux-omap@vger.kernel.org, tharvey@gateworks.com,
        support.opensource@diasemi.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/5] mfd: arizona: Free info IRQs on probe failure
Message-ID: <avGuz4d4E0Ncwn+z@opensource.cirrus.com>
References: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
 <20261107162122461AuQ94DzIh_R4gD8FWdVlC@zte.com.cn>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107162122461AuQ94DzIh_R4gD8FWdVlC@zte.com.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SA1PR19MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a6a2f3-585a-40a9-e326-08df3e54d9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700016|23010399003|376014|22082099003|16102099003|18002099003|10067099003|4143699003|11063799006|56012099006|261028144727099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	US6xmWPWF67ZdOBVJiEiVSpQ7Uj5PxA9Gxkya/e5Xc9C0sxdHLoB6mAwYupzAqn0UqEjUd0deIwHM7lzwzqYJ8+sqjsivDtEtIR9MUTfq6Ob4/nc7MMVoToItNY9Um6cShlQtds7q+8cvxl9UFMHlYg7h0H7+v5297qSrmMZe2/wFsbPNkQs7VJno3cSrb/m9tvk+RPbp4kJIuyjJUL0zyVM69gmc78gAn6qSRlL6YRqVbsvsfSND0b1XOyURTp8ex4ISMO6DeakZAVHfwSnISuhxl1aEGbQGeIa2L08dVqJsg4QhDuupvj1N3KAntGrSuYwjOJGjMuF7PiSpa9pm/ONxBHRnSGHJro3GXBU3JQBQdBRDc1QLczfy/OOCwU2Im57jKxMH9rvxkodg9/AR4iqylFgp3V4IkLQwgeU7lOO2oXYmuVMYAGMGRgQmnjfnpdhmq5LyLB7tbAiZR9/QdxVrFqrv0wengUjP7MnAELbyLTX4VK/lIQmMnVW1tGG5fVA/U3jbWFFDtOXryzuv1Z7xllajibBgRQ8ir0pQKpETheIpTy6V4s3SmDC+Ee34UZdgCPh8LQqPI7XE/BRykeajxR+6qdbIyQuuk/Kf69b563rb6zpUJYh5IMdjpSMyP36/CzA5G7OiSTOCvIAFYBZ9fD3EI7v6/Ux/0jq3wAr/Yq/nVNGCsr+UDRXXg0dQ0BlIHOp+pJJtomLNP/Jsg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(16102099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6frZVnp5rejUeD5G0PrSkEMwAAYFn/sOc/f1eR27VZLxY9tkaohpKrOoMXeYDBfj00t7jgpmnKFJ/KbcTrFpM6S0m0jS3ibSXqkuf2eke3kF2wXwwYRg9a1ziBgrKlA7vjbdyE+/q0XGfZaL+ol1VWrA832MkOIYuQE496V756xq0e04cWdHC8O/GsgudiUs9w7EHkh8uIxg4cXueMQfGVBFOZwxSblc0G5w26i40xq2JC6MIMkBf97eXzUGgD00vj6WpzOIb8Y+tcyf7caJ+Lw1EJ/n6s11zyx2npY4NSGY6iwmIOvqcCfa3AzvyAp97dqe2nJNJ2glzODsP+TFwUrlfpEohJq433ZXKMp7vwsonh65Dpths9X4nXkiv7c1PlIl53JlpdCWU5+1YlQrwePLN9aEs2XrXQMjd+0iij9Eyz6/Nly9Wm++9gMaSeRN
X-Exchange-RoutingPolicyChecked:
	FCIjoPPJ+N5c5vgd23wduZfC4BadGuqRBCEIXqx5jtBfBhpeWnFENU+RDGBtng9XXJvujoavJs1kTOI2nOy9xPpZnniJYFg0bkVcORxjmjX7HBWiZddBIqr58ruvSuNxNr0W2Skptb3n0oMR0M/b0CpThrvB74idKzKv205fXcCv7KdJNtty8a5FvN9moZzFT2PWWl0kd7x0jnxes/PetFSFChLLx2+7vmfwn81/fHycPMK9YG1MWRPqopnn6BaWnLlFior3lT+VJ/o1XPH8GE74X9EM3M3zCEwfWv1CR20HWzjX2N5kaU0oMxSqAcxrmSO+Xzg3W6mY8xaxjyE41A==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:30:26.1816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a6a2f3-585a-40a9-e326-08df3e54d9f9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4973
X-Authority-Analysis: v=2.4 cv=PO2aavqC c=1 sm=1 tr=0 ts=6af1aed8 cx=c_pps
 a=f5zdTMICB3cTsa2928V7WQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=1RTuLK3dAAAA:8 a=w1d2syhTAAAA:8 a=05e4l9YneAdKSMrYoj8A:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NSBTYWx0ZWRfX8ShiIdZpe3Go
 /69ziQYBGKijDc+05iPTUlnMxz8qoNm3Br99VWHQtXGZ7Et07RQyo+zWINwGAvIJXjVVRECaI31
 vHOwW1DMzdUN9D67ibOD2QDydLBlRTg=
X-Proofpoint-GUID: DF-edkdd3_5rDLqfvHxhoKT2eJAf4tGd
X-Proofpoint-ORIG-GUID: DF-edkdd3_5rDLqfvHxhoKT2eJAf4tGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NSBTYWx0ZWRfX1aME/tygvwSq
 9+kRjAu1xhjCBMUcxmBOiB4YNp+8dCefNj+6q3+2BxjwAYSfHfkB3yQgJquqER0K94b1GaVWMbP
 uelHzBI4te+8w9vlHGuvsmMmoHCfdk13cFVZVqRkoXxWsuv5FqMHzI5tOGCGNLyyMazCyeI94D1
 qRtqXGJQLWyIADfT6yOcLy4vsg3kOvCAg8bRKjK+sLleRuX45w+Hrsp5487r2PlFMtPju7FDbmp
 k3R/i0MPieWjxJOqcg8pY+iaGrbNniPxj1k24WMyy7KryXAjf/1tFj8hivCLDGtYNS4kV5/998R
 NpSVJ0F2jW0yIFey37KZ6TzcoIhBh4shapPdGgZwuOPRmaBqAybNhFTt7zUj3AUJ571GZxg4LIx
 zs2nrZaJyCSn/WJjvytlLtY2tCVVBmlkkuZM7KFcZX6JBNyN2jOSdX1ZQRI1JQWwkfBFGTkNCu2
 tG2d1kvnT2LwblINpiw==
X-Proofpoint-Spam-Reason: safe

On Sat, Nov 07, 2026 at 04:21:22PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> arizona_dev_init() registers three informational IRQs (CLKGEN error,
> Overclocked and Underclocked) with arizona_request_irq() before adding
> the sub-devices.  If mfd_add_devices() fails the error path only calls
> arizona_irq_exit(), which frees the CTRLIF_ERR/BOOT_DONE IRQs and the
> IRQ chip/domain but leaves these three requested IRQs behind; they are
> freed only in arizona_dev_exit() on the normal removal path.
> 
> As a result the three threaded IRQ handlers stay registered and
> irq_dispose_mapping()/irq_domain_remove() in arizona_irq_exit() act on
> virtual IRQs that are still in use.  Free them in the probe failure path
> too, in the same order as arizona_dev_exit().
> 
> Fixes: 3cc729869475 ("mfd: arizona: Core driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
