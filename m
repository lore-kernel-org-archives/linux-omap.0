Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D033436A;
	Wed,  1 Apr 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042665; cv=fail; b=jIrqPZmyBwU9e3i+UucgyTPfrnENlplwVvqeeiwqe/L9Vq5ewBGHhhx+8aiVkfB91MmCadSMsdK6jIDi8eyjpdIWTDC5TimRnrCuBYUm90GVR8zPOp/o/q8dVfwEanpcVttPn+IF/5Pm7CTIL8OwfEo8qZpHtYAZVlOvPqEWbHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042665; c=relaxed/simple;
	bh=Ck7TZL5eKOfPzX8QvvbETVwL6IyJmV5ZXkqKbSBpHT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=goI0Sp/NZcCpkah0nKiLrhww9z3VlGgN9NwnJuypErgPoWUE9yg5TSWh0m9wGJwtImWp/QHZkVc3wdoUvxBp4ll4qIrR3ZWkvBbDG2ntb/a3l2tVtdp+WnH5vxST6uPRMCGPhlpkopEgt/aVOrEAzyObv9I/N6evwryGR3xRSkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sr6MHadH; arc=fail smtp.client-ip=40.107.208.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sr6MHadH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqikWOoO2sRrDB0ywTYCIi8xUCZdA3gcCL5C3wQYoCqNMrJ+HsOya24uq/JoRTzMtP5Uf+ogMlrLsKAuTJRFnvARmOvNZTYygx+6lD1XiLBHawcjQcu2kBDmEi1iuEfZH5ofoOa3GNZfLyrj9X28FmilJ1G3udlnh/snOV8zIlW1SwYl99QOwCx9g8Gwc9hMMpw6PjE4+i/yTH9Ho/ozNHQ9+hPb5PC00c4X1ABEUXQorck5eETZPw5e+acDsln2GEcRtwKa/AaRKbsXpYbqQlWOW+juoXCkLYukNBcoBKMda2+ycbYtJXvo0Jck8zyOgpgcglibSOkClQhfEX8HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5SwRznjOIzFqX5tQ+S5rUxTQmhua/QB7+aWnyAX/50=;
 b=R9lgLMD3vSsohVIvOsLQXYvAIjVZfTQuij1o7LTmsljWEgxsQE5hiGUSoooO0lIQY9hCC5HyGkwJYd2G7hG99hMdwm9D9GBCNfHQpzX17Yk5DiIUFzmsTLTRzBpmsmRlYx/T5M9pvTxvTH/dBmyBRNjaDBP0bQAe/eA6MAlVDx41GXfC1MH46NBrYNGDxe+0xzzwQtVQPdSG5wadbYq6wtYKa5/AcVrEWtUrE0CGAS4bchjkAcZ5zXR9RgRhrR2w/Cw6p0Pahed1KEPR7NMecNyh8nhffsSqELSYF5LOvhgAUmtnLUBulCjGGO7sYdOZpHMWHQ8Fl47GKFKhH8YFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5SwRznjOIzFqX5tQ+S5rUxTQmhua/QB7+aWnyAX/50=;
 b=Sr6MHadH5HZGA/2UmjmZrnZUn3EAuj9llyK31+RzU4/iDwo3o/it/V2T9WUGw0cnNr1qnNy1lCIiCHmVXl3yNZe3ZO8Xda8Ve27OBBvOkSrqfnp3d9xcjgeV0ZcplSKz52BEFPciFvnJRS5addjfRYu11bmHxn8Xawh5af4SnqM=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 11:24:21 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::3f) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 11:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 11:24:19 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:24:19 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 06:24:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 06:24:19 -0500
Received: from [10.24.68.91] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631BOCKq4172212;
	Wed, 1 Apr 2026 06:24:13 -0500
Message-ID: <ebac1ef0-8be5-4147-bb29-ce1912905dc8@ti.com>
Date: Wed, 1 Apr 2026 16:54:12 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mfd: tps65219: Make poweroff handler conditional
 on system-power-controller
To: Lee Jones <lee@kernel.org>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <aaro.koskinen@iki.fi>, <andreas@kemnade.info>,
	<khilman@baylibre.com>, <rogerq@kernel.org>, <tony@atomide.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<s-ramamoorthy@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<d-gole@ti.com>, <k-willis@ti.com>
