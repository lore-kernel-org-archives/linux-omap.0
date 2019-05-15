From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Date: Wed, 15 May 2019 16:43:39 +0530
Message-ID: <82581f9a-5aaa-b56c-f9d5-4188b60b3e6b@ti.com>
References: <20190515100848.19560-1-j-keerthy@ti.com>
 <20190515100848.19560-4-j-keerthy@ti.com>
 <20190515110851.GD5613@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515110851.GD5613@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 15/05/19 4:38 PM, Mark Brown wrote:
> On Wed, May 15, 2019 at 03:38:48PM +0530, Keerthy wrote:
> 
>> @@ -172,6 +178,9 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
>>   	if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87565_Q1) {
>>   		min_idx = LP87565_BUCK_10;
>>   		max_idx = LP87565_BUCK_23;
>> +	} else if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87561_Q1) {
>> +		min_idx = LP87565_BUCK_3210;
>> +		max_idx = LP87565_BUCK_3210;
> 
> This if/else chain should be a switch statement.

Okay. I will convert that in v2.

Thanks,
Keerthy

> 
