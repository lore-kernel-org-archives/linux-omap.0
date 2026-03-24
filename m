Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121A35A939;
	Tue, 24 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347498; cv=fail; b=cuOmQMKUBGDo1cvZfrHBUExSrGtskvzKyjXouySwfYcx7NK55AUofHGehYj9UrZfvwBI48DgVwY4CmFwp0L48PV1uuXl1ODOEk0dz/bYEiN5Hx0XZJ44+aD7S0oBlX0WliDv8IDR8YwsF+A6UPLoQcZCwHJNQWVAho6lxPyaGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347498; c=relaxed/simple;
	bh=/QxiV8TmJUAsNABDW7q1k5nE3/dE6LCOirPOgapIa+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AyuJYl6LdxfkDX7xwc0ExBurFTAw6w79B/7cpWFzCHXG4uASQvgEnTs2q9PNtHRINsPoEGjdfg9TGmKgPkQe97Sqqug+BPDJooWfN0tKSW1/0Aq671Lf6RToXQAgVJ0KLCZQEUXhN22i2ts+WPbdx/5sgZg9kO7f0wCYWH8DmPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Evedi2fj; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Evedi2fj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSS2hFSlYCwcdMVaztbfcgaCRWVpH84BOH39OVv41zF8CrPfSY5RQflLTlvzJhMcVJY+k5GuQA3+961lsw5pIAHNiY+bakCx7sro+ehENG8qYDXHo5+0WDW1XeP/wxY0kXa4SfWLtleUmu886SyhCc2kVRGIIreG1Oq/ctctnMkz8MM9jmFNILFOlf3LIZPkcpC3keQwBHMxvDyJg+aCzfL18Sdk54cLrPQeTq51fH4DAAtaqjnLYIbirLEtR1gbdlQQXIupBUe0IjYfcglI1c0Ux+OzPUnfe9Grh2+srpDJB4YLfZxdFSAnyyd+80RXE6QRQfV3ELwPMmNZKPYiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i24ZP82J6EJdROgMBeERmJ+qulWVTkIL5dStJN4sD7Q=;
 b=NCK7ggCTJb3YMhWqr5u3/aEDUgaNnf6qE1dgtK4UMOfo9MpB5cIAV4DC0IbPqVBLWD8ZOALmSCQDliBmReyLkERQbNKPWkf2+FZFZp4xsmV+ws8m1+Rgw/xUbrcaGjaD060fysgEPfXazckxxvCiqzo3Nmou44xXsr4PGmyw849ZGeQCS9lCs05m0lRRMRsKIs5GyZWNvs6SfC0CtScEGXBNUQgctmKytKY+P3BzC1em9g5+V5LWaWQjBu1bnhVVrIW0tB6lMPQOdxEkBm3PVyETgda+H6RL2iajofweV+whrQgfYjlrIOtzXQnG79JmK/OzaXOghlq6duejLIxSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i24ZP82J6EJdROgMBeERmJ+qulWVTkIL5dStJN4sD7Q=;
 b=Evedi2fjb/ux7pGCvsaS+InHd7Xpt5GbBh852eHgmpTgkIkrF03VKtk6yvqAyvPhwc19X6+9w6SoNSDehZ6LxV2Lt1dzA82wTgpYjkVB2YdIpNVV603MYHOl+mruyhZ9EU9O+3d5yo6xPmm8wv6ZHFZxuq4+XnnrzJ4w9gNPx5I=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by CY8PR10MB6660.namprd10.prod.outlook.com (2603:10b6:930:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:18:14 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::fd) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 10:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 10:18:12 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:18:12 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:18:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:18:12 -0500
Received: from [10.24.68.91] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OAI5Qu2450654;
	Tue, 24 Mar 2026 05:18:06 -0500
Message-ID: <43955cb9-fc8a-422b-9636-c6a83b0c61fe@ti.com>
Date: Tue, 24 Mar 2026 15:48:05 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mfd: tps65219: Make poweroff handler conditional on
 system-power-controller
To: Lee Jones <lee@kernel.org>
CC: "Bajjuri, Praneeth" <praneeth@ti.com>, "Menon, Nishanth" <nm@ti.com>,
	"Davis, Andrew" <afd@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
	"kristo@kernel.org" <kristo@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
	"andreas@kemnade.info" <andreas@kemnade.info>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "Ramamoorthy, Shree" <s-ramamoorthy@ti.com>,
	"Mahaveer, Vishal" <vishalm@ti.com>, "Francis, Sebin" <sebin.francis@ti.com>,
	"Gole, Dhruva" <d-gole@ti.com>, "Willis, Kendall" <k-willis@ti.com>
