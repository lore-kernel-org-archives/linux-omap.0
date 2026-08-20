Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171F44065F;
	Thu, 20 Aug 2026 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196637; cv=fail; b=FI2U9h80JM6deFoEQkKvFtygWerA4Rrqc5qCDWgwG+XwaeeRS0ufOsKi80fmAxoFAjlmI1A7IHmOq5HFxM0qUoHrbKmopHH5xg2eIVmX3FhDH8nTG/0CAiYrpKrE/+FETxnz/lh/l1QljsWLElWwogWJYp5bAgpBOEgv0bXoLk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196637; c=relaxed/simple;
	bh=qE33Ssyx63dMqI0BpCJ3rGUhbl7sXUpfHFugnYJdr4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrWNaATJVa7u6bNKN4QZqOHiMKHNBHkS5YMzr8lMX5z1LHKWKt6TUwDlFiR7+SxIJyoOvn8c1cm+NDMLls6Rxq7f9LRL3F2COBYSTLmodYKwj8x5TsgsqVnDRYuPnVyG2i5d0YpbNwFvRC8417T603XApuR3BiRNsyuaYnIt2EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=ufwGz/A/; arc=fail smtp.client-ip=210.130.202.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="ufwGz/A/"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 67K24dhN1954132; Thu, 20 Aug 2026 11:04:39 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1787191404;x=1788401004;bh=qE33Ssyx63dMqI0BpCJ3rGUhbl7sXUpfHFugn
	YJdr4Q=;b=ufwGz/A/ddFiVE9KeyVz5cgNI8rjwa5i5zKbk/yPdi/Hzq3dibW32vy3TMft7mlDWsc
	fRYIeTBLSOqPdveDA/gbCBAvy8dhrVtyzFeYMPB88aCM7vpA0D8jyiMa+p2vYSCko7xY4cm2rbinD
	rDkm7yYPGOj0hxpaislU140Us6X/Fg4OeQZxwG07LNiHvZvcTeKb78jNaTWJb67Xf0jwjVNw+hvKK
	ikVofWm44xo5v+NXOF5I/fLZhCDTkNuaxqwoo+YYYNT1vWFR2l2qzx2yLxWiARXveYHgVvVnPf4IB
	EYRpy6PTYEiQuoGwhKVcPKPtpz+/fQYTCMK8rrQ+V46w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 67K23NUa3991878; Thu, 20 Aug 2026 11:03:23 +0900
X-Iguazu-Qid: 2yAbM4coxr8UWOf7LM
X-Iguazu-QSIG: v=2; s=1; t=1787191403; q=2yAbM4coxr8UWOf7LM; m=SM/hiBgyNg5u+LszwUwnjv7Qm5rYPbDvOON4C/aJfhA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hQRYP0WyKz1xnh; Thu, 20 Aug 2026 11:03:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cu6jTBxxPUQQAKph8wWfSBH+Ho+rBXu6FizceDtEc3FJPhV/h0lOCbWDuuSAXxQKqghNDxOkF4q6cWF4T8LfYfk/JTIQ69xg93NUE67hNFVj741HRUQOYytwpOSijWq/h5uJrzl5yVU+DrFZ06UepcATv8p2YxJUJDPd6nevfjkd3JfDXCZGs84dkb4bPOV/mbayvQvpOyfiL1zwZSnsR70QJjAt45bgoh2BLN8LEyj9Pt/7hXrFj8fytVVgT+HWmCYBCbeTsw/50bjACrvHwK1ti5TciVvEPec6hqtjlkT6VKPGZUVKGVIueP9s+CJfMT+zZILZZpssbP9l1kiqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y04uLzqZC9cn7ODpEwkMq2GDOWFB7Nkh2MGWP8hnINU=;
 b=dAiuCm9C9hnAFuUjvyNS8BKlYKvnXCcnNjzEjw5ydOm+xn1Ue5LRhZ5d1BZvMOKHP3qCdvlX8bqUKmg8Oeoniy53NO1VbrZ4lAgJyoTi3/iIK5Z8jtaoH8UL07PcncZ7EsnBJ667Cytfjpa3L+SRifprPizxoEJINraOibwt1fhWoKO2ckBWJ359xxlrvGnschMteCBx8zrLcOjO7k/XOxEddWuLh6Ol5Kf/aBv/0JxDS0juAkUxVR079uLu2ArwId/2M/pOv3p4jKJvfpG2/pQ3f0yitm1HQfkmrVNxccpDn5ifKQwycBt1e88gpQd6Qg0YsXQsVEHzb4PBfv41Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <geert+renesas@glider.be>, <kristo@kernel.org>, <sboyd@kernel.org>,
        <bmasney+clk@redhat.com>, <jbrunet+clk@baylibre.com>,
        <nuno.sa@analog.com>, <linux@roeck-us.net>,
        <Michael.Hennerich@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <sunny.luo@amlogic.com>, <xianwei.zhao@amlogic.com>,
        <broonie@kernel.org>, <kees@kernel.org>, <khilman@baylibre.com>,
        <mathieu.dubois-briand@bootlin.com>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-hwmon@vger.kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is
 fully initialized
