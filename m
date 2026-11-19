Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104739;
	b=cnVXaDnxO7sdSAw96GRv13wmSV8f/xvmFv8iDH3s5uplg8KUQTwMfPiWX5Vm4eMI8+c1
	 NOJjxwcdFdNoKn4awoJ6M0D1HmOE2c81Pntiuq3N5MDmCOeDBMrLNdSVfPB0Ef7LrdJ8e
	 xwlK8iz1mXvF0jiM6I0Oa5i2VTAivFXzzZVwPVDfxwOB8MwEssYbN3Qh+WLkkYsFdtYQW
	 yWYzp9DV+cYxa/zGyDpLPlOtL5K/bpvK0sVHM8QLFAZxQ6nrCrnUK19zaRJYO0XcWvsH2
	 8Aq5JQRyMkpGtjhaj3ael8Spl9aybh1qSZa+dAwDgFEUnLBd4gtAW9z1+XgqMK/m7FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104739;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ms+OUDdRD1+eJYfzojBmQLq4fqQkHAElg2cT3eHxjC0=;
	b=SnizlBBMH33uSfXTJfFRWeHiBWrEQEZJtkAdLprkids2flWvrD2YnvIf/1cipRoIeo34
	 6JxDIbYZOzF/hGnbkvCddmGPrKHDIcH4TzEI2kAulxMA250OHkhk0V6CJhj9AUSiOh5Fv
	 W58n9OS8lyKrP2Op2a17h9bmHo1M63iDK4hTgZCd7jhU83LymMGL371m0llw3mjEbsE5x
	 QoAfah9w6AuHJhtFnRT5pj2sEBm4XDbfXNH8eqbLQiuqaK2F0RMiVznroGi3RukjSLjSl
	 YMlRbNrhHhm/3oLv8GQRvHtg46jmj7InAkyRA5xvM4JfWArTukm5CqtnJNvyoYnPCCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pyFy3Eki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.53
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F99606A325;
	Thu, 19 Nov 2026 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F99606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pyFy3Eki
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiU72ACWBQnz21b2njvygFVsWYIvLFbSlym1x9c1Idpg6Qvj1ZEI7L6KsU5BWqscVdQaXT6c6/hNyS5yCD6m6cTydDyMAeJiPxtCknCJtrVaudHbn0cbwxLWZ8Z56WnU23jna4SdTFtWNHsY+Ds3msWK+iWU48i/4IiQ0bsI3A9ZNbKLPl/MYNmFP75KQ2o28PR7fVr2tQA80PrrK6a8yw5UYaMe0AV6/XTTugUNXsC7XQVrQycP2z1eQz1oRmsiCPokPHbPojQc9LMzEpghwEOTO/ZautlVR2zpjPVthwIQQDJr21hLtGPNcwjMEVaPP0BVR+M3iRo/6diK6v5AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms+OUDdRD1+eJYfzojBmQLq4fqQkHAElg2cT3eHxjC0=;
 b=slUCSy8MakRQYTbIct48FLFcXXsoKTWj1JM9SdyqgRJD8ofQ+75Z890o57Ynut5O+/dJKj4GW9Y7+n5DmAL1AVoLXH88wCy1y7CzwNHzm3OLDo3pnWiLBkrAsPtxi9lMMpp9s8msoUZAaaz3vTG4KVbj55DC6J7SbuCpZuZhkpZdhZ+8nDejgcqZVW8paCkiWUEdq8xsf7vTbDiVywSJnGCbRSJFntuxCYoafPGqcd6rr9LkKcc/gM3IQv92UR5I/4mCNXDDOAs8YuPRmO1IJgtYVjHWvBa276/jHjvAO3Tf+q/667mkCFMGm4SOCHAOxy9Ns6EjJkXYbWFaXuJXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms+OUDdRD1+eJYfzojBmQLq4fqQkHAElg2cT3eHxjC0=;
 b=pyFy3Eki2F5qQe/8gEOFXstOzgUfLMXbfGUrdxsSnHX2eK+8hUCLzVYO7V4hFMcoVLdmL1TMMBp/ZUJ5snMN7wMpaQw1CiNi7MYndghVkjuxebpW/JFdVlaQkZ0OnA4Q4CFDctv7mb5etuRNJbAsGS+RVulPx4bgyZDCnZ9cLLTS6i1xT2kJouNrN3KZ6+NrlSfPuZKcRE2sQK3KNNsOV8q0gEh/CgsTYAx/gFum3MNVcmGXaAjejZAF7oiCzQzhGaxV89xgeYe/EPYl1cZV/fdpplgyDLx47cSmGVteWpwwFOXLvhNZ7jyER1aac5wZMEYTGqFm3Dy5MBJnMTlcUw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 16:12:13 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0662.000; Thu, 19 Nov 2026
 16:12:13 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "diogo.ivo@bootlin.com" <diogo.ivo@bootlin.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"andreas@kemnade.info" <andreas@kemnade.info>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "tony@atomide.com" <tony@atomide.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 0/3] watchdog: omap: Preserve OMAP watchdog across boot to
 detect faulty boots
