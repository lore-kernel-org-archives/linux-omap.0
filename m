Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315781;
	b=AuIxDC6EcxNrOrNWpNlMUQ/vRQiW7ZEmJjNdIbpoWgDRDFzIGyQ8WEY5fKVY29K2A1Hf
	 nnKfcIpyUVALdUGPdm4WXtVqySBN0yImcnb3Fj4e3D+9xKWunbKkBKsfOKv8iDyXz53CZ
	 CInz8JjxEe4ZAR8zywjkd6ag22G2PUlEDrnWALgeAJPywOXbRx3ynLNH2e7l+L7sDIC85
	 qyX3rgFIsdw0LZh+7PnVRP5u0ReqeKJDuDRlsGyYWWYvUklzyNtBmZtkkpbdy+iMO9O0e
	 NuGoYurV/BsEvGgHBE9IYA6x1pExtJyRGHfs6pYiba2KtGh6rSLdSzyQ2jgSnIWvxEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315781;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LjE1J6naeAj8vJcGg6lzhRg2C66DsZETx7e5PDHofgM=;
	b=C/OsgeTb6+wyhwnZCgaNQvvuJ69WadcEU601EtcJVNvC8jvvt3Brki+za7fb/OJyScHN
	 HHePXUrdmh1IsKaK8T4CUpHQFLNrOxRcQWl1i17+YnmhFDKl4kGiPN3ycPTaFnz4IC/32
	 jPzaOrCQj7T9ntwXzvToCU5SHJgxFThPTXAAMgkO0O+s4pzY0nSywKENotx193l91M4WP
	 uUyrZGBGvfW/E77rdcGy6K+Qykdxz27JKqOng1afMT4rUo6BYbzSj7dL3kJAJihqKsPgT
	 r8KgT6nbUgc/7Gsi5uGR5M15WGPZyAjrv3rtRWCPhv59aQ31q7soZLmaO6p0/ijthcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=tdYk4d6R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.8
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F30606A740;
	Tue, 10 Nov 2026 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51F30606A740
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=tdYk4d6R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt+dlNJOxs2kD+8tj5FHsDe0At/+jnGB/dk8C7OcTMLYhQ5H8DtT7I88ZdbIZDHi9z6O3cZzbKOTo0N21wmnf+rrOatUz9WdKt3gOaCK+tLMtIcSJgXGBN4Q0vff+tgkg3eeK5ZMdLZ8WD/lTVIMStvY3MtuOx5cH7Yz5ZIrRdQ2oZQ9DYXPtmH/gH1cMdyI62/kYVHhDwBwRC8BeTJiFgK8lka7KgH4cGoHFbHMPaoZIQjAaetUSz+uBDUT8quv70n1FCm0xfAKBn+eEWykGGpdiROPvEzzjUoxuohUzFzuY5v4G75kdEqBpZ5gk9om9uGmEKdLC6rUyPuXHhEpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjE1J6naeAj8vJcGg6lzhRg2C66DsZETx7e5PDHofgM=;
 b=PHrDJgbf0RGxnFOR1kjsS3laL1bwaV8ioRwcdtcTMPV0hjmPskpZQepWFRmUA6WrAJ/WM1hq5z4IGqm87f88beqW3i6U5+Q9D29KTaJR/6msZG9a/lP9bKDB7juw2fwaPIsGM+JFEdefjsqHMFY6v5qcbFnFqrEETVtHi7pni0gSAiS22HLKzlKKR11VpfGSzD1aOcQr8TcWA4QNZDwZCwDPyIqu/jotc+KB58nm2DpSHIttZOyZlv597ZzHDMJ39YoJ0JwqyFN4axjIhP4/Q8SQFG79sgI+oghX6+OmtW7mVQCNbSsLgi9QMV9hfeCzEZokEw72ZJvhDJw8/2Fhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjE1J6naeAj8vJcGg6lzhRg2C66DsZETx7e5PDHofgM=;
 b=tdYk4d6RUuak+yi+zLBBNNy2/KBs4Q1ghtTbrX8Ic4zUc7I8nAP+7k3Ur15PEjHDPguvutchdwNUWjefxbx3XKaBFH/mtG6FitIaBB6I6lzAsqvkhAdjsDTkMLUAzxHtZ2DljF1DODqSUH9i3m8B/b7Y1O0zxI0D69gsBfq3x7kD3MRTA1pKzfrOKP0YazlJDJyNfRD15vv8EaOw0yJhMPlwtB/c0mOzWT6UezSRNdRbBDlCVTeIAWu/fnS3s075E/Llrw10CVs8txHfMh7n49KBxp67hczOBIDlSh7seVW+JT0j9ZcPHis0ryokB+BkBaaExyBpaSW74VA8hnYzxQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB8748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 13:02:46 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0615.004; Tue, 10 Nov 2026
 13:02:46 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "1298662399@qq.com" <1298662399@qq.com>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2] gpio: omap: handle debounce clock preparation failure
