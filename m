Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512803;
	b=lmBC/+ldygPfgYnTrvP3VrVWdv6irq66yWYqOjj/Ii+KnFa6ROu1X6nyqhPngU/OhX2p
	 bhzZBRqEOP+hsuFcwHx8nzkKQSGHT9iZWDd1w/j3MdzCcHqDjRUzumxtjpSnIPBUnzHSR
	 1ohVl1EBER9X90p8bICWy0hi9JAsfVVqoH88T2dK22vj0w81bQij/aG5c4h4N6oO2puMg
	 AGa1TsUYx/wDb7E0uFU7v1N80YD+3yKqa+JA90sJxGUr9iZ1hN50qBIQxr66ilNOF9WhE
	 +9WAF/LdY3j8TItP7DNkobpZBuE9bfUe39P1bNH7RGKqj7tx159xOx6kZA4w00cKvEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512803;
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
	bh=NFcpTMH6ugx9odkFira+sH8dPyR1VBkwstiktUF9Ric=;
	b=mpTL5QZdq+0LAT+8CKkQNESI9VCH2vwoHMghRiMbh6C2R7gZ8YAHKDAGG1MhRuGE6zWx
	 9Hk51JCQ8jyls6FJiujzAwBOPJIBltfPqjCLCrY6gllWRSwcZ8WLo/Tj8wCuyfUefBgTb
	 zBPk9gQt6YRX8zogUgLaZJmslaWy5LxVjrmiYUnGDHGaOFw6FNypZfjrDc/ADLHsj5tXU
	 oukZRi7uAdRyFHatpWTGJinqHGT+GGzpMggdsMgKJ9gIJ61XUcHFzqzyjp0V3EhEgoIBT
	 zII2sBTcNlxK0HwG0gZQYVKYwMT6iSp2A7PCckB/8fFVVGJMeh4oXk08pT2dkiFwjGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="s/SKZKr2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFCA606A322;
	Tue, 24 Nov 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFCA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s/SKZKr2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPeSGoIu43GPgR435G8yd7cP/un37qFt2lxgKSJrOgPEqz068Vs2cKUGh2xESqWCvAwvjctkwx8nyMEvIw8vY7TOkU02d9xiWOzYdM9bGMGUPPnUZEKXm75Ku18nzxBZitjN/i1wmNAW99as1CQqw+yQLkhILKY1+nykaFXA83ZD/RkUXDw+Tx7HEZgma9MnpWgarbFPoWZtCgrB/fUvxJHm4HAMwEBm0Ayqn5ylhK7B7LuTaT8z0ZI2w21IvxJCNez/Lw/JenKSMhPzv7tqWL+EUO/pc8F8pvl+WJe6RdGG2zS0IAJ9oJ5dNzwNNux/RcYDlS0c6/AyWhfLC5/pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFcpTMH6ugx9odkFira+sH8dPyR1VBkwstiktUF9Ric=;
 b=H8ycsAkaaBqJC01rGNwXY9Y7znWooWvdyvB84vZrXJVRyjZdKFRUc/US+Fh0A70D+PJJ1n6dH5UXx397m5w5fjU5TyMnuZy3OzqPOChheUoBnxEzLHCai2j+p1KxyCRAWWkDuECQ9lqPE220k0s5TTGvM6+GCtjEO9bK/71OJBDTMsoAUL8R1g04ssVb7rrefL6okdkpiurDBJ2Ri1v9zS9a23beC042wcvNldzI7Lv7O4MCrhr/05wLP11uCNhZarMco0rMcYNt3YhEtw1JbQLiQaHL5nENsyRwHH3VWDBlODRwSpvKziD5OOfEi/issrsokkuoP+eEBT3NYbEoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFcpTMH6ugx9odkFira+sH8dPyR1VBkwstiktUF9Ric=;
 b=s/SKZKr2O5P2MD9Cbnj6+yxCVdXnQVxieVoBZqTcea8hX0ah3P6+Qg569yVfSQ7c4kPDl72PxVF/8n7+kSzSbhrCYaPambEupn0hUFXGaSCqCBDWz/zJHOkE/40ShvntaUNMyGfCN0KN9XRdOJdrBq4ukYQgP34eXR6BRn1brQKkoKKEuaKwuwSxbLngvtd8I6rrKvdZGawvlMQIwSm/wMymi4qDQ0GiZ/x1Uc/X+MH74jlxOPSFG+uC8fF9xDLqgRS0ieGYAa0r+5J7GSupFmVCdkVWCvqkSNzvOv5Eh+G8YfWhwVKPDwswKnPdGoiXrlDLaOXRolPhPH1JL40KwA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA2PR10MB9116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:33:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 09:33:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linusw@kernel.org" <linusw@kernel.org>, "ssantosh@kernel.org"
	<ssantosh@kernel.org>, "brgl@kernel.org" <brgl@kernel.org>,
	"khilman@kernel.org" <khilman@kernel.org>, "congnt264@gmail.com"
	<congnt264@gmail.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"1298662399@qq.com" <1298662399@qq.com>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>