References: <20260324101419.95616-1-a-kaur@ti.com>
 <20260324101419.95616-3-a-kaur@ti.com> <20260331101203.GA3795166@google.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20260331101203.GA3795166@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: eedb88dd-cfd0-4f34-4c72-08de8fe1379f
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Vza0iptrnzbkQ6dpqlIKG9yq03ri78/3YxGcJXPEL2t43ZHX8YOWyuozCa/vL7tG72UerrqtxOmkkPHZk8nt4H1J/u8brLkDJ2JGivQ75IXEQkBmQWpc5A29jj/uvN20ELxqKoZC/wojvUnL+YNzE1WjsnPoC+0tW4EeoXyIWX7sJuqWCUHFjn+EOpsPExoiigMw4OlftufpOpkZgiCJdUJ+HQqkm8iihPFccXJsDx2oJLVJe2jTGG2X2NEeCDqIL2PfEmROAYlnQjtCCBHrLnGPJpF3hQaLaAV2MeM7vv0vXRpbEcIxCMg3Pe/8ek2IVmyGG11uosanaDRtPSDKs/N5nv+WTP+Fka+iduowsTpwG3wsdemiHvG4XyDvV30t+ICYfU6+ALiO9CiR5X5AepJd8nXzzUjGD1u0zpFnX9KmN0bQ7tM/2dK3d7RiKawFtjcdL9s4U+M5OvIn8ToQlkdS2lFk5FEj472lsUqkdeZ8eqZ1clfYtn88jkEal7xaPSG99P9NLsOxLixp0Ml21na0lQePQTXi0r+pcQ3ftagWSsdHcpnvGAHoHN0zFXyrrEIeY3n4Xvi6IlNK/z4/eWm+WOHNMF2L9i7+CT7kJMa+EEd4tatFioOy5CHQWFXu7acrHdjovU8TMuxk1BU3rCbbjyF6/0N0HtFpFO5XcGHQ/bkXemtmBUrsZF0BIz8amsiIuvDccWWmahWcMExv6sR5Lx3/JH59MHlNiGRKcW9RkyIq4g+FWSqBsklODqYfTxH3XyJoVg1zoi8Ni36VXA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jq4SWjN+Xpig0S4n9cAqwHrmn5F0hInNMlWQTml1hjfaz5aEw+9Qfg+Zuhvy/MpkhwtHHCZFoppNs8n+BW8DxewefNRVw8FJ65l36GKEAWss7vGN/M/7Cy4OH14ycmPiP8IGGAhTUuInAQ5U3iGk5z8GInBxEY/D5/9RbdDX+IGJWQFimaJzXvh8PAazwuW2Ke4NYSFW/T/JOUHvbVOyCR+1JH61M6eSGuyDs7ohNfXYavDoz3UYz/xJKbng8K57FC0wkpPAo7+h0lc5gQ/t5gdS5sb3Zsch3undgrH8KkIZ4UnsexeCsge2Fwh6DQ1WVdaz2bISQ0TbXhwACO46PeS5pPZ7/asoYJHtz1OO/YTA/4KoB/j6fIASv1LA5GJUar9BWVllheOX9192bv4PrQpkLdaAqUwmvIeJFrpRh7oWa7cZZcKoRVrBzdJ89MVH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:24:19.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedb88dd-cfd0-4f34-4c72-08de8fe1379f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873

Hi Lee,

On 31/03/26 15:42, Lee Jones wrote:
> ---
> 
> On Tue, 24 Mar 2026, Akashdeep Kaur wrote:
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
>>   drivers/mfd/tps65219.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
>> index 7275dcdb7c44..6fa202339a0c 100644
>> --- a/drivers/mfd/tps65219.c
>> +++ b/drivers/mfd/tps65219.c
>> @@ -541,13 +541,15 @@ static int tps65219_probe(struct i2c_client *client)
>>   		return ret;
>>   	}
>>   
>> -	ret = devm_register_power_off_handler(tps->dev,
>> -					      tps65219_power_off_handler,
>> -					      tps);
>> -	if (ret) {
>> -		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
>> -		return ret;
>> +	if (of_device_is_system_power_controller(tps->dev->of_node)) {
>> +		ret = devm_register_power_off_handler(tps->dev,
>> +						      tps65219_power_off_handler,
>> +						      tps);
>> +		if (ret)
>> +			return dev_err_probe(tps->dev, ret,
>> +					"failed to register power-off handler\n");
> 
> Couple of nits to fix.
> 
> The `"` should be aligned with the `(` and the `failed` should be capitalised.

Fixed the formatting issues.
> 
>>   	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
> 
Regards,
Akashdeep Kaur

