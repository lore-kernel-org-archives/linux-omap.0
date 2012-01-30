From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 00:07:59 +0200
Message-ID: <CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44606 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab2A3WIB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 17:08:01 -0500
Received: by lagu2 with SMTP id u2so2494258lag.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 14:08:00 -0800 (PST)
In-Reply-To: <87obtlrniz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Mon, Jan 30, 2012 at 9:36 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
>> Hi,
>>
>> On 3.2 (I think some earlier versions too), with CONFIG_CPU_IDLE
>> enabled GPIO based buttons are not working properly on OMAP3 pandora=
,
>> button presses are almost never registered. The buttons are connecte=
d
>> GPIO bank4 and have hardware debounce feature enabled.
>>
>> Doing either of the following solves (or hides) the problem:
>> - disabling CPU_IDLE in kernel config
>> - disabling debounce for the buttons
>> - running a program spinning a loop on the CPU
>>
>> From what I can see in the code debounce clock is disabled when
>> entering idle, can those GPIOs work without debounce clock?
>
> Yes, the clock is only for the debounce feature, but the GPIOs are
> capable of wakeups and interrupts with the debounce clock disabled.

Hmm but it doesn't work here (OMAP3530 ES2.1), /proc/interrupts
doesn't increase when I hit buttons unless something else is happening
at the same time. I wonder if I'm missing something here, does it all
work for you with debounce on? It can be easily tested if you add
=2Edebounce_interval to gpio_keys_button of gpio_keys_platform_data.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