Subject: Re: [PATCH] gpio: omap: do not unprepare the debounce clock twice on
 probe failure
Thread-Topic: [PATCH] gpio: omap: do not unprepare the debounce clock twice on
 probe failure
Thread-Index: AQHde/EsG6WNvpR5IEeHPXY4a4+eRbc89b2A
Date: Tue, 24 Nov 2026 09:33:09 +0000
Message-ID: <de693e03c94d53c97bcbcf1e0c2ac7067cb27a19.camel@siemens.com>
References: <20261124085231.3696739-1-congnt264@gmail.com>
In-Reply-To: <20261124085231.3696739-1-congnt264@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA2PR10MB9116:EE_
x-ms-office365-filtering-correlation-id: ed36a797-c3a2-4b50-44ab-08df4a0df3bc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|261026140227099003|261022105027099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|261021123027099003|55112099003|261009223027099003|22082099003;
x-microsoft-antispam-message-info:
 bj0h9VQLTvm/s+iS9Jd2MydSUBs84Aqtr1C7ZkDhdILdDDLaekA/gPDeNdpSvdHuhY6TJZRxi6WN+2yQftjjNFE1eRZVZm3/ao4YI14+gfzhpzXFi7iiBlZDP3UHgAUdIKP59KyUuW6eGlcwRx4oJ8teYyYAt0F1qsC8m6NTHTB1lMP8GJbdQ0N5FFBsE77pNB0G2znIeoe8mBpPllCfxG14WNNhE4G+F3QkLcQozH/soM1N18uHp1GujgJF1zPyI/iOxV3IVOOkCzwINXxzTil+YxikhuU/4C5PfPOXUDKIvGRz+zBgemipMFrxgOMnl+Gzwx6jHAt7rCHeRSH9OTmo+dFOrQgkiCCt9Xk2CtkfrzG8RhcR33BWchoddO5DH6SN81I8szH+4jh3750/sE6MjfTut9IHCSFACHjSg7kYsj3T7+/IycZ36KtPS/Jq7KRxAnl2H1fmJLJH03KwncTAeogie/fHQGvwdbWJnzp82R2M4eofFKGEFOj3ONcme3thxCwbnJdl2fKfhf13kw4Q0lInf50acPxB5pre5hH1isK9K76Dj4jbDd90l7hJdG9p32Yedp4n866vV7PWrrGshIqY4bCTCArZDFQErT3YjVi40c1OHoexjdbPMRsbTOKzSawxE82JUffw2sPOH9zrbJ0/r2UCWzvPxzlZW9s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(261021123027099003)(55112099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1IrQTFqRUtuZnk3VCtQTnRWaGJBQ0NxeldLU0lJdVVPWUNKdkgrWUVNRkgx?=
 =?utf-8?B?OWd6ajF4d29WbTNqckRJc2FBNkFVS0lkdmdoVmF3MXdxai9WZ1R5Z0lSMG9u?=
 =?utf-8?B?Y0lWTmdsa0JkbzVpWmFTSTkrNUc0MEZZWGZUZjVjOExwUmNINHorcWJ4WHd0?=
 =?utf-8?B?cmcydDhUbkRqNE1oK3JkbVJ6aDNDTW5iNHpZUUgwOXJRa3JFYjlkNnZSRXZL?=
 =?utf-8?B?Z3pMTUNWcXozSURaMEw3eGE5QjRJTm9SUktBd2FQd2FFN1lVNU55UEV2MlNO?=
 =?utf-8?B?aUZoNTJNNHFyN2tYN3Z2aWYxRllPekdFUUxMcWFTSUxqWWswUmVjeXkwUnBR?=
 =?utf-8?B?WWJTNGVXc2NSTytoejd0WGc3THhIaFFURUpITzhYSUJGakZPeWJWVEkvbXVM?=
 =?utf-8?B?aWsvYXBnVVJpREMwTGxLVENYSzRUclpRbW9VTXdvZUNMS1lDQ0FKR3VCRXFx?=
 =?utf-8?B?dUczV2NtRmV2V3k3VHNxZG1BSXFLRVdEMlRzbmx0YU9JbGM3NkRxa1ZzM1NB?=
 =?utf-8?B?ZkIwTGUveVdHYmFnbmNOMGlHZnA0OHZuMHdXZEZ2eVhBSmR0cUZKdU1ZSFMz?=
 =?utf-8?B?d0xBSUpJU05Ud2E5N1dxZG93Mkt3Q0txazIwNUNSbEkwbjMxNHhuWVBRQksr?=
 =?utf-8?B?UnBibHFVY2VHTVpxems1WTF4NlpaaUd5RDQzSFQ1OGQwaWdxUkt5SlFScnZR?=
 =?utf-8?B?MEwwaHMzcjhqZitJbmxvTUx5dWsydnNvMmd2YThOL29Ic1dlL25Kd1Q4V2U4?=
 =?utf-8?B?eEl4VWRLbk5pSTZpZE5ic0x0dDhFdmhDVEVmQjhSNVJrdnI4aG5yMTVSeU5D?=
 =?utf-8?B?d2Q0czRxV3F5dGZKN3N4ZTZkVllPcTNmZzJtbGc4OHlXdWJjZjNGRDZSMXF0?=
 =?utf-8?B?SStaV0huMmFWWTJydHd2cWNDdXlLWWlUYkQxc3BjYUhLYWo3UmJRamZ5eTNV?=
 =?utf-8?B?L0trVm94QXQ2U01RNkhXdjVxZEtqSmlsSlQyTnhwc1QwR3gzdWRqZXpIYit6?=
 =?utf-8?B?cVBVVVBHT29tOVplc1BNSUpyZE5tYTdwYzl1RVBDQ1ZVRk56RUFEVW52dHFJ?=
 =?utf-8?B?dzU0bThzaTN0UzE1alVoZE1DVDFLNTVxS2QxRWpYdDlpRHd0amlPcExMbVNo?=
 =?utf-8?B?M2lHTXFEaHNaRXVXbWM3SmpBcHc1aDBlaWJrR1dlQklYZllKZnhtN3ExMWtL?=
 =?utf-8?B?cDVBM1JLaGkyOEtCMGdqd01BdzI3MFVsQUEzN0JER2dTeXAzK2tJUkRJZ0da?=
 =?utf-8?B?NWE2N2NXVDE3L05NYjI1NmJQZzJXOXkrNUJ2MVJyOWRDb3hxdmEyMmw5ZEJI?=
 =?utf-8?B?OERBRnlydFc2VWtKYk83c3ZjR04wRE9SNUVqT1U1OFo2U2k0U3BZVHZ1TVNo?=
 =?utf-8?B?ZzNyRmIxVGo4bG1Ob25OZlhxZFY1YzhvRHVSRGtEUWVpRis0S1dOTVduamw4?=
 =?utf-8?B?S3NSR0VSMGdLeEY3UnBzbVFzQzJRT3lyREV6M2p5YmhQSWJ1ZmZoZ0VjT2E5?=
 =?utf-8?B?c0NJeVNGZXpXa0c3Y2hIcWlnL3BSS3F1czhsbDhVcG80K05SdHIwYmx2M0ZX?=
 =?utf-8?B?MllLcHM4NldwaFRnRlV6NnFGWFVNbGpic0lIYWcwY0Z6NlNxdkFoY2FPbFFI?=
 =?utf-8?B?V3NZTEI5by9mZHpCNExCaHJTQjEyM2NROUcrYzI2dm9sdDRUZGFYQ29IWDY0?=
 =?utf-8?B?TWwxL2VRdGtwQnp6ejhOMXVnNklLN3N4OWhDTm0zYnZYS1VQZnBId1hqQ2Fk?=
 =?utf-8?B?eElEWmhaZThYQXdSdi9IRi9mQmRqRnJTWitFTXA3V2RjY2xMTVR0cFNkTnBz?=
 =?utf-8?B?MU9jMG4wcllGRG1WWnJlc1JsZFRYek5HdUN6SFlmOVkxNUw1d2JtNnRVT0E2?=
 =?utf-8?B?ckNacEVvUDc2aFlUcnRwTktxbkNQdlVyMjhJNG1pWGZnR0NrRUQ3TkhZYXJy?=
 =?utf-8?B?UXBwb3ZQZEpRc0p3ajZiTmRsbzJVcGZ6QWNENUljVHJHL0JvL003NTluSmtI?=
 =?utf-8?B?OEx6aGtOQllBT3VSUnJBRVlyeGdhV0kydm40RHpEMnI0S3BKNSszS2lGL2g3?=
 =?utf-8?B?S0hNdnBYYVBRMXJIUmcyYjlnaXd0NTBmb3Y0anFoUStWN0dmVzRFRzJ2VHVz?=
 =?utf-8?B?VkJxYUd6R0dVNS9WN0lrMFU0UWhRaHZNYVR3ZWNLNEgrR1dBV2I4OWZWcjU2?=
 =?utf-8?B?WURXTkR2d3dFUG9aeE90VGcxcmxrZFlWdGFTQmc0SlQ3MzFVVjlESzlhYTAy?=
 =?utf-8?B?cGVmT3FMOGZzQ3lianJnMXU5eUM3TFVMaHRQR1RueHlTUytjUDlFMFJqT0F1?=
 =?utf-8?B?OFg2NHZjaDN6b2gzbmRoMS9idlRJSEp0OEkyeDBnNGVmWHZOYXYyNnRxb1Rz?=
 =?utf-8?Q?Gdvtb3E1yph+5UKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F61D41A9872460498F49CAFB20DB9654@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed36a797-c3a2-4b50-44ab-08df4a0df3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 09:33:09.3876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FP3bsR9soikxm03sb4qZBeP/py0mpEb8uYEAC1yWqrev4KivSkq9BiNJ7AWDsQFCR2aDQ+Yov55TDS/13qUICINzksfO73Yj2ZWh+kAXOwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9116

SGkgQ29uZywNCg0KdGhhbmtzIGZvciB0aGUgZml4IQ0KDQpPbiBUdWUsIDIwMjYtMTEtMjQgYXQg
MTU6NTIgKzA3MDAsIENvbmcgTmd1eWVuIHdyb3RlOg0KPiBUaGUgZGVib3VuY2UgY2xvY2sgaXMg
bm93IG9idGFpbmVkIHdpdGggZGV2bV9jbGtfZ2V0X3ByZXBhcmVkKCksIHNvDQo+IGRldnJlcyB1
bnByZXBhcmVzIGl0IHdoZW4gcHJvYmUgZmFpbHMgb3IgdGhlIGRldmljZSBpcyB1bmJvdW5kLiBU
aGUgZXJyb3INCj4gcGF0aCBhZGRlZCBmb3IgYSBmYWlsaW5nIHBtX3J1bnRpbWVfcmVzdW1lX2Fu
ZF9nZXQoKSBzdGlsbCBjYWxscw0KPiBjbGtfdW5wcmVwYXJlKCkgb24gdGhlIHNhbWUgY2xvY2sg
YnkgaGFuZC4NCj4gDQo+IFdoZW4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIGZhaWxzIGFu
ZCBhIGRlYm91bmNlIGNsb2NrIGlzIHByZXNlbnQsDQo+IHRoZSBjbG9jayBpcyB1bnByZXBhcmVk
IHR3aWNlLiBUaGUgc2Vjb25kIGNsa191bnByZXBhcmUoKSB3YXJucyB0aGF0IHRoZQ0KPiBjbG9j
ayBpcyBhbHJlYWR5IHVucHJlcGFyZWQuDQo+IA0KPiBEcm9wIHRoZSBtYW51YWwgY2xrX3VucHJl
cGFyZSgpLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgYXVkaXRpbmcgdGhlIGRyaXZl
ciB3aXRoIGFuIExMTSBjb2RpbmcgYXNzaXN0YW50Lg0KPiANCj4gRml4ZXM6IDlkZjk4MmYxZjI4
MyAoImdwaW86IG9tYXA6IGhhbmRsZSBkZWJvdW5jZSBjbG9jayBwcmVwYXJhdGlvbiBmYWlsdXJl
IikNCj4gU2lnbmVkLW9mZi1ieTogQ29uZyBOZ3V5ZW4gPGNvbmdudDI2NEBnbWFpbC5jb20+DQoN
Cmxvb2tzIGNvcnJlY3QgdG8gbWUsDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxh
bGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCkxvb2tzIGxpa2UgdGhlIGlzc3VlIGNy
ZXB0IGluIGJlY2F1c2Ugb2YgdGhlIHRpZ2h0IG1lcmdlcyBvZg0KMDViZTFhOTlkNmQ2OCAoImdw
aW86IG9tYXA6IFByb3BhZ2F0ZSBydW50aW1lIFBNIGZhaWx1cmVzIGluIHByb2JlIGFuZCByZXF1
ZXN0IiksDQpwcmVzZW50IGluIHY3LjQtcmMzIChuZXh0LTIwMjYxMTA0KSBhbmQgdGhlIGZvbGxv
d2luZyBtZXJnZSBvZiA5ZGY5ODJmMWYyODMNCigiZ3Bpbzogb21hcDogaGFuZGxlIGRlYm91bmNl
IGNsb2NrIHByZXBhcmF0aW9uIGZhaWx1cmUiKSBpbnRvIG5leHQtMjAyNjExMTksDQp3aGljaCB3
YXNuJ3QgYmFzZWQgb24gYXQgbGVhc3QgdjcuNC1yYzMuDQoNCj4gLS0tDQo+IMKgZHJpdmVycy9n
cGlvL2dwaW8tb21hcC5jIHwgMiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLW9tYXAuYyBiL2RyaXZlcnMv
Z3Bpby9ncGlvLW9tYXAuYw0KPiBpbmRleCAwZGE2MjhhZTc3YmUuLjBhZjI2YzNmNzE5NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tb21hcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3Bp
by9ncGlvLW9tYXAuYw0KPiBAQCAtMTQ2Myw4ICsxNDYzLDYgQEAgc3RhdGljIGludCBvbWFwX2dw
aW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gwqAJcmV0ID0gcG1fcnVu
dGltZV9yZXN1bWVfYW5kX2dldChkZXYpOw0KPiDCoAlpZiAocmV0IDwgMCkgew0KPiDCoAkJcG1f
cnVudGltZV9kaXNhYmxlKGRldik7DQo+IC0JCWlmIChiYW5rLT5kYmNrX2ZsYWcpDQo+IC0JCQlj
bGtfdW5wcmVwYXJlKGJhbmstPmRiY2spOw0KPiDCoAkJcmV0dXJuIHJldDsNCj4gwqAJfQ0KPiDC
oA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29t
DQo=
