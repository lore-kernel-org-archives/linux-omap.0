From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 1/3] OMAP UART: Add omap-serial driver support.
Date: Wed, 2 Dec 2009 19:13:25 +0530
Message-ID: <d6a0f7aa0912020543s7f8310fdueb0a3a6c52df1326@mail.gmail.com>
References: <35817.192.168.10.88.1256713980.squirrel@dbdmail.itg.ti.com>
	 <45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
	 <87ws1fvjwu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:31039 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbZLBNnT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 08:43:19 -0500
Received: by qw-out-2122.google.com with SMTP id 3so29694qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 05:43:25 -0800 (PST)
In-Reply-To: <87ws1fvjwu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Wed, Nov 25, 2009 at 12:18 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From 4756e3743c7acd2de1030b2bd432c1b19f0b9ff5 Mon Sep 17 00:00:00 20=
01
>> From: Govindraj R <govindraj.raja@ti.com>
>> Date: Fri, 13 Nov 2009 12:01:54 +0530
>> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>>
>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>>
>> It adds support for the following features:
>> 1. It supports Interrupt mode and DMA mode of operation.
>> 2. Supports Hardware flow control and sofware flow control.
>> 3. Debug Console support on all UARTs.
>>
>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
>
> Some general comments.
>
> This should summarize how this is different from the 8250 driver on
> which it was based, as it's clear that it was based on 8250 but not
> clear at all what the changes are.
>
> At first glance, you've dropped several features from the 8250 driver
> which we currently use. =A0Namely, the ability for platform code to
> override some of the defaults:
>
> - change irq_flags
> - serial_in function
> - optional ioremapping (omap_hwmod layer will have done ioremap alrea=
dy)


Agree. uart_port_info [should be renamed to omap_uart_port_info]
should grow with fields like irqflags, membase and mapbase feilds.

adding these would need rework on the patch:
http://patchwork.kernel.org/patch/62555/

Should I work on top of above patch?

Serial in function might not be necessary for omap-serial driver,
this function was added to handle RX reading by checking if DR bit set
in LSR reg.
This is taken care in omap-serial driver.

---
Regards,
Govindraj.R

>
> These are now hard-coded in the new driver which makes it
> significantly less flexible.
>
> In a few minutes I will be posting a set of patches to convert the
> mach-omap2/serial.c to use omap_hwmod/omap_device. =A0This replaces y=
our
> PATCH 2/3, so please use with any subsequent updates.
>
>> ---
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0115 +++
>> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 23 +
>> =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
>> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 1330 +++++++++++++++++++++++++
>> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +
>> =A05 files changed, 1472 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>> =A0create mode 100644 drivers/serial/omap-serial.c
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
