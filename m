Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00B3C455C;
	Thu, 16 Jul 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194149; cv=fail; b=WWKwnslelSfExyeXFme6OAGHEa/zil6nVsRIm64J9n9f1002ujiGyrxx71hAI1q4TroXGs1ES9gcMyZ+OoB8eV7i1zoYB6VaN5lN1yu6KjtHZKOwgggo3z5oa/KMrgr2FwD20W9Fq1oknwUvBfQk73dPTsVqnn6Th1sOwICJAqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194149; c=relaxed/simple;
	bh=+kIaRCKM/p7dG2qYVGAI+ws5PZSi7KHQLCVqhNthh5E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OprqrMQxVRxESHcBWI9NzH+WLki4hmaYQL+OGRdtSN8eK1bFUrbhBRai1zhBAHziPfErsG+QZcm2smeHFIz1s8fWW48nTw4XMLJRp+UJHSjJTIo1PBRPYzEgr7QRO51eX9fzJ3nEjgKO+tZmfEh5nasVfgGAmqBykMJheW7dWRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrdE0+hR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrdE0+hR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784194148; x=1815730148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+kIaRCKM/p7dG2qYVGAI+ws5PZSi7KHQLCVqhNthh5E=;
  b=VrdE0+hRbM12TXIpwY2R/J0rwOdcUDxh7uskBbuK+UEpt53cbarqMRc3
   6Z96v+vNtZx9T5fMVrPRPSM5IJFPost5SW6FzkTzGb6aaDaoiGoNDTtWI
   3gFrpBW9mmj+nAkB1MMzm3luvfrsW0pRaEY8f3iFTGdPmQeOtohsfaDlQ
   Cfdx/MJSmVZBbw/fL+mPRTsZ8K1WpOk9wuT5xWPDO3IaFTolFh+2DNkZU
   T2S/TKGvbTYQAPcoNYaJrUvp8ocoVqSLgnAMntd47F4HsOvgwwWOJ8CQY
   23gLrgVd4UBKF7A2QxMrWZMV6h+qwPZnhgBLp1EJLebqTBEj/VTzGsXgS
   Q==;
X-CSE-ConnectionGUID: dOurRiWgR/CZrvSyU4qbfA==
X-CSE-MsgGUID: Jmebn4g3TIma+Rq6iigJ+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88750950"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88750950"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:29:07 -0700
X-CSE-ConnectionGUID: JGQhZy1WRPSw2nTMKHpnCw==
X-CSE-MsgGUID: kA4pIfZ6S9meV92uUpDopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="254695236"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:29:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:29:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 02:29:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 02:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOVl4nbRdcK5w6o+68xH1i9rQFudWRBDVNRCZC1iI2Yn4BP28Xw1909Bjnbpr3CMEo6Z6L6doCT9mHx1FfjsPM/pQ7hNWNdQ75TNqs6kT8qYlNY8JjXJYjVJKzeEIxZJJxTYYKFmT6YC+Rii2AcpwJsLg15uE3PgPcdgBcv+AtnnSpIQknSk3DagqDOKLSBFLA5xPVLZ4bP62o8dveD+7LTSHYKe11rUtcrmLwWOcCDiT8/pnZc3iR03BWNUapByJhYa7t6JW4lbvB3NzDDIXWfqrGIu+oQmf9qlteWMnpMzJO7fhk3qsRJufBHeKWpaW9hTHHNv1TTHvZPUf+zkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGFFvIU/zL4cKRbo8FUFyXv2+mSg1smMNSYP42TWlJc=;
 b=UTPlor1/Tp+cfhGaHcJ7/L1FxE47qJeBY0obAdEe6xmMYMaEJd3FaIEKCHLecUr0/fj+r4cemodhYrlNTmfhevccAv1WBuezeHlCXrjlsnej80kUQeCOJOityI0kpsTiVGShXfUZXo3TNmMI+JGpmrroP/keNSE9QT/Lu9qsnfGCGiqlKVi2LhrCVXGzFPRZChLirTMHeL73o0BLHDHikE82wpcYuVtJustMm5ufX2juVNzG8qAR0DXl9knK9q8uLFKT5V4l0QD4lfJXIj9B2UT8RAZAkkAvB97LujZ40rsytQSVj0vdsTZXTWscXQ7soSj6vHP3hztM1oNSjX50uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:29:03 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 09:29:03 +0000
