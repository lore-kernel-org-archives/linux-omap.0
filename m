From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: GPIO debounce problems on 3.2
Date: Tue, 31 Jan 2012 03:00:46 +0200
Message-ID: <CANOLnOMv5jdmo8LeeV2C6X-Yoq_xJ__kzbcFBcdmPsbt6YfsYQ@mail.gmail.com>
References: <CANOLnOOKSC72MsteqE_+F4Q3MUZCJBfDebe7kKHoLsDAxr5y0g@mail.gmail.com>
	<87obtlrniz.fsf@ti.com>
	<CANOLnOM-kaHv=Dm2-6xowK4Z_BJuRopj-25M1HeyJsiYgXp7tA@mail.gmail.com>
	<87obtkpyna.fsf@ti.com>
	<alpine.DEB.2.00.1201301628440.17726@utopia.booyaka.com>
	<871uqgpvpx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56256 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900Ab2AaBAs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 20:00:48 -0500
Received: by lagu2 with SMTP id u2so2559388lag.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 17:00:46 -0800 (PST)
In-Reply-To: <871uqgpvpx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 2:22 AM, Kevin Hilman <khilman@ti.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> That's probably I/O ring/pad wakeups happening there, not GPIO wakeu=
ps.
>> Gra=C5=BEvydas, you are referring to the case where the CORE powerdo=
main is on,
>> but the GPIO IP block is idle?
>
> Right good point.
>
> If CORE is powerdomain is staying on, you might also have a look at t=
he
> "GPIO module-level wakeups not always working" item in the "Known
> problems" section of the OMAP PM wiki:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://elinux.org/OMAP_Power_Manage=
ment#Known_Problems
>
> It might be the case that haven't done a request_irq() +
> enable_irq_wake() for those GPIOs.

Well I'm just using standard gpio_keys driver, which does
request_threaded_irq(), I guess that's good enough? I've also tried
sticking enable_irq_wake() just after it but that didn't help.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
