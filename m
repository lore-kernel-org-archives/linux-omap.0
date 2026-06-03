Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AB2B9A4;
	Wed,  3 Jun 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497840; cv=fail; b=FvIo0Haanxagqk01vFPr70yFaqqs2lHTn9o4az1/E/dYXFb7/12GGoaga3kVpIEqZr1ZYNI+6Bti21tnLmNBTWQe9WCjxSCaAiMzpwGyHBl2z50FHrOfctl5O5VJqH3lcM3zfxR3xa2PtmyyK0wuD9/vFvpdnOb+vNBK1cFr2z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497840; c=relaxed/simple;
	bh=jRZNu1SK+RHOXGPria0eAx+eBezPyOhH27/sMHC1V6I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxWOcpiEwLGLS/ma79tN7iHSghWBjvlTcXkhVlu0pVS6gdABHiQnf4T2HxLv+Z4mfZBh9a1beMFMExCXTxzdEL5ZXFm69qo82RHHEgHJgtyyJFVNh/8J0VZwObj9FaMozHikhalSvRR6OTFMTwAk1DzELA96VwGVzg6aNdJGTOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agz/z7uW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agz/z7uW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780497838; x=1812033838;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=jRZNu1SK+RHOXGPria0eAx+eBezPyOhH27/sMHC1V6I=;
  b=agz/z7uWMrXHWPAzRJgG/S6BVRuG36Y2/LXVgS3vIHQkj07PqruAghcP
   Rxah+6CeD7wPgPcTfF7lx0/jqJl91FNkncxwaPREfP/RandfaNksN1A2a
   eiAn2VmeNBCyO2Ai9C+qJB0l0hrHKvsz/hd1/R1s5zix8cvTQZ8uce/9u
   MaO81QMDjJStoFCyVeu8yNUBUsYPcrJLWpLmpzam3nY8GnDn8ScwNSAsS
   oBX2vW32NRCg9umDWrUq14L/cLqNbUt3uWCF8VbvDQkKG2adk2DW7KW5P
   yYS+q9HQ9Xi7LcUVnsFtyuhYjJDgXt08B0eI+OX/vMy3mUGvgJIkHR3Kp
   w==;
