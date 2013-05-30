From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/1] i2c: omap: correct usage of the interrupt enable register
Date: Thu, 30 May 2013 07:18:26 -0700
Message-ID: <87obbsa6vh.fsf@linaro.org>
References: <1369812944-685-1-git-send-email-oleksandr.dmytryshyn@ti.com>
	<1369812944-685-2-git-send-email-oleksandr.dmytryshyn@ti.com>
	<878v2x7lak.fsf@linaro.org> <51A71375.9030100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55067 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab3E3OSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 10:18:30 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so435136pde.9
        for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 07:18:29 -0700 (PDT)
In-Reply-To: <51A71375.9030100@ti.com> (Oleksandr Dmytryshyn's message of
	"Thu, 30 May 2013 11:53:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com> writes:

> On 05/29/2013 08:22 PM, Kevin Hilman wrote:
>> Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com> writes:
>>
>>> Starting from the OMAP chips with version2 registers scheme there are
>>> 2 registers (I2C_IRQENABLE_SET and I2C_IRQENABLE_CLR) to manage
>>> interrupts instead of the older OMAP chips with old scheme which have
>>> only one register (I2C_IE).  Now we should use I2C_IRQENABLE_SET
>>> register for enabling interrupts and I2C_IRQENABLE_CLR register for
>>> disabling interrupts.
>> Why?  (changelogs should always answer the "why" question)
>>
>> IOW, what is broken without this change, how does it fail?  And equally
>> important, how is it currently working?
>>
>> Kevin
>>
>>
> Hi, Kevin.
>
> If the i2c controller during suspend will generate an interrupt, it
> can lead to unpredictable behaviour in the kernel.
>
> Based on the logic of the kernel code interrupts from i2c should be
> prohibited during suspend. Kernel writes 0 to the I2C_IE register in
> the omap_i2c_runtime_suspend() function. In the other side kernel
> writes saved interrupt flags to the I2C_IE register in
> omap_i2c_runtime_resume() function. I.e. interrupts should be disabled
> during suspend.
>
> This works for chips with version1 registers scheme. Interrupts are
> disabled during suspend. For chips with version2 scheme registers
> writting 0 to the I2C_IE register does nothing (because now the
> I2C_IRQENABLE_SET register is located at this address ). This register
> is used to enable interrupts. For disabling interrupts
> I2C_IRQENABLE_CLR register should be used.
>
> I've checked that interrupts in the i2c controller are still enabled
> after writting 0 to the I2C_IE register. But with my patch interrupts
> are disabled in the omap_i2c_runtime_suspend() function.

Yes, I understand why your patch works, and it looks correct to me.  

My main concern is that the changelog is missing a detailed description
of the problem that is being solved, as well as a summary of why this
has ever worked.  I guess we've just been lucky and not seen interrupts
during suspend?

Kevin