Message-ID: <61bfa6e4-d8b7-4bf0-84f2-173384c690ea@intel.com>
Date: Thu, 16 Jul 2026 11:28:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for
 error handling
To: <phucduc.bui@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "Christophe
 JAILLET" <christophe.jaillet@wanadoo.fr>, <linux-omap@vger.kernel.org>
References: <20260716090829.72082-1-phucduc.bui@gmail.com>
 <20260716090829.72082-8-phucduc.bui@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260716090829.72082-8-phucduc.bui@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0204.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::25) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 919438e2-8652-4d99-e092-08dee31cacb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qvjlgcChfQdCs/2jwow2CJG52vHLWajbRB2diUdslP2uQdLRtpIIUI00gnfYGy7a3C/XReiqYwcNBlYD8BDAJLxuGz2LzQ5WYP6E6aNM4Ea1h+PPB7IBKuPDMtXb1YH1Lcwkmiaxcw/PoE34/nb78PB0lS0Za44FIQIypq9LRAB9R5L/4tgb8DaSrZQ3GkAhciP89Il7nchi7dZfOmJLAqg6AvWipHncO9ADE7k/B6zV+R4pYUdHJCf0qkzHH7vLC5nAYDauZRD15MKit/SDZso+74UL7S55Eoe5ym+J8vOpxBQOaWn2DUvjkHLGEEVKbvgmTZIiY4lTXa0w9xSTl4JZqyrhdeGU8IUWv/I2zmIIFGlWzSlcBGh9/N0uD3tF84R2lZ9xXWc+cEkje5LOgLmDRELWUCcAfj+8orriS8mck4oW5Bu5nQHAFRBXwCqdQRmsPNSaiXiTeEvgdLy8mxU8xU+m4tlD3ZgJt2SX1FhBVyTrZGWYYMK//ROb7CGuMQ01Izn4WdFwKelCW4nrVX+JKruQ6Xy8R2isvyoUn4PTL+N71HzvVd3RX3G2/JI4qxftipsPjaCIMRud24lXoelMD2JeALv8DnYjLhg6PbE91ME0qVGEUAFNAsnfEJO4cSWoQ/IXq45P220ORIH3ot7pSRzjrbPCG2/R3xMGkfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk93dUJ5eUFOSndNWnFUdW9JTzlIMzZ3UDI4S3VkNHUvTHBIMkpTRDJ5OWsw?=
 =?utf-8?B?SFk5TlVtWmVWeEtFZWI0Njk2K2s4RG1ZdmdxYWdxdnBJdVhSdlF0ZStLNXg4?=
 =?utf-8?B?ZmY4aUl0K1I2RGpOc3NrVHVwSWp1bG91MlJDT1RRZ1FLWDMxWi80RnA4RW9J?=
 =?utf-8?B?bzhZaWxzRGJxVW41T1JsUWtmZElnYlJjenMwazZlenFtbTFDRERSZUVBaUtO?=
 =?utf-8?B?Z2lScnNYOEoraGY4RmJESTNmcEZ5ZUxCcUJjWHNGZy9TakV4MWtJdVMzQjdz?=
 =?utf-8?B?dStPKzN5R2lNSERGR0YrRGlKcDlTaitZWDVaMVljcHI4WlFwb1k0bnF1TEtQ?=
 =?utf-8?B?N3hiWlR3d2Q0cTBTUlRmN1lZVWJyaEwzSUNyUDRRY3ZVcysweU84QS9TSUJE?=
 =?utf-8?B?SWNxWFRxYzAyTmkyZE05eEZHak1HNk5tV1JVQ2ZwQWl5cHU2Ui9YK0JVMlNO?=
 =?utf-8?B?ODF2MGtwVEthSXQwOFFiVTBpb29TRWlxdS9LK1NJbTJVNWdFTDdEcjd1bTYw?=
 =?utf-8?B?M0xkN2prOW0wWHAyZU1EM0FLWVlZbldnSGJqczhBNUxoUXRyMjQ1TjUzZjBT?=
 =?utf-8?B?SEYwVGlHT3ZlM2w1TkRxU3ZIb1FETSt5RGF3WmcxcnpSa2crWHgwV0ZLMEhp?=
 =?utf-8?B?cXhnb3ArQzdUNDBpMWlvZW1WczNyY1Y4UWo2elR2c0ZhS1dLUGM1bGs3Y0FG?=
 =?utf-8?B?N3M1TGorc1ZlT3hsdFJSM2V6ZVluencvZ2dpdENxUll0Qy9LZmxKU0w2QXlv?=
 =?utf-8?B?NnRrWXRVQ2xqV2d6ZzNidHZlZDdTZEorekxZdEhMWDJXMWNDYWtEaGNPM0Mz?=
 =?utf-8?B?aHdXNDljTkE2eDVlTWc4bHZiVzQzYlJZcDBSekdZNEtNbDBhdUhLcTRVU1pP?=
 =?utf-8?B?VFJvVVJJdjdZSk9NVS9QZ2RYaXd5MkRib0VCQjJGekhzbTdpQi81OWMrZm5o?=
 =?utf-8?B?UTZlQ3hUN3BGVlZaZVZYbHR5SEZoVHJzdnRVTzJqY3NKbnZKOU5tVDl2SlNv?=
 =?utf-8?B?cUhLcXJkNVNJVmttQWd3ZXZpVG1UZDRUTDNsY1NQRzYvbXZrTFJKTkJTVWVU?=
 =?utf-8?B?ZGEwN1dtaStsOE5rcmkwS3pBNmFOa25YNit4S3VVOHBoaitCMWhJMGFLcmN6?=
 =?utf-8?B?NCs4QjZXRUlHQXVza09HRFJlRWVIcE56ZE9IK2w5OWhUZXdOYklSTllpMi9D?=
 =?utf-8?B?cXE2MWxvU2ZCOVd2Y2VSWXF6WTc3MlhTQzNCMXR4ZmwzM016bWlkbmZSaWVS?=
 =?utf-8?B?UEtXT2MrOCtuRFl5djJYeHhTdEwxQjBlNkxRaithcjZTSkpVWC92b3V5M2Y3?=
 =?utf-8?B?MG1wbUFieGZjM1BXT0ZSbWZYbDVXaEtpSGRsdU9uOXI0RW53RnFVd1JDSVNz?=
 =?utf-8?B?bjhHZ2tsL0FMV29ORkYxVUhLVUI4OU5hUU1JeUdoS0xZbmJOU29MMnREWEJm?=
 =?utf-8?B?UWxlWG16dklNRGU1SnZrdFlkQXlvU1dVNVpJL1h4eWtBeUUyTDg3TmtvNTlw?=
 =?utf-8?B?emhCTjFoYmtjSW81TThwVTgxY01xQjlVbDFJZ01ab1NDUVV3OEZPREtpb1VY?=
 =?utf-8?B?SGd6TWFJd0JIcEJEdmhueXVHSzdHMW0rMGxaM0k2S2xhdGtobUpjQUExVFN4?=
 =?utf-8?B?bHhRekU0WWMwK2w5bWh3RGlYb1RsanZRc09vblpBdzVSRXNRQW5YVTlZa0JS?=
 =?utf-8?B?RDNRZXIvZEZZL1c3VjVvMDJmNm8zMGRSVDBnM052c0tnaUtmRFRNZjRNcG93?=
 =?utf-8?B?Vnc0a2FEbzNWbG5HMGZFUlpNWUJRejh6STErQk9jc09CVDk2anNGK0IvRG5q?=
 =?utf-8?B?Smg0MWNldFlURm5STzFxaUU2ME1ydFRXZUJlYmtrSUkxZWd1TFBCZVpDRWQr?=
 =?utf-8?B?NlJEQk1venRwUHhHaUNqWmw4LzVoOHZRaHlXL0g2bXhBQ3o2MEptcFpZQjZv?=
 =?utf-8?B?eVZWRnBIZUxsc3J5b0lwUWdJcVdoTmxxMTU2QjdTWWwzeWJOUlhGc29paXZk?=
 =?utf-8?B?M2laTmVqbG1OYTRQUUh2QU9UNDBRMHliZGdMbml4OUluczhwSUVoTzdFb0F4?=
 =?utf-8?B?MDdTamg2ME5KOFlpeUJqYjc1bjBJYzBCZ3pGZHRrcWcyQTR6d2wveU9MaUhv?=
 =?utf-8?B?QnhPNmgxWTFRYTlDZXFYUTlHYzZqc0EzTXFxZ0htUCt6T2hEM2pEY1JidHZn?=
 =?utf-8?B?ekJTVDV6R2VrcHcxR2ptelVhVHEySkVzVDFlYTIwNzFSM0huU0dIV24zMFlM?=
 =?utf-8?B?RDBUZmZYMjljSElMSU05cEphNVJXYWlOL1RBZy92bDNldW5xZ1VMNndzNlJH?=
 =?utf-8?B?MnVNRjlJaTVpeXhGU0lxbk5rTmlIKzdTRWhoYTRVcGVxQTVXbXl5QT09?=
