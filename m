Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4641A546;
	Thu, 16 Jul 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200529; cv=fail; b=FLTiU+9VnyFNH7FCFM9cqjZPBHRXewO6iLIs6wTghfnypFHYpLO9VCmWdXfl2W18ju+RJ+/mt4x5l0w6CX8ZaDmo3gCNsQfG+RO6wc+0OqDP2LNvODRV6UNzWChnSyA+tu5Bryy8jfoWxLqvQsqoQu/dTc245O5Pgt4TVAWdXKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200529; c=relaxed/simple;
	bh=R0iTNPnl1awCfJdi+Dzo/S8JdCM4FjkgrAIye/kQs3E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oL3BJQFWDOUvSqHNnIjp4FGhBzsh6tcjB6MZsHkplng4/NgQeVmiG21x3cofzY32KJIhwodURxJjN+MmTlfP3IGS1W1/1EiD4AomE6wYsy8MuEWUW5OEGDJbzO+8oLx6P5s/A9nmPr5+N9H7KCIy7T2MDwPo9fI/uDUxQoJepLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/AyTx3M; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/AyTx3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784200527; x=1815736527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0iTNPnl1awCfJdi+Dzo/S8JdCM4FjkgrAIye/kQs3E=;
  b=J/AyTx3M0Ay7BRVYwwNF9cXyowXUeoYyPBZXj5Tv/MWD2tL8F1GkLY8P
   GbRwpRFWT9a/nn0GMHQdlM+gtjXTMMwDcCfjDMLzxusVUBsS2ha+JupNj
   u+lIpA0wmhTSIMha1peH4k0HuR0sKkbHRolDsbe4tf2CSKmy9pi/ZRg5o
   L9nFdNU62jiC41kvbeCO689wiIGJBL7V2lRGcgPWa1NOo/Gn/EuFU7nzI
   JvqGXzGJUjAixObYV7x2e9KUGjF/pFXGolyl4gTkF6qjsAOL3aC2BAafx
   OxJ3a91Y5iJyggWFqziv01uBHH4TcGh9FBYc/Y/vJfO5H6xEQA5kUlStg
   g==;
X-CSE-ConnectionGUID: yK2Ui25dRl2EMqausYVm8Q==
X-CSE-MsgGUID: +ImyhTiXQUKN/Fq55mrMTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88533569"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88533569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:15:25 -0700
X-CSE-ConnectionGUID: KQ8a7bCySTGw7N06KQIUpQ==
X-CSE-MsgGUID: GjSgclVOSgaow1YdmBWlNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="294702548"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:15:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:15:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 04:15:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKYJDOJlyKcwvl3NVWA2k3lhBP1yEr+xjIo79I13eu8IC3gkusTOS7Fwsvf+G8TQbEAaa2a84krcuhscqU03Sz4ywXCis0uVX7oQwYjIPPTkriIv1NeIq6urMdGCu+877khQadoXcq76epXhvqxNaNpP1HAynJvqOk3Ql6Ov/hKhob/tdlMw4eLtjlC3lhaQgzg3YVE8UWbjQH+NxfoUpjvoYwxeusnJ+pbZWTE/F8h0+GKOmy7yxmGf3sZX+UJNyPNTv1DXH5VweuKzF9S6tE/vs+s+fKn1//0mhlvP8a66UA3iRfb1WlL5PqANcnQfXFq8Lb02gXAEPmWGD343Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4tCSr2aHwW7qWKHp8pe/JZQZF0PvfZCWdJ3KU52x9o=;
 b=zJyWQ9Y+DVUrlhdnBiEIcMTh/e/D3+imM7d2w25+xAp8vHyMfr+UhY8M0EJ7dOpCQsxeRPjO0I2A8UXDS8NPFBueeruHM53Gt7JFXQ2/21mr08YsTvZAZGBgtsoAIqVJs7vM+RPMyq7035JvYoEk0evi1ATkeV/Fu8URdyriCr0/8fyynplWxWvFlwHoEdrJI5ek/cg7Ocr2WorAQsF+etwM1x5PPTIuPGheUwzvCWzTiStVCvwlO09dI4a9d+Uvi16yiFktYz34fxKsV32JNI96KJuYjiPBfOVuOKZAeUhdujRnD4Z2gBk6WbCP1p4eISpHeX00aW0PggHhT1mV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:15:22 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 11:15:21 +0000
