Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793797151;
	b=xcOnW2cbpFcy44T6zYGFvRUdwJ+OtCojNiMtPffB32R49hHsCCEqMzEU+nx51LZRk5NQ
	 tEpoJ3ePlXJ88nU2kYsltwTbp3Jn7nQFoClCewds1emma8/udMC25mQv4uqMi+ht7D7zg
	 IN4IY+ysqU/DSdx/TkWg/AjXOrYDx0n4e7ZTZhbY10UrCDoMwWVCHgmi9Ab9w+ZQDP1GN
	 +jL17ZpfQaSoCuPdBtWBpcsQCj6pB21ZZDU5KDKCC8j3J6jg6iMz+JndOY2L13QHMXERU
	 bH1S4So1NsJEGmjCM3kWUSGmQHJgLlWRPKBtgaq8XJCFW7CBEpcDBFLtVpc+LoUQG5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797151;
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
	bh=0yHIas0wfepQ69KFdnkQ6twZgBi8QUptLrjjnr5W/HY=;
	b=Dgy+I2dkpmVCzkmXrpZBIaZ4CcjeEu81JcVJnJCfxBJhM1+ysx0E4HwXN8WpafHhhq5J
	 eOh2LHrJ01FBfnRvepPra9VZMPfolTjS6i+MohnzPynAILJavzRO3Rc5Jt79CvlZfG3PP
	 ili1K+EApCRve2tbDdP2saRZTuFUA9uigReZCApcN6jsVvhKJiyYn7/O4Eqlmk6yjH4f8
	 3h59QSu6raL4S7PCtEyCgTnlqzMkN3vmOeS7hHOb4RRkVraD4GtXJAg2epPBae2DMQ8NA
	 jtnQ4by/r1J/tUqDsu2K8sL2kpnFSexugr/fgJz4VbrH5COnLOfOezED7kxBz7rgV2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=BTlhQzIb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.48
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FB606A31B;
	Wed,  4 Nov 2026 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=BTlhQzIb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyfyNrQhZRWn6efr9akVTUzahJJ10LamaM6/ttgmZ8SPwXZaYAvC7OflNRAO886NDPQyNm1hKAq2NTEGebjkrDQxKPNv+TGjdNSiN3H3JeTGH1sOhlixo+4wHB/zD7UG8iUOSVsI+Xz0m3fRl+lZPn8AHhyXMAx14cabE7VtdgPONyLHoFkBbe/RaGwTmOn2d7U0hqEvKhjJKqWRoLkVjRSJ4fPAiKyy3c7mLUIAQNMKk55ENbGCdNzWwowlGQknd54/3N3iwyw5QeUmYilk6KE5UUJeLDOxwkxR2M7m7cLnXSOjMCXzRA7cahoEJ0q+KyPGFJFv+yyBRffX8gn5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yHIas0wfepQ69KFdnkQ6twZgBi8QUptLrjjnr5W/HY=;
 b=HOrMNFcWoky87w8Z3Up/wXQskMPUbN4LOo9b+F3aWDsAhYASD4fyuVp5yEfepRq6+bzueJlaAwy/cqhdCDGaK0nycD3FAiQkunZRIn7LX6n9hUniCmBxQJCB02+yeICwddZ2D9Nv8T1G6Ky/Yyzca0WxXJTlp++JNJTeMQdlM55opSlRUTX6wuY06D9jh6Euda5zJ84oeMy/odulMn1jcfJNwEiyCRIZ502LMZ5zBYs12jiHDszXuPbzDeWcmAGz+PuMPPt5HLDZ97wqIJgirZ12/H65JB7UjAx2/843vooJ5cJ2yCenUj0ha2PIq+z14KLIY8ZrLO3I5thpr9suig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yHIas0wfepQ69KFdnkQ6twZgBi8QUptLrjjnr5W/HY=;
 b=BTlhQzIbKCxVNbLYNY4D/gpuEwQWlvkJJ4SJ/HRNDUKHIoSynQAcD6p0g6XNyIWfVC2fM325uOhVVQDznIOJwDXd3z21wNcMkISFAkTD58LDvFGd5BFS67XE6pNahsKj0HW1QA3JGsVwSohx1EbFEf2vJfEjtL58PZaAkMQMrzvdWzNBaN+u6UOf3dGPPQma99t57LPSXu/e4x/q2gAZEAkNPjOaKafQsYzQJ8f0aTPxDNZSVZXKVWhPctLLkbMBAHjmOw+0tdMZFvPtB6R9F9HyEZhUwxV9GuL+gn75kCbRjboReLYYU2t6SOqcCCZLB9WZWl9d7j7ROcZkMCVJdg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVUPR10MB9702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:360::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 12:59:07 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:59:06 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linusw@kernel.org" <linusw@kernel.org>
