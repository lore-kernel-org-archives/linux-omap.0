From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP: UART: omap_device converions, remove implicit 8520 assumptions
Date: Mon, 01 Mar 2010 11:26:35 -0800
Message-ID: <87k4tvetck.fsf@deeprootsystems.com>
References: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com>
	<1263340728-17929-3-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031E4F22E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:63916 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0CAT0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 14:26:39 -0500
Received: by pxi26 with SMTP id 26so992464pxi.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 11:26:39 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E4F22E3@dbde02.ent.ti.com> (Rajendra Nayak's message of "Sat\, 30 Jan 2010 12\:05\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Raja, Govindraj" <govindraj.raja@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

[...]

>> +             /*
>> +              * Need to block sleep long enough for interrupt driven
>> +              * driver to start.  Console driver is in polling mode
>> +              * so device needs to be kept enabled while
>> polling driver
>> +              * is in use.
>> +              */
>> +             uart->timeout = (30 * HZ);
>> +             omap_uart_block_sleep(uart);
>> +             uart->timeout = DEFAULT_TIMEOUT;
>> +
>> +             if ((cpu_is_omap34xx() && uart->padconf) ||
>> +                 (uart->wk_en && uart->wk_mask)) {
>> +                     device_init_wakeup(&od->pdev.dev, true);
>> +                     DEV_CREATE_FILE(&od->pdev.dev,
>> &dev_attr_sleep_timeout);
>> +             }
>> +
>> +#ifdef CONFIG_SERIAL_8250_CONSOLE
>>               /* omap44xx: Never read empty UART fifo
>>                * omap3xxx: Never read empty UART fifo on UARTs
>>                * with IP rev >=0x52
>>                */
>>               if (cpu_is_omap44xx())
>> -                     uart->p->serial_in = serial_in_override;
>> -             else if ((serial_read_reg(uart->p,
>> UART_OMAP_MVER) & 0xFF)
>> +                     p->serial_in = serial_in_override;
>> +             else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
>>                               >= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
>> -                     uart->p->serial_in = serial_in_override;
>> +                     p->serial_in = serial_in_override;
>> +#endif
>
> I think this (overriding serial_in) needs to be done sometime before you do a
> omap_device_build() call. Else this has no affect.
>

Thanks Rajendra, you're right, good catch.

Will fix in next spin.

Thanks ,

Kevin
