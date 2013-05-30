From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: omap: correct usage of the interrupt enable
 register
Date: Thu, 30 May 2013 18:42:50 +0300
Message-ID: <51A7737A.5000902@ti.com>
References: <1369812944-685-1-git-send-email-oleksandr.dmytryshyn@ti.com> <1369812944-685-2-git-send-email-oleksandr.dmytryshyn@ti.com> <878v2x7lak.fsf@linaro.org> <51A71375.9030100@ti.com> <87obbsa6vh.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87obbsa6vh.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/30/2013 05:18 PM, Kevin Hilman wrote:
> Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org> writes:
>
>> On 05/29/2013 08:22 PM, Kevin Hilman wrote:
>>> Oleksandr Dmytryshyn <oleksandr.dmytryshyn-l0cyMroinI0@public.gmane.org> writes:
>>>
>>>> Starting from the OMAP chips with version2 registers scheme there are
>>>> 2 registers (I2C_IRQENABLE_SET and I2C_IRQENABLE_CLR) to manage
>>>> interrupts instead of the older OMAP chips with old scheme which have
>>>> only one register (I2C_IE).  Now we should use I2C_IRQENABLE_SET
>>>> register for enabling interrupts and I2C_IRQENABLE_CLR register for
>>>> disabling interrupts.
>>> Why?  (changelogs should always answer the "why" question)
>>>
>>> IOW, what is broken without this change, how does it fail?  And equally
>>> important, how is it currently working?
>>>
>>> Kevin
>>>
>>>
>> Hi, Kevin.
>>
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
>> I2C_IRQENABLE_SET register is located at this address ). This register
>> is used to enable interrupts. For disabling interrupts
>> I2C_IRQENABLE_CLR register should be used.
>>
>> I've checked that interrupts in the i2c controller are still enabled
>> after writting 0 to the I2C_IE register. But with my patch interrupts
>> are disabled in the omap_i2c_runtime_suspend() function.
> Yes, I understand why your patch works, and it looks correct to me.
>
> My main concern is that the changelog is missing a detailed description
> of the problem that is being solved, as well as a summary of why this
> has ever worked.  I guess we've just been lucky and not seen interrupts
> during suspend?
>
> Kevin
Hi, Kevin.

Yes. You are right about the interrupts.

-- 

Best regards,
Oleksandr Dmytryshyn | OMAP4 Platform
GlobalLogic Inc. | Innovation by Design
