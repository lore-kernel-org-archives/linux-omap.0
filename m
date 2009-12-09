From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/3] OMAP UART: Add omap-serial driver support.
Date: Wed, 09 Dec 2009 14:33:15 -0800
Message-ID: <87ljhbu6ac.fsf@deeprootsystems.com>
References: <35817.192.168.10.88.1256713980.squirrel@dbdmail.itg.ti.com>
	<45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
	<87ws1fvjwu.fsf@deeprootsystems.com>
	<d6a0f7aa0912020543s7f8310fdueb0a3a6c52df1326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:41059 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758312AbZLIWdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 17:33:11 -0500
Received: by iwn1 with SMTP id 1so4938439iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 14:33:18 -0800 (PST)
In-Reply-To: <d6a0f7aa0912020543s7f8310fdueb0a3a6c52df1326@mail.gmail.com> (Govindraj's message of "Wed\, 2 Dec 2009 19\:13\:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Nov 25, 2009 at 12:18 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> From 4756e3743c7acd2de1030b2bd432c1b19f0b9ff5 Mon Sep 17 00:00:00 2=
001
>>> From: Govindraj R <govindraj.raja@ti.com>
>>> Date: Fri, 13 Nov 2009 12:01:54 +0530
>>> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>>>
>>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>>>
>>> It adds support for the following features:
>>> 1. It supports Interrupt mode and DMA mode of operation.
>>> 2. Supports Hardware flow control and sofware flow control.
>>> 3. Debug Console support on all UARTs.
>>>
>>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
>>
>> Some general comments.
>>
>> This should summarize how this is different from the 8250 driver on
>> which it was based, as it's clear that it was based on 8250 but not
>> clear at all what the changes are.
>>
>> At first glance, you've dropped several features from the 8250 drive=
r
>> which we currently use. =A0Namely, the ability for platform code to
>> override some of the defaults:
>>
>> - change irq_flags
>> - serial_in function
>> - optional ioremapping (omap_hwmod layer will have done ioremap alre=
ady)
>
>
> Agree. uart_port_info [should be renamed to omap_uart_port_info]
> should grow with fields like irqflags, membase and mapbase feilds.
>
> adding these would need rework on the patch:
> http://patchwork.kernel.org/patch/62555/
>
> Should I work on top of above patch?

Yes.

> Serial in function might not be necessary for omap-serial driver,
> this function was added to handle RX reading by checking if DR bit se=
t
> in LSR reg.
>
> This is taken care in omap-serial driver.

OK, I didn't look closely at that but I'd like to be sure that the
extra checking can be optimized out on the SoCs that don't need it.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
