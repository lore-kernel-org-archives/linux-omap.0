Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A953921EC;
	Mon, 19 Oct 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394656; cv=fail; b=pJ1wrH7C89NjCq0YVMMdrFJ5PSCMT3VFOisN/dXNL8ZlwVIWe64DtjymBmHipbfb9HSR7OUPOrVFA3Gzxvtekh1UV3b60sxk+DlewpAt9nbq3nhDXjIPVlp5Ywu58P8H5S/n9lJT4MAsOKmjdTWN/nR6WKTKqEZdXHbhFS2oV2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394656; c=relaxed/simple;
	bh=ONTVKVEPRM6c2CnWWSFsGsTnvheefy2WzS/fYavKc6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eydbk2/I043gU+MJizUJV0IVTMZL1MqdzqGjONQzGvqtzjkaH/r+Xuyz3zlbNwBMTeJ8OMM6+8wixstWXYZZcTSoOSq9p0cKSTTVaiW9lZwH9SJysCzNK955pPRvuGmV1Wi/rIAv3YNlLTy9tYNYBq96Rj7jqgnVWPDKbptVPLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=phT9mRcq; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="phT9mRcq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szgjxbOBRh4kklpq/6rByGeoKXxvnBscUZRjadnoJ5bL8EcYu+f/aw65gQM28qSOZmB4hs69gg4RRoEseP4UdexMrb+Y8RdQBoKHMTqIlexRz7WFYnMaE2YeIE4cdMpD+4dnWW21Y0q25Bie74q/XifG5nkuxsj8mF9GFUv0E7GlgFkI8DzM746/44cCc6qOkKBdEaKAek4APl1ocH9HBATNf9SvC3jkxlqRX9pzV8/HWz0v2O/xpbzI++POh9d0ONVD2dJEb5xUdI+4eJi4xVuHNqv9IXDOXg7X5KzihacbSXItb4taEumOtseufNPBvGDG3uoaABkDRgg4uMUNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONTVKVEPRM6c2CnWWSFsGsTnvheefy2WzS/fYavKc6Y=;
 b=cesEqw5udiA10//PxwGnBLt+oPeEbCPVGtFcW0gzuklV11193qLH0D/kF4EHADShJeyFgz/dllqOR8g7x8xH1DEVEM3amQcTZ0Vo0tTUZSCauzejCPGKzfS7KIH3f+OqI6uFUp+JPpTnhtUlP5+z87Y/NLjtJSs2mr841ScwjR0LOBWe8tTmYekzlGbjZg6gbUDM8WMApvb1+FcVLH43RfB9OWeKkYHzIuq7tqszZdbR21KmVbVbRzGrQ1UWRefS3FuVs6+yxfEpeNXpce5bn1OU70aCgOvo2iFKzmqHti2w5zbmhuX2WsUNc71mV4cKjxabMbbyjCKfIRcmNB+gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONTVKVEPRM6c2CnWWSFsGsTnvheefy2WzS/fYavKc6Y=;
 b=phT9mRcq9Fh6ASelOyTE3/a5ELMGYmHSMdeSLlCnDpK0QxItJnR8YBTtoOBjglXiyyGEEEKe9rNVxoLdyJ2dq+4aeWJNRZx8rWFZDjRiqW150yl5+8XT8ujg/S43btuimEI2/JjT2PRQbkU3ZMSDXvxkk6tofKw33OPPNpOIaXu6lp3X+UaSba4z+goesrrd1+gXpIWZvokYfPG1uDDGKQb2XRLGArZ/dkALnVE5paWmtKR9xacyXpREZYjk+uGk4GGvf+5+xqCsqAu20qnW9/fSPxsPOhphyaRu3aNHxXRvaFLV1BRCheEniTqgPDtgOI63v48rV0YSZCpg7si1Fw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by MI3PR10MB067125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:24:11 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 07:24:11 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kmehltretter@gmail.com" <kmehltretter@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Thread-Topic: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Thread-Index: AQHdX5rUpogDvpk56UqJCQ/FPzTj+A==