X-Exchange-RoutingPolicyChecked: dizNi9HuZ411M7P5BTlPOzsVSJKXZ83y1zMf+ehaamnPZ2VPoFWNjrmbwYx/E2KLq2VOfEYZaAULvpFBY38bVIX8bEoa1D6u1AbCKTL6VxVE7Ut7JOIBKCDTeJQdrFz/E951yTGy53j7ayuf9I+4dt7TDq2fCrjx6x5WUZrwWK0fl2DUQFQKxlKH1fAfO5LvfB2F894EV525X4qbswxaV1ZBPWg+OrpgtlC5Vvbnf4ZQxKt2/mt6itOHJPEBP9YF91qq6X7yf1OnNQoga8SqXNu9J30QhWs8ZvFAC9oB/Uj+MtgJv0ikrxoFj16hGsxuN22epkAJXzQ7erOJySVKeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 919438e2-8652-4d99-e092-08dee31cacb1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:29:03.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nQ+89nyKgssjvGyBTzgKlVhxxe4mNUgLMU4VFXGFbKB8FgmeQ1qKAgCg48BEOXZ7U3P5JEvC+2h/uHjGuFiKT2Gk6WRiGj3xsyoYAhUzl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com

On 7/16/2026 11:08 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Replace dev_err() with dev_err_probe() when reporting
> devm_snd_soc_register_card() failures. This suppresses
> unnecessary log messages for deferred probe errors.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   sound/soc/ti/omap-hdmi.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index e60f5b483fc5..72114965c37d 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
> @@ -375,10 +375,8 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
>   	card->dev = dev;
>   
>   	ret = devm_snd_soc_register_card(dev, card);
> -	if (ret) {
> -		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "snd_soc_register_card failed\n");

Some patches have '()' some do not.  I'd expect all the patches updated 
as per Christophe's review.

>   
>   	ad->card = card;
>   	snd_soc_card_set_drvdata(card, ad);

