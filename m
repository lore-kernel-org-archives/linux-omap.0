Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5540A921;
	Thu, 16 Jul 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197184; cv=fail; b=BJod8YNI3590S/St2oI1wZA4NsJpjQvKtvIQIQ22gJUadBkb1QcTlKszSh2dwJ2DEThCzLnniZx+KVoUkeldbSQFKc4GEBf3ObCkgrRt2t8r3Fymb6A6caSZfMV1cMDFU4kBzWc6OWyf+Dr55oDAtxgepxuhatnRlQSG4fsPUuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197184; c=relaxed/simple;
	bh=CBm8VYt3YQBpNar2MH0dxVss8sKQGv/gf/t03boatFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LaVNzYklrbKvd9ENsfmcYFSNukkqgnwK2UFaYLihDfHSrA4fJ6VLZASEjprShBnAn/GaFlm+gWYUtxQTBWwFRyoN4zMJsGVqEgMmXOUfdcGI92px87bnkmTMR/fBioWFAkL2m0aqdkhdusyEt7RQMZjUPT8HtGoJvIImS73aDmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlCXfwl8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlCXfwl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784197182; x=1815733182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CBm8VYt3YQBpNar2MH0dxVss8sKQGv/gf/t03boatFY=;
  b=ZlCXfwl8OkauYJM8FPTdlUsEEUtzTEUobPVwbDCwrrLlaMv+lIPQHLgK
   JGMB/EjnDGnP/YGYL2QmCPVzYQB6N6QDYzDUumzj02mZ9l4qgx4HCrQV7
   TurWLpoodRdVEXsKTMiKaccA4ECZfwVPEmfdxu9FYekoTgRNDxHTNggEi
   3f6HLv0B9EMgnj64v+qm/wWyyZk7yjBGdccdVgTbeL1Z4WBbnGSZf04XJ
   4QD33kPVJuvL+XvjtOORKu/vSMyspN7Z1uIDPkP71oqDXQtKRLV/tTidg
   Po3wF2zS15HrViJyltOIhAAg/4Tv8C/51a4fpyCfWcyFmQsU96syyGrB4
   w==;
X-CSE-ConnectionGUID: 95xBOfhaRri3njjxJvojtQ==
X-CSE-MsgGUID: gqDDM7EkRh+8oqcKd6PsgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84812031"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84812031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:19:41 -0700
X-CSE-ConnectionGUID: wlU9EgCGQBuxRYsKl2mubA==
X-CSE-MsgGUID: 7a8RZipwSbeM3kSpmP7tKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="261385195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:19:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:19:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 03:19:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXeA9K7BKAUzhtNX7t0VqjRarac62OKz0QPGfBrfxoIQNBV2uiktpUZTA7/SY25AvtskziyFrqG5WaHXm0OQOT92ihjvNvF9q14vTHd0i+nSPs9pIbpAqU/TZH1+WBgR+jtXOg+VlC0Tp2y5B9zi30csIpJi4MZJ33oD+5K3ClVtw1qVkzncf0paaoVhUs+702M2r1geqh0bIISb8TmpPcYT7HkxEKfozn329lD1/vVTG1DnXqw83VQNuY9GPhe08WQpNDnteLjysx6l5ZD2doI6rsZVm8H7kOpGI23HoGQ2cUPExgUvSlt604ro4dnyb4VXbalaF/TPmDcTcDzgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKAGfwmpDenY9O8Wo4GHQHFA37+HJHzLZP5xB9JjgS8=;
 b=vPuG1Jl56fBSZRuF52r+TJyuQDvn5oJxXlVVQ+GJqqRTPyhcTAG1VRMyIIMUYEC1kvUzivuXEGFYJq3T3f9qrtZe3i7fQr2OWpah0Yu6USU0M5LeEzeMZGCRCGTwGgVYecvXRDiSsacHHxAv5ArsKxU4yXWZBvTkAHbI3JZarzsQ2few7nLvMq5PmwuwJWj5LkMEykuTJ3kGsLgDf8Xkdc2LDtYH9bimQvgkloKJepk9v1qFAvlVIq0+KFKJ3dbXFop3eWPeN0CbxnI9eIftBG37sm133BJu3YonmqLc/SI5s4vvn8ZNSVtUPzvbSF2VTClSqvNfRbGIE01SIelGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by IA3PR11MB8919.namprd11.prod.outlook.com (2603:10b6:208:576::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 10:19:31 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 10:19:31 +0000
Message-ID: <3940b68d-da97-4e27-8816-e912162b6f62@intel.com>
Date: Thu, 16 Jul 2026 12:19:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] ASoC: ti: rx51: Use dev_err_probe() for error
 handling
To: <phucduc.bui@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "Christophe
 JAILLET" <christophe.jaillet@wanadoo.fr>, <linux-omap@vger.kernel.org>
