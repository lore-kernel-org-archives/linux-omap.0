Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127887;
	b=z8QuWlYF78DbYeX/HCu6IKIJHgWrhzdvSc3O0MGoDq8rsI9MxXlxsEfLxakHNwWGG2Ym
	 o/9LoysvCh1qRB1NUC+YBOhoekAsANfBCW7ghb1y/FKSTr2qpi1p/Z0ckLYNv18qpIVDV
	 LSpaXSJtqP5gsNsKLb3ZaGTeu2m02eAROrk2wKfFzBNRQoiuuuWOcaFKm7+FP8GJ1q8VW
	 w8Z/RkRjZGPZGp7BHs+L+Zi9uIbxKdH4U8LQwJkOUQ0ur9koNyMPs6v/j230qCGph78sQ
	 5BQpiBxmtiDrmBjZIsYvSTO1Az/VteSdtpXEXDj2bY2IG2UDr3EC5r3M/amEL4xJO3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127887;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:
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
	bh=I0CNy4GaD80h5ggA3xdlAHOuy9i9R1+jiA83pCVYVEc=;
	b=y8i61Tn/PPeTr2Epd6rhi6TtoIqIAoHpEbJE0RuyfZ8+D0BSYlclj6l/e78mWsYQoZJM
	 FP+LAeRyHqQZDvLCbAp9UeDRfHc8Uio+ynD4fnc840hGchxcY8ys1EVU/KE0vesJes9hX
	 HOygQD56neVcMZsBI8EHlaNd/V52/LSBapavUeuiWqCYWReT2plpsFWulBxvwXWN9irxB
	 Hl3E1wyGjMFVKnxBc9tcUEj6T19fWFcbU0T9+eIw89EZxCaXLkkv03O084+0pgCMhoz7F
	 fnHzcVZqcrmYOj2+ISsWCtbJ0fZwMvI+HObfsjjP3l8upmNF6SgP5slLLQaVpHbuleQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=i34ZbAoP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.1
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70316606A320;
	Thu, 19 Nov 2026 22:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70316606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=i34ZbAoP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ4cJEbA1qPR18z0LqcDUk5ocmPWPWyfbcvmLC48BISF3NO10Y8ezr62Y7fiI+OpSd3u8+jGh3KBYxm+9HANh4OUPp4s3WFa5kR3EO1tlURH9GGfA4EFTPR6uAopaT044E4YZNjG/bwvSGQ4qIfGqtrUXKDQprHzdSFfFiJvIotn+4yDbQ6bx24Ov2wo0ydX3brcMYfo7ZttDXFCyA2kJ8JYYDYJst8mgXTMHOjhlm/tsuIi0MdSApC00z2E0rcNniVqCm5mU/eDDl07ylwJcxhapot/gGYBh2tp361yyKhoSWqtRW5J9M+N0dzAcajUbSWCd/nS3+x90fE7rXzo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0CNy4GaD80h5ggA3xdlAHOuy9i9R1+jiA83pCVYVEc=;
 b=fhEuByZKAtb8ziyZkiEaBvSLSMH0G9uYyKPc6giOdAvDlmzR+w+DKX9yCRa+4VE5mt11oW7WbwRICMNlXIYj17iUuylYaLTNJhqx119e0UC+IbQfmLbeDidbruOTrBipTxTuF6YpL8easwFW6t8ZyYyOnd9PDHiMBeOZh5YUjWAApaKwwzGN5rYJ/sEQ70PAa/4SzKq1wYAFS2ZrhzuMFgYiIPI+XvRpxh5i/u1ZXtG1vzVAxcENoRp8kEb7KenSB1/nOEFYVzbuIwvEDo3kkL4JR4TLLUIdKy8lEmCp5zRADy4mGbHUzhStSFcBnXwIkIPJp6zak74vXv91ABEfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0CNy4GaD80h5ggA3xdlAHOuy9i9R1+jiA83pCVYVEc=;
 b=i34ZbAoPa4v9dOX61i0gsH0ZM2k8iBLDTuiAetUO8SKfkS4kmddueIH5AudpIJMPGUhk29GeJ+5MzWhUgfaWeAFqJGGSstGBvBweCctVyOdVAXfADDUaiPhE5zoXVphlTL1tAn2OQZlmft1ejrh2dkKrF65lNeptxxCsedgill16zsrbUzu0vsouXlo/kJe+KwFYYeSn2si+r6QFxQlDeDt8NdfRwd6ImpO4pZHevjbKCdbqaaEP5YmGY9f91iSS+t83MzhRfGwOaLd2lcl9tnaO1T/FvF5NAD8d9zPIWRqGRKICnda+CClrJrIoZB9j2mvGmzmNwAbCwiTKK5kUdw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 22:38:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0662.001; Thu, 19 Nov 2026
 22:38:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "lee@kernel.org" <lee@kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2 09/12] pinctrl: single: Reject invalid register width
 in pcs_probe()