Thread-Topic: [PATCH v2] gpio: omap: handle debounce clock preparation failure
Thread-Index: AQHdcFAj7tPXd0n+WEKB1bWexAlicLcnRu2A
Date: Tue, 10 Nov 2026 13:02:46 +0000
Message-ID: <1ccf55859a5a2df75587274f70c7ae591d5b4d1e.camel@siemens.com>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
	 <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
In-Reply-To: <tencent_D8A4B6EE90931660EB6F586543FD58110E06@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB8748:EE_
x-ms-office365-filtering-correlation-id: 5502bd06-8dec-4c48-ffd7-08df3f2aea88
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261009223027099003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|260925021311599003|56012099006|260925021911599003|4143699003|11063799006|261026121527099003|260925022911599003|10067099003|55112099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 Tv3T/YtIIy7r9om2TuFXhkaAlQhCXhIMj8BL0HBKQCA8pRt48S96rbxqRLmYMq45KCJjXmECcovCbF5nhowaAPqwkrGCg4ygL7FpKiYlEC+Xw9RCkwKg2yyVQVAyws1B/zdGLvuGYSO+5mWjOfIqQ/kGRi7wJCbc/iWQ8RFTsPMa3uAD/qIhv/NUkCD/F6q7gxK/+VFcKdNJHSos+tLpMei+UnnmVDlQkjS3ZWkrPHe/oJ3uiU85dzSYV69RGjZSrfQlpDPXE5Mhwnk1DA1gHZooOoroloh0xuKuw6oXdSXJL9l6jyxCV1EMnWt7mwpBeM5a2QQCDXCzzRqgZ6M/AIw6nm5SJE0bmtR/T9GgWgcoKVil3ER0rjN9J+SfeE/NZPRjb4n7VghmUByBwMmaJBdg9CUd0RvTopjHdPt6jtkA5PN5eB3qBlj5S6JM0z4zQgxerBeffUupNh1DoJ9RnLQWOMhXLYh1IvJ8MBpttEZcCO4bEzcD1ledSwoZP6JhOkXVB5zohZxAd3Gv7T1nc0v0j4IAfqcEwBXBTNJy4qPLNmQ4OfFB58FJGXj9JxKocEsN9Ps8L1NmwgXob2PGlePz1+KQdf3lul3tmG4ZbRZXXk6IDP+8uDiVTJdD2g/eX3Er7jCmN5HzNIXR+vyZqdAlguJrsQRa6JeXcEb2v+Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009223027099003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(260925021311599003)(56012099006)(260925021911599003)(4143699003)(11063799006)(261026121527099003)(260925022911599003)(10067099003)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXNpcEhpUWwrVmFIZ1dnalAxQjlIVmJMM0pSSlZMbEgxM2lJeWxRN0xkVHNw?=
 =?utf-8?B?YmNEdUxtdmVnenkxNSt0REhLSGpuQTd4eGlvT0Y5NmV6V2NvWXJHaVJBcU1L?=
 =?utf-8?B?UURTWWI2MW8ycEs0SkdXczk3cnRudGt3K01aZUtmb3dreHhVSHRNTEdZRjZ0?=
 =?utf-8?B?eHIrUDUzL2lUWGVhNXNtd1BZclZKWDhRakJteUFOT3IxcXRwMDFvMnhwY1px?=
 =?utf-8?B?YWdlbjJNK3lzcWp1U25rUG9rM2tYeVdDdEl3dzYwbExzenlPcWV1bkIrWGlv?=
 =?utf-8?B?ZWRtbXdLU3l0WWJZY2UxVE5MWS9Yam00WjNRY0M3RzU5Tit1ODFSc3RuMmhN?=
 =?utf-8?B?MklpU2U2T2ZtazUzYTVvdmNsMFdmdE14alJiQ3RCMUVLa0ZWa1JPMkdnTGNo?=
 =?utf-8?B?alFTSktXZnVwaGIzdll0VDZpVFdocmg5YjB4dUZ5b0pERy9PMUFSZGRERmor?=
 =?utf-8?B?bEVVcFlFNmNhQ0J2K25GWlppWHJFOVM4cUhQMGlHdlh2WkJHZno4Uy9DNms3?=
 =?utf-8?B?cnBjSFRnQ0szZ1lKN3g0VUQ5Qm5ENkhta1EyMENOdkdNNGJUd3JOTVdGdHQ3?=
 =?utf-8?B?UzFiWCtXcEt0U0VHeDJGVFhrcjJPcUgyTGpsME9pck1IdkRvZXN6Q29HOEdZ?=
 =?utf-8?B?VUZCalp0bjE4eHdsaDc5TXpxWWYzSVFQaHhUTnlVdTJaSzZMcWxrdVpVZHJV?=
 =?utf-8?B?NituR05KYzBMaGdPQWtUM0NwVDRRaWVzT0RoU1lzc3hPbFBmbGRodmkreDhy?=
 =?utf-8?B?bmRUZ1lmZXpLNGx2ckdrWVlLdkx4bU43NzF3Qmh0eDJ3VXZDSFdBdEdJMFlV?=
 =?utf-8?B?UGh0UVZuZDV5VGJaOEx0UHl2KysyTzhhZW5NR2tyUXBIanVZN2xQRkd3a21v?=
 =?utf-8?B?M0JRYVBWeWxFa3FWdkYrMk45QUtTTnVqN25zNk5RazVpV3ZKRElOb2RIdkNB?=
 =?utf-8?B?U3JtWEVhdnl0dHNQTDZ5dVRaZlpreXBYaGpxQ21oWjYvTnhEVDYyUWhtQWhD?=
 =?utf-8?B?NGtZelJHTnphZ2ltYW10b25zbTZqZDU4SWtaRDduMVlhWmFWWWx2WTR6Ykc1?=
 =?utf-8?B?cStGL04wUUx4b1BBUk1CaTl4R3BKM1g4RjdkV09DV3M1WGR0L1F0c1pzVVIz?=
 =?utf-8?B?aXRrb2VPQmJRTjJNM3FOMFo0alFKR3BmbTJWRTRWZkY3MXBjL0p3QlpNbzlu?=
 =?utf-8?B?K1MzNGwrUWIrTFF0MlBCVlZHSFNNR2JobUw0eWVDYzkxb1NSZld4a3o3ekkv?=
 =?utf-8?B?eDA4K0xiRzkrMUNyMUVsakpzSDB4cnN3NmJuVEZ6cWN2U2QzVXFnZUVKaTJF?=
 =?utf-8?B?bitHdFVMangwT1AxRnA2bjVvNnFDdXBrMXZKTXRGNkxhYUZkNU9JTWRKR2JU?=
 =?utf-8?B?S1F4c2YySWw4SjAvUkU0NVRGYUMzYWlyZDg1K2RYREpXdWh5a0R4YW1FNWNL?=
 =?utf-8?B?aTdhVHBaZFBXNkttT3JmN1REcnVGeWJzeVRGeGZSak9jdkprZUh6SGlBeTY0?=
 =?utf-8?B?YXh1TGt6Tlg0ZnU5MVNYWThmU3o5SStjbFp1N3lpMGJiWnRsV3prT0Z1eWgy?=
 =?utf-8?B?WTl4VXluZWUrTTJsQTd2czRyZUMrb1dKUzd6ZGNDOGZRRzA1N0gyV0duUm1j?=
 =?utf-8?B?MFdLVHhSeW5pdXh0WWhmeHdVN0NidFVjZUtuNWFXV2VnU0loWm1hUzlmdjc2?=
 =?utf-8?B?U3RzNzdPVkw2M1dDQnNwcjZMTFY5bG95RUpqQmUrbExzRE9qRVVsakJpZGNo?=
 =?utf-8?B?ZnRnSFpQS0RsUWNQeWdyYTJlcUtBa2Z6TFR2Tm1ENFRET3lNdzZKVTQ4Mmx1?=
 =?utf-8?B?ekllOFA3cnhVUytzY1lNa2hXZ1hIQW5RcHhxcXZxL1BycU9rWjZZMFJmeGZW?=
 =?utf-8?B?dStVSXZ2dTZaMW1mdnRnSlZVSkNwOS9BTC9jQ3cwOXorWSthNTZTVWxwTVFr?=
 =?utf-8?B?RzlodHRFQXpESlJCRitiZVoxV2xwQnE4bEtnTG5yOUFSUEtXUmpRK2huOFBI?=
 =?utf-8?B?QUlvWlUwQnlya1FaNTVQNVRScXpSSXBhUnR3Z1FpT1NsY3AxVjV1UWNoZGRJ?=
 =?utf-8?B?bHM0UTlhd1llNHRPaktSem5YSTVZWjZMeEVSd3M1VVJJazZTYTVmQ0htbTZX?=
 =?utf-8?B?dDhIQmlFOHdjUXJjdWhFRVRZVHpobDRHeDVabzFKcUdETmFkbjhzam1Pb2pE?=
 =?utf-8?B?M3NVeTNCT1lzRytDM0JFdytJc3cxcENERzF0ejJPWHBQRncxNXFJTjNyWkhR?=
 =?utf-8?B?ZlF0Q2UwUXpSRkZaVHdFcW52NFBMR1hmRzl5NWtybzk3a25pdnY1bVFZMTQ5?=
 =?utf-8?B?TkRiUm5xbHE5YUxMSU5nVklKWG4zS0JockVMOWJsMDFWTzNYakVUM3BiMXpX?=
 =?utf-8?Q?JuPcKIjIS3aHdraQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20B2826AA5F58949943FF0DD1DE61866@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5502bd06-8dec-4c48-ffd7-08df3f2aea88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 13:02:46.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7atj3xPZcU3gyznmpfgefh/xnikDlR+O8CShuBuHr53zWzeBEEibkcYjgguu6BudBGAqddHMcpJLSQxLiLwNgjxY1/lrKOZ+QlXeNZa724=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8748