Thread-Topic: [PATCH 0/3] watchdog: omap: Preserve OMAP watchdog across boot
 to detect faulty boots
Thread-Index: AQHdeEC8OaaiEBeULkCqR8awCO8FYw==
Date: Thu, 19 Nov 2026 16:12:13 +0000
Message-ID: <a0ce41df99aeb47edc733733be54b9c0e9ead767.camel@siemens.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
	 <407b9420-0ec6-4d95-960b-633677edf760@roeck-us.net>
	 <14eb1c72-fab0-445a-82f2-5851a855f723@bootlin.com>
	 <f1adea74-8f87-4442-aa12-18536cabec3c@roeck-us.net>
In-Reply-To: <f1adea74-8f87-4442-aa12-18536cabec3c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9466:EE_
x-ms-office365-filtering-correlation-id: 54d390f6-a62b-4d82-9bf0-08df4657df7e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|22082099003|6133799003|55112099003|921020|56012099006|5023799004|4143699003|11063799006|10067099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261022075727099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info:
 fJLb9nXjcEsZil36HluMzvN3w7PT2wWNKlxrQYpZ7wSXVXW6YnWv/72BTp3ohl9IT3aJdoGy0bVbzLI4q6K3ALoOuaZz/YNzHL0YpB9taRDcDwUUPcxrx4aR6akUO0Rj20+kqMabNHa3s03orXmDoEGt+iHuAAqZIm8IoUyHqZhW5pkwVfxdoFo4TxPuaaQXPpL6ukFO7wjP/ALbww9S4GL4+a5vw24C5m84hesgTXqpupsgFndSoPLVfLanYpRr/GTpvqfY0wIpwjHMD7X4F1QPQCfPdhQgWcx2gzCIWIk2N63yCXJDvr+tgiFLYZG2SamkQi9cT1p70Y8XxkxqXruX/SryDXS0iqOp6BdeCXRLd9PwWVeD8qiE3+DfSmEePNifieD3q5Hjrzu7e1lJvE3P4taLZw0q94yjUwMnky3NYMO4ImEqScS3F+x0A4Ai7EZrDie23ZSrDi0dW9gF6ynQVjlTHQbSMT4Ec+b8xpxOcrHUqHlmKLfpcUTIYRkkJuhmYylbhWrbrakoNC3RYLVC8c9+qJPKCj85yd5t2PQWPiEMYsKBJydSZw5xCgGJltUWuVawadi7QhcnVIXKXUpFzwgErlvCZU5NMXdVEsaPrM/K/XqGZKz530HWTTFH7baVOFlExjK/I+nEeKcv+HfqhIdK3ZX+7miuZHGMDpIjWX/nVilwhMpLffehU8VW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(55112099003)(921020)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261026121527099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVNaREFKSlNNenpscmtPVUZqTVNnczNUYjZwZDFOU1RLK2Y5T1hVVTZuVDcz?=
 =?utf-8?B?cHZKQjZERkllZnJxMzhoYTdKN2FMeHYySnlCTjRtZ2tBWGt5RktOMm1XWDFs?=
 =?utf-8?B?Wmw0RUVBVHlucVNmc0tROGVHa1JsYXdWZ2FHRThMQ1FVOS9DRXBUYTBNSFhr?=
 =?utf-8?B?UFBsOW9EWDYrU1hwdFlqa0NBYndpWmZ5Yit6MUNod29COXFFNlE5QmRFRHl4?=
 =?utf-8?B?aEVOT1RqZFpPaTZPU05GQmlsZnFnSGFWQVZPeVVMNEpMK1ZWTmhnSE9tbitq?=
 =?utf-8?B?SGpNUGJnVHRNSGZOQ3BuTGRKZFBRUlZEVkxzOTR0cDVZU1lwRWtPcHpvSnBJ?=
 =?utf-8?B?L29uZ05LeVhUWVhkWExoa0V0WXVqLytJVTZ0NG1RZGthYyt1a2M4RjV6dE8v?=
 =?utf-8?B?SGhRSjdoT0F6WC9FZ2FtSzRRZ2FiZVpiQjJiNTU4TVpyRGFGLzlwLzAvTEln?=
 =?utf-8?B?bzFFeDRycHhqRkh6VnNKR2NZTWFGTlNxM0sxYlNGc3MwVWZJc0c2Y3E3L1BH?=
 =?utf-8?B?cXBiSlVZbnloSmhVa1ZCUUNzc2V5R2xJWGhVUjcza1Z3OVdXNzVzN21zdG9J?=
 =?utf-8?B?eDBROGxBVjNSMUE2TVIwcTJnR09sSnVmeEpoR2RCZ0ZxeVNWcVFRaXdzNlFr?=
 =?utf-8?B?S2d5Qk9vblRCNHJadE9DNWRjV3crL1kydDBmbFc5ZjYxTkJRVFJkRm5DUytR?=
 =?utf-8?B?NDlnU3M2WW44SUlFZUd5Si9LRXloS2I0NDBQMEdMOWlHZ3lOQ1pweWNMUC9E?=
 =?utf-8?B?dytOYXkwN1dZeitBUU0yUzhQTlM4L2k5eG9lalY4MXFQWlZmN25FODVUbzJR?=
 =?utf-8?B?Z3BtUkhVWlVqZ1ZzMkRkM0hjZExWNmVuZEZBaFlDQTNuMElYdzRVZFZYNUJw?=
 =?utf-8?B?T29HMVR4UUV6Vk5IQXZ6NHNvZ1A1STEyREVGdUduZnNpa1AyK0pXUjh5b2Ir?=
 =?utf-8?B?YWlGZXl1c25JaFpSU0R3bks2QlRvaFlwWGRUSmU1WmxzVTVtUktteWM4OEsz?=
 =?utf-8?B?MVdSdDlBNE93TFNKdnU1bklTNGJHSzU1RHA5bmxCdFp2dWd1ZGQyUEJHS3Mr?=
 =?utf-8?B?bWVyWjc4d0ZpVWptZnBWekwva3ZVN3IrQ1NnczY5bUJyOW1pU281K3kwTFFE?=
 =?utf-8?B?TmhYVlRQWjNwMmlHU0IraW1zVElDb1YwTkFhV2k3dHRiN1Q1L25IY2lpeDhm?=
 =?utf-8?B?MGxhRXA3T2Vua0VycUducGdGVCt4RG9sWVlreExPNXRHSzRaL0k0M096cU0r?=
 =?utf-8?B?aHlUU3dUN1E3Wk1hcTdCUGhtUzdvKzhRT0kxZ09BNW9VNU1qSTVqOG1tZkN2?=
 =?utf-8?B?MjVJQWxCVUpDbDVpQ2ZvK1AzdnpnNHNSMjN0UkNudGdVU3FQKzV5aVREbHlM?=
 =?utf-8?B?Ym1NWG5qbkorbTFIQ24vK2g2OGtoczVFTWNKN0xac2QrSHRMdlliMnMzSVQ0?=
 =?utf-8?B?ZVN0VkxFWHFiT0JwL1BZRi85Q3pNT3ZYcUhGMkIrc3NWYndwNk1lelAzbi82?=
 =?utf-8?B?Ym4vL2pDeWRxR29wSzAvT25velVkZ05LQ0JTcjRPUndUZS9BQW1GbnhpWDVa?=
 =?utf-8?B?ZmFLNWpscnBMcE4rZi9Kam0zdTN6K1R6dVVLV21Hck1HS2s2dEY0a2hPMDl0?=
 =?utf-8?B?UzQyWUpWYUlSb3JZY01JZUNXMnNLNFVGam90NmVCWHVyd3B2WjVDRTJKS21Q?=
 =?utf-8?B?Rko3dUU0ZDBqSkEvUDlUV2hHRlgzZkkvaFNZWTJCaXNIVTVEMUNzWEN6aUZO?=
 =?utf-8?B?NGtOUGhGOE4rT2diVDdUYk90alZIdzM4YWhxRElvS0dmY2UweFRmN1VBcE5p?=
 =?utf-8?B?NFk1eTJjdk9wL090Q2UxemN0T1BTZHhMNDlYUGo5bzhQd3BlRWo4U3R4QmZs?=
 =?utf-8?B?b3l6d1FHS2xBSlQ2QjFpTkZsSzBSMU1CL2VOQThMZ3dCY2o5T0dzNkpxVTFw?=
 =?utf-8?B?aFVyMDJJMFc5K0tsRDNXcTBxMFMyTEtpOE5CSklHWlNxR21WUXNzQytPNDlp?=
 =?utf-8?B?ZVV6V1I2V2JkTjBqci9HWXllTG1LRW11NkF5OE00SHR6WmZQditVR0d5RzBl?=
 =?utf-8?B?RDRuRTFCRklaaXByMzJIYitWbEhEWkI5NnY5em9ob2tobGtDcXJBTjdSak9Q?=
 =?utf-8?B?c1JVcDBGdWg4RU1nZkNIVHY4ZlU2NGpRQ05rNzMraFgvTUVieWJ6YTl6WEo5?=
 =?utf-8?B?ekFqYmN3UHNkdVpPNDhzaW1Yd0Zlc3RLczk1LytWTUdhLzVvMEp1ZStlVzZk?=
 =?utf-8?B?UE9VSGxGUFl4c1k4cWhEMlBaWHcrVlJPRWV5V2I0c0ZoMlhudnRoNDVuTWQy?=
 =?utf-8?B?Tm8veTB3RklsamYzekIwbTNMRHlQSkVPUlkwbk00alhKZ1FTdzV2bFBIanJ6?=
 =?utf-8?Q?cLj66lNQVbPRtxHl1eYvzAYZM2rXQ/Lq5Qm88N2rDDA1g?=