CC: "tony@atomide.com" <tony@atomide.com>, "haojian.zhuang@linaro.org"
	<haojian.zhuang@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nm@ti.com" <nm@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>
Subject: Re: [PATCH 0/2] pinctrl: fix group/function table leaks on consumer
 re-probe
Thread-Topic: [PATCH 0/2] pinctrl: fix group/function table leaks on consumer
 re-probe
Thread-Index: AQHdUYIuyH0ImFI6Z0+/+TURXnpPprceDY4AgAAH+QA=
Date: Wed, 4 Nov 2026 12:59:06 +0000
Message-ID: <7af1eb9dd56daef2c714362160fa23873779b2d1.camel@siemens.com>
References: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
	 <CAD++jLn8yxh3LmUzbb2vZfJFJB=_mCZ+VeQhnZktfmuMiv5uEg@mail.gmail.com>
In-Reply-To:
 <CAD++jLn8yxh3LmUzbb2vZfJFJB=_mCZ+VeQhnZktfmuMiv5uEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVUPR10MB9702:EE_
x-ms-office365-filtering-correlation-id: 0a4d9438-e6f6-41b1-0108-08df3a7368fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|261021121427099003|4143699003|261021123027099003|56012099006|261026121527099003|261028144727099003|11063799006|261022105027099003|261026140227099003|10067099003|261102123227099003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 mopRqPRD1OcPjAuTmf+c8RATvGJPNq/aaoRZj1lC82HiIoIt7zl2/czrhJD6DkCWuK6imHbKIwt2T90oAhxYAMDyx5DboWdBGs2UY99BgzES4/k7fFnanyTSEvY7WRgIDMvOLM0Ai/q+T0AQv2eLZVROEHD96hFjOBuQH6XVjQKr36gDSzelRhUbrtgjIelp3TNDrnuQWbpkibidjG9mRGvOcLS/mxE6OZpopW6c/5QOg+mbI1fD85QI6Tt4jnOhnLKDkKtAt4PH90m8V95Iu/tYyN19usbDTvc3k5OcZW+9iR2eJws37asWqq2tq1GoH+CCOcpWyati4br84LTNrcE/xt5zZROiF5JC7qyfjfMkBO91m4wShwc7YgBLQV4/RZZ8s6jAMwzm3ePrlD9BQK9vRTTVcd6X03b/JhuBN7bOFNXVTULAHPgjkzlCh7rOezaqGCF9J3o/gAKxxSpBiXMp0jnxg5YDlX5VcmEd+3ZnLeRRvZVDsbdMGQPAS1OhixwZbZSl3DMg9uXGvKbRaKaRYugPWOpDCBDWUVLXhah8DoOs8m+TQUnaJ7ZPuZrCePIB4EoJFUMybyww4EW5Vwo49hs3gAdnTjAbw+morUgAzBKnhj3G4gIeaOS8HMxF/uAcaySsTEbQXljnxyD1dhvXxolJI9nofZqVpZ/YA6I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(261021121427099003)(4143699003)(261021123027099003)(56012099006)(261026121527099003)(261028144727099003)(11063799006)(261022105027099003)(261026140227099003)(10067099003)(261102123227099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkxyN28wa28yUUNsNGxsZlp0WU9yUmZBZVg5REkvbG5tRlVXRmVhQkxBOUpM?=
 =?utf-8?B?dVZ2MkhRaDhGM2NJTGo4L1M5b0NWTzFTMzJmM0FlUEJjRWd1Y2JUclpXampJ?=
 =?utf-8?B?c0g3UU0rUXYraDVraGxBbXlLU3orSy9Bd1pITW12S0VuV0dtaEIwVHB5TFUr?=
 =?utf-8?B?VnZta2x0eTk5Z29nSTNqSzIwbXZwaTBIRWRJSnd2bU5Xa0g1MWMvYjVIWHVj?=
 =?utf-8?B?ek5CdkdaQytnMm1OOTNkMWU0OUZkMTRyZUxTSUw4blhvMGZwcUtmR0ROVXNv?=
 =?utf-8?B?M0RrYm1GM0VQR1dyd1JOMnNMS1BBcHZURVdFRFZWdjZDMXlvSzlYeWxKLzFo?=
 =?utf-8?B?NHRhQWFZRGhiNldhdmFta1VRREZrYTRaSmhtc0dNdU9ualVEenRPd3pGaDdr?=
 =?utf-8?B?Y1NRU0hVVWt3Q3pxeFg5UFFFOWdlcXJ4WmpZTjFWeVMvdEdaNGs0dUJkZHZo?=
 =?utf-8?B?c1g1WUVLVEZUZGRta05HOUFGemRxY0luTkx2VDhkaDdOc0g2VW1GRHI0YTMy?=
 =?utf-8?B?YThOemdvVUt6eHBpdzQrMzNGc0lVaGFSU2JmQ0kwNTdOcGYrcmJ3NHJlZVA2?=
 =?utf-8?B?ZnpodlI3VkVhUWZ3bjUrVDNadm9EN2Y3eFFiYWh6ZlZmVVVEcHNQWlFYOUZz?=
 =?utf-8?B?elRvVXNjbGN6MFo0d05pLzk0YlFaM1YwL0tOVlZ2UzBhZk1jQnNzdlZlYXkx?=
 =?utf-8?B?T1JoYTNwYkFodEI2cFhQb09abUVPS0lXNURpYmFhbTgxcjNoT3BETnRBY0Vt?=
 =?utf-8?B?cnFzZ1QyUmQ0SE8rbkUwdlF3NWFvOEhPTldVeUs3Zy9TYW9aTURDMXFjei80?=
 =?utf-8?B?Q2J0WlpOdkI2cExrSEJrQXlJbDNlNTJGTWdEbWorTHgzOUVNMlIvQml1RDBS?=
 =?utf-8?B?dkVwNjU0WWF0NnlhL21RVnIvQkpEYjZScFhTSzhXTVJrVVVyME4rby94LzZo?=
 =?utf-8?B?c3N5N25zdzhzTS9Td05RNTZ1MFpOa3V2azUxU0ZacEw2aktyUnNubSt1dm1z?=
 =?utf-8?B?MGE3NXpiTWRsdWFNd0FxeHlEdy9mMmZ2dHNIYzN3MGVveWxHbUJ1aGcrSTRH?=
 =?utf-8?B?Ri9KSWNBQkxEaE9aSVpsOUg4Q3ozR2dlYXl1Mmd6NHZhM3ErTkJvcTJZYkVy?=
 =?utf-8?B?azhPSSs3Tm1aMnM5Mkg0eTMvamYzc2Q2WEx4bHVzcGVMQXhJTXVYK3FRRHJo?=
 =?utf-8?B?aVF5Tm9ZMHJiNXhQVjJ5ZDM1NU1na2cyc2FRenJXQ3NuNVZnZ3dZeG1Qclpk?=
 =?utf-8?B?RVRMSG80ZDREdGdBZGR6RUVMYVJaTi9JL09oejEyenE3elNxQUZQcjk2dlpa?=
 =?utf-8?B?a2hCUTdIdUNaSXJqSy9KTHNDbjY3Qkc0ZUlzV3Q1M0tqbmR5ZE5Fa085bzZI?=
 =?utf-8?B?M2puditrTzF2SkNDaDgrZ0JDbUp0eEdQdWY5QnVGMDZWMEpYcjdXWElTOE8z?=
 =?utf-8?B?Zk5RT040bGpONDJUR2dWSlBuV3pnQlBlS1hBRmNCQzdhcE9OK2QrZEhLa0dF?=
 =?utf-8?B?V21RWVIvd0JZNXhNUUl2TXE2c2lqRkdRZ3BRUDhlZUZRVmZXNk0rSEFlVVhY?=
 =?utf-8?B?QWxvSzV4SEswWFlVamlpZ2FkUHc1ZU9rOWVkZmwwWTZidGszRTc1R2hFY0RB?=
 =?utf-8?B?Zk5pZWJHbTBsM01TV2hBbVg3a2cvdVZwdXRydmRwaHNVMjU4V3pzUE9kUmtC?=
 =?utf-8?B?UUNaM3ZwelplTUNHMi9zOUxQS25IWDhqcFdhL1g2T1NPVnEwVXNjdlVXZ3hl?=
 =?utf-8?B?bkFwNVcycy9RSnkwOU1xU0p6YitaTnRMZ3h2bnUveUZzKzdZREl1MUdBYlVs?=
 =?utf-8?B?K1dYWlc2NWUxamRydmY3Y3llZmRVNXJmdTdTSy9JaEs0UTljVXBWMlB2aVdj?=
 =?utf-8?B?MWt2NFNCL2lwbHlFQVNMM2Z3RG10VHhHcFp6YytlTEhQWlJwcHhpNkxWMlFy?=
 =?utf-8?B?UUdKMnVDVFRmU2JqY2RnbGFCRkpJSE94dUczY0VRaUhaQ3d6NXh1bnhrMkcz?=
 =?utf-8?B?YWt2bkRlL0VUNkNOeVBML1gvTnV4TTA5T0hnV2RGYWJMR1l1WFhwamtOUUpO?=
 =?utf-8?B?eUVqa1JBV2NUMC9VUFlOWi9oQzV4YnlYbC9IRHdGSEF3Y3l4UjFFZkpPTzla?=
 =?utf-8?B?ZkQzeXRLcWV2VzlrV0NMUTZVOG9Qb3Bwa29uNXB3b1hVY3VGN0dQNlhVeDEx?=
 =?utf-8?B?SDNXdUZtR21SRTdZVWR4aWxpNmlzRmE5U216Tkd2b1pKVGVHNlNOUGRiRmZT?=
 =?utf-8?B?NE5NN2g0b2FDU0l1UWQvdSt4OHpsT1lxQUlBUFJzSzVURUdLVHMvU2tsbEo2?=
 =?utf-8?B?Zm9PTksxZUY1TmxZWEVjeWpQQ3NpdFdTVFdtSktlSjV6NlhDbndXajF0UXJH?=
 =?utf-8?Q?CItMNr2wsyBekxyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8706C5E21AEFED4F8657578BE323DF85@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4d9438-e6f6-41b1-0108-08df3a7368fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 12:59:06.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIYE76MLAo2QXN49Q1ZWK+aSNeSdQcXc95R29IRDC7Zj9a4IViO0tKrAmtgSXmxgaKIrETBuDfuC8maLH/y9h679xvz5ig6AScePptvkzOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9702

SGkgTGludXMsDQoNCk9uIFdlZCwgMjAyNi0xMS0wNCBhdCAxMzozMCArMDEwMCwgTGludXMgV2Fs
bGVpaiB3cm90ZToNCj4gPiBBbGV4YW5kZXIgU3ZlcmRsaW4gKDIpOg0KPiA+IMKgwqAgcGluY3Ry
bDogc2luZ2xlOiBkb24ndCBsZWFrIGdyb3VwL2Z1bmN0aW9uIHRhYmxlcyBvbiBjb25zdW1lciBy
ZS1wcm9iZQ0KPiA+IMKgwqAgcGluY3RybDogdGktaW9kZWxheTogZml4IG1lbW9yeSBsZWFrcyBv
biBjb25zdW1lciByZS1wcm9iZQ0KPiANCj4gSSBnb3QgZXhhY3RseSB6ZXJvIHJldmlld3Mgb24g
dGhpcyBwYXRjaCBzZXQgZnJvbSB0aGUgcGluY3RybC1zaW5nbGUNCj4gbWFpbnRhaW5lcnMsIHNv
IEkgaGF2ZSBub3cganVzdCBhcHBsaWVkIGl0Lg0KPiANCj4gTWF5YmUgdGhlIG9sZCBtYWludGFp
bmVycyBoYXZlIG90aGVyIHRoaW5ncyB0byBkbywgaGF2ZSB5b3UgY29uc2lkZXJlZA0KPiBzaWdu
aW5nIHVwIGFzIGNvLW1haW50YWluZXI/IFlvdSBzZWVtIHRvIGtub3cgd2hhdCB5b3UgYXJlIGRv
aW5nLg0KDQp0aGFua3MgZm9yIHRoZSBwcm9wb3NhbCEgSSB3aWxsIHRyeSwgdGhlcmUgaXMgbm90
IGEgbG90IG9mIHRyYWZmaWMgb24NCnRoaXMgZHJpdmVyLCBob3BlZnVsbHkgSSdsbCBiZSBhYmxl
IHRvIHByb3ZpZGUgYXQgbGVhc3QgcmV2aWV3IGZvciB0aGUNCmVtZXJnaW5nIHBhdGNoZXMuIEkn
bGwgc2VuZCBhIHBhdGNoLi4uDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==