References: <20260716090829.72082-1-phucduc.bui@gmail.com>
 <20260716090829.72082-11-phucduc.bui@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260716090829.72082-11-phucduc.bui@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|IA3PR11MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f724010-2290-4adf-24ba-08dee323b9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aryUOgFnuF8p4l/OsioC0stuCWaJ5Bah6lri3+0GhQcThw7aZIdfi0gunzOmxaAyFcRAEJNzoxwW+iZxAuoT1fd1TFbq09BPQ2V3bKgB4wjjN7DzpbDEKHd/6nB3HLS0v4lh/E5cJhbcluJoJTk2T+Y2k5JmtZZ12GN807Dh8qoIa7ytEPJRifTH+6xizSykxP1bVfG0RysLW6PFljhQ7IhNPyNb1omUDFy4+ArzIx+yGTB/PtU3VrURWKiPNlW2B69VmdOzVRmzyGtHz/2oCi2oBgER6Q2qFvHOrSu8sG++HcULzpKMCTaAGQyJ6bAr4nLWEQun8tq9Sd+UUsffIf8HPjCcqcJKWNh+slo9oXSL51fAWV3tgJ6J/8hpUXT+izIBsBuPA1vIeO8RXD2GzY3inl7rwazmxipTwUSNNyON3XiDBIgghJRUkPWjzLPp37YgFYrWJekMXV+yZKD4iLGRvFWAscCo6joZ5cLBU0EZ+vlKpSFkRVtRQgCD7ypsiJVTqx+yTqmpYEI0Ze+L7vLGwFpBrnpu+v1pbMbHusQYRRHZXs7ZobVznEhOlGeDCqraMwjs+9xONMmqKHtVMoxp+LPgD1u5nfZ/o66SOGa/csGr49vmER9V6eRPxIgRMd5QeTJy0Rbt470z5Sueav97S7bBeKG/7C0aqSnukFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NzTzhFUmQ1OG9OaXM1dzFZcnVyMGxUNW5IUmMwbTB0c1NUNHFVM0RkSmd3?=
 =?utf-8?B?bFIvVTNPTlBWczBYbU5lelpWMGRaTy9SR0FsbDYzd3JOVUwrYVhDbTlnUnVu?=
 =?utf-8?B?YWJBVWpYYXViMytlWDdUaWtXTDJhdi9rQWJuaVh3YndvOTRKTUxjMHZOTVRp?=
 =?utf-8?B?ZnVaci82Y2I3OFlJY09XM0xDR3B3N3VHN2E3QTJPNHN4UkE0Ty91c1pSUmJt?=
 =?utf-8?B?UDBxbmVYVVBFQTZsK054UGNQNDdjclBmUENrcDJJVUxDMzdlT1YyL3c3MDVw?=
 =?utf-8?B?V29Yd2RnMEdQU1B4SDZQUUMzT2VTalB2S2xHTW9iZDJwUzlLMWNwZHZ3aWxx?=
 =?utf-8?B?blg3MXFXMHFWN2k1aS96OFhtSkl3U0ZTZm1yMXAvN1pqLzA0NDNGcWgzcldp?=
 =?utf-8?B?YjNtSUFzNEhwTFN3eHpiY0V4Nko0TzBSWTN4SjRxWkJxbmFsbEREZ01ZN2J5?=
 =?utf-8?B?cHV3bTVTWG1VbFZ0R2daSkJzZEYwcm9JWFNmQldURkJQUVIvdHpwSkRCVHBP?=
 =?utf-8?B?TlJqUGFZbFA1c3JGK01SZmVyRHZXRCtLbloyRG5yZjJoRzdyZjFQQzFyaDBk?=
 =?utf-8?B?TENDNm5UVHBESDBsaHhnYzAzemVTVkVuY0pjbG5KSWxFeVJzbUozWXh3d2dy?=
 =?utf-8?B?UW5DeVFVU0dXYWNTTWhxeEJmVkhDaU91WUV3SWdvU3ZtUXR5eTNnUjNsbEha?=
 =?utf-8?B?WEJEMFVucEJqUDdac3FiaFdaZDNpWDA1aXM3WG5EV0I2UTFkYnlxWm5XTURy?=
 =?utf-8?B?YUNIeUw5aTFnOVVzdG8rdGQrMUE1UFJBd3R3Vjlka201bWdFdDkxRmtSaGJo?=
 =?utf-8?B?bVRDcERack4yRnRqb0dKM29veUY2Zm03VjZib29VTFRob0NvMzVUelphSmlw?=
 =?utf-8?B?NFVRWHVqYjFiSnBPeDhoZ0VSMzk4L0NpNUZzcVdIYmVhWU5Pd0dwNUVpZXZP?=
 =?utf-8?B?R2FwRzNyYTIxRVVMYWc0RnNpRjZ5UDU4dnRKZ01wQllqMHRFblFFTFE2clU5?=
 =?utf-8?B?WmhNSHl0QldLREM5YzlrbTE4MzhlWUhxdmc2NHl2cFBmT05HMzYvcFdRc3pX?=
 =?utf-8?B?QzRSWUNVOXJucEhuWHVHTGMvL3RyUVVuOXNYR1o0Vmd6T240WXpKTElvb3g3?=
 =?utf-8?B?TjIrbnlSaGk3UlEzRE8zdTQveGxiVG5FL3ZkY3VzU3dmVlo3T0RkUjB5VDFB?=
 =?utf-8?B?T21YY1lvKy9uVHNhOXJrWFpNL3dBQmZYeEJPWTlTcHV6MkV4bjUzaitiZUFR?=
 =?utf-8?B?clR0UGJNT0lXUFFhREQwd1VEejltTkVSaTB0d1I1UVp0NkdLaXlSVGZReGVN?=
 =?utf-8?B?KzlONzRscldNQ2NycG9wa3BQNE10S2RlOWpJMHMyQ0FPZGdISjRoKzB3QUdB?=
 =?utf-8?B?WEJxYVVxR2NnK21iaEhaRUcwQlhsOW4yYXZ2eS9HTUtZYUZzU2xiY3BIelBo?=
 =?utf-8?B?RjBNVVFxT1hTL2dtbThoZnk1aHpHakgwdmRLUDVtMVIrZ1kvSExpVnRRUVU0?=
 =?utf-8?B?cVpvWVgvZ0lkcDlsc3c4R3dKRXlDQnFueVVCQ1IvWWVTWVBwa1djcTNqbjR6?=
 =?utf-8?B?Q0dpTGkyRzBZRXViSWs1bWZOM1NPQzUwOW1hYnhUVkZPR0ZPVGdNNDRnNzY5?=
 =?utf-8?B?Q2ZwTUduZWdHZktQMFh6eWVuWE1IdmVJdVRBakZvSy9lRUpxWGFrOHVMQWho?=
 =?utf-8?B?enA0dVJ4MmxIS0lxc3dGUXFqUkpCcGtUZ3I3Z09kYzRXTFZ4VDVsVC9UYzBl?=
 =?utf-8?B?R2g3ak5hSlBDa3NKNk5oRzZzUUg3T3pHL0NVeVFmQVNOK0U3S2RWK3VxNlAv?=
 =?utf-8?B?NDFZOXhKb3gzUTNsSXFabSt2R0xhaGNtZjN3N29mRWJreisyQjRnVGNHUXJV?=
 =?utf-8?B?NXBXRFpnNVJjalNOZXpmdmV0SE96TTZzeW05TzJLdXZLSzF5NFE2RkE1bS81?=
 =?utf-8?B?aWJmUzUzUy93enhRS0tWZzhxQnRaNGVZTHQ3VGFOVUttYzBJYXI3QUs1MDBy?=
 =?utf-8?B?ZnQvdi9WejNLVDhjWXBiemozdE9JWjV4UTdSL2pxVXBnME1MR2J0M1Y5WnBl?=
 =?utf-8?B?ZGZTQml4czJ6dHRBWFFvVUlMVHNkcUZRQ3pYSTgzd2ZXMDJ2RDlvbzNrZCts?=
 =?utf-8?B?RzUzTEZQTzZyc3JjUE5PeE80UHlmVHQ4TE4wM2hRODZHTVhOYTZsc09JUUVh?=
 =?utf-8?B?Z2ZvbWNTWjhZbEpHRWJVS3kyRXIyUkM2T0VVRWljcUdOVDhTR0FMUnFOV3M2?=
 =?utf-8?B?cEpVVkRxRWVVTHh6d1pkSE4wem4vSko1eEt4STJHNjhNakgzUnZELzFQS2ZC?=
 =?utf-8?B?aXRYQmpNYTNNdDM2d2QrYU80YWxHeXk4aWxlbHF5blJ3SUlpRXd5QT09?=