Message-ID: <1d4ebb0d-816e-4176-89d1-065a7bae00d7@intel.com>
Date: Thu, 16 Jul 2026 13:15:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] ASoC: ti: rx51: Use dev_err_probe() for error
 handling
To: Bui Duc Phuc <phucduc.bui@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "Christophe
 JAILLET" <christophe.jaillet@wanadoo.fr>, <linux-omap@vger.kernel.org>
References: <20260716090829.72082-1-phucduc.bui@gmail.com>
 <20260716090829.72082-11-phucduc.bui@gmail.com>
 <3940b68d-da97-4e27-8816-e912162b6f62@intel.com>
 <CAABR9nGtoFmHjUcbhKxwY_-YJ_Kb++OVN8YkZKvkCMgBEHFjjQ@mail.gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAABR9nGtoFmHjUcbhKxwY_-YJ_Kb++OVN8YkZKvkCMgBEHFjjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::10) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dbab97-a1c7-42a7-69e7-08dee32b86a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 26S535+BklMsWD8jW/7uqTkKDbvxYYT6bGJER5tJm/wiYleOdmZMOSFa5I4gVE5oHUJps7nEmRV6LO6ofZl6QyM2jJhqzS3XSoYLGPcA4KiVCImvnB0VuZ1473ndK08BNZMmY3L+RinE/Qhx0hD9445U1mHeH8vI91t9yTFXzPyYEct/wNMy3aXPF1RgDGtEvkmsKE3xda3EXKml5EOVCgd2guM+r7C4cNebmJgvJTtOYZU+r8p5lyK0LA8zL3l+gaMWJl1geB9sGRj9HqQilfgN04+q8C8yoDbRstPKBITQ1NJNzt44Unt1mWlCwiXJpt0qj4TH5pkOhssJk4qRiCoSovXoXF97vKk16s8MXdXkJFM+cW7uJiXDBYq3NDQG2xET5fjIINpFJm4WqA/Lrg/eDi3/RLd47F1RUD3LReoVhI7pufH+nX4SBVL4XyEx2GQ9+fKUDO2GmvNwohfeYFFHXJOdpPac7h9x50dorug1oDoMXGcYPVhnA33uj6Eg1D2pQzBsFILHQ6pI7x4IFT991fg3T+6OTow7KPtbxqWb1se+7K3Vm37WHfbSisVGFSRAg8IdfCwox0GWlSjiSWOKQLwjrxcUIymfL1GS2gG4onPBGCbJ35KR1QVikGDPNhFs5laNwyr/2mfBgbok696aXmrQaUn3WquHp0FdSls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBTOWVwdTYxbUEzczZ0a1VXNHQwcE5DbXVCa3kzcTRacW0zUXkzZldMMWQw?=
 =?utf-8?B?bXA1anVSM1ZIS3dCb2xQb1phRkNsd0lXdmRnTVFYbkNuVUhGVVlpVW9MeGk3?=
 =?utf-8?B?RGRJdk5FbTFWTWhjSHB1dktUSEZwNWtDL0FYUFRnRjBsTHN4Zi9lMlJJRUx3?=
 =?utf-8?B?ckNTa3hIRnNYSit3UDlXWFVzdTJzR0liSFVTczBsVXdFcWZ3bVJYdFFuNHNB?=
 =?utf-8?B?aE1XL2hrMTRiQjlkeC8ybU1zaE1JaThPeDA2U3liTlBBV0lKSEFZMFRlQUdE?=
 =?utf-8?B?TVBSLzVVTEdCdjZvZWpvMzY4aFhoVTVYT1VNTXkvMEpVMTk0aDJSdXdNWjF4?=
 =?utf-8?B?WTFGUWNQalEvSUxFbWZRMXovdURtREJRU0ZlTzQxNktrdFh0clZFZmJSbWR5?=
 =?utf-8?B?TDNKdHY4L1FUZHQ0R1pKUmpIQXV0dmYrQUhFQjF4NHZKenlndXZUd28vaHlN?=
 =?utf-8?B?ZHNpNXM5NENKVldVZU01MnVxQnh0L1kwU0h3dVJYbFpXNWlOVlM4ZnltTzVY?=
 =?utf-8?B?R2FEdmkrTXlFUE85QzRUbWdhd1FOUFk0cmRDVzYveEtOU0hCTTJJZU9iM3NI?=
 =?utf-8?B?NXRsY2VxSUtEYVRUcWtrbjZ5S0YwTCttQ2ZqM0JUY0pISFI3cXNEcGk2UVJj?=
 =?utf-8?B?RDFNY2UxS29LRGlyMWE1U3BzMTBiVmxYSXN4RnFEcVNGQ1JtZWxXK0d5WldZ?=
 =?utf-8?B?NU1LUVFFd2U2amFWeU1jK0FUWjgxQzJNRW1kZWMvZmovUkEvcFBhRkpqMFRZ?=
 =?utf-8?B?bDllNk15b2dvWEFkbUROd2pabnZ5S2dFVW5zSGQxcGRUYURraTFHZDdQYjR4?=
 =?utf-8?B?RkZLTk4yR1dOYlBYZTVKaHc0dnZubFIxY0VDUml0WjQybFBLQ0NCSk1PVWhG?=
 =?utf-8?B?cE1xdXB1UG8wck1VcGdRZVBhMEVXNnkvajlXdzBUR2NYZ1hBb3Bqdm1qYS8y?=
 =?utf-8?B?LzdVNHBJVXhPcUsvWjM3NURUNTVNRWtqdlZPSi9PNzV2bkRnZmp6anJrRXBH?=
 =?utf-8?B?RlhSMVljdXJuQUcwKzdJRnh0MENXNmQrUVpZT1M1ZUp1ZVBCaWE1VXI2WXNn?=
 =?utf-8?B?ZDE4K2ZOQVVZeXlKVXBVODhkMEtJUGM0NC9kUDFyYkxHTFJGMnNLcm0zT2tK?=
 =?utf-8?B?ZmErM096eEJoY0FnL3FPSDhHOEs2b1VMU0F5blR0aUlDSVg2MmZ6d0lTVXQx?=
 =?utf-8?B?MGgwOUdLOS84WDU0YnlmTVdpZ3EzUjJlTlI1TzRMWWxCZjNBbCtOeTFDT0Fm?=
 =?utf-8?B?QkNwd20rQWJIQ2VpeGFFOGRNbExzZTdoS2FYSnNPYnA3UW1aQzRBaHBqRTBP?=
 =?utf-8?B?UHUrMzhOZ1JGRTNuczBScytGOWdsVmVGOTY3b2toZ0ZYcVlJQXl2alVvNnhh?=
 =?utf-8?B?aVRCNlBGSVFxbjJaOHowQThzRHVveU1NVkpTdnBxMU51K0ptSW1CQ0xRSUV0?=
 =?utf-8?B?azMwK3l5K0xqa2kwMWxvRURhVVJsZ3FkZ29ZUk1CdUhKWjRPZkdNRmhFSTk1?=
 =?utf-8?B?aElvVlZCeVhuTko1VTExbWc2TVp6ZmtCZTRGN09kSUpKUjZBYkxGa1RIakk4?=
 =?utf-8?B?N2VIZE10VUw2c0w2ejVtNjdWOTNQOUhtNktYa3p5WlZoOXVucGFhTTgxWnRv?=
 =?utf-8?B?SHQ1ZGE5VnJ2L01md1NRTkpWUm1Ia2lFUE9jSjJEQ0p3amNZRGhsTUQ5b0pI?=
 =?utf-8?B?bXlnR0lhMitxU3prUzFMV2tySUtCaVVTbW5uK1U0RFZaWTJUZENYM1hYalFH?=
 =?utf-8?B?T2pkMFYvT0JnajJoVXFuZG5QUGVxU0dURkY2SGNZSmw5bTBjUGZacTc3Vldz?=
 =?utf-8?B?QXB2TmZjaUIrRThtUWMrZUJSYmc5TjVtSEMwYmNzY2pXVi9ROTJzK2NLVHBH?=
 =?utf-8?B?R0ZyNDZ1NDZIaHNhQzA0SG81ZytMTzZLMEdPQ3dML3hXOVE2NkJ1OXBPVFJ1?=
 =?utf-8?B?UnZrdUlJQjBXbDA1dDJ2TmRlZm1LeFdwSWJsYkNJREN0VjA2NGdFdnE4RmZQ?=
 =?utf-8?B?ZXZMcER5eU5wTG0vNTVGc2xhL2k0R1ZHMVNXOFh0b1FDUWk2cUVjNmlPM2gz?=
 =?utf-8?B?SjZZU211WWNqWWRpUk9HaWpaazVmdi9ibW1kRkc2bGtzTHQwTUJOYnZjMjNy?=
 =?utf-8?B?LzYrY0dBNjNhSHVTTVpjNHVJU3BtSEVrZXM2TlpFM2tGU25sSVFBcGE2MVFn?=
 =?utf-8?B?NFl6cTQ5S2UrZUxjLzFwWkt5Z0MwZlRNSVgxbS9xQTQwaXlqMUpQdmlSeERT?=
 =?utf-8?B?REwxQTh2WlRFcGF4dW1obFNNWWxpV2d1ZGx3VDJmY2RGUVI5Wlo2VEY1OUhk?=
 =?utf-8?B?N2lScE55Nlk5ZW5vWittc2U5aEhTanUwQU1lMUgvVU5MQUFTTkMydz09?=
