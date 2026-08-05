Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2553E0C77;
	Wed,  5 Aug 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913629; cv=fail; b=coaU+ScHJc+VZW0frl50smXf1KoYbCC1uMR2h2pVGkqPkLGYecDz091w0G+qZjeYuUjpROvnEmaiaEfN2dJ2j+TsGq5nqUq19yjBxmyUu0dIDl7OXo5XRz61Hs8YcoeKrt873591tQvdY8unOTv3gQvkKP45SavMNUr3DLywGME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913629; c=relaxed/simple;
	bh=YbiwGItHlLaldlbeGX8PddUQUlbEbEjVYB4sGbeaa8I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3JWJd7uu9kZ2umwe9wfvFUpYz1r4ti7kmRhzS8e7RL+5BfrLKS3aRII40qNzO/MCPMbA47w4v65lG+XXDdhSNUKeiygWlq+CakdPoXHqMNjWYZT8SaSPv0jdcp3vvWBnvL1iylWzlTuTY930mCptMeXLOQUnTW4rEVmKwGXyGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gi8w+C3B; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gi8w+C3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785913628; x=1817449628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YbiwGItHlLaldlbeGX8PddUQUlbEbEjVYB4sGbeaa8I=;
  b=gi8w+C3BRfn+0cjGwmQiLkKbd/xNzAkSpkwFmiTQHzhStrvZdP88TH99
   pMVywE2H1kj+Kd0RJOzFbegzJ+gInNZo3d40a/up1oSAL0GwX53tzSb3U
   BANIJBtSrO2XYJ0glBKjmUTigJyWL3qMS0zOJ21PV55cD9MMyTj7/C02t
   AnQvkX0GMJTbJHNdmpDQy1dfsVf3L5RRl4ruT3sMwZvJ9DYTPG4wLrfnH
   HHOzJc3YfmYg+0FO6hSEcws4yiWGgZ04D4O/jCZQGBqT0s4lx09xb+JH9
   Pca5gVcCmyx6RyA+Y9shNMwALhvcPWyDXPAhQzkHvDPu6lElp9TPwR54V
   Q==;
X-CSE-ConnectionGUID: YJX3S1fDRhKIdf/ILTI4Yg==
X-CSE-MsgGUID: vqe6PJ79SrKSs3U6ExWXYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90154354"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90154354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:07:07 -0700
X-CSE-ConnectionGUID: 1rLd9PLdScGOcv7nNvzjkQ==
X-CSE-MsgGUID: mcGa5a0UTR26Fur+M7jVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265562109"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:07:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 00:07:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 00:07:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 00:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh3btJ0uD/HkQeCfGtiYkQRi0L7kQVmJ8G2CY89/Grjxe/8jl2JYQ+l/41n6Q5gZg4MuRyDQzCgsKKk2OMy30BVptnoPVkx6T7cYOjZPUM0WEnbIaXSAQi9PCDSHXgWs60H4AeX+eAmizThclPYwVPrX6yDAatbMqi+fmYEVepbxizrNDzX9GQkng0CxrXCheLm47DPtSc1Bf8Fy9jaNKrEL8/B0QRggy3ngODUumJLwyhhqRBfp+HCsfrATrhCeImzl6OV5XasYDdWSXoehufOPrjEfhRspONQSjK0iU34wTpSArkyihz8IhEEnFpEpLtZ64QdWMBwo8jk0JDNbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acrLkQO8evaKl4SC/as5G/2JP01YaCOrp5xq6nJ/HJU=;
 b=rY7eF8GMGpofT1arWpqszyrlM6LWOHIFvvXHactMdzlyzNYYTRBwxBR2AC8uuk/aKCWU9ol+jrGW5z0w8qoOAYA2xIhowFu7G+tegiFxWt6G6Bsu+GHkaeUoLsXPfn0K1h27mGAZRLX+Ma5J7rXv9H9HfRYNLS6IOVEGaHu9dUxudAsIwC2XcstA2hUf1B9lKw9C7ZpAkmjruPPA61CcwXcwTJS32EtQRy7vG+gqyr9FDy2T0GQX+xhn02nvXi6u4ctHFbLm1Hy4PTw/9v+1OWpoyBj95PqtGw86ekFH3w/P+1H3zg+e+R0JDMnKf6/1f/pyMZrhOsAXGDUhMYcYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 07:07:04 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 07:07:04 +0000