SGkgSmlhd2VuLA0KDQp0aGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCg0KT24gTW9uLCAyMDI2LTEx
LTA5IGF0IDE3OjQyICswNDAwLCBKaWF3ZW4gTGl1IHdyb3RlOg0KPiBvbWFwX2dwaW9fcHJvYmUo
KSBpZ25vcmVzIHRoZSByZXR1cm4gdmFsdWUgb2YgY2xrX3ByZXBhcmUoKSBmb3IgdGhlDQo+IGRl
Ym91bmNlIGNsb2NrLiBJZiBwcmVwYXJhdGlvbiBmYWlscywgdGhlIGRyaXZlciBzdGlsbCB0cmVh
dHMgZGVib3VuY2UgYXMNCj4gYXZhaWxhYmxlIGFuZCBtYXkgdXNlIG9yIHVucHJlcGFyZSBhIGNs
b2NrIHRoYXQgd2FzIG5vdCBwcmVwYXJlZC4NCj4gDQo+IFVzZSBkZXZtX2Nsa19nZXRfcHJlcGFy
ZWQoKSBhbmQgZGlzYWJsZSBkZWJvdW5jZSBpZiB0aGUgY2xvY2sgY2Fubm90IGJlDQo+IG9idGFp
bmVkIG9yIHByZXBhcmVkLiBUaGlzIGtlZXBzIHRoZSBleGlzdGluZyBiZWhhdmlvciBmb3IgY2xv
Y2sgbG9va3VwDQo+IGZhaWx1cmVzLiBSZW1vdmUgYm90aCBtYW51YWwgY2xrX3VucHJlcGFyZSgp
IGNhbGxzIGJlY2F1c2UgdGhlIG1hbmFnZWQNCj4gY2xvY2sgaXMgcmVsZWFzZWQgb24gcHJvYmUg
ZmFpbHVyZSBhbmQgZGV2aWNlIHJlbW92YWwuDQoNClRoZSBkZXZlbG9wbWVudCBoaXN0b3J5IGJl
bG93IGNvdWxkIHByb2JhYmx5IGdvIGJlbG93ICItLS0iIHNvIHRoYXQNCml0IGRvZXNuJ3QgYXBw
ZWFyIGluIGdpdCBoaXN0b3J5Pw0KDQo+IEFuIGVhcmxpZXIgbWFuYWdlZC1jbG9jayBjb252ZXJz
aW9uIHdhcyBkcm9wcGVkIGFmdGVyIGEgcmVwb3J0ZWQgYm9vdA0KPiBmYWlsdXJlLiBBIGZvbGxv
dy11cCByZW1vdmluZyB0aGUgdHdvIG1hbnVhbCB1bnByZXBhcmUgY2FsbHMgd2FzIHJlcG9ydGVk
DQo+IHRvIHJlc3RvcmUgYm9vdC4gVGhpcyBjaGFuZ2UgYWxzbyByZW1vdmVzIHRob3NlIGNhbGxz
Lg0KPiBCdWlsdCBncGlvLW9tYXAubyB3aXRoIEFSTSBtdWx0aV92N19kZWZjb25maWcgYW5kIENs
YW5nIDE5OyB0aGUgY3VycmVudA0KPiBwYXRjaCBoYXMgbm90IGJlZW4gdGVzdGVkIG9uIE9NQVAg
aGFyZHdhcmUuDQo+IA0KPiBUaGUgb3JpZ2luYWwgcmVwb3J0IHdhcyBnZW5lcmF0ZWQgdXNpbmcg
Qk1DLUFnZW50OyBzb3VyY2UgcmV2aWV3IGFuZA0KPiBtYWludGFpbmVyIGZlZWRiYWNrIGluZm9y
bWVkIHRoaXMgcmV2aXNpb24uDQo+IA0KPiBGaXhlczogNWQ5NDUyZTdjNTJhICgiZ3Bpbzogb21h
cDogZml4IGNsa19wcmVwYXJlL3VucHJlcGFyZSB1c2FnZSIpDQo+IFN1Z2dlc3RlZC1ieTogQW5k
cmVhcyBLZW1uYWRlIDxhbmRyZWFzQGtlbW5hZGUuaW5mbz4NCj4gTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci90ZW5jZW50X0I0RjUwNDQ1Njc5MEU4QkEzQzRFQUI4MEY0QkZCNjk1NEUw
OEBxcS5jb20NCj4gTGluazogaHR0cHM6Ly9sa21sLnJlc2Nsb3VkLml1LmVkdS9oeXBlcm1haWwv
bGludXgva2VybmVsLzI0MTIuMi8wMDQxNC5odG1sDQo+IFNpZ25lZC1vZmYtYnk6IEppYXdlbiBM
aXUgPDEyOTg2NjIzOTlAcXEuY29tPg0KDQpvdGhlciB0aGFuIGFib3ZlLA0KUmV2aWV3ZWQtYnk6
IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQpU
aGUgcGF0Y2ggY2F1c2VzIG5vIHJlZ3Jlc3Npb24gb24gb3VyIEFNMzM1eCBIVyBkZXBsb3lpbmcg
Z3Bpby1vbWFwIGRyaXZlciwNClRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0g
VXNlIGRldm1fY2xrX2dldF9wcmVwYXJlZCgpIGFuZCByZW1vdmUgYm90aCBtYW51YWwgdW5wcmVw
YXJlIGNhbGxzLg0KPiAtIERpc2FibGUgZGVib3VuY2Ugb24gcHJlcGFyZSBmYWlsdXJlLCByZXRh
aW5pbmcgY2xvY2stZ2V0IGZhaWx1cmUgYmVoYXZpb3IuDQo+IC0gQWRkIHRoZSBGaXhlcyB0YWcg
YW5kIGRlc2NyaWJlIHRoZSBlYXJsaWVyIG1hbmFnZWQtY2xvY2sgYXR0ZW1wdC4NCj4gDQo+IEJ1
aWx0IHdpdGggQVJDSD1hcm0sIExMVk09LTE5LCBtdWx0aV92N19kZWZjb25maWcsIFc9MSBhbmQN
Cj4gQ09ORklHX0dQSU9fT01BUD15LiBObyBPTUFQIGhhcmR3YXJlIHRlc3Qgb3IgY3VycmVudCBy
ZXByb2R1Y2VyIGlzIGF2YWlsYWJsZS4NCj4gDQo+IMKgZHJpdmVycy9ncGlvL2dwaW8tb21hcC5j
IHwgMTAgKystLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW8tb21hcC5j
IGIvZHJpdmVycy9ncGlvL2dwaW8tb21hcC5jDQo+IGluZGV4IGE5NzM0YjJhMS4uMzE0YmJiNDhl
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwaW8vZ3Bpby1vbWFwLmMNCj4gKysrIGIvZHJpdmVy
cy9ncGlvL2dwaW8tb21hcC5jDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==