Thread-Topic: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is
 fully initialized
Thread-Index: AQHdMA3LYxN7b9KO+0GeT5d+mUKOsLamLh8A
Date: Thu, 20 Aug 2026 02:03:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481812D226130989DCE5FC1BCDA42@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
In-Reply-To: 
 <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10664:EE_
x-ms-office365-filtering-correlation-id: bdc5a8da-d726-45e1-9ae8-08defe5f32c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|10067099003|6133799003|18002099003|11063799006|4143699003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: 
 5AG/uE5d3tsZf7NPB9F1VIziBsSWceehZQoAWEfBlVDHwTdcepBjynAACgRlRBjlsxvFgyrbc9pxfrt1pMyEZwcivuEs1UfHQ6Tl1Ig2eUUgZn/GHzDb3jQ6w/RzkTXrm7+81Az9tEMQPtZpCiZ30uTvrsLB6dG8bKY0jcjBnTDV7AQZaaH3i9hBobOYKZLRcLUzyIl0drc5N2gT6EeWvO5sPkafte5AzbcKnOjb9SrifiamR6wfVi7Q2I7Wm1ntpRr+8eEX1gimoUuOKfH/K4YgsiIf2Is6s4fVaZ1Rh6khFcP0OGmDjNwSvC1U0gCBxJs3Gu6LPACWaXUNHCVNh+2Po3GuuYay+6MuF63fIEMm3kPA1tG75Gov3PA4Bv7vGhO+lX3c+A08s2Zsr0g//a6pos0Nbs2avA4ZQD0No4hvE5qNZUNV5RAfg4CtPezwKVFK+8Hx8cBnpwy2uuLijpRamsqPY10JzPz3nuEGILphpfPkfsiMXmXJOo94MZniYdDyv8XW4OP1UoBgZ2uK3SGIR/RzI1wDtjwpope9dLbM0gf6NmEzWBD7aGVxm3KT6Jl++HA59/gOsOOHzme4RsxX0xpxT3uQuj6jIo1f38cPwIg4RO0SSC8zYq1dPgrH2XcW88F04lTAGyTH6oZAWP1/sicSWROjj1HTuMKXa6hZTH8NaPdpxSujH3jKloigxjlQxQtS7U4ABLhUr95+A+d84M+Aiezy8afd+42gXQk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(11063799006)(4143699003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SGR5TzV0cDVjVVhtbTIwcjdqQVgydWwyRFhsd3UrY0U5UVlYMUlxTDZz?=
 =?iso-2022-jp?B?aHdMLzJIR0d1S1E4cWNaYXE1MEw2Qk5aMTRFenQyQUhDdmhXczFxZVFo?=
 =?iso-2022-jp?B?TlcrVXF5MitvTU53RlRVYjdYVTFsSFhFYXg1aUlaSzNUem9CQVU3MVVv?=
 =?iso-2022-jp?B?bTZNbzRabmN0RjYxTURXeVYyT2FRMzM1S0JzRXlwL1BLb0EyNEVqWmJi?=
 =?iso-2022-jp?B?OEVwR0VhdFk3OGp4dEhuU2hHeitYSW5raDIxSVZ0ZjFRblpFbXdnRzAz?=
 =?iso-2022-jp?B?ekp4OS9GWmxqRW1saVJ0VFFCWjM0cEZIaS9iaVRiLzFKYkVJQldxMmJJ?=
 =?iso-2022-jp?B?UCtBNms0QXFhZkt0MktVOTV0b21jUXdMTWhDczFiUEhZK0R3eUoyc1pE?=
 =?iso-2022-jp?B?V2NTb1Z4TFBlU0RLa3Zwd0h5MlRROFk3WXAvQ3JwNWxSZ3NNZThISG9r?=
 =?iso-2022-jp?B?RDRUb2c3eXA5VG1zYzBQRmtGNFVkNDJMTStlQjZ5emUwdDQzaEE2T05p?=
 =?iso-2022-jp?B?ek4rc0F5aWYrenN6K1J3WDRDZCtUWHVlNVhldFVZbTI4SVFYV1Z2eDlI?=
 =?iso-2022-jp?B?eG5YUytQSm1VVlBVWWx2ZnE0SldERHI5MFBRNUF2U0s2VW5JV251ek14?=
 =?iso-2022-jp?B?SERWUkcrTDc1Q0lUbjR4cFhOTVQ4eWFZL092SXlHUDFhaThGdFRvalJP?=
 =?iso-2022-jp?B?K29LekRRKzZDcnJhQVdTTHR3eGxudXBWb0FVU1MwcUhnRE9yZDJUcmI0?=
 =?iso-2022-jp?B?dVVkN0dUUjZXaG1Ya1VXZEQ5c0lYMTlDWVdlV1VEbEQ3eWlLTHBZZzgr?=
 =?iso-2022-jp?B?RWd5SDI4ZlpDZERVQ1NRSE1LY1hRMUJpVVBabkJ4Q0dpcmh2NFNLUlMv?=
 =?iso-2022-jp?B?NTJ6QUtLdVBmbWI5Q1h4dnZEVEtMdjZkdG5DVG9MeEY2UlpSbnY2Sjho?=
 =?iso-2022-jp?B?K0RtZ3Jlb2xXNnBRbjQwSjQyUFJNS01hV0ljZWdiTmlzWEVrZmxOL0M0?=
 =?iso-2022-jp?B?TDV1RVAxejJGaHJLMmpvYzhVL3JVVlZsbUVKNkVvK3dyMERtcjM2ZVFM?=
 =?iso-2022-jp?B?Sm5LU0FMSUNCTmFHQ241dVhGTWdUZEpxeHVUSEhWcDV6MTRpZnFYSmJC?=
 =?iso-2022-jp?B?amZDTHFoQ05IT3g3V1dHazN0NEhHLzVPbmh4ajVObkJtRlkwczNYcXRU?=
 =?iso-2022-jp?B?bHJFZUFZY0JzQ01Gd1lSem5DUm11bHNMNVlxYjBMQ3lscW0rK1A2MXk2?=
 =?iso-2022-jp?B?UHR1LzJoRzc3UkNreXFyODhSNU53NjNhMmdsa1NjMlVRSzlncXg2VFhh?=
 =?iso-2022-jp?B?UklJeFN0QlhPcndQeEZ0Mks1ZzYwSEthanR2eE9HS3d2cXZDbUZHYXlL?=
 =?iso-2022-jp?B?ZWJnS2pIc1NycWhIWm5RZVVLWDMxZklIeFR0OGI4QWRpSkk4VDdFVVE1?=
 =?iso-2022-jp?B?aGQwRTVxcmtjUmZjd2JlTGlTZFdtRUN2eXpHdDFSOUtqNThvVDUyRnhW?=
 =?iso-2022-jp?B?RFlpMUUvTHorUTNCaVEyRDdNc3NSYkR3Vm9ieHFlcGJpaWJzc3ljK1h4?=
 =?iso-2022-jp?B?Z3A2QkJQVU5Gb2VEWCsxbUV5OG5xSG9zWlR5R2NxWmducGV2NSt2Rnhs?=
 =?iso-2022-jp?B?NDEzZ2RkK0c0UTZXL085YlJQMGp2QmFhQ1ZmeGExenUxTHY1djl0V1hG?=
 =?iso-2022-jp?B?RFVpSEwyYlNkNkhtYXpGd0RiVHpKMmIvaXhQa01uQVJwNVM1UmZjYXJX?=
 =?iso-2022-jp?B?VTM3WjdoWUJhaGozcDQveUR6VGdlQi9ZaHAyUWhJc1phTXhpWUpDMWxm?=
 =?iso-2022-jp?B?SVBiekFjWTdNNkNaSmxRZEFwYm9GNVJQRTNiZWprYktzZWlzcWhZdCtV?=
 =?iso-2022-jp?B?R1dVdG5Ha1BKeWJxS2xrN25nZVMrRXN1cEhUOGt2YzU4ajRRQ3Y4Umxv?=
 =?iso-2022-jp?B?RnZwSjdsRG5NY3kyQ3FUQVBWaUUvWDBFaWliL0xJSEw3TkpZMU51UjBE?=
 =?iso-2022-jp?B?SVp2NmM1NXFydlpESVNvRHlYSW9kcStmSnFkckZBRW5xc2gvQXN0bmdo?=
 =?iso-2022-jp?B?YUo4eDgyY09ZU0I4ck83MWd0L3dpamQ3RGhDVFlmL2xvcmVoTElMMXkz?=
 =?iso-2022-jp?B?SmdEVm93NEpNTS81L2VMMGo5dUc4REl4TG9PL09pdlM2b2hTaFk3TmQw?=
 =?iso-2022-jp?B?dHFDY1I5bFowdjZOaDBGeE9tc0ZySTM4cFF0T1RKdk1iUXV2dElhSG03?=
 =?iso-2022-jp?B?dnlid2s1R2hnZFRZMTQ3Ukp2K2FjVDJPbmp5bnNhVzV5N25ybm02NllF?=
 =?iso-2022-jp?B?dkpFQ0ZwdisySDBaeWNJV0tKZEZaL1FuN05CVTdSYm5pS21JdU1LQkk3?=
 =?iso-2022-jp?B?OCtVckY4aElkdGQ3dmdCTGRUSkM0enh4VWFEWWdaMEgyZ1l4bVUzbk9P?=
 =?iso-2022-jp?B?VkNPaGQwVy8wa3ZoVFRYdVVXVW9ZRGpnV05ZcGk0NjF2Zlp4TklMZHFK?=
 =?iso-2022-jp?B?S3MvMjNXbVFWa1JMQjB0TnRNMTZ2L3BsQTN3L3NoQStqc29NU0NMcnBP?=
 =?iso-2022-jp?B?Vmd0aTF5bz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	JTGCX/dF3GQ39rI672YcevbHGzYKlkBZqgqR2Atjp3OQCLkPVZWZ/kWkWzavYvXwRo9uQzikjoMEFxm0Ii6zhguwT51/B9j+Ehqpw4uZFwMzFUOJ243pO9t0AEWxG+miRnRiOe3QkITR4ZqFQOLabPX4aj8101AAs4MYfe0NN5Cgqrp8om67PybaMfXM7ZkyO0D0BkRUBm0HnRz9OfjMTJnNs2LPPMnI8EfkX7LfIjXOTmDZD+bXWnFyra80nRoy2px29IJJKAcwxmItzLwKjinuZHMKPd33ClDvwNphL5hbV1smV4xQI3kGzMU4DKXyDfpXtAGlUUWyHlvuB6IK0w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc5a8da-d726-45e1-9ae8-08defe5f32c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 02:03:15.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 246WpNVXnYh7HtjaSPT1qpxd1lrWblVl8cV/6GAV35lGr8xKxEXSz6DwSJXxZjfWR5o7IG/O0g5B+OJcPzdIqwaZjGh5UIDA3AGRmUuUTQOh4zwTvubv5Qnp8JniugjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10664

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: Thursday, August 20, 2026 4:05 AM
> To: Tero Kristo <kristo@kernel.org>; Stephen Boyd <sboyd@kernel.org>; Bri=
an
> Masney <bmasney+clk@redhat.com>; Jerome Brunet
> <jbrunet+clk@baylibre.com>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B=
(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Nuno Sa
> <nuno.sa@analog.com>; Guenter Roeck <linux@roeck-us.net>; Michael
> Hennerich <Michael.Hennerich@analog.com>; Antoniu Miclaus
> <antoniu.miclaus@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> <andy@kernel.org>; Sunny Luo <sunny.luo@amlogic.com>; Xianwei Zhao
> <xianwei.zhao@amlogic.com>; Mark Brown <broonie@kernel.org>; Kees
> Cook <kees@kernel.org>; Kevin Hilman <khilman@baylibre.com>; Mathieu
> Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-hwmon@vger.kernel.org; linux@analog.com; linux-iio@vger.kernel.org;
> linux-amlogic@lists.infradead.org; linux-spi@vger.kernel.org;
> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Geert Uytterhoev=
en
> <geert+renesas@glider.be>
> Subject: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is f=
ully
> initialized
>=20
> The clk_init_data structure contains several mutually-exclusive members f=
or
> different methods to specify the possible parents of a clock, prompting d=
rivers
> to initialize only the members they need.  However, not initializing all =
members
> may cause subtle issues, which are only exposed when
> CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>=20
> visconti_clk_register_gate() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and thu=
s may
> cause a crash.
>=20
> Make sure all members are fully initialized, to fix such bugs, and to avo=
id future
> breakage when converting drivers to a different method for specifying the
> parents.
>=20
> Fixes: b4cbe606dc3674b2 ("clk: visconti: Add support common clock driver
> and reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