X-CSE-ConnectionGUID: JyjUoeLaS92bGooSmnsXWw==
X-CSE-MsgGUID: E+dLpe4ZSJaxPnTXipyNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81167614"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81167614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:43:57 -0700
X-CSE-ConnectionGUID: ReL6oHx1SS2hERJq0SOqUQ==
X-CSE-MsgGUID: d2AGhDaxTZ6EjfXBr8K70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243420091"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:43:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:43:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:43:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgbPzD+9uNkiEYLBe/HgWjulhDy5LLAH84jIzVVuaVqOgHFeRJ23EH8VjICKGusnyU2zolx67EhEMOV0y+Q546EJpizjFtWJF7qa5utHqGj5d3/hay8FvhUuR3nW0OL/SR+5PlcLcesnvlspes5ctdoTdSkFXtWnsV3iE0I35wvXc0/knL/3oQowN+QOVlJ7HdcsBTYQZVLCp27HL5zv4YDG5ZsSWorNzeyEzcdoVGpxb2061xbAR5XD3CW9mBPJnUiHG4/dSuKja3wYOWptsMqs5zxeFWdqRMHhy8r5MU/MsP2vAfoVi5KTwxj8WM/0iM7wFJqfPvdNQ32jH0RcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRS3Jd6MuV/TtYzWbF0aqm0UsdE9v+kfwuMH6q6dCnY=;
 b=PWzVyY1/zME98IGx31kLNTNMwOVUsPRAnwMxmB7ytgDrd56AVxkckVhhyqPx/JocP4n5iXpjvHtKJY66TsktFUHOBPGxp3bsWPRRnaVNivSKciTEC77Hfy/G/dOvUik12LL+Lb4X1WdBNWwwpC+QpcxADuvfabTERwNuvaaGAiO6QyGny7n1piWtcAuDeWAAVcDRY9pLdIZV9riissWEv60lschbJ01g8FNMpbaOuCBmLn5vhhT1T8sRtG6ZsSlXfQlAFYYl9zuU7rPA4w3WHOJpsUIaPto0fOMFKdcLyZtQ4OnlnJJ16A++jTcns4HpdZ9eCmqbYvs6Fx79Lqn1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4940.namprd11.prod.outlook.com (2603:10b6:806:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:43:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 14:43:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kevin Hao <haokexin@gmail.com>, Alexander Sverdlin
	<alexander.sverdlin@gmail.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Murali Karicheri
	<m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Thread-Topic: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Thread-Index: AQHc82JqANod20DBBEKGiAOlsIvnrrYs5+4w
Date: Wed, 3 Jun 2026 14:43:48 +0000
Message-ID: <IA3PR11MB898623B5BB7ECF02CADF7B4EE5132@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260603140742.1398659-1-lgs201920130244@gmail.com>
In-Reply-To: <20260603140742.1398659-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4940:EE_
x-ms-office365-filtering-correlation-id: 4e5d6d0e-ec38-4703-20b9-08dec17e85d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|3023799007|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: gAReACC37AvJxhc12+leOFDcDMqRsX2MKEtv7QahjwOakZmK5TcGx2+O+P7eo0UQ+MZpb6l+C0H5tP30xc6mgtmzZopzXyxDyABCoQyUb3dCK/VUGpwselc4E4V6iHXPUf1T/PQDoeI938/sMiSkLJWgUHM98QIInsHqp4PaMERegfLfie52VTtjMTUmbCc3vU9UhysLf0OOWwUUc+OliRYhrxbYgT4bWnduylbp+3Wj4poXZpLsqolri489YPG3Kft9Ri4FFZ3ZDnke+JEk59v6u/gks1dOgdt7fpF+9MkihlNQy0oBUXGRI+h0AOPYan65bXR3GHe9J1+3/y/XjoOa+OG8/+zJHWDp/s9LZRqENC486KLDZWYUdZhqX6+WmEe4wcdhhDSWNVkIxdQdqzmeX7EBAXRYuKp+ciGHc7KT1dbg/p74nrqkl1gIp7SRDIYfu8pwqoAr9XTp5b2Cf4rvfCEXgDdQNCDLqDxCqA2Lhbf/sccipKlApyXBhvLUeMrhL0splipyuX4c0rhYehKXFG07xRrEQ5HKUyCmQ4VUZY0BImwkmuOVKVmtmkD7hqFpMv2jupJkXWpCQ/ROemxPIoWvFmPlXtg5QZHamNL9581b7ccmwdEvwDqt2N4XskHUrrykAPRgeyWP1DqUC387RVjB36TBAqwwh7mr6MNcYLAmbw8FUVrRIac0Noy4WAd6cpqAmOm4VFQqsYFnqnbminq1Ao3yJyevAEb63y5KjAwVVOM5stQOzgKpVYhdwN9jsPlmKd6VAGHzFmb4QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qUDu/ofcGybKvYM8weALtp65d2Gdx0cnFwRx5GBzdnG82sgQDIS9oBSmrqJg?=
 =?us-ascii?Q?73v4mBRHVtMK2RqdQTACf4BJ5nl32GHGqi3YWSAo3VU7I+Ur4Pv+a7PyYRCl?=
 =?us-ascii?Q?QZXfdLalA5fdhF4a/B78Syh0JUo77gyxo1N+PQnl1RHh9GQCzsr/zL1SRK7q?=
 =?us-ascii?Q?yngQSdkbfsW7e0Lf2u8puCjDqq0mIFywdcuAmrv5FXJINBYLH9oLWTDyCH26?=
 =?us-ascii?Q?lL0aTPdSYsnst/DHXTAmGbsvhHNE3cKzWVhn+HoBPC743DeiusbttSpatABG?=
 =?us-ascii?Q?n1m7MdQF+h0d9QnjME4A1HkHn9E97T8y7WQPGdY4ayVfO6PrObZMldqXprgq?=
 =?us-ascii?Q?/wk0gNTNaROomLIEGsw75xoQIvu8zbV19mXVN5uY1eQJzo/Xeu5YRin/kuwe?=
 =?us-ascii?Q?ZncxSuSL3By6bzycVYrrSIcUN1Kcl6q5Nxmwm9nHzZVDYsCjsstLjVxufVJ1?=
 =?us-ascii?Q?xiaFiWSMxUNsJOgUHXziLCQWlMKiYKwoPG+jk+G/Ei95zi4Ycs+qr8YNbWeD?=
 =?us-ascii?Q?j2juNHvzohVPEG6D/+Gq+S8Ox4wK1yMhQrIXm/vQQUnRMlXjgLGLNFHz6QpX?=
 =?us-ascii?Q?Xhk4jMRZFLijOrZvNVaL6A2fEOgZS0Ia8ua0mpldre2HtpS/HPyw2yEHORMC?=
 =?us-ascii?Q?YPjgU+hGIWMtvOFLQbTfQ7+W1Umi0+CHljREDLFIpuZbd2k6iT7tkgjchem5?=
 =?us-ascii?Q?y3HdKol0Eka3QqaVGYb5SwJxS5MdKJKgPnOTJknSZNNboMIsUblG7gCzrFqY?=
 =?us-ascii?Q?58752e5Ntx2a7zaN5kNO2rCjZV1xucv1Xqgz7zQKbmSoIP8zHgcwd4vmGXvg?=
 =?us-ascii?Q?VQaJzglKTPzrsgADo9nCxqpXSTFe38mASb6YOPKMXnrQeExDjIFXQrvdB7cB?=
 =?us-ascii?Q?PWUYzCRl0eVDAvu+zc+xKTiU1/uAZhPPu3G88PIWdfVqSM6FbXaaA/2kFVF0?=
 =?us-ascii?Q?ByHSGdBvcTAC4US7FjbXrUd9V2e16g1ilA/iEbBz3B3pT0HHu+uxfztCyNGk?=
 =?us-ascii?Q?c/5TUqLtbQatLs7WgIRlX/R/qHelvjvpobUtFT5P6vKbYh1Kb9pWPWZtl7l/?=
 =?us-ascii?Q?px1vUQShZqk5SkY7fSK/RG2zzCkaSxoJa4CiX2v/FDb3A97xNmUaOa+d/T3Y?=
 =?us-ascii?Q?SABf3Fs1JF/9p167bmYDkThOle0OuznFwEHAaTzMl7aX0ULWF5nzriDMacu7?=
 =?us-ascii?Q?/StjMk4Eb0onsG1KaO3AAjiOu4JwTV5qIYqsh7wYQhYXfFKTQ8nf6xvfE4EC?=
 =?us-ascii?Q?ccYIX1nHySh0gOGu42FTkj314RDhhQMnaH0QAnf+9TpfgT/sTUYBTczfeMIQ?=
 =?us-ascii?Q?NZXVA96Cw2RK1II33eCvzz/ScTqQsVszZWHkUE9DW2+k7rIxShKSL/yn+NOv?=
 =?us-ascii?Q?NG1W8N2WhD18ESZITAleCFwvT6AOiMt4woeCjGF6B08Fv7vqRk+NYxSgS/pq?=
 =?us-ascii?Q?bdRzLMVs9d6kZPBcrWcz5zUVe9j4SqFrNl+xlAZlenkDIPqBDq72N3Im4FJY?=
 =?us-ascii?Q?aHfaPTav7KBZUOcv45z7769XW2hVIuDnLm4Cb1QfjwAwApNqN1LVOiiwdilE?=
 =?us-ascii?Q?GwLbHykPX8roMjqbjmoMHyE4Tvbhge1bMlAXcWMr7RHcsTaS+TlVtwpaKfg6?=
 =?us-ascii?Q?X68U6SZdNUiKlXtfGwtmK9cRF3sqsMJjGgTpnAX4/1VAxzy/0/eAjhGK5cT0?=
 =?us-ascii?Q?D0NvTSvAS2uXAZUUTWho2fRWV9p7xsPEODd1/wzb1UGTToQ4eIdctb7ClCjD?=
 =?us-ascii?Q?EuDb604DZGtIaLOTjCQnTktw1gNUmig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nPsXn8LZ8S+F81oqb9m7H6DjAeI28+88KnwNKXOtAHOZ2crALKyX+tcQfl6jV8o6I8TB/xbSUq4T6SL+xsmAQG9L50rLxr/Cm6v5K7xjPiJGXFcjIInGLnGNxr7MYOEW4KwP3NLEf8nN5hUgJRnzT8MRHpNPznrlaPo+Evo7DAzEkxQOIC68aU4plncQ+286/7+UT5wHdTMlOhsXcoskhgDu4R0vYhBclFPJxH+Yhgq2ZneIq9fQRrtBwGUYzLSCAur04sR3pQKuYqagGH5FLRtwn/hC2Ppi0sqJnZnXjDX7wB/eSdcYkVKpghk2eCOt+/+w4tSzQYKVMFOkSH/2hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d6d0e-ec38-4703-20b9-08dec17e85d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 14:43:48.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HysePxi7cs1pe83FQNPXXNln0RFaB/ah7qNMZcznL4ob7V1aBmvR04NCqfr8NkqgpJ3BZiuL9DIp0vrcxuiho6ohqkndNSeVWCsBNDan3C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4940
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Guangshuo Li <lgs201920130244@gmail.com>
> Sent: Wednesday, June 3, 2026 4:08 PM
> To: Siddharth Vadapalli <s-vadapalli@ti.com>; Roger Quadros
> <rogerq@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Kevin Hao <haokexin@gmail.com>; Alexander Sverdlin
> <alexander.sverdlin@gmail.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Daniel Zahka
> <daniel.zahka@gmail.com>; Guangshuo Li <lgs201920130244@gmail.com>;
> Ilias Apalodimas <ilias.apalodimas@linaro.org>; Murali Karicheri <m-
> karicheri2@ti.com>; Grygorii Strashko <grygorii.strashko@ti.com>;
> linux-omap@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] net: cpsw_new: unregister devlink on port
> registration failure
>=20
> cpsw_probe() registers devlink before registering the CPSW ports.
>=20
> If cpsw_register_ports() fails, the error path only unregisters the
> notifiers and then releases the lower level resources. It does not
> undo the successful cpsw_register_devlink() call, leaving the devlink
> instance and its parameters registered after probe has failed.
>=20
> Add a devlink cleanup label for the path where devlink registration
> has already succeeded, and use it when port registration fails.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev
> based driver part 1 - dual-emac")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c
> b/drivers/net/ethernet/ti/cpsw_new.c
> index 7f42f58a4b03..95b3b58db6e0 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device
> *pdev)
>=20
>  	ret =3D cpsw_register_ports(cpsw);
>  	if (ret)
> -		goto clean_unregister_notifiers;
> +		goto clean_unregister_devlink;
>=20
>  	dev_notice(dev, "initialized (regs %pa, pool size %d)
> hw_ver:%08X %d.%d (%d)\n",
>  		   &ss_res->start, descs_pool_size,
> @@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device
> *pdev)
>=20
>  	return 0;
>=20
> +clean_unregister_devlink:
> +	cpsw_unregister_devlink(cpsw);
>  clean_unregister_notifiers:
>  	cpsw_unregister_notifiers(cpsw);
>  clean_cpts:
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