Thread-Topic: [PATCH v2 09/12] pinctrl: single: Reject invalid register width
 in pcs_probe()
Thread-Index: AQHdeGfIxG7k1qz9S0mIWeebPgVHrbc1/FEA
Date: Thu, 19 Nov 2026 22:38:02 +0000
Message-ID: <d317f6c0a35fa28b75cbf7f641b7bc8ae39b46a9.camel@siemens.com>
References: <20261119205013.2563811-1-lee@kernel.org>
	 <20261119205013.2563811-10-lee@kernel.org>
In-Reply-To: <20261119205013.2563811-10-lee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5704:EE_
x-ms-office365-filtering-correlation-id: b82a8c14-f3da-422b-7de9-08df468dc536
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 8K1i3kbAxG+LpmVzVfff0+sZ4IH0vigew7nl8xwopWLKVBm6bcoPlY/AQocWMCzgu00U+POAUK8OzdDYHi6rsTn7SXuW7rYHwrGzhdJEhrVVOrlZnPzRWKMi7w3iWRyFX7d4+HVTsrv3uTHHWy/cCO1D7n8n0ptanxMVpnYLivw2J4Bk7uuR/RsLo+/F2JRIUQfVnOx2XF0mHguKRhqQDtjINGQxF4GshFvBYZAr51AumhkYpQ6GyJf/ZTWExVhH5SiYagByUgSJP9jK/v5MAPk23UtWFB38GgdGwvaI6red2Wo0efyazJN4pSeYe53LYl1YeuPusf+nLfhZgkuOrPvPCltNGYSg6dfaMuELWo1Cw924uLkZ3Hc/s1ZevL9KDW5Y2J62DLxnclHIF6wWL1HU+pByuz3BEHrBdhSMAzqVDWNuwe2wyiG9nQsEoNQRAkP6ytc2IvSq8NMtVdu8QznDp9GYZm6sGX/SSF7zZ9LWUvT2OvK7g0El9yYy6giA/ySKZ918AyXDvAEAATs/TAwQziXAmHvhUDpwbCgYKaZOXATDyC/7q4ya/uMLWOS7M8gCKqSEqRcsYRUkQB97XUMbFBKhA7d/25Ltf9oLV8by5lJOk0ycRUV1E8vmtFRSROgr+59Ow3kZ29HKpjGTJzK+YhBcvjmg+HtF5F6klBI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TitVYStTSG92S1A2blAvdHZoTGR2dUxtbXlXZFN3bitMZnpDSFh2WWlHVFAv?=
 =?utf-8?B?aHZLRXc1NmpLRHpVMlgwLzJCTHREV0d5QWoreHlRMGNSaGlBOU5YemZ6clZP?=
 =?utf-8?B?WThEb2oxRk1XcGRtRHEzb3BTREtyVGFMeFc2NmxkZzRvNHdDa1pxRFg0OGJD?=
 =?utf-8?B?RU1KVlJIYWNCemtOYnlURitJeVhRYkZqaHo1bXBJdGlHMFJrQTNPQ3hRTU1s?=
 =?utf-8?B?L1FGanN1cUc2b1dxQ1llZkxyM3JZb0M4c2ZmRUxaNTc3c2Ztc051Z3pKV0tH?=
 =?utf-8?B?MWNhdjNHYWNhT296d1NKeEVFVGpYVmlWOWIrcHR4b0hFd3ZxU0VJS3RYOWpK?=
 =?utf-8?B?bGFPd2JiOXRrbjl3NkRiL3MwTk4zQmVTa2kvK1VyaldQTkN6OUlRUU5icVoy?=
 =?utf-8?B?dUJQZXpocHFHYWNoSjJwYTROOTZucVNpdllPRjZWL2tUSkdnckxibEIxaUZv?=
 =?utf-8?B?TVUza01rdFR4YzJoWGRPcEMxUVZNdVRJN0R2ZWMwMEIrcWh5a09qaVFYWlN4?=
 =?utf-8?B?TFRvQ1RnTzJZd0ZPS0NiZ1BWVjlqMFROV0xkd3JQVEp3SjJrajdnMk1GUndt?=
 =?utf-8?B?aURvSzJ1MFIwM2M4alhQSWtVU2h3Q0txWmRoMmF6c0ZtSzgwSUc1YzhxMlIw?=
 =?utf-8?B?ZmhqQ0gvaUhQWU9iLzUxZjVRNUJndFM3TDBhdUdhcFhTNTJrcUd6Zm1zZ25w?=
 =?utf-8?B?SVZ4T3hNL21GdHFNa05DMnRwL2RnYlBPYUp6bEtoMXkzL0Q5SEhIKzNwb0NX?=
 =?utf-8?B?S29ncjZKN1QvajNqcEc2WHc1bkFoWXUvc2pZS2o5cG9EeGtZR1VRRHBnNnUv?=
 =?utf-8?B?V0lsSnM3bzZiYUl6bDhPMFE5TGw2VUZzQi85UWVDMUd0WHplQ1FTbzJVQUlD?=
 =?utf-8?B?SWtPQlYvVzA2b1pjWmI0QkhEKzlaRUU1ekJlWkJiVDQySkR0dTEzK3hPRGxP?=
 =?utf-8?B?S1VNL1JFYnRXUjZGL3RVbFAvUWdoUkp3ZkhTV1JqSzAxSUh6bHBsNkk1cTJr?=
 =?utf-8?B?a1RNR3l3VkJqNFFxNnpKd3AyUloycGp3UEtyaHhSL21Nd0pTMTY3bWVYV0RG?=
 =?utf-8?B?dkxxRmdFMGdwc3FjalAyanJDVUhaYTN4Z053STJTSzhRMG4waTZDMUJnN0FS?=
 =?utf-8?B?U1BrcUxlNjV2bTVqT2dUaGJldGQ4QTRRWjB4QSt3RU5rRjJ1QmwvNmx5SUdl?=
 =?utf-8?B?MU5Eb0R5UytlemVVMVkrODJ2Y2FhVVFRemJBdGYzbkVTZzI4akdOT0xkckNL?=
 =?utf-8?B?djUxd0NrbWNsaE9CV2lRMVVteUZrTlpQT3UzNy9CMzhJV3QzMnNLY2FsNTl4?=
 =?utf-8?B?WEZIVndNWU9GUEpVS3U3RDVNRWgvZmFZM0s1a1IveG1FM1htMko5WVJhdGtO?=
 =?utf-8?B?K2UwYW5tbTVhclFQdS9CYlMvTEx4UUQ0L21MakxYYTFaMTBtSGtmbU84aTlG?=
 =?utf-8?B?d1FuVlJsTVdGNHJIWHNYVGJFV3kxR3NQdFhFT3ZHaDdpOEYzZyswVGExYWlY?=
 =?utf-8?B?MU9LbmcyZUU0NmVuODFmK0FPa0s2dktSSUwzUXlPMk1EajNsWjV1MGpPRFc5?=
 =?utf-8?B?ZVJqZzlxLzVFV08wZVFXcmZ3OG1TNGlVYnhQMlZxekxPSmVyWVBTZXZLZS90?=
 =?utf-8?B?cnVHdENDUm1aaHhMbURRNDZDZTJER3d2ODkwdm15L0lqQUQzQnVzN3ZLSk9L?=
 =?utf-8?B?emZQV2Jyd2VURUtNUVlGbEZ4TnU1TjMxQ1ZLdmJPc2dBbzdaYnZBZW9HR3k1?=
 =?utf-8?B?Mk5IMDQvellYTVgrRk0vODhRaitpRzZhK3RIVk1ranE2d2I1TE9ESzcvdnB2?=
 =?utf-8?B?NXVmNDJxcUdPYjhRVE43bzVzSjZXd1cyRWwvd25iY1R2U0VQRWF3bmdXSlRB?=
 =?utf-8?B?WU9zZG5BRTNqcHlHd3V5VngyS09ZTzJkWGpDLzVUZTJRUlZ5UE56UmI5Mkto?=
 =?utf-8?B?YTFXSmVic1Uzek5ybXBrWHh0R3k1K3lIMEE0eENibnp1cWcrdE5EY2psVzA4?=
 =?utf-8?B?Q0owcUUrQnYvdnplWjhqcVVKOWpYaW9oVTVCSDVYbEltRWY2eDQzaGZrRm1D?=
 =?utf-8?B?WDBOREVrWUhzc2x0K21kNzF6Mlpib0NkVFl1aFY4QmE4T042aDI4MEVFY2Zu?=
 =?utf-8?B?M0dPZTFXSGNpSi9SMnhLZ2xhWUk2VVR0YlJDWFBaSmF5cnBIcUlnOVpFMEZ1?=
 =?utf-8?B?RDFRelJYMlA4MFZEaktSU3pOOUdiMnlmSDZxYWNZOW9NbFBMQUV5Yk1SK2w5?=
 =?utf-8?B?RHB6Q3ZxaHIxZDFwU3FnMHY2N1kyd2lwOEpXc3NYdnhGUXFSTnFzZUpQcHNL?=
 =?utf-8?B?eGk4SjZIQ0RrMFBFeXFVQ0dkcStROFhaVjlYc0Z2SlIxZGFxdGdrcys4bmFa?=
 =?utf-8?Q?lSme1Bt0qgM8AnHNp2mc2YFaN8b2oS/SJEKHMum7E5i6+?=
