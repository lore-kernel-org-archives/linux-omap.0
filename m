Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256E18C2C;
	Fri, 30 Jan 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791581; cv=fail; b=Q6NWx7D48Dr4LBJcB/aKWpe2Z7LElTAMrUlschduflD6ZNfpKN9iI0Go5nqNB4NMhlWQxYff84rgMV8rfO5EZYtMQtQgR6x/vdMprWiOKPiUL/UeX+cikBIeMfBssXffNesRTa1c73lrCSi66spUBMC2ygbVH96a8/4c1Dutsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791581; c=relaxed/simple;
	bh=HUlW5cgFQZdCYudDE6lW7L+jDFEDCXeyohVtYSRRDvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Su6ZzxJnpDAs8V73uw2fhbF+nH4uy90ozFRvi7ZZNrrAC2pMetKMRmNYLY15jcfgfbFxxJcQ5eZj2EAdvCAWuiC87WohgVJtSYDAHtYeU6vwaKcdVFv872ModCaRVpUojwmbZX4tBBvIDz1xd9JIjbsV6q7DLQuf+h9P5rojVtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=slx9G4mK; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="slx9G4mK"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UG5QEb2151150;
	Fri, 30 Jan 2026 16:18:10 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010035.outbound.protection.outlook.com [52.101.169.35])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4bvq4vcwku-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 16:18:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXk3sBXBIeLAHFJ5I4mBRNEfXAYpl7wwiT8I1a2OA6P0IlBrLG0nvnGCBvFc9z/5RAD3+PwanLWRpmg/XQJG3zQoYTd8Vvdyqq7A5wd4fREBik0poRjZI0hXYeaYs7g0y07e9Nm/5vA2XW+fWmy42vZqzKMNCS6kjbFBlVfv0E8sRnFXNf2go2hcvdEUSizmEG2Jj3tii4KMR4h2lFccYbYsppx5f74Jbho/KtMDd0BXqQrhMj7rtHJQ14j/W74fEzWGl8TN/DaYRU8i19s/qlkIRlpoD5VtC7asrMXsbTK4J8Td6P21Wzpydt03MFsY5ZPe+qQjQD2ysYL00lBAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUlW5cgFQZdCYudDE6lW7L+jDFEDCXeyohVtYSRRDvA=;
 b=hY18nY6Kk8EhglmxUHhvuRbuQtBbnMl6kboH97cJTIcBIYlLPcaOk4kEJ3RPbHWVud4iBiLhWMf6tQXhD9YCrJDL9jcrhqs0FctkYcNctCZAJACHWBrAedCJ4FDT7NzSIS8GgAk3aTb+vwXWV7r6dEBtY8D6ZAO2+iQWlqsi920HA9o5mNTSHJqbZDW1odJAaJ20zSnKSgMpwYNVdqMyGfY5NWnnbCOQp6HhHGlzp4zVoF3vTq8vuezFQIln+OvnkxiSfodH7vUodNK5mKaQGjgpVqgw7D3IfRyDHNXe6eiEWp/GEc/PV4YiIZ1hMy4Eoua8k+uzKvd/iewXt4XkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUlW5cgFQZdCYudDE6lW7L+jDFEDCXeyohVtYSRRDvA=;
 b=slx9G4mK9YODh5BBixL4hX2FuNY9ocmxcw7yLkchJLT2KffGep93hUq1KrjRcA74KSXLY05xNmoMCVXskrwz0xQ6vG/S9P0N24Y/w1U0LqViWJrEmGt1iTgfdx8Uz5HM6zydTjDipTu2z8Uso85+RC0Zh75mHq+rEW9MVgVpTappc+OgT9EkG2kBfb4b6Q57dMrq52lYM3UGYVjjoavPDG0jKp+D6IsqbPiLBdn1Jl5dYIjFCSUYLlE5D+gtEZhP0VlgwMp+rlH3JxceqMWqIg8Uhb3QjCqk4uwTl5QjxGbDWMPFWv71xYQAF9yD2AolvXlnlsgHSlLREVLKYAxXKg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB3663.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Fri, 30 Jan
 2026 16:17:59 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 16:17:58 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "akemnade@kernel.org"
	<akemnade@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Aaro Koskinen
	<aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack preventing irq
 storms
Thread-Topic: [PATCH 1/2] iio: imu: inv-mpu9150: fix irq ack preventing irq
 storms
