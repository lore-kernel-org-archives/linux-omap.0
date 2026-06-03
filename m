Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291D13D51E;
	Wed,  3 Jun 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505927; cv=fail; b=oit8IZYyFdqCMMAW81esHNMnTKv7BHAboeMI9BniBXs7qlzAHsa3mEXA2xIidO76q0WSmofccc5j5epspv4Y00DXM/ewYZXpODLVWpYmpSU1r0MjNZMZC8lsqXIM7pDGSGy8P/fS3yOiST0YFU94CRuzkg6z1pnsKNz5wFak/VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505927; c=relaxed/simple;
	bh=suEu7vI96YV4BTGZ66JzdiogdESFYOo7SD1CiZnohyQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pE5wJI583SNvpxzD1oTwArghQ4A+OmMqG55K4Wp5XueABE8OGeCflU+C+fR+pFP6xFx5JDVBxMUmNQ4Qgzc3aoY2xbF+SLwXfpnxk8Dx7jOSD/GVj+qBIxnyOyh1MK1hT6fhqpa1OWPxRklVz1v9q7GpxfeeKo72UR2BNABY5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=REr3dxee; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="REr3dxee"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCgKAV1mvw/pmPLwJ+kJOyDSgJoaKiIM3ThIdTBa9t9ImoVJt8tKeFVImVD8Fe9/iD2p/OM4vlCBoQDvmDobgB8ioE+jv1B6KOOHSIehnPsc6WrYWZ916lKv0V3GY64kphR7thiLf7oszQk3G/feOpfb0v5faqykSIfB0YgpuchBYq4QaAsHTlmtHUOXIIv7QrhDkK6b8OGYi0RPRWjy6fZJk9f8rZAeZAOA0K2hMb6ehYNfUQJyXVBDITid2ZzNtCpwXUDCt1D5fQhTkAJzFf5pCX2A/ihjjQqmSEW5Z4hltm3aanxW/d0OO2E793Dc23lADfn2wylNuh2mkYttgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suEu7vI96YV4BTGZ66JzdiogdESFYOo7SD1CiZnohyQ=;
 b=fYs14tUnZuWgi1CEAX8T0C3cnbOWRh6loGFeQTcZOhEZXHPk1YPnXeVGM3ZhRN/Q69jNFbUGC8ILiG1/iFEETKcSIx4n+8AQvGT72+b7p1ovOFrpKSEDUVL5eLDAeDb5sVZH0rCopWTT8F1/UpaIhZWVmrGJtnycZFL5Urmz8z5EczFMoZcG/u+KC/huQdafgeq0tE2iQM/yzQ1Z5cgb/UCmHtbF99hwRilb2zWoy6C1tNvYgFjs8eeUFZfagv4S+VQoS1m7TYCX7A9u9qu0zb7J5nKyWTivRMDv6vTeB3KHMxmq1kbwMacBJUGSgI0twDRuuOctcLjRU9pxggmvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suEu7vI96YV4BTGZ66JzdiogdESFYOo7SD1CiZnohyQ=;
 b=REr3dxee8RS3BR58qckgD7mRMHX2kw5wA2EPQ6kQ9xYCzplmp54RtF+qBu5LnjkKKq4SkuqqnTZvOQsJc9YoIcOESeytPVd/LUlem8GYm+CttcWa33AKwLyOI1pgIg5jP8HvMJ/VIZySNb+EIyO3JiSRj9k17N5MEMvH6lg7tK5RtHUxjOtQTaPKlCPnAlwGUQXSOYg2Pduxs1/F1/bFIYWYWpQ+dVw8Wkx5HRI2V+VfI7qZawDPeP9wFSPHLV1EmhJS9givSZ4BixK1ZIyT4SKZklQI1tYjXEr3gfDqGenhFImCKP+lxfWJvygoSi1QTUJ8xuwOuwmlN1hvtXEKqg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB6935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:58:42 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 16:58:42 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "lgs201920130244@gmail.com" <lgs201920130244@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Thread-Topic: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Thread-Index: AQHc83o6sE1dn+0kzkKseXHUdpiwcA==