x-ms-exchange-antispam-messagedata-1:
 Z9hR4H57WL3aGNqXndvmsLk6rsdSbBK11LFUhPgqcr7bwILSLFoTVFf7
Content-Type: text/plain; charset="utf-8"
Content-ID: <98600F840BD00E4F96D314180EB2501A@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b82a8c14-f3da-422b-7de9-08df468dc536
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 22:38:02.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zib/JKqUsGUmdGk/qdGeqk/SgSU8GLdjY831CF2SFsl5HHXfvkCn/ysIkX3+SCKZ1ZlMqj87w1ITSLUslp2JoMg/MFYvAeYiPy2WzP8tU+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5704

SGkgTGVlIQ0KDQpPbiBUaHUsIDIwMjYtMTEtMTkgYXQgMjA6NDkgKzAwMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gSWYgdGhlICJwaW5jdHJsLXNpbmdsZSxyZWdpc3Rlci13aWR0aCIgcHJvcGVydHkg
c3BlY2lmaWVzIGFuIHVuc3VwcG9ydGVkDQo+IHdpZHRoIChhbnl0aGluZyBvdGhlciB0aGFuIDgs
IDE2LCBvciAzMiksIHBjc19wcm9iZSgpIGhpdHMgdGhlIGRlZmF1bHQNCj4gYnJhbmNoIGluIHRo
ZSBzd2l0Y2ggc3RhdGVtZW50IGFuZCBjb250aW51ZXMgd2l0aG91dCBpbml0aWFsaXNpbmcNCj4g
cGNzLT5yZWFkIG9yIHBjcy0+d3JpdGUsIGxlYWRpbmcgdG8gYSBkaXZpZGUtYnktemVybyBpbg0K
PiBwY3NfYWxsb2NhdGVfcGluX3RhYmxlKCkgb3IgYSBOVUxMIGZ1bmN0aW9uIHBvaW50ZXIgZGVy
ZWZlcmVuY2Ugd2hlbg0KPiBhY2Nlc3NpbmcgcmVnaXN0ZXJzLg0KPiANCj4gVmFsaWRhdGUgcGNz
LT53aWR0aCBpbW1lZGlhdGVseSBhZnRlciByZWFkaW5nIHRoZSBwcm9wZXJ0eSBhbmQgcmV0dXJu
DQo+IC1FSU5WQUwgZnJvbSB0aGUgZGVmYXVsdCBicmFuY2ggaW4gcGNzX3Byb2JlKCkuDQo+IA0K
PiBGaXhlczogOGI4YjA5MWJmMDdmICgicGluY3RybDogQWRkIG9uZS1yZWdpc3Rlci1wZXItcGlu
IHR5cGUgZGV2aWNlIHRyZWUgYmFzZWQgcGluY3RybCBkcml2ZXIiKQ0KPiBDbG9zZXM6IGh0dHBz
Oi8vc2FzaGlrby5kZXYvIy9idWcvbGludXgtYTAzMDNiNmUtZDBjNi00MjkyLWFlZWItZmE4YTIx
ODYxODI3DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRs
aW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gDQo+IHYxID0+
IHYyOiBObyBjaGFuZ2VzDQo+IA0KPiDCoGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXNpbmdsZS5j
IHwgMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQoNCi0tIA0KQWxleGFuZGVyIFN2
ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
