From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: serial port input corruption with 2.6.32?
Date: Wed, 06 Jan 2010 16:25:09 -0800
Message-ID: <874omy92xm.fsf@deeprootsystems.com>
References: <5e088bd90912231259k12dfafeckecbaaa1d29cec4ed@mail.gmail.com>
	<4551feaf0912231306gfebba89rf4e5b014c3a74fe7@mail.gmail.com>
	<5e088bd90912231322y3f507e4bvc453583946340cb8@mail.gmail.com>
	<87k4vuak71.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC3560870300519479@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44431 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab0AGAZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:25:12 -0500
Received: by pwj9 with SMTP id 9so11604784pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:25:11 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300519479@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 7 Jan 2010 05\:10\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>Steve Sakoman <sakoman@gmail.com> writes:
>>
>>> On Wed, Dec 23, 2009 at 1:06 PM, Robert Nelson <robertcnelson@gmail=
=2Ecom> wrote:
>>>> On Wed, Dec 23, 2009 at 2:59 PM, Steve Sakoman <sakoman@gmail.com>=
 wrote:
>>>>> I'm seeing some strange behavior with my console serial port with=
 2.6.32.
>>>>>
> <snip>
>>This will also have obvious and serious PM implications for non
>>serial-console devices connected to UARTs (IrDA, bluetooth, modems,
>>etc.)
>
> OMAP uarts for BT etc use h/w flow control, which is another way of
> waking up omap before sending any chars and hence don=E2=80=99t loose=
 data.

Good point.  However, I haven't personally tested (or heard) that it
actually works as would be expected.  Can you confirm working BT over
a UART with idle/unclocking enabled?

Kevin


> Console uses no flow control as you know.
>
>>
>>I've heard some ideas of muxing the UART into GPIO mode when idle and
>>having a bitbanging to get the first char so it is not lost, but
>>haven't seen any patches to do it.
>>
>>While it doesn't really solve your problem, I hope it at least helps
>>understand the reason for it.
>
> You could write a book on uart pm :)
>
>>
>>Kevin
>>
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