Date: Wed, 3 Jun 2026 16:58:42 +0000
Message-ID: <c835f4f16639eb47111aa64c2968193fb71957ad.camel@siemens.com>
References: <20260603140742.1398659-1-lgs201920130244@gmail.com>
In-Reply-To: <20260603140742.1398659-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB6935:EE_
x-ms-office365-filtering-correlation-id: 2e885647-f510-432a-acce-08dec1915dc8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|11063799006|18002099003|22082099003|3023799007|55112099003|38070700021;
x-microsoft-antispam-message-info:
 bEOo2neeJ7BzUwuBA14hAm5yqAjeueuOmFttIqNuKvoQ6rUB5+3pipN1KqRBK5MnDnnBlFX6hwDSgmMtv+OefTzkjGUl1LTlrlwb7ugWOTJkBk1viYRsFpEjLitL4V+2XGzGs9EdVDvJVRTFConW8j3Vc4olpHrGr15U89yPyMM3R5CeUB/JDPbeiiKZYzOm5hAVItlO1mcJtQULwWoLpW1PNZSmod9dsTW/Fx8+azztlzLpa3bhcujxiqMnWt9Bj4zrQKlXkD0DfgkOq+nVIQvshORLKayoEWNZ36uKo24eYtIqnwrAxQe/5aYeZQPqvqvEwrdTvh4yyMIh5oWbIzoarp0Mlcip39czrUisJ+7MwGAXjT3VQ6tQoXjKr4ah4fdG4QWTdlvg4l1wkc88JYbn5AOcwjL7AHDyiE6Yuew3Rzdb2Rxdl6GyhVpPV/UTYW+H6z4CSqjgh00O3eSPZkKlFCT3xICb5AOZjFsRTMDJFB0/aW4xK9kBg/y+f3gzUlwGXQz3Yy8X5L5a5cmNr5h773m09LW+mptXXgu6EmRT4m6DP7OK6Y7BajXSVvI8cR9kVFv8C/zMUwbk8RKvDjHUcNJ+E7k1WnHjok5oe7UkkOyeOpBz504KA9YYwkFDkk2cPeeYStgr1FKdXpPR+lDBi+KG/Q7eXRqemPVGeNPmpgaB+DAFwcdRqWjk1L6F5BH5ZzZOwmp5Sa6Mrm/Rpg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ulh5Q1JIcjdBRkZOelRiYkVtcGN1M1BQTnhRQWRGbVZVaFVNN011bHBmSkdE?=
 =?utf-8?B?bjZGVDFHZFlVbEdtWmZXK3d6T2FlZHUzeGovSmZNM0hFdjdHR2VOQ0JZQTNH?=
 =?utf-8?B?dUE1WEZ2Z2htRlhjMGhxcWRsL2UwZkxXZXhhMjJpd20xc2FBUkxuL0Y0N1BJ?=
 =?utf-8?B?U0V6U01Mc01KeXU3Y05xeDNIb1ViTzFrbVZ6dGVuVHNIWW1aa1FCZnlWMTd1?=
 =?utf-8?B?RkIwV2JvMFZyN3paNXQzRno1azFoam9xditGclI0a0lBQitneitPaGxiY21o?=
 =?utf-8?B?ZEhqSEphbHVTTkluU1VkK2hGR0Y2MlhoOFZTc21kbGJTeFlsd1EyREZhcSs3?=
 =?utf-8?B?Z1o5NkhOVGs5Znp4THFxd3c4UjFZQXZBOVRWVm1HVmc0SUNPUTZsQUd4K0Jw?=
 =?utf-8?B?TC9qTzJiTmxEdWVPZkw5ZW5Nd3M2MmdHMndVTTYzWE9DYzhITUVBeTJhaHpu?=
 =?utf-8?B?azJ5RW1KcHIvVnJ4S0UvY1U2MTNuWWxycm5XQ2NHUUlGQ3RtazIybzdScktm?=
 =?utf-8?B?dzM3RFJsMmlRL2xBVnZpeHd1V1lWRWVhQ2JGODBPei9RZFQxQmZRaVEzT3JC?=
 =?utf-8?B?TGlWemxOU3RwcnRpOTVlN3JnRldaYytIS1c4Qkt4Vld4UkxHNkNJam80V0xj?=
 =?utf-8?B?S09MYjlTNjRvY2xPVHdJeWxhcGlBMjRNc1BnZFpWc0U3RUxRam5jNnEva2dT?=
 =?utf-8?B?WVBXQnc0MndkZjdnVk1iZmhGRVFCZ1k2OFk0a1RIcmF1c3JGY21zNXNESUQv?=
 =?utf-8?B?VE1tQ2pORVpCQUpTVEs1SVVQVjNNYnRzU2p0dTZjNy8rUXVRdFVweEdYODZT?=
 =?utf-8?B?d2RrYUVoQXZSc3Y0R2VMN21UeXRqZU9EQU9OQUdDbktwRGRMdmQvRC9weGlw?=
 =?utf-8?B?dHBrTDRFRU8zNWx1eGIxZEljRWZTL2plSzViRktReE5UdDhEYnZCSGdmODU2?=
 =?utf-8?B?UDBwYi83V014NFFhRG9pQ1FjOTF6TkZDS3ZDZFhPLy9iZHByRGk1dW02Q0F4?=
 =?utf-8?B?dGRJSW51c0NJaFpON2s4azFHSHJqQ0JuUzJsYmovVDNmS25LcVJ1Nk0rVmdj?=
 =?utf-8?B?dXZJKzZKYTVjNmFrQUVXaHZLSUJwZng0enVZZ1ZpeFhuSjBRVEt2R1c3RHE2?=
 =?utf-8?B?ekFkOVpsTk9MdFVqQlJDMGk0SGxpSXAyREIwZlhqRlM5eXNYNm5paEppYllv?=
 =?utf-8?B?bFlJSHRuQ01QNkljVEtCMmZheGpDSDY4eVJVUnZtdGtsUjBjRERTOVVkZ3Zs?=
 =?utf-8?B?d0tIcVV3bUhGUEh5N3FCQVpSOXV1RlVobSt2bVNNZWxoMWFwazVZTGFoejJy?=
 =?utf-8?B?T29TazdmdWMvTnJJemJUWjYxUndqRlltWkxoQk0zdlBobGdzTlhMQ0E2Mm9P?=
 =?utf-8?B?RFNKQXhsUEFDZWt6L0ZuU29USmFsSFEraFpvOTJPemd4eXZPMGJRN29tZlVG?=
 =?utf-8?B?a2YxWHduV29sT0gwdkZZdW9pWlB2SnJsK01PekpBalRrTm5INVROUnRLVzll?=
 =?utf-8?B?RzVGZWgxK0k1WERGUjlsakZoaW83STRxU1ZybmF1QlpOR2gxTmt1TDlIVXcw?=
 =?utf-8?B?MXg3N1dLQVVOMXBoRlQrSit0NmF6dkFxdUx2Vi9jaUNuTFpSUm51Z3ZoNWh4?=
 =?utf-8?B?VkdkL0VBZ1lrdTh1Q3FnRytJZGFQSXROMEJhVFJ3WXVJVVI3amJtNVE4eEdm?=
 =?utf-8?B?VHI0ODR0dVVEZWVpUXBvMXdGR3pkNHNGalhqczI1UEZ0Rks3WmpmQ1Z4VkNJ?=
 =?utf-8?B?T0xqUTNrbkd4Z2thd3I0R1BqOUpVbTZPd2NBY3hleDN6VG02YWVFdXVQMjNT?=
 =?utf-8?B?dVRzUUhrNDRla3JNL2JRMStEYjdOeDdDbGtJSUFkVnh2QmRRYW9WOTl2YUo1?=
 =?utf-8?B?NXJsQStmODBZWDZ3WC9OaDV6RXZKcmYyaTJWQTVGMGhmSmY4eW1jbG5ReUZv?=
 =?utf-8?B?Tlo0WWpyZDVoTXMxemx5eEdVWlNBSUt6bjJRVC94T2MySjl3d0hGb041TXlE?=
 =?utf-8?B?ZnIrMlVCd01SbGZPZTF0SEZQYTE2cWJXY05NQlN0UjdTZmFwdkswQ3Vsekdz?=
 =?utf-8?B?UW1pYWVyeXhSZG1JM1luNmF0UDZWd2N0MHZud1F4R0xZMEZNeWgyb3draGhM?=
 =?utf-8?B?TVNGWG8zb2pqa1dVZ2swdmVJNVB4aEZmMVNWNlJVclZ0OXdIckNtQ2ZzNWUw?=
 =?utf-8?B?Szh0ZXFSL0JuZGozUHlqY1R2clQ2QkJnY1NCenFZcnZ3SEJ1aGdzL2YvK3Q4?=
 =?utf-8?B?aWs1VjVOamZhZUlXcyt1TFZ1ZGNTTFhBcC9OMUFpVEt5ZmZGL0R5ZjhtNVpM?=
 =?utf-8?B?TW9Xc0ZkMnNLbXNIS3ZvQUlwUTQ1dlVzTlNZQStrSTZHeU05YmlIZXpFUG5Q?=
 =?utf-8?Q?HjBeASxuAxWFlLcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1EC9BE22907FF4D846A5E711DC6413F@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e885647-f510-432a-acce-08dec1915dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 16:58:42.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/RPeZTj1aR9xOyWS39mCdKMIwhyZ7gvv6Qez5tMgF67oJKEju3jVaX1/AQ3B4TS5vuzMTcklpbAqhU8VJOB/WS6FYJhKeIC32Dk8QX8U74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6935