Message-ID: <99bc4c85-5f5e-42bc-8799-eaa7ef5d1257@intel.com>
Date: Wed, 5 Aug 2026 09:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] ASoC: ti: Improve probe error handling
To: <phucduc.bui@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
	<linux-omap@vger.kernel.org>
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260714120042.491712-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|DS4PPF6F32BC4DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 691af58c-d33f-453c-7516-08def2c02719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TZX9XrWCvnccCX/DDgDy4WmtmPeqGQ2ZdpR9TGRkAXsSz3ZvuTFc45ZX7pyBlcibnGkOM2JmnQ/ucl+/dMz6W2jZTfNSQxqpJWQ4+7Ms+NE+tGj6ZASY9xZzZsPW/KwwOOP9k6ywXwtfcWzK2agWUZU6Sbmu2ROHZDWpHM5cSUItHQS39eQgrcRguuGN18AfmSoyYT6WuHWTryxi9NkEBeuLfA4azprfxIvo/prE+cTRTwp5vNu9nI3UZGpZuG2ytfv8qh0uu9iivg2EjBPm9K/v4NUHGFKuWsDsWnUZvGmfPqmMrKpZoBzv6Uf7SptWoLvn6h94/olzyLgB2FnqW8NJu4dT7ruJ8cDzi8Jr4mxTC9I5cEkNnygzu+ZRd3BcC29Vtfa4okzhu51FgILqTOKo6xJ3koTuJrsPBP+bE1K72495xRiJIftDoypcy8LDz8hsaYYgB3j0EGMkY4OC/SaCcW2s6B6Eb2ZlZOHPM9/2dPcagJf9LCHgOvyLXtq5hTwaF13LiuuAgw9P6XxmIu4Rud7HozChNHOQnran4KFmL+vSTsrlfnbfZWgyl7lyfIps1hTgpsizp2PrUkNE9eWX2uXJ9AeL/JHG92uKeAFmyKFRKU1UNX1QAIA3VWNc85g5fjjaRDlpUY+D8Veh1a9aZ5lpLdh3lweQPrbVR9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmN5eEk0RFZYY0pUek5ldHR4czdPMDlsNW02ZnB1emtIQjJQZkhiUUdqYlIv?=
 =?utf-8?B?N1hNaktnZTBucFhYbmxoSVJoKy90cFhTZ0dUMWZybHo5SVRiWk8wUGVadFRB?=
 =?utf-8?B?K2JYd2xLQ3phOHBGQk1FMHdOOWpUTTBDMFBJdFllTmZKSmRERHY0anBib2tS?=
 =?utf-8?B?TGpUdlFvWlp6SmJRQmx6elVyNkxaandXMm9rMXhOMjgxR2FlU3lRZkhYL0Jh?=
 =?utf-8?B?U2ZlVEpuY1VGSDJqNlVVMW5QK2Nsa0ZCa2IzT05ITDFneVZ2VUFwSmd6NExs?=
 =?utf-8?B?cVh1WWw3c1pqRHVzeXQwTFJTUFlvRDNDOUdqSUI0YWZ5ZkJCZDNSdmZJMTZL?=
 =?utf-8?B?ZGpjWmJYSmtiYytsM01jNmhsUzE3MCtyV1FKVEwrWmRSUWg4aUxLWjVwaTVC?=
 =?utf-8?B?TnNZU2w2bUJjSGhLTG9wdkovN1N1SXFlOUUwMUhTUGlqYlh1T1I5T1VEUlBs?=
 =?utf-8?B?d0NxS3lvVHZrYS9yb1VxSmZXUFZkSHowM2c2WlczQ1d5ZGkvR2lXTktDU0to?=
 =?utf-8?B?WWh4MnE2OXdFL2pvaGlYRlVPWFNzQzVrU25xQ2dkSXVOS0JjV3MrZGhvajYr?=
 =?utf-8?B?cUdxUmxlMi9FMWtZZDJDdmttdFdTbWlELzFqbVdpYmZ0SFNEVTBUU0dCN1Y0?=
 =?utf-8?B?akorV3czZnJKQ0VnOG8rUmZIdFRrVDVsZnZqTXFsQTFuWlowb3hvbHRXUEVi?=
 =?utf-8?B?Ti9XRzhaWnhZaXFSZWRVdlVwWC9SYkdNdytDOE5NTlJkazdpeGtFUDZRaFFQ?=
 =?utf-8?B?L01OZnlhMFVudklHbm4rSlI4MTN4NGY0bUJTM0hGQnBmVFk2emJleXVudkhI?=
 =?utf-8?B?d0doZXYvS3lIcFdKV3M1TUh2dTVvZUdlZnJlL2dNK3JpVC8xUFMrZ2Qxdlls?=
 =?utf-8?B?Q2twS1ZvekU1d3V2dEN5WDlWMXo3Y3VTQ2dXYUlwYldBRy9zZDlzOEtOVCs3?=
 =?utf-8?B?bkFCZG8yY0dSU3FWRS9rdmhuaWxUajJSTnl3MFUzUTJTdnlQbHlpVFlVdXkv?=
 =?utf-8?B?b2wxaFFTc2tYR0F3TE54cEYzUEVyc1YrMXgydDU1d3pWcS9uQ0RDSUVFSWtU?=
 =?utf-8?B?aTVvREI4ejVNb25xQURFeE1nenpqR296QjlMUU9qbmxXUE5EZ3lrZVJpVVpG?=
 =?utf-8?B?L3JNaHJPdHA4Wk5Nb1ptSy8zYmlsOWorNzNsQmVnNFhBTm5kR1dLYjgyNG1U?=
 =?utf-8?B?dWJxZUcvcXR4TFBRU2hZeVJ4QXRIb0RYaGQwKy9pSUs2RVh1UDNkM050T2xx?=
 =?utf-8?B?YmtlOGYxRENKZ0pBdlVDMmNLVTZ5cnV1YVZRK3JKSERRNGo4bFhGQVUrL3BT?=
 =?utf-8?B?TlFzTk5Tc0x2MDdpa1ZlOTNNUVhvVW9tZDdwOGZWTEdZNTVMQzB4dFNyZm05?=
 =?utf-8?B?UlBTb0svdS9vK3ZBcjVoWDMzNnNtZm92R2xkT2VDenpGMEVxSWdIQzlmcFd4?=
 =?utf-8?B?VmlaU2ZmY1FDN0hDWURTMlRaQVJmeHRCUkVOT0srdjhrNXFJaisyc2gxdW8r?=
 =?utf-8?B?ZzF2a293YXdSZXdPckhwbjkrWEgwVXVoQXVOaGJvZFJTdlY4blhFVlVvTUFW?=
 =?utf-8?B?ekdyR3BvM2t4TW9rVkJJNGVlWFIvYks4ZzV1eHZjcVNiaHAxLzRXM2NWOEZY?=
 =?utf-8?B?YnB4dnpnWFg4R3JjNng0Wk11ZUxKTjF2TVpObGZaTzExeFpMc3FnL0E5dlgz?=
 =?utf-8?B?MTR3MlFFV1NmMTNJckVZZzE4ampqU1M3d0IrbmhQYnptT1lDVkJGZ3FpdjF1?=
 =?utf-8?B?NFV5RFNSYVcrcXZJRFdmRStPM2tiaDVGeFh5ejMvOWNKSVdGOUdrdkFaWEVy?=
 =?utf-8?B?UmFKSm1USGRKZXk0Mndzb05ZalVWR0YwWXc5eThuWUNwZnVFYUZkMTAvamo1?=
 =?utf-8?B?SjdRN3hlS3dFL1M4REc2cnRkaEVYY0tsUnNMNXdBbGgwQi9OMEwwWDJka2Zi?=
 =?utf-8?B?NWtwSFIxK0I5YU92V0krRHZ6MnNTVGRwSXZuak9jOWpkRWdjREtYK3dNb2FT?=
 =?utf-8?B?RnphUHJ2cDNHUW45WlRxRWUraSs3RWM3c2xlTkNXTmQvd29PNDl5d3RDMFVt?=
 =?utf-8?B?aEM2WTBJV3o3UkN2ZEl3S0xEWVlUT0NKODRjb05jUEJpSzNhTFdLNTRYR01o?=
 =?utf-8?B?aVFpR1I3OCtvL3VUQmJRV0FRSmpkaGZPN3JZVkcyUnlsZTR1MlRkQTFmbXdz?=
 =?utf-8?B?NHZ4b2NqRTVaMW9pZUtEOVZ4MTJneHU0eld6WGxjK2NsSDVHckE2MHZoMmJr?=
 =?utf-8?B?OEZtYWNDY0FJR3UvdzFNbXJEL281amZTREQ1blZvWFM2dGJzdXlXN0tFOHNn?=
 =?utf-8?B?N2FkWnlRYVZXOE83MDNDVms2aEhobWtIM0RiT21qV1hUcllYMGVYOXBDTE4w?=
 =?utf-8?Q?VL1lWzc8/mPaSWUs=3D?=