X-Exchange-RoutingPolicyChecked: ih/raZTP4l0DmkcJYNHgh/12SmTATL8QeIrRFaAy5u0eUbEGAIITAgbP/Ja9PMLgpScgPCuFYckrCoy0B7ArXCRIvmamA/LOIpAyK8oSft48aQSCf5lsE1VNLW1Iaw5RtYdojI3xyFBLPPwaHbcjctA/ZLZNEhERJBM2vXUyJQPjXN8zVnd10UgjF0igOcudLE1bHKUFc8IkhiiIGrS4MybyPDr+uMkdXeYe6sn2gp7AF11G3E3sgZsPNBzEa/PI87zKRH+Ai28e8cq0Yr5u78GhEw3OigsBZy7+jfif2Eygx8pnZATldkaWQUXe1mAC3Qk72TGEGNegA0rXZE0l1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f724010-2290-4adf-24ba-08dee323b9b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 10:19:31.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N+/df22O1Xh9e/oEBybUuwpms3r0rI6uraPqVf+7wzK6BWHPNkYNOBvI56BwHizvSz3Q9//SBmHeaUxRhi0EdOz8B6gxN/dgM3hMsJCje4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8919
X-OriginatorOrg: intel.com

On 7/16/2026 11:08 AM, phucduc.bui@gmail.com wrote:

>   	err = devm_snd_soc_register_card(card->dev, card);
> -	if (err) {
> -		dev_err(card->dev, "snd_soc_register_card failed (%d)\n", err);
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(card->dev, err,
> +				     "snd_soc_register_card failed\n");

Pinging this patch too to make it easier, Phuc.  Certainly 7/10 isn't 
the only one.

>   
>   	return 0;
>   }