SGkgR3VhbmdzaHVvLA0KDQpPbiBXZWQsIDIwMjYtMDYtMDMgYXQgMjI6MDcgKzA4MDAsIEd1YW5n
c2h1byBMaSB3cm90ZToNCj4gY3Bzd19wcm9iZSgpIHJlZ2lzdGVycyBkZXZsaW5rIGJlZm9yZSBy
ZWdpc3RlcmluZyB0aGUgQ1BTVyBwb3J0cy4NCj4gDQo+IElmIGNwc3dfcmVnaXN0ZXJfcG9ydHMo
KSBmYWlscywgdGhlIGVycm9yIHBhdGggb25seSB1bnJlZ2lzdGVycyB0aGUNCj4gbm90aWZpZXJz
IGFuZCB0aGVuIHJlbGVhc2VzIHRoZSBsb3dlciBsZXZlbCByZXNvdXJjZXMuIEl0IGRvZXMgbm90
IHVuZG8NCj4gdGhlIHN1Y2Nlc3NmdWwgY3Bzd19yZWdpc3Rlcl9kZXZsaW5rKCkgY2FsbCwgbGVh
dmluZyB0aGUgZGV2bGluayBpbnN0YW5jZQ0KPiBhbmQgaXRzIHBhcmFtZXRlcnMgcmVnaXN0ZXJl
ZCBhZnRlciBwcm9iZSBoYXMgZmFpbGVkLg0KPiANCj4gQWRkIGEgZGV2bGluayBjbGVhbnVwIGxh
YmVsIGZvciB0aGUgcGF0aCB3aGVyZSBkZXZsaW5rIHJlZ2lzdHJhdGlvbiBoYXMNCj4gYWxyZWFk
eSBzdWNjZWVkZWQsIGFuZCB1c2UgaXQgd2hlbiBwb3J0IHJlZ2lzdHJhdGlvbiBmYWlscy4NCj4g
DQo+IEZpeGVzOiBlZDM1MjVlZGE0YzQgKCJuZXQ6IGV0aGVybmV0OiB0aTogaW50cm9kdWNlIGNw
c3cgc3dpdGNoZGV2IGJhc2VkIGRyaXZlciBwYXJ0IDEgLSBkdWFsLWVtYWMiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBHdWFuZ3NodW8gTGkgPGxnczIwMTkyMDEzMDI0NEBnbWFpbC5jb20+DQoNCnRoYW5r
cyBmb3IgdGhlIHBhdGNoISBBcGFydCBmcm9tIHRoZSBpc3N1ZSBBbmRyZXcgbWVudGlvbmVkLCB0
aGUgZml4IGl0c2VsZg0KbG9va3MgZ29vZCB0byBtZSwNCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRl
ciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDC
oGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2Nwc3dfbmV3LmMgfCA0ICsrKy0NCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvY3Bzd19uZXcuYyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3RpL2Nwc3dfbmV3LmMNCj4gaW5kZXggN2Y0MmY1OGE0YjAzLi45NWIzYjU4ZGI2ZTAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2Nwc3dfbmV3LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvY3Bzd19uZXcuYw0KPiBAQCAtMjA1MCw3ICsyMDUwLDcg
QEAgc3RhdGljIGludCBjcHN3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
IMKgDQo+IMKgCXJldCA9IGNwc3dfcmVnaXN0ZXJfcG9ydHMoY3Bzdyk7DQo+IMKgCWlmIChyZXQp
DQo+IC0JCWdvdG8gY2xlYW5fdW5yZWdpc3Rlcl9ub3RpZmllcnM7DQo+ICsJCWdvdG8gY2xlYW5f
dW5yZWdpc3Rlcl9kZXZsaW5rOw0KPiDCoA0KPiDCoAlkZXZfbm90aWNlKGRldiwgImluaXRpYWxp
emVkIChyZWdzICVwYSwgcG9vbCBzaXplICVkKSBod192ZXI6JTA4WCAlZC4lZCAoJWQpXG4iLA0K
PiDCoAkJwqDCoCAmc3NfcmVzLT5zdGFydCwgZGVzY3NfcG9vbF9zaXplLA0KPiBAQCAtMjA2Miw2
ICsyMDYyLDggQEAgc3RhdGljIGludCBjcHN3X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+IMKgDQo+IMKgCXJldHVybiAwOw0KPiDCoA0KPiArY2xlYW5fdW5yZWdpc3Rlcl9k
ZXZsaW5rOg0KPiArCWNwc3dfdW5yZWdpc3Rlcl9kZXZsaW5rKGNwc3cpOw0KPiDCoGNsZWFuX3Vu
cmVnaXN0ZXJfbm90aWZpZXJzOg0KPiDCoAljcHN3X3VucmVnaXN0ZXJfbm90aWZpZXJzKGNwc3cp
Ow0KPiDCoGNsZWFuX2NwdHM6DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==