Thread-Index: AQHcepp6RfunxHnxy0WYJkIDhU6ZTbVM9tCAgB4aSEc=
Date: Fri, 30 Jan 2026 16:17:58 +0000
Message-ID:
 <FR3P281MB1757D391A1747D25E58471BBCE9FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-1-08ecf085c4ae@kernel.org>
 <20260111123003.450bec98@jic23-huawei>
In-Reply-To: <20260111123003.450bec98@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB3663:EE_
x-ms-office365-filtering-correlation-id: 9c275885-69ff-41ca-64f9-08de601b21fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjJNMDdHTXRrRmtjWnYySVRTNGFzWHZQMFNvTDVmcXNQYlJBQ3grckZxZWMw?=
 =?utf-8?B?YjljYUdXQm9tQy91SFh2MTh3R1dveW1NL25FYU9VcDBiNnZDYmZLUDZXdjl6?=
 =?utf-8?B?ZjdtM2o1dGl1SnZVQ0V3MTI1OHF5NDlKMGJucUVoZUZJVzBpUFRnbWRMYjg2?=
 =?utf-8?B?WmZTUWlrcmVtZm82a2pqaEFJUG51K0ZNVFEvdzdveEMyQWZyYWdkeVp4ajVZ?=
 =?utf-8?B?VFRLWnhnMjdMRjljK0J5OVlweW8yR3h1ZzdOL3dsOXBsS3Jkcno3T3l3ZnJT?=
 =?utf-8?B?TkxjcEo2eWdDdmV5NVo5V09WRmRBVzcvdjhsbFlDTkR0c1V4c2xhdThuRDFn?=
 =?utf-8?B?WklvK0ZzSTBQaDlGTmUramlZWXZ0NzdGQUhoaXNpQTVreU93SzRFcUdneWQ0?=
 =?utf-8?B?clpUVGRjbWFuQjVvT0pXdW1RTWxpTXBVTHo3dmY3TTROTW00eTdRalhSSFl0?=
 =?utf-8?B?bDVYWWpzWDJmTjVJRE85Z0JrWkNXdmJUdFV4MDJWZmJhVXZwSS85MEhjMjR0?=
 =?utf-8?B?cUI2T2NnNWpmaXVKNE5yekgxUy9nNFlYM0h2aVozSkFJVnByVnM3MVVkYUpw?=
 =?utf-8?B?bzF6V1lPZ0huTm1INEEwUlpUT0JzQ2xkOEFHMDUzb1FUOTZGT2FIb2dvNUdY?=
 =?utf-8?B?VVBMWm5IWVFvVy82N1kxTG9oTGZYckw4VHNpUThFTy9SNTF0bW5JMTBvNFd0?=
 =?utf-8?B?QWNVZG5XaWwvQXpCSkVhVGx2MGJlWE42QThlYmc2eTNLdlNvMCt0MjRnN0NQ?=
 =?utf-8?B?ZWppRi9udWNLa1Q4NktJOStrZ0g4L1AwK2ZlakRzSWFlU1J6V09KalpRdlpI?=
 =?utf-8?B?UW1vUUMzRm83cGVscGgvNlJEdldhaktHRVpXTFJ0dlA4RjcvT3dtMSt6cGdh?=
 =?utf-8?B?L2cya2lBRDFpRUpzSHRkMS9DR3UzUGYzU2dJUlU0MWtEQmJabzExMUxtN1c3?=
 =?utf-8?B?WFFjWlB6T0NrOFk0cHIvc3BLelp4em5aRXltZ1VNWlBhOCs4bUp6MW44WUpQ?=
 =?utf-8?B?aFkzZ3dMZGREY2VmZm1sT3JIbzN5NnhJa2NyRnZDYVdtR1h1RUJLNzNDMDE0?=
 =?utf-8?B?eDNrc0dIaFN3MU1aZms0RWszNURQaDg2WSsrZUlMYmh2SFh2WWtSM3ppeTI5?=
 =?utf-8?B?SG1JOGRkRTVVZ2pZdElsL29RTlhkS0tMdlVtRFczQWJyUk9MR0xZMHlQWGxL?=
 =?utf-8?B?NEJWcEtCRExZZW5wRXU3VTF1VWZGU3FMTmlnbkdPcDdxVmNpNk5mZnhwWjMx?=
 =?utf-8?B?TUNYeUYwSU9HLzJLNGNKd2xDVTBaaXUwRTg5eWxuUVY4ZGtxZ2xFeHptVThN?=
 =?utf-8?B?UkRmVHZHSGxOSUxvazlRTDlGR2pRVVhmRjV2ZTJ4UTZRVXRSenI5VmhIQnl2?=
 =?utf-8?B?akVSTWxWUEhaRUVBSXcvSUl4QXpXVmEyUVVMdk1DZW16aU9EeXpzUkFiMWtM?=
 =?utf-8?B?QTBIcHhzaDI1U1pPQW5maE1WVU56R2VicWt1OFdSb0xHcTRCL2FBQVEvQzlB?=
 =?utf-8?B?aTVoNXlzVkF6VE83T1kra1JGWXM1dDZYQjJ1ZEdab2J4bkU1YU8xRlEwemNU?=
 =?utf-8?B?R2dPV1dBRHNJUjB1YkR4WlYyNFlwekEvaDN2aWluVGlGeGtBcytJS1d4cFZm?=
 =?utf-8?B?OXRQZlNGOTFWWmt3MFAzUlFPdmE5dXZFTGRnRWdFUThlNC9vZjc5K2c4L1FL?=
 =?utf-8?B?QzNGN3BVQ2pEKzgvb0dJSU5mMTZ1Z1ljTFV0a09pVG1VTjZxeW8xclVsaVZS?=
 =?utf-8?B?ZFJreFFLMGxHU0I2UFVtcXRGSzB2VTVpVktadFhoWU8waHgyMXZmRFFxTDV3?=
 =?utf-8?B?S1BjQWMxQUNQbC9ZOWxLN015aE9SYWFKczdlVWdtR0NOOUZoOVJlcHNKUG81?=
 =?utf-8?B?Wk9ROXR6cWVQZWdUblZnQVYvbW02OWtGZFBwUkdzcE1haUNjSmxxSVk3bmRh?=
 =?utf-8?B?UFlMSG8wcWxxemY0WXYrT0FrYUxYNlVtYlZaMUY5N3RnQzkwUTBiaG9YMTYw?=
 =?utf-8?B?c0I3ZEozRHkwZ2Z0YUs5dmR0QUFpc2JmWHY2ZzIrUE5Rd3g2eEFPN0I5SDh5?=
 =?utf-8?B?MjIrM2ljKyt3UTlEcmdYR2dVdU5QTEFmSHl3YUw3Q0k3TisyTmlsS2Era1p1?=
 =?utf-8?B?UU9TTEcweGl4Q2Qwd1czVy84R01GR3Q0VHl6RWNoWVIwaEtrWlg5WW43U21U?=
 =?utf-8?Q?OVte90W4WrxoyZ7DW2N00fw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVJuN3h5eXBrWGRkalJ3TkdoYWRieDlReTVxQzVBcndpUjNWY2NJaEFkWkhK?=
 =?utf-8?B?MjBvWWtlWVQ2MzdKVkZBYzZQWnZva1dkZ0kydk10RjNIQys2Q21KTmFLT0Jr?=
 =?utf-8?B?d29xcllTQ3ZIaGVDUDdtMm0xZ2RYRTliSWtnYXJLeHRIQVhUN3hwR28zcHB3?=
 =?utf-8?B?VHQxOWxiK0drMXhhcTRZWVI4ZVRieS9WSm1TR2FQUDYxWW5hclBHcVBjY3JX?=
 =?utf-8?B?dUtFa0Nra0NVbko2U2wrSkdTblFudkFrc0lHYlpObndsdFVNNndHSTRZN0FC?=
 =?utf-8?B?N0hxaE15aGRZdDRFYk9xOFlKUVM5L0hBWnRuVGlmRVdJdW9IeDN3RW53YTZk?=
 =?utf-8?B?NUh6UEovYXZ5OUVrUEhIZlIySVNMbldGK1Z2Rm5nU2Q5cUZ3ZjVLSWUxUTJG?=
 =?utf-8?B?dVpPOVpqbllOc2orYjFxMUU0K0ZLV3FHVXArZ000RWswMXlxYktqUWczMnpZ?=
 =?utf-8?B?YTJlUlYxcEhpMUkvVDNhWitJZy9HbERrSDdlcWprTUhWQkZ6RUtlaExHZnNK?=
 =?utf-8?B?ZHNRcGRHNUFMNnBoZnArVTR6a3lvSURpeW1GQXNzaWRWcEF3NTFSOWx1c1RD?=
 =?utf-8?B?RjVNSDR1ZXhlZkI3RW4xS0x0Y3d6SDhNbGdXU1NLV0kvSnJ4QnRZOUtMRzc2?=
 =?utf-8?B?U0t2OFBVK2t5MDVJcnBRSGRLNnB5bVhlb2I5My8rb0tpTFRacGtYYVJBUXlO?=
 =?utf-8?B?MThSWjRDMEJNZHNxYTFhdXJhbyswZ3JwKzdmSmUrNlJmSTNiQmNzeGhIK2xV?=
 =?utf-8?B?YjJOMEVtNlVKUjdzUi96Smo4T1lvQVdFV2dLTXVWaEZNcTdxRzJFbXdpdDdI?=
 =?utf-8?B?K2wwSERHOVdMbHdmeG92MklBUHAvT0RWc0xoVVM3VUJiTGUwY0t6K0ZVTGhT?=
 =?utf-8?B?VTNMUGFKV1pEZUJJTVdNMExIS0h2RUJ5bHRIZ1pnV0lYZW5RMzRSd3ZhRHRH?=
 =?utf-8?B?UzdJRXVscmdtM1BLMlkrSnArYUJmZmNhanhjQUdrRXZnSjZZaFBjZTJTUGhh?=
 =?utf-8?B?MlpjcVBCMWNwMHFBVS9nNFllRWNWZXJ3L3ZDT01GSGVWYjJsamxxNHp1NU5H?=
 =?utf-8?B?UnpDZEdFUllENlliOVJzdVR0anc4M0praE5YNXpteDY0bS93bXVzVEhlS1dj?=
 =?utf-8?B?dUZmcGRLdVBxVVF4YkF2bGN0UUVmeWEwRDkvTlVIYW5GVHFGSkFhRmJwdTY3?=
 =?utf-8?B?Z2J3VDcrMndSa2Vsb0IxTExzSWtWU2NCTkt5dGpjUUJMUEhSbE9BbEc4WVNt?=
 =?utf-8?B?czVNeWxtRElyeGdKMXNGQlJtNnkyVk04NTI1ckk5b2k3WkZtVWkvc0JDbGEz?=
 =?utf-8?B?UjR5WTZwUnQ5L3BSYUdGeWdRYkRLYkR1UklHUXh2NnBVOU00NFZXVkR2QTkr?=
 =?utf-8?B?LzExcmRqSWMyMXEwcGI3MEJ0ZnpDQXFTaVdlVjRFdUtxWnl1OXVnNEtQQXZ3?=
 =?utf-8?B?MGhkb09QL05kVFhaNXVEZUNrQlA5U3VrVFNJZlU4UnJNY2F3cmEwRC9BY0Jz?=
 =?utf-8?B?ckVVTFhsUWxxTkFBNDQ3eDZpM2pxUE4zYXVnWlVRcTZMUzFwcEFKYkhtNHNW?=
 =?utf-8?B?L3BvSENGcDRVMVhGTm4zemJxTUIwNHlBdkZLRGVXWmYrdjAvSHdZWDJob2lN?=
 =?utf-8?B?RHVzYjFuZ09aVW9DekFtbjZ5eEFKMUREdW0wQVJKZmVhSVNqeGRjVFdxcGh1?=
 =?utf-8?B?K3BNYkFEeFBoODRxZFJNSWVoQnpCRVA5c2UyMEZ6VmUyQWxXc1U1UlVQTVF2?=
 =?utf-8?B?WWN3WEpzWmVULzBzc2dWdXAwSHVHR3Vsak5FWGs5NFg3WjhBdGFuM2dHUkIv?=
 =?utf-8?B?Q1ZmN0NOdXFIRDBzUnBNNElWcVRDL3pWTFNKU3NYbjNud1JUTE1BZ0d2MS9p?=
 =?utf-8?B?TjM0OFJNYnpLMFVRTG9mREoyalBSdXNqaDJzczFCYjF6dUZyQkFnRmUxQzhR?=
 =?utf-8?B?eENVWmlNSGxzck85cDZuQStScWlJVW1wNDRZYkdQMk53OVJSS0NsL25SY0c2?=
 =?utf-8?B?cHJJSXFLTUxMQ1czSVY2MzkweUh2Ty8zNlFWZVdsM2FGaWdRL3cyYTVoUU1F?=
 =?utf-8?B?cU9jaWJpc0VHN01wdURHa0JsUmRtNkhCTEFQblhDN2xOTlI1ZC91TTVYM2lz?=
 =?utf-8?B?bWtxYXNBbzFUZTFTa2xCaVBNVGNsZ2x4K2hRazQ4MS9DaHArR0JaeW91THFS?=
 =?utf-8?B?WW5LeFYyL1M0VTBwRGF1b1V4MnFGY0w5a2dzVWlsMk1qUGZ3VXQxK3J3M2tk?=
 =?utf-8?B?NFRWKzIzNHd1QzBKTldnQWwvdnBubmpEMEhqeHVxQm9NNlJIOUM1SkNNWWtY?=
 =?utf-8?B?UEJyeDdIQlVaRXJzL3JGUVhwL0lFQUZaRFRtZVpFWmZ4M1lwWFlrRlY0WVNN?=
 =?utf-8?Q?SekZao1Kl0FHO4xLOfjP59gQZeKiVCDsqwn0JZV4/rfsQ?=