X-Exchange-RoutingPolicyChecked: BMjcy1AGBhMP/xdL08sBk5vQwIcWRj9PmmeapdzzrKeL83FgKOPIhPax3ItARxaNBFe7aT5QQLBKGnzrAjwDx3Fft7AFanXi3GQZSsNvn0AC3Scnv44gDOWhj7m6yzz0wGeDON2V50eiRF1YJpeFjwcNV3t4+8DYizavMnzazVvVz7jz/nUudxAAVpRV9UCE04dnxuiDh+C4nfm9AXz+n53/KQiaFiGnTEX5dT8bcQGPNwNFLwLk5seUnbpPE0jsOTSroquaFsLaVyLzXUOSP3Kq01kpb9WvwFiy+YU610PNNyqKZYVKugCAmXwG1qXNlfwZlKFMqeDSavO7M625tQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 691af58c-d33f-453c-7516-08def2c02719
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:07:03.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjZz/vmvOqfsuGaH7J4ydvRk/laq9Mp4U5VwulG4Ps4ye8hu5juijXmDXJhXljoN13MqNeULxtJ3D3RUFVVBVHkFR/A1Udg2CE2ruOTC3oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

On 7/14/2026 2:00 PM, phucduc.bui@gmail.com wrote:

> The changes fall into two categories:
>   1.Replace dev_err() with dev_err_probe() when reporting probe
>     failures. This preserves the original error code while suppressing
>     unnecessary log messages for deferred probe errors.
>   2.Preserve the original error codes returned by helper functions
>     instead of converting them to -ENODEV, and remove redundant error
>     messages where the helper already reports the failure.

> bui duc phuc (10):
>    ASoC: ti: ams-delta: Use dev_err_probe() for error handling
>    ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
>    ASoC: ti: j721e-evm: Return the original error from card name parsing
>    ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
>    ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
>    ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
>    ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
>    ASoC: ti: omap-twl4030: Return the original error code
>    ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
>    ASoC: ti: rx51: Use dev_err_probe() for error handling
If there are no dependencies between the 1) and 2), have all patches 
belonging to 1) lead the series before any 2)s pop up.

Right now you have three outstanding patches in the middle of the set 
that clearly differentiate from "Use dev_err_probe() for error handling" 
pattern like if you are about to hide something.

Which obviously you do not but the impression is there nonetheless.

Kind regards,
Czarek