Date: Mon, 19 Oct 2026 07:24:11 +0000
Message-ID: <dd75c9ecf9bca41c147b9d288e9f60efe8b1429b.camel@siemens.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
In-Reply-To: <20261019060430.33254-1-kmehltretter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|MI3PR10MB067125:EE_
x-ms-office365-filtering-correlation-id: 5c9ea42d-a89c-42d5-0ae9-08df2db1f898
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|11063799006|56012099006|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|55112099003|6133799003;
x-microsoft-antispam-message-info:
 Dt7x29ecDxePfnQbGZP+43PGPRko/uKhLVqNUVWl1la9vAnFHGC/ZLDgUptxg8W5HPCM9pUXRFaJmyJOI/4kNXpej54mJuhppm5LhIy/mGm5DKdpgwkRc0VtbWhrvbgGStHQifZiutb4pJEPS/IJjMTbAEJo+AT0+u6uJCxPCqgT2Cfp8s5w0yUvMOtZWyA4tVCVymiViTiHEa0u7TS3CSY+ryLtt3rCdqniEk/Bswya5CvpE12RF6gGvoe3H/BKNK9eDaKMwoOwvJs/gDxobjp0nU1yhF7Wb23LBDeXzLdFwYGmyPrRDPNv/rY0IaMZh7u6kPqVzjq4pGglwfFO9eBTXR95jzndEOPapPkB6hAzVQ/oGMFDNefcM51sIFyPyacuo9FbThEKomU6s2aTzp0KW4dECjbxilRjtlEDxqSfYJ8zNA5HJ/OskSbNF+iiyaGJ8Bwm2vhB4wrYO+TMIYwzomm1u2s04pJRH5zqautuZn9cJvFoT5e8XNzXcFsol86JcqcdfoCd7Cx8qzoRw9q10QRTS3vE09D7M22Py6f7/kJLz3cwpX8urYJsoD8oWs+3BfcUlkhxV40By85IsJjiIiQvUfE7F3MJ680jhudw+J1ALn2aqfq8+AzKMk2M3pHX/2VPvQ0BTqjSpTme8xLO9hRob+CIlYM78DcL/6s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(11063799006)(56012099006)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFJ3dGZ0OHZNTjN2eFIwZ1JDSGI3M1RNcG9tSzl1WmdjTHl5UUMxbWlraXBv?=
 =?utf-8?B?YlMzVHFhbjhtd2dzUzBDVlROdTRjazAvRTJIL0Z3M1NlZ2t1MkFSQ2kybDRs?=
 =?utf-8?B?c3JZN3llSGxubWFrTldleVRYcDE1Wkt3Y0V0azRSK3I1QVBhWm5WWVR1SVAv?=
 =?utf-8?B?bVBkdktoWEcxSSt2QjkySDc4K1JnV25Rd00wNXQveFVFYlNISXNEaHd3MEVL?=
 =?utf-8?B?S1B6SXhjVEh5OHg0dkdtZFFvdDFWTEYrUlBGWVZDVm5Cb0p2Qnp5RDRINzlL?=
 =?utf-8?B?U1V3YU94bGpNZ0pKalk1eVUvekx2RDhPOWRmK0lnc3FXS0orSzdEYjhBM2VG?=
 =?utf-8?B?RUVHUVE2ODg2VUNMbjY3M2V3R1dlR3E3R0Q1allmTE0vVVRTTFY4WVZoOHNM?=
 =?utf-8?B?Tlk3dTl1cis0SE51V3VPczJuTm4vdjJkamZ4WUc1RmNpZ0I0OFlYWHdLSU1n?=
 =?utf-8?B?YUZUU2w5WDcxT2RVRHY0K1FPdFhEekM4MytDZlNXRlUvTHdPelZTSW1kcFlr?=
 =?utf-8?B?V1ZIa0xlejFROHVOTTJocksvSC96ZWE4eTlaRzJzYTg0K0FsMFFNT2hqY0Ja?=
 =?utf-8?B?NXFSeXdsQktpNSt1S0c4dVBXL1g3dXNTYVlveHVSSVZyallrbUowT3ZVSTBk?=
 =?utf-8?B?VCsxaklSMWF5OGpHWFZUblVKUWtVQUI2Q0lPQ1g1WVNFdXI4U0kzRVViZ25k?=
 =?utf-8?B?VW1sVzJrQ3ZIa3c5eldHbVA3cXlLZ0tRSFJGRjJJZkt5djlaTndUejFjOUg4?=
 =?utf-8?B?MHpQTG9WajBFNGZrMEJ4SkZSUWhES2c3M2RieU9BaHdqNEdTMDZ6VUc2ZG9G?=
 =?utf-8?B?WjI3ekIyWEppTDU4eUtxdHlxMzZYR3ltTEJDY3ViZUEyQ1NYbnQrdlZRRlFX?=
 =?utf-8?B?ZlNkZDNlayttMTh6SFlhZDVRd3QzeTRkcFlWZDZkcmkyRTlsVDg3WTVkd3Jy?=
 =?utf-8?B?NFZVcVg3WmR3S1ZiOTVXOElFZE8wbE5FK0VzVkhNZXpaTWU5dzQ0TDBSTnNM?=
 =?utf-8?B?cmU2bkdKTnJLZnNLUXFiUDFreUJoYXA1SzhZWTg3QlY1Ly85bzVuSE1tY3lt?=
 =?utf-8?B?bklQVTVYcGFUODJQOFBJSituK0FRUWFPK3UvbVlVZWhyY2lsaG9oWER0d3JN?=
 =?utf-8?B?RGJRWEtWZ0lTUlRPZ1htMzJwM2NaNW5CR1B6ZDVVVWthVCtVc2kxTmFnTVpn?=
 =?utf-8?B?NzBKQ09XRFkzdHVKQUJjVTVyTnk1WFZNNkprWFN3ZWFIZTFsMDQ2UGNMUlNz?=
 =?utf-8?B?THZnNW43UGxEL29hRW9iRHdOSFpJaCtray9lMU9WZXR0U01lUHVYbCtWZGkr?=
 =?utf-8?B?aG8vVFlDbDU3TldGMmt0UzBTbWVtb1ZiWU1SQUlTd01rWnc5TC9xbk95UUtv?=
 =?utf-8?B?RmpwZXArcnB0dnZkU2pSNnFSdkRFTkJyTW5CMDFiQXFuUklZWnVsL3pPOW9v?=
 =?utf-8?B?TnBubnd6V25HY3J3SExBR2R6em02QTU1R21vLzZ2dXJqTVQ4Rk1MQzd3UlYv?=
 =?utf-8?B?eXNOZnZvVmZtVFMyNllTdmlQK0hpbEVmZXRNeS9SempSNEgvUU1IOEY5cVhW?=
 =?utf-8?B?LzVReWplbDVRbWJsZ2VzSnRJM0tnV1UrcHlsUXFBVDVsbzZ0b29HdWYwVUEw?=
 =?utf-8?B?RG1lU1lZMTFaWE45b0pmUXYvbVYrSWdia2gvWU4yL1FBdmM1S3Fub09Cak5R?=
 =?utf-8?B?WVA3WG5ONzZ2ZlNoNnpqT01EN0t2eitGcVBHeEhFNFpqN0c2aVZ5Vmg3dTlB?=
 =?utf-8?B?MTBWN2p3Zk5NdFRNbDVuN0JmZ2FuejJXdzJRNDA3dE42K0ZuWjBNbUF5UGJI?=
 =?utf-8?B?dlJ0WTVKS2o1cG1BOEdnS0FQL05ySjQ1N1AwVCtrZ2hUYlJ4bHJ6bnE3M2Ra?=
 =?utf-8?B?WDF1dXBYV1hCMUw0Tld3TThFQlp6MERmMDdHMk1SZEMwL0R6SEFFZG10NXcx?=
 =?utf-8?B?TjJIZm4yM2tQV1VwV0RreC9LY0VzWjBFY3Q5VTVQcjNQRno1NWtsTFMxRE9M?=
 =?utf-8?B?VHI5QzgzWDlMb2Jod29XbERnMmk3K05NUG5Db3RrS1FOdXZSUFlyZG5VMU1X?=
 =?utf-8?B?dmx5ejQvVllwTHBiRnRHZWhjTTd4U2FmMFhabEM3aXdyaWl2UXY3YmUrSk1X?=
 =?utf-8?B?YkZCaXFsL1lyU3YwUVpMZmd4UERlUklaQ1k0Z2U5aTViVWJsalpqVFNzNEUy?=
 =?utf-8?B?Q3VMNFFlakdNVEdieVhHQzBoU0VQeHI4WEphZXJONjIrQTU3T29aai9QSlJo?=
 =?utf-8?B?a0E4UjR3UDZJb2gybUEvbitjcm9LM0JMMlpnSWdzcW1Ia1Fla1AzOXVXWVMz?=
 =?utf-8?B?NFlvbUxYclRFMzJPRFo3Vm5pOHJ3L0NmSUJpV0s5WWZGU2xuQWY2eFQ3Qm16?=
 =?utf-8?Q?BpCDD8zSqmBdkw6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61005D830B607442A1519AF6299458CC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9ea42d-a89c-42d5-0ae9-08df2db1f898
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 07:24:11.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt34yInVHvDH0IxnEMGlRGnaYQMF/EmNBD6V1xoYFMrrxk8+FFSLjxbnHvrLqssCL+T9T4IDw6hHyy5gD//RzDGg12UypEi/7TmxPGviKyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB067125