References: <20260310111846.1084623-1-a-kaur@ti.com>
 <20260310111846.1084623-3-a-kaur@ti.com> <20260319112405.GJ554736@google.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20260319112405.GJ554736@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR10MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 87db745d-17c0-45d2-2d1e-08de898ea7f5
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NKh9vTgd6Y6UDmt4T9JapUo7lIfzip0X/o3gYgGCbsTDfH9Z+hFZN3OY313X07wAIQp4iM8IQQi+7MxZwA9MtIt0Mt9+cSTfcgxglZ6k/26Hl0O2rror0/NrKEBaH8DDxmeC+wNCrP6NRgL+6f/KG5ynKP5jzJVzJhwU1DVAu9Jai0/sE8Z+XGM52PXxmIk1I87v3hl0QFOJCNeM/ObzxzdXA6LPbrUKy8TQsfqPICFF6GQkYZgrF4vA+WzdQN4yVCQwZ3nQhDS17GOaCYlvPyhuokO5LMKCASUum7kk/2D6xyascMni0yGRrY/vIHQMICBa00+Rg7OzaYMZhPD3OQsN4jixiARDl8ASfN4JwDxsaQn6tPpoy3/YBLJsc5KXrvh9StPrP3XiUxdeae0yHTX2fq4g0CXWQQwS/bt4KWoQRu6DJIH4e86KDPYCWJIbDAq/EXEWRwxkQxqz1vgsFaCazGtYV/AVLdrQkf1nAfxZmRvQDs9GJBrq/U15q/T285lj7/8WLOPAyxdO7kObYKIhjG0ewMjR+EYFNzmYjVdPx6Ae6IOSyL6rV/4VEn0rced0gLGAS4C64BZfHYnRw6UhkKeCNGQXIXXEazk72+CniFXWP2xNSs8yhWH2kzH5yYrv9FxsSvSdaYbphqtRDkkrsNw1pNWTIioiqQqcoaKuO2rT98dxHJU/QU5aNVtVmwb+S31OBfN9V8v83KHrihhb3sEPXX97tHAl6AAS9ibhYQ7Sf1n/yxuzuC9jThv901aVwkVyeItUtlvNpOW+PA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FBo9BV56cjcHKiluMy1MZXn9LQLSd0ic5Je9iBTousHVJ39H2LPvINVVGiL18anWbDOUUP1bnr14lLJumPCy4qzQJSeyjIW3GrQQGt3W6g0Ep32SNmOO75H3+k8NVpbneLsybJlebVtqlvV+hW/9nX6xGU1MTDooN34CDSbQ40IBuVNyYLCoibzug2KgWkZE1ioUYiusKwq9ElXTw+FJHE3ah/F6MGN1tgf70R/mfxUXXtKIN67KmV7DygdQ3AL6UrHAtvMHnXBuPCM7KgSnGzbQh8y4iOnHEK66bODHQBSbB8ftFgIUhVjiHFEAC863Tw8fN/qUjOJD6YfJOWsgJ1RmNynqceXRa3qpetrTtgCgnj78v8AOfMc291AmJ0SbLg3fY4kWyQcMBYpxGKUgJacgIx9qJ2JHx9hES0RF2oLNSBKvBwC9JK6WxvtzW1Eb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:18:12.8225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87db745d-17c0-45d2-2d1e-08de898ea7f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6660

On 19/03/26 16:54, Lee Jones wrote:
> On Tue, 10 Mar 2026, Akashdeep Kaur wrote:
> 
>> Currently, the TPS65219 driver unconditionally registers a poweroff
>> handler. This causes issues on systems where a different component
>> (such as TF-A firmware) should handle system poweroff instead.
>>
>> Make the poweroff handler registration conditional based on the
>> "system-power-controller" device tree property. This follows the
>> standard kernel pattern where only the designated power controller
>> registers for system poweroff operations.
>>
>> On systems where the property is absent, the PMIC will not register
>> a poweroff handler, allowing other poweroff mechanisms to function.
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> ---
>>   drivers/mfd/tps65219.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
>> index 7275dcdb7c44..beb816707d8f 100644
>> --- a/drivers/mfd/tps65219.c
>> +++ b/drivers/mfd/tps65219.c
>> @@ -541,13 +541,19 @@ static int tps65219_probe(struct i2c_client *client)
...
>> +	/*
>> +	 * Only register PMIC power-off handler if system-power-controller
>> +	 * property is present.
>> +	 */
>> +	if (of_device_is_system_power_controller(tps->dev->of_node)) {
> 
> The function name `of_device_is_system_power_controller()` is quite
> self-descriptive. Is this comment really necessary? The code seems clear
> enough without it.

Hi Lee, yes, i agree, Removed the comment.

Thanks,
Akashdeep Kaur
> 
>> +		ret = devm_register_power_off_handler(tps->dev,
>> +						      tps65219_power_off_handler,
>> +						      tps);
>> +		if (ret)
>> +			return dev_err_probe(tps->dev, ret,
>> +					"failed to register power-off handler\n");
>>   	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
> 

