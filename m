From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/1] i2c: omap: correct usage of the interrupt enable
 register
Date: Fri, 31 May 2013 11:19:08 +0300
Message-ID: <51A85CFC.2000904@ti.com>
References: <1369929379-19165-1-git-send-email-oleksandr.dmytryshyn@ti.com> <1369929379-19165-2-git-send-email-oleksandr.dmytryshyn@ti.com> <87vc604dr9.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vc604dr9.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/30/2013 07:46 PM, Kevin Hilman wrote:
> Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org> writes:
>
>> If the i2c controller during suspend will generate an interrupt, it
>> can lead to unpredictable behaviour in the kernel.
>>
>> Based on the logic of the kernel code interrupts from i2c should be
>> prohibited during suspend. Kernel writes 0 to the I2C_IE register in
>> the omap_i2c_runtime_suspend() function. In the other side kernel
>> writes saved interrupt flags to the I2C_IE register in
>> omap_i2c_runtime_resume() function. I.e. interrupts should be disabled
>> during suspend.
>>
>> This works for chips with version1 registers scheme. Interrupts are
>> disabled during suspend. For chips with version2 scheme registers
>> writting 0 to the I2C_IE register does nothing (because now the
>> I2C_IRQENABLE_SET register is located at this address). This register
>> is used to enable interrupts. For disabling interrupts
>> I2C_IRQENABLE_CLR register should be used.
>>
>> Because the registers I2C_IRQENABLE_SET and I2C_IE have the same
>> addresses, the interrupt enabling procedure is unchanged.
>>
>> Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
> Much better, but still doesn't explain how/why this has been working up
> until now.  Have we just been lucky?
Yes, this has been working up until now because we've just been lucky.
>
>> ---
>>   drivers/i2c/busses/i2c-omap.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index e02f9e3..2419899 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -180,6 +180,8 @@ enum {
>>   #define I2C_OMAP_ERRATA_I207		(1 << 0)
>>   #define I2C_OMAP_ERRATA_I462		(1 << 1)
>>   
>> +#define OMAP_I2C_INTERRUPTS_MASK	0x6FFF
> To be more clear, this should probably have v2 in the name.
I'll rename this mask in the patch-set v3
>
> Kevin
>


-- 

Best regards,
Oleksandr Dmytryshyn | OMAP4 Platform
GlobalLogic Inc. | Innovation by Design
