From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Date: Mon, 27 Jan 2020 18:27:19 -0600
Message-ID: <448eeb87-9945-8a93-9231-6e2a22aa8342@ti.com>
References: <20200127231208.1443-1-s-anna@ti.com>
 <217993e5-5e1d-79a1-7684-c6bb964379f0@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56222 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1A2L (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2020 19:28:11 -0500
In-Reply-To: <217993e5-5e1d-79a1-7684-c6bb964379f0@lechnology.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lechner <david@lechnology.com>, Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi David,

On 1/27/20 5:40 PM, David Lechner wrote:
> On 1/27/20 5:12 PM, Suman Anna wrote:
>> The DT node full name is currently being used in regmap_config
>> which in turn is used to create the regmap debugfs directories.
>> This name however is not guaranteed to be unique and the regmap
>> debugfs registration can fail in the cases where the syscon nodes
>> have the same unit-address but are present in different DT node
>> hierarchies. Replace this logic using the syscon reg resource
>> address instead (inspired from logic used while creating platform
>> devices) to ensure a unique name is given for each syscon.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> v2: Fix build warning reported by kbuild test bot
>> v1: https://patchwork.kernel.org/patch/11346363/
>>
>>   drivers/mfd/syscon.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
>> index e22197c832e8..f0815d8e6e95 100644
>> --- a/drivers/mfd/syscon.c
>> +++ b/drivers/mfd/syscon.c
>> @@ -101,12 +101,14 @@ static struct syscon *of_syscon_register(struct
>> device_node *np, bool check_clk)
>>           }
>>       }
>>   -    syscon_config.name = of_node_full_name(np);
>> +    syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np,
>> +                       (u64)res.start);
> 
> Would it make sense to also include the node name along with the
> pointer address so that the name is still easily identifiable?

I haven't dropped the node name, it is still there, the pOFn part. I am
only replacing the DT unit-address with the bus address, I haven't
changed the name style either.

regards
Suman

> 
>>       syscon_config.reg_stride = reg_io_width;
>>       syscon_config.val_bits = reg_io_width * 8;
>>       syscon_config.max_register = resource_size(&res) - reg_io_width;
>>         regmap = regmap_init_mmio(NULL, base, &syscon_config);
>> +    kfree(syscon_config.name);
>>       if (IS_ERR(regmap)) {
>>           pr_err("regmap init failed\n");
>>           ret = PTR_ERR(regmap);
>>
> 