x-ms-exchange-antispam-messagedata-1: kBBL2XrEYqPf4YB1fGqxt/PQaZEIHCmPEMM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c275885-69ff-41ca-64f9-08de601b21fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 16:17:58.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIohxkeDmE7/pFsO/A9md9Xgd0upelfBkEqIxWxJAaxB6XMNySQQSaga2JZMK1bmWbsofy9/pvbVIUHQLj4HNTA4frO3bS/CNtMuAJn9pjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3663
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzMyBTYWx0ZWRfX1FlvbvnGDLze
 3UFgqhSsKjuM59qd1KVasTqmAcFVf71ZpTN64Bw8pPXjwhAwyJVNNxmFfIzE+HGsmTotcNq29Zp
 xqcoavg7K9Qkn7cc1Xbs0NNLD/VGv3QN8cRaM3Rzy4Zly0Ny0D+SXhzAIvWqSXJS8qqYpFDuN2a
 tD9at7SQYWBXZ0xBU9tRF8fyvUtMexBr3JSNpPIK34j1Q5HKSwEbR/778gkRwmMP5nFoWSCQ0eJ
 NDR0EVtse0GBXW5U793jSKKxcbFP/VZFYbfjF48/US3nMGc30YotH90RmWdC7kZsRok/Z2Lc5T3
 eNR8W9brOfwpNhyBShyJuc6UrfnU4xT0BtXsYApQzaywadRT/s9ZJClQbqfbZWWiw5+lfWDtArQ
 DWWdiu+t24GBtVEbS7jl3omDxpNmr2qHqvy+5+ZCTn9z4rc/qZpDG8xixnQw9w/4rj0zxLGjFxO
 Y8Pt6UB2I2IOEZ9srjw==
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=697cd9c1 cx=c_pps
 a=7J+gLUN74uN2k8cruMQpcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=50gAi1W1AAAA:8 a=2KMo9-giAAAA:8 a=i0EeH86SAAAA:8 a=LUZXa1UkAxxzZH2ZcDoA:9
 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=bIAsa0K8HJLRn3BBPJ--:22 a=UeCTMeHK7YUBiLmz_SX7:22