x-ms-exchange-antispam-messagedata-1:
 NqrYDOEeWRyvZE2T60682sl41QBhwYqbebdNY1YgQB1rJOVTw2R70ydi
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E7A7289C789B144989D57CD5E0E3EB6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d390f6-a62b-4d82-9bf0-08df4657df7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 16:12:13.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gysqvpJJ3RsTThdxRlv14NqNclH8dCQa4zZOljwDDcw1tFzYSRFy0ryVpia9l0+OaDPDZ92h2ad4dN+NzalYGAEemTHRF771XiZNX4x1Zt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9466

SGkgR3VlbnRlciwgRGlvZ28hDQoNCk9uIEZyaSwgMjAyNi0wOS0xMSBhdCAxMDoyNSAtMDcwMCwg
R3VlbnRlciBSb2VjayB3cm90ZToNCj4gPiA+ID4gQWxsb3cgdGhlIE9NQVAgd2F0Y2hkb2cgdG8g
c3Vydml2ZSBiZWluZyBzdG9wcGVkIG9uIGtlcm5lbCBpbml0aWFsaXphdGlvbg0KPiA+ID4gPiBz
byBpdCBjYW4gZGV0ZWN0IGEgZmF1bHR5IGJvb3QgaW4gY2FzZXMgd2hlcmUgdGhlIGJvb3Rsb2Fk
ZXIgbGVhdmVzIGl0DQo+ID4gPiA+IHJ1bm5pbmcgYW5kIHRoZSB3YXRjaGRvZyBkcml2ZXIgcGlj
a3MgaXQgdXAgZHVyaW5nIGtlcm5lbCBpbml0Lg0KPiA+ID4gPiANCj4gPiA+ID4gLSBQYXRjaCAx
IHJlbW92ZXMgYSBkdXBsaWNhdGUgb21hcF93ZHRfc3RhcnQoKSBjYWxsIGxlZnQgYmVoaW5kIGJ5
DQo+ID4gPiA+IGNkMDA0ZDgyOTlmMSAoIndhdGNoZG9nOiBGaXggT01BUCB3YXRjaGRvZyBlYXJs
eSBoYW5kbGluZyIpLiBUaGlzIGlzDQo+ID4gPiA+IHVucmVsYXRlZCB0byB0aGUgbWFpbiBnb2Fs
IG9mIHRoZSBzZXJpZXMgYW5kIGNhbiBiZSBwaWNrZWQgdXANCj4gPiA+ID4gaW5kZXBlbmRlbnRs
eS4NCj4gPiA+ID4gDQo+ID4gPiA+IC0gUGF0Y2ggMiBhZGRzIHN1cHBvcnQgZm9yIHJlYWRpbmcg
dGhlIHdhdGNoZG9nIGJvb3Qgc3RhdHVzLiBQcm9iZSBub3cNCj4gPiA+ID4gY2hlY2tzIHdoZXRo
ZXIgdGhlIHdhdGNoZG9nIGlzIGFscmVhZHkgcnVubmluZyBhbmQgdGFrZXMgaXQgb3ZlciBpbnN0
ZWFkDQo+ID4gPiA+IG9mIGJsaW5kbHkgc3RvcHBpbmcgaXQgYmFzZWQgb24gZWFybHlfZW5hYmxl
IGFsb25lLiBUaGlzIGludHJvZHVjZXMgYQ0KPiA+ID4gPiByZWdyZXNzaW9uIHBvc3NpYmlsaXR5
LCBleHBsYWluZWQgaW4gZGV0YWlsIGluIHRoZSBwYXRjaCdzIG1lc3NhZ2UuDQo+ID4gPiA+IA0K
PiA+ID4gPiAtIFBhdGNoIDMgbWFya3MgdGhlIE9NQVA0IHdhdGNoZG9nIG5vZGUgdGksbm8tcmVz
ZXQtb24taW5pdCBzbyB0aGUNCj4gPiA+ID4gdGktc3lzYyBkcml2ZXIgc3RvcHMgcmVzZXR0aW5n
IGl0LiBBIGRldGFpbGVkIGV4cGxhaW5hdGlvbiBvZiB3aHkgaXMNCj4gPiA+ID4gYWxzbyBwcm92
aWRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb2YgdGhlIHBhdGNoLg0KPiA+ID4gPiANCj4gPiA+
ID4gVGhpcyBzZXJpZXMgaGFzIGJlZW4gdGVzdGVkIG9uIGEgcGxhdGZvcm0gYmFzZWQgb24gdGhl
IFZBUi1TT00tT000NCBmcm9tDQo+ID4gPiA+IFZhcmlzY2l0ZSwgcnVubmluZyBhIFRJIE9NQVA0
NDYwIFNvQy4NCj4gPiA+ID4gDQo+ID4gPiBQbGVhc2UgYWRkcmVzcyB0aGUgaXNzdWVzIHJlcG9y
dGVkIGJ5IFNhc2hpa28sIG9yIGV4cGxhaW4gd2h5IHRoZXkgZG9uJ3QgYXBwbHkuDQo+ID4gDQo+
ID4gSSBoYXZlIGp1c3QgcmVwbGllZCB0byB0aGUgU2FzaGlrbyByZXZpZXdzIGJ1dCBJJ20gbm90
IHN1cmUgaWYgeW91IGdvdA0KPiA+IHRoZSByZXBsaWVzIGFzIFNhc2hpa28gZGlkIG5vdCBpbmNs
dWRlIHlvdXIgZS1tYWlsIGluIGl0cyByZXZpZXcuIElmIHlvdQ0KPiA+IGRpZCBub3QgcmVjZWl2
ZSB0aGVtIHBsZWFzZSBsZXQgbWUga25vdyBhbmQgSSBjYW4gcmVzZW5kIHRoZW0uIEluDQo+ID4g
YW55IGNhc2UgaWYgeW91IGNvdWxkIGdpdmUgeW91ciBvcGluaW9uIG9uIHRoZSBjb21tZW50cyBJ
IGxlZnQgb24gdGhlDQo+ID4gcGF0Y2hlcyBhYm91dCByZWdyZXNzaW9ucyB0aGF0IHdvdWxkIGJl
IGdyZWF0IGFzIEkgdGhpbmsgYWZ0ZXIgdGhlDQo+ID4gU2FzaGlrbyBwb2ludHMgYXJlIGFkZHJl
c3NlZCB0aGF0IGlzIHRoZSBtYWluIGJsb2NrZXIgZm9yIHRoaXMgc2VyaWVzLg0KPiA+IA0KPiBJ
IGRpZC4gSSBqdXN0IHdvbmRlciBpZiB0aGUgZWZmb3J0IGlzIHdvcnRoIHRoZSBwYWluIC8gY29z
dC4NCj4gDQo+IElzIHRoZXJlIGFuIGFjdHVhbCB1c2UgY2FzZSA/IElzIHRoZSBwcm9ibGVtIHlv
dSBhcmUgdHJ5aW5nIHRvIHNvbHZlDQo+IGEgcmVhbCBwcm9ibGVtLCBvciBhIHRoZW9yZXRpYyBv
bmUgPyBGb3IgZXhhbXBsZSwgdGhlIHBhdGNoZXMgaW1wb3NlDQo+IGEgaGFyZCBib290IGRlbGF5
IG9mIG1vcmUgdGhhbiAzMCBtcyBpbiBvbWFwX3dkdF9pc19ydW5uaW5nKCkuDQo+IEV2ZW4gdGhv
dWdoIHRoYXQgY291bGQgYmUgb3B0aW1pemVkICh0aGVyZSBpcyBubyByZWFzb24gdG8gd2FpdA0K
PiB0aGF0IGxvbmc7IHRoZSB2YWx1ZSBjb3VsZCBjaGFuZ2UgYSBtaWNyb3NlY29uZCBhZnRlciB0
aGUgZmlyc3QgcmVhZCksDQo+IGl0IGlzIG5ldmVydGhlbGVzcyBhIG1hbmRhdG9yeSBib290IGRl
bGF5Lg0KPiANCj4gQW5vdGhlciBjb25jZXJuIGlzIHRoZSBpbXBhY3QgYW5kIHBvdGVudGlhbCBz
aWRlIGVmZmVjdHMgb2Ygc2V0dGluZw0KPiB0aSxuby1yZXNldC1vbi1pbml0IChhbmQgdGhlIHBv
c3NpYmxlIGJvb3QgbG9vcCBjYXVzZSBieSBpdCBkdWUgdG8gdGhlIG9kZA0KPiAzMC1zZWNvbmQg
aW5pdCBkZWxheSkuIEFmdGVyIHRoaXMgY2hhbmdlLCBhIHJ1bm5pbmcgd2F0Y2hkb2cgaXMgbm8g
bG9uZ2VyDQo+IHN0b3BwZWQuIFdoYXQgaGFwcGVucyBvbiBzeXN0ZW1zIHdoaWNoIGRvIG5vdCBs
b2FkIHRoZSB3YXRjaGRvZyBhdCBhbGwNCj4gKGZvciBleGFtcGxlIGJlY2F1c2UgdGhlIGRyaXZl
ciB3YXMgbm90IGNvbmZpZ3VyZWQpID8gV2lsbCB0aGF0IGFsc28gY2F1c2UNCj4gYSBib290IGxv
b3Agb24gc3VjaCBzeXN0ZW1zID8NCj4gDQo+IFRoaXMgaXMganVzdCBhIGNvdXBsZSBvZiBwcm9i
bGVtcyBpbnRyb2R1Y2VkIGJ5IHRoaXMgc2VyaWVzLiBZb3UgYmV0dGVyIGhhdmUNCj4gYSB2ZXJ5
IGdvb2QgcmVhc29uIGZvciBpdCB0byB3YXJyYW50IGhhdmluZyB0byBkZWFsIHdpdGggdGhlIHBv
dGVudGlhbCBmYWxsb3V0Lg0KDQpJIGFjdHVhbGx5IGZpbmQgdGhlIHNlcmllcyBwcm9taXNpbmcv
dXNlZnVsIGFuZCB3aWxsIGJlIHRlc3RpbmcvcHJvdmlkaW5nDQpmZWVkYmFjayBvbiBpdC4gSSB0
aGluayBpdCdzIHRvbyBlYXJseSB0byB0aHJvdyBpdCBhd2F5ISA7LSkNClRoYW5rcyBmb3IgeW91
ciB3b3JrLCBEaW9nbyENCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K