SGkhDQoNCk9uIE1vbiwgMjAyNi0xMC0xOSBhdCAwODowNCArMDIwMCwgS2FybCBNZWhsdHJldHRl
ciB3cm90ZToNCj4gVGhlIGxlZ2FjeSBDUFNXIGRyaXZlciByZWdpc3RlcnMgaXRzIG5ldGRldnMg
YmVmb3JlIHJlcXVlc3RpbmcgSVJRcy4gSWYNCj4gYSBsYXRlciBJUlEgcmVxdWVzdCBmYWlscyBp
biBkdWFsLUVNQUMgbW9kZSwgdGhlIHByb2JlIGVycm9yIHBhdGgNCj4gdW5yZWdpc3RlcnMgb25s
eSB0aGUgcHJpbWFyeSBuZXRkZXYuIERldnJlcyB0aGVuIGNhbGxzIGZyZWVfbmV0ZGV2KCkgb24N
Cj4gdGhlIHN0aWxsLXJlZ2lzdGVyZWQgc2Vjb25kYXJ5IG5ldGRldiwgdHJpZ2dlcmluZyB0aGUg
cmVnX3N0YXRlIEJVR19PTi4NCj4gDQo+IE9uY2UgcmVnaXN0ZXJlZCwgZWl0aGVyIGludGVyZmFj
ZSBjYW4gcXVldWUgcnhfbW9kZV93b3JrIHRocm91Z2gNCj4gZGV2X3NldF9yeF9tb2RlKCkuIFRo
ZSBlcnJvciBwYXRoIGRvZXMgbm90IGRyYWluIHRoZSB3b3JrIGJlZm9yZSBkZXZyZXMNCj4gcmVs
ZWFzZXMgdGhlIG5ldGRldiBhbmQgaXRzIHByaXZhdGUgZGF0YSwgYWxsb3dpbmcgdGhlIHdvcmtl
ciB0byBhY2Nlc3MNCj4gZnJlZWQgbWVtb3J5Lg0KPiANCj4gVXNlIHRoZSBzYW1lIHBlci1wb3J0
IGNsZWFudXAgZm9yIHByb2JlIGZhaWx1cmUgYW5kIHJlbW92ZS4gVW5yZWdpc3Rlcg0KPiBlYWNo
IG5ldGRldiB3aG9zZSByZWdfc3RhdGUgaXMgTkVUUkVHX1JFR0lTVEVSRUQsIHRoZW4gZHJhaW4g
aXRzDQo+IHJ4X21vZGVfd29yay4gVGhlIHN0YXRlIGNoZWNrIGlzIG5lZWRlZCBiZWNhdXNlIGNw
c3dfcHJvYmVfZHVhbF9lbWFjKCkNCj4gc3RvcmVzIHRoZSBzZWNvbmRhcnkgcG9pbnRlciBiZWZv
cmUgcmVnaXN0ZXJfbmV0ZGV2KCkgc3VjY2VlZHMuDQo+IA0KPiBUaGUgd29ya3F1ZXVlIGxpZmV0
aW1lIGlzc3VlIHdhcyBmb3VuZCBkdXJpbmcgYW4gTExNLWFzc2lzdGVkIHJldmlldyBvZg0KPiB0
aGUgNi4xMi4xMTItcmMxIHN0YWJsZSBzZXJpZXMuIEluc3BlY3RpbmcgdGhlIHNhbWUgcGF0aCB0
aGVuIGV4cG9zZWQNCj4gdGhlIGR1YWwtRU1BQyBjbGVhbnVwIGJ1Zy4NCj4gDQo+IEFuIGluc3Ry
dW1lbnRlZCBLQVNBTiBBUk0ga2VybmVsIGFuZCBhIFFFTVUgQ1BTVyBwcm9iZSBzdHViIHJlcHJv
ZHVjZWQNCj4gYm90aCBmYWlsdXJlcyBieSBmb3JjaW5nIHRoZSBUWCBJUlEgcmVxdWVzdCB0byBy
ZXR1cm4gLUVCVVNZLiBOb3QgdGVzdGVkDQo+IG9uIHJlYWwgaGFyZHdhcmUuDQo+IA0KPiBGaXhl
czogMDcwZjljNjU4YTU5ICgibmV0OiBldGhlcm5ldDogdGk6IGNwc3c6IFB1c2ggdGhlIHJlcXVl
c3RfaXJxIGZ1bmN0aW9uIHRvIHRoZSBlbmQgb2YgcHJvYmUiKQ0KPiBGaXhlczogMGI4Yzg3OGQx
MTczICgibmV0OiBjcHN3OiBFeGVjdXRlIG5kb19zZXRfcnhfbW9kZSBjYWxsYmFjayBpbiBhIHdv
cmsgcXVldWUiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTog
TExNDQo+IFNpZ25lZC1vZmYtYnk6IEthcmwgTWVobHRyZXR0ZXIgPGttZWhsdHJldHRlckBnbWFp
bC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gdjI6DQo+IMKgIC0gZm9sZCB0aGUgdHdvIGZp
eGVzIGludG8gb25lIHBhdGNoIChKYWt1YikNCj4gwqAgLSBzaGFyZSByZWdpc3RlcmVkLXBvcnQg
Y2xlYW51cCBiZXR3ZWVuIHByb2JlIHVud2luZCBhbmQgcmVtb3ZlIChKYWt1YikNCj4gwqAgLSBj
aGVjayBORVRSRUdfUkVHSVNURVJFRCBpbnN0ZWFkIG9mIGFkZGluZyBhIGxvY2FsIGZsYWcgKEph
a3ViKQ0KPiDCoCAtIGFkZCB0aGUgcmVxdWVzdGVkIGRpc2NvdmVyeSBjb250ZXh0IChuZXRkZXYg
Ym90KQ0KPiDCoCAtIHJlYmFzZSBvbiBuZXQNCj4gDQo+IHYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvY292ZXIuMTc5MTAzNTc4OS5naXQua21laGx0cmV0dGVyQGdtYWlsLmNvbS8N
Cj4gDQo+IFRlc3RlZDoNCj4gwqAgLSBBUk0gVz0xIGNwc3cubyBidWlsZHMgd2l0aCBUSV9DUFNX
PXkgYW5kIFRJX0NQU1c9bQ0KPiDCoCAtIEtBU0FOIEFSTSBydW5zIHdpdGggYSBRRU1VIENQU1cg
cHJvYmUgc3R1Yi4gQSB0ZXN0IGhvb2sgaGVsZA0KPiDCoMKgwqAgcnhfbW9kZV93b3JrIHBlbmRp
bmcgd2hpbGUgdGhlIFRYIElSUSByZXF1ZXN0IGZhaWxlZCB3aXRoIC1FQlVTWS4NCj4gwqDCoMKg
IEJvdGggZmFpbHVyZXMgcmVwcm9kdWNlZCB3aXRob3V0IHRoZSBjb21iaW5lZCBmaXg7IHYyIGNv
bXBsZXRlZA0KPiDCoMKgwqAgc2luZ2xlLSBhbmQgZHVhbC1FTUFDIGNsZWFudXAgd2l0aG91dCBL
QVNBTiBvciBCVUcgcmVwb3J0cyBpbiB0d28NCj4gwqDCoMKgIHJ1bnMgcGVyIG1vZGUuDQo+IA0K
PiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2Nwc3cuYyB8IDMzICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90
aS9jcHN3LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9jcHN3LmMNCj4gaW5kZXggYWEzNTMx
ZTg0NGU4Ny4uMDEyOTZjMDU4MmJmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvdGkvY3Bzdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2Nwc3cuYw0KPiBA
QCAtMTUyNCw2ICsxNTI0LDIzIEBAIHN0YXRpYyBpbnQgY3Bzd19wcm9iZV9kdWFsX2VtYWMoc3Ry
dWN0IGNwc3dfcHJpdiAqcHJpdikNCj4gwqAJcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKgDQo+ICtz
dGF0aWMgdm9pZCBjcHN3X3VucmVnaXN0ZXJfcG9ydHMoc3RydWN0IGNwc3dfY29tbW9uICpjcHN3
KQ0KPiArew0KPiArCXN0cnVjdCBuZXRfZGV2aWNlICpuZGV2Ow0KPiArCXN0cnVjdCBjcHN3X3By
aXYgKnByaXY7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgY3Bzdy0+ZGF0
YS5zbGF2ZXM7IGkrKykgew0KPiArCQluZGV2ID0gY3Bzdy0+c2xhdmVzW2ldLm5kZXY7DQo+ICsJ
CWlmICghbmRldiB8fCBuZGV2LT5yZWdfc3RhdGUgIT0gTkVUUkVHX1JFR0lTVEVSRUQpDQo+ICsJ
CQljb250aW51ZTsNCj4gKw0KPiArCQlwcml2ID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ICsJCXVu
cmVnaXN0ZXJfbmV0ZGV2KG5kZXYpOw0KPiArCQlkaXNhYmxlX3dvcmtfc3luYygmcHJpdi0+cnhf
bW9kZV93b3JrKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBjcHN3X29mX210YWJsZVtdID0gew0KPiDCoAl7IC5jb21wYXRpYmxlID0gInRp
LGNwc3cifSwNCj4gwqAJeyAuY29tcGF0aWJsZSA9ICJ0aSxhbTMzNXgtY3BzdyJ9LA0KPiBAQCAt
MTc2NCw3ICsxNzgxLDcgQEAgc3RhdGljIGludCBjcHN3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+IMKgCXJldHVybiAwOw0KPiDCoA0KPiDCoGNsZWFuX3VucmVnaXN0ZXJf
bmV0ZGV2X3JldDoNCj4gLQl1bnJlZ2lzdGVyX25ldGRldihuZGV2KTsNCj4gKwljcHN3X3VucmVn
aXN0ZXJfcG9ydHMoY3Bzdyk7DQo+IMKgY2xlYW5fY3B0czoNCj4gwqAJY3B0c19yZWxlYXNlKGNw
c3ctPmNwdHMpOw0KPiDCoAljcGRtYV9jdGxyX2Rlc3Ryb3koY3Bzdy0+ZG1hKTsNCj4gQEAgLTE3
NzksOSArMTc5Niw3IEBAIHN0YXRpYyBpbnQgY3Bzd19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiDCoHN0YXRpYyB2b2lkIGNwc3dfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgY3Bzd19jb21tb24gKmNwc3cgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gLQlzdHJ1Y3QgbmV0X2RldmljZSAqbmRldjsNCj4g
LQlzdHJ1Y3QgY3Bzd19wcml2ICpwcml2Ow0KPiAtCWludCBpLCByZXQ7DQo+ICsJaW50IHJldDsN
Cj4gwqANCj4gwqAJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgmcGRldi0+ZGV2KTsN
Cj4gwqAJaWYgKHJldCA8IDApIHsNCj4gQEAgLTE3OTMsMTUgKzE4MDgsNyBAQCBzdGF0aWMgdm9p
ZCBjcHN3X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiDCoAkJcmV0dXJu
Ow0KPiDCoAl9DQo+IMKgDQo+IC0JZm9yIChpID0gMDsgaSA8IGNwc3ctPmRhdGEuc2xhdmVzOyBp
KyspIHsNCj4gLQkJbmRldiA9IGNwc3ctPnNsYXZlc1tpXS5uZGV2Ow0KPiAtCQlpZiAoIW5kZXYp
DQo+IC0JCQljb250aW51ZTsNCj4gLQ0KPiAtCQlwcml2ID0gbmV0ZGV2X3ByaXYobmRldik7DQo+
IC0JCXVucmVnaXN0ZXJfbmV0ZGV2KG5kZXYpOw0KPiAtCQlkaXNhYmxlX3dvcmtfc3luYygmcHJp
di0+cnhfbW9kZV93b3JrKTsNCj4gLQl9DQo+ICsJY3Bzd191bnJlZ2lzdGVyX3BvcnRzKGNwc3cp
Ow0KPiDCoA0KPiDCoAljcHRzX3JlbGVhc2UoY3Bzdy0+Y3B0cyk7DQo+IMKgCWNwZG1hX2N0bHJf
ZGVzdHJveShjcHN3LT5kbWEpOw0KPiANCj4gYmFzZS1jb21taXQ6IDdlYzQ4ZjM5NmExZDg5NTMy
YzA1MzdiYzM4YjQwOGI4YzMxZWUzN2YNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1l
bnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