X-Exchange-RoutingPolicyChecked: l5435QtIX0Neh8jsqIZtzJoJwMsOvxfhxHAJjEAmHiWE1JyvwhbjwfPxBpFABGY1We6665T0TsKZtg4csUuroS+aWBhbUBxGF7VZ6cgEyfunkHHQSy6Hz4Vb7RobPJSPz2a+xadBYIyXeV7D5w/9Pucbisqs4spQ3FMoTVvuf8XbgW6pZTDwDCS3WhmExysMHTvc7GHJ51ClXYivfpjnv1x0DhdHV09ArUWBSH3gcsS8gfd3YB009nbNfw+rSXyv3vTmD9/SMt//slbH+6dhzwuAual85hS4SDgT3z9LGUoB1oXs1nQt9oYcG6rCnsc5r6Dbe190KZ7XT95hgLKl3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dbab97-a1c7-42a7-69e7-08dee32b86a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:15:21.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqwgXfU6ieLQopU85cmS9ApvFQpr9pzp7aUDHLM+FgeHv8yF04fRkOHGqKkSnz6PGiZ5NhuJT7pHsqvm5XJNWSBeCxq4Bfc+ssMAcHhP8mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

On 7/16/2026 12:41 PM, Bui Duc Phuc wrote:
> Hi Cezary,
> 
> Thanks for the reminder, Cezary.
> 
>>
>> Pinging this patch too to make it easier, Phuc.  Certainly 7/10 isn't
>> the only one.
>>
> 
> I've fixed the remaining instances and sent the v3 series.
Another round of helpful tips: wait a bit before sending another 
revision.  What if someone finds another "small" thing?  It is rare to 
have a good reason for generating high traffic on the list.  A day or 
two of break is OK for simple sets, week or two for features and such.

Also, please do include reviewers when sending updates - you've sent v3 
without including them (e.g.: me).

Kind regards,
Czarek