X-Proofpoint-GUID: GxeTYtAaAgj-Mu8NKafU8EtjsuCJ0zF0
X-Proofpoint-ORIG-GUID: GxeTYtAaAgj-Mu8NKafU8EtjsuCJ0zF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300133

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTrCoEpvbmF0
aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Cj5TZW50OsKgU3VuZGF5LCBKYW51YXJ5IDEx
LCAyMDI2IDEzOjMwCj5UbzrCoGFrZW1uYWRlQGtlcm5lbC5vcmcgPGFrZW1uYWRlQGtlcm5lbC5v
cmc+Cj5DYzrCoEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUuTWFuZXlyb2xA
dGRrLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47
IEFhcm8gS29za2luZW4gPGFhcm8ua29za2luZW5AaWtpLmZpPjsgQW5kcmVhcyBLZW1uYWRlIDxh
bmRyZWFzQGtlbW5hZGUuaW5mbz47IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+
OyBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz47IFRvbnkgTGluZGdyZW4gPHRvbnlA
YXRvbWlkZS5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsg
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9yZyA8bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc+
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+
Cj5TdWJqZWN0OsKgUmU6IFtQQVRDSCAxLzJdIGlpbzogaW11OiBpbnYtbXB1OTE1MDogZml4IGly
cSBhY2sgcHJldmVudGluZyBpcnEgc3Rvcm1zCj7CoAo+T24gV2VkLCAzMSBEZWMgMjAyNSAyMjri
gIoxNDrigIoxNiArMDEwMCBha2VtbmFkZUDigIprZXJuZWwu4oCKb3JnIHdyb3RlOiA+IEZyb206
IEFuZHJlYXMgS2VtbmFkZSA8YW5kcmVhc0DigIprZW1uYWRlLuKAimluZm8+ID4gPiBJUlEgbmVl
ZHMgdG8gYmUgYWNrZWQuIGZvciBzb21lIG9kZCByZWFzb25zLCByZWFkaW5nIGZyb20gaXJxIHN0
YXR1cyBkb2VzID4gbm90IHJlbGlhYmxlIGhlbHAsIGVuYWJsZSBhY2tpbmcgZnJvbQo+WmpRY21R
UllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5k
ZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPsKg
Cj5aalFjbVFSWUZwZnB0QmFubmVyRW5kCj5PbiBXZWQsIDMxIERlYyAyMDI1IDIyOjE0OjE2ICsw
MTAwCj5ha2VtbmFkZUBrZXJuZWwub3JnIHdyb3RlOgo+Cj4+IEZyb206IEFuZHJlYXMgS2VtbmFk
ZSA8YW5kcmVhc0BrZW1uYWRlLmluZm8+Cj4+IAo+PiBJUlEgbmVlZHMgdG8gYmUgYWNrZWQuIGZv
ciBzb21lIG9kZCByZWFzb25zLCByZWFkaW5nIGZyb20gaXJxIHN0YXR1cyBkb2VzCj4+IG5vdCBy
ZWxpYWJsZSBoZWxwLCBlbmFibGUgYWNraW5nIGZyb20gYW55IHJlZ2lzdGVyIHRvIGJlIG9uIHRo
ZSBzYWZlIHNpZGUKPj4gYW5kIHJlYWQgdGhlIGlycSBzdGF0dXMgcmVnaXN0ZXIuIENvbW1lbnRz
IGluIHRoZSBjb2RlIGluZGljYXRlIGEga25vd24KPj4gdW5yZWxpYWJpbGl0eSB3aXRoIHRoYXQg
cmVnaXN0ZXIuCj4+IFRoZSBibGFtZWQgY29tbWl0IHdhcyB0ZXN0ZWQgd2l0aCBtcHU2MDUwIGlu
IGxnLHA4OTUgYW5kIGxnLHA4ODAgYWNjb3JkaW5nCj4+IHRvIFRlc3RlZC1ieXMuIEJ1dCB3aXRo
IHRoZSBNUFU5MTUwIGluIHRoZSBFcHNvbiBNb3ZlcmlvIEJULTIwMCB0aGlzIGxlYWRzCj4+IHRv
IGlycSBzdG9ybXMgd2l0aG91dCBwcm9wZXJseSBhY2tpbmcgdGhlIGlycS4KPj4gCj4+IEZpeGVz
OiAwYTNiNTE3YzgwODkgKCJpaW86IGltdTogaW52X21wdTYwNTA6IGZpeCBpbnRlcnJ1cHQgc3Rh
dHVzIHJlYWQgZm9yIG9sZCBidWdneSBjaGlwcyIpCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMg
S2VtbmFkZSA8YW5kcmVhc0BrZW1uYWRlLmluZm8+Cj5KZWFuLUJhcHRpc3RlLAo+Cj5JZiB5b3Ug
aGF2ZSB0aW1lIHRvIGxvb2sgYXQgdGhpcyB0aGF0IHdvdWxkIGJlIGdyZWF0Lgo+Cj5XaGlsc3Qg
aGVyZSBJJ2xsIG5vdGUgdGhlIGRlZmluZXMgaW4gdGhpcyBkcml2ZXIgY291bGQgcmVhbGx5IGRv
IHdpdGggY29uc2lzdGVuY3kKPmltcHJvdmVtZW50cy4gwqBJJ2QgbGlrZSB0byBzZWUgR0VOTUFT
SygpIGFuZCBCSVQoKSB1c2VkIGV2ZXJ5d2hlcmUuCj5DdXJyZW50bHkgaXQncyBtb3N0bHkgdGhl
IHN0eWxlIHVzZWQgaW4gdGhpcyBwYXRjaCB3aXRoIGEgZmV3IGZpZWxkcyBpbgo+dGhlIG5ld2Vy
IHN0eWxlLiDCoAo+Cj5UaGFua3MKPgo+Sm9uYXRoYW4KCkhlbGxvIEpvbmF0aGFuLAoKc29ycnkg
Zm9yIHRoZSBsYXRlIHJlc3BvbnNlLiBUaGlzIGlzIGEgdmVyeSBvbGQgY2hpcCwgSSdtIHNvcnJ5
IEkgd29uJ3QgYmUKYWJsZSB0byBjaGVjayB0aGUgbW9kaWZpY2F0aW9uIG9uIG15IHNpZGUuCgpC
eSBsb29raW5nIGF0IGl0LCBpdCBzZWVtcyBjb3JyZWN0IGlmIGl0IGlzIGluZGVlZCBmaXhpbmcg
dGhlIGlzc3VlLiBJJ20KZ2l2aW5nIG15IGFja25vd2xlZGdlbWVudCB0byB0aGUgcGF0Y2guCgpB
Y2tlZC1ieTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0
ZGsuY29tPgoKVGhhbmtzLApKQgoKPgo+PiAtLS0KPj4gwqBkcml2ZXJzL2lpby9pbXUvaW52X21w
dTYwNTAvaW52X21wdV9jb3JlLmMgwqAgwqB8IDggKysrKysrKysKPj4gwqBkcml2ZXJzL2lpby9p
bXUvaW52X21wdTYwNTAvaW52X21wdV9paW8uaCDCoCDCoCB8IDIgKysKPj4gwqBkcml2ZXJzL2lp
by9pbXUvaW52X21wdTYwNTAvaW52X21wdV90cmlnZ2VyLmMgfCA1ICsrKystCj4+IMKgMyBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jIGIvZHJpdmVy
cy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jCj4+IGluZGV4IGIyZmExZjQ5NTdh
NWIuLjU3OTY4OTZkNTRjZDggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1
NjA1MC9pbnZfbXB1X2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAv
aW52X21wdV9jb3JlLmMKPj4gQEAgLTE5NDMsNiArMTk0MywxNCBAQCBpbnQgaW52X21wdV9jb3Jl
X3Byb2JlKHN0cnVjdCByZWdtYXAgKnJlZ21hcCwgaW50IGlycSwgY29uc3QgY2hhciAqbmFtZSwK
Pj4gwqAJCQlpcnFfdHlwZSk7Cj4+IMKgCQlyZXR1cm4gLUVJTlZBTDsKPj4gwqAJfQo+PiArCj4+
ICsJLyoKPj4gKwkgKiBBY2tpbmcgaW50ZXJydXB0cyBieSBzdGF0dXMgcmVnaXN0ZXIgZG9lcyBu
b3Qgd29yayByZWxpYWJseQo+PiArCSAqIGJ1dCBzZWVtIHRvIHdvcmsgd2hlbiB0aGlzIGJpdCBp
cyBzZXQuCj4+ICsJICovCj4+ICsJaWYgKHN0LT5jaGlwX3R5cGUgPT0gSU5WX01QVTkxNTApCj4+
ICsJCXN0LT5pcnFfbWFzayB8PSBJTlZfTVBVNjA1MF9JTlRfUkRfQ0xFQVI7Cj4+ICsKPj4gwqAJ
ZGV2aWNlX3NldF93YWtldXBfY2FwYWJsZShkZXYsIHRydWUpOwo+PiDCoAo+PiDCoAlzdC0+dmRk
X3N1cHBseSA9IGRldm1fcmVndWxhdG9yX2dldChkZXYsICJ2ZGQiKTsKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2lpby5oIGIvZHJpdmVycy9paW8v
aW11L2ludl9tcHU2MDUwL2ludl9tcHVfaWlvLmgKPj4gaW5kZXggMjExOTAxZjhiOGViNi4uNjIz
OWIxYTgwM2Y3NyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2lu
dl9tcHVfaWlvLmgKPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVf
aWlvLmgKPj4gQEAgLTM5MCw2ICszOTAsOCBAQCBzdHJ1Y3QgaW52X21wdTYwNTBfc3RhdGUgewo+
PiDCoC8qIGVuYWJsZSBsZXZlbCB0cmlnZ2VyaW5nICovCj4+IMKgI2RlZmluZSBJTlZfTVBVNjA1
MF9MQVRDSF9JTlRfRU4JMHgyMAo+PiDCoCNkZWZpbmUgSU5WX01QVTYwNTBfQklUX0JZUEFTU19F
TgkweDIKPj4gKy8qIGFsbG93IGFja2luZyBpbnRlcnJ1cHRzIGJ5IGFueSByZWdpc3RlciByZWFk
ICovCj4+ICsjZGVmaW5lIElOVl9NUFU2MDUwX0lOVF9SRF9DTEVBUgkweDEwCj4+IMKgCj4+IMKg
LyogQWxsb3dlZCB0aW1lc3RhbXAgcGVyaW9kIGppdHRlciBpbiBwZXJjZW50ICovCj4+IMKgI2Rl
ZmluZSBJTlZfTVBVNjA1MF9UU19QRVJJT0RfSklUVEVSCTQKPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X3RyaWdnZXIuYyBiL2RyaXZlcnMvaWlvL2lt
dS9pbnZfbXB1NjA1MC9pbnZfbXB1X3RyaWdnZXIuYwo+PiBpbmRleCAxMGE0NzMzNDIwNzU5Li4y
MmMxY2U2NmY5OWVlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAv
aW52X21wdV90cmlnZ2VyLmMKPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2lu
dl9tcHVfdHJpZ2dlci5jCj4+IEBAIC0yNDgsNyArMjQ4LDYgQEAgc3RhdGljIGlycXJldHVybl90
IGludl9tcHU2MDUwX2ludGVycnVwdF9oYW5kbGUoaW50IGlycSwgdm9pZCAqcCkKPj4gwqAJc3dp
dGNoIChzdC0+Y2hpcF90eXBlKSB7Cj4+IMKgCWNhc2UgSU5WX01QVTYwMDA6Cj4+IMKgCWNhc2Ug
SU5WX01QVTYwNTA6Cj4+IC0JY2FzZSBJTlZfTVBVOTE1MDoKPj4gwqAJCS8qCj4+IMKgCQkgKiBX
b00gaXMgbm90IHN1cHBvcnRlZCBhbmQgaW50ZXJydXB0IHN0YXR1cyByZWFkIHNlZW1zIHRvIGJl
IGJyb2tlbiBmb3IKPj4gwqAJCSAqIHNvbWUgY2hpcHMuIFNpbmNlIGRhdGEgcmVhZHkgaXMgdGhl
IG9ubHkgaW50ZXJydXB0LCBieXBhc3MgaW50ZXJydXB0Cj4+IEBAIC0yNTcsNiArMjU2LDEwIEBA
IHN0YXRpYyBpcnFyZXR1cm5fdCBpbnZfbXB1NjA1MF9pbnRlcnJ1cHRfaGFuZGxlKGludCBpcnEs
IHZvaWQgKnApCj4+IMKgCQl3b21fYml0cyA9IDA7Cj4+IMKgCQlpbnRfc3RhdHVzID0gSU5WX01Q
VTYwNTBfQklUX1JBV19EQVRBX1JEWV9JTlQ7Cj4+IMKgCQlnb3RvIGRhdGFfcmVhZHlfaW50ZXJy
dXB0Owo+PiArCWNhc2UgSU5WX01QVTkxNTA6Cj4+ICsJCS8qIElSUSBuZWVkcyB0byBiZSBhY2tl
ZCAqLwo+PiArCQl3b21fYml0cyA9IDA7Cj4+ICsJCWJyZWFrOwo+PiDCoAljYXNlIElOVl9NUFU2
NTAwOgo+PiDCoAljYXNlIElOVl9NUFU2NTE1Ogo+PiDCoAljYXNlIElOVl9NUFU2ODgwOgo+PiAK
Pgo+
