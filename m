From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Tue, 9 Mar 2010 15:41:47 -0800
Message-ID: <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
	<20100309004832.GK2900@atomide.com> <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
	<20100309024602.GQ2900@atomide.com> <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
	<20100309155636.GS2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:19711 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab0CIXmI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 18:42:08 -0500
Received: by qw-out-2122.google.com with SMTP id 8so148436qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 15:42:07 -0800 (PST)
In-Reply-To: <20100309155636.GS2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

On Tue, Mar 9, 2010 at 7:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100308 19:03]:
>> On Mon, Mar 8, 2010 at 6:46 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>>
>> Alright, I found it. =C2=A00c8219f0302d0d27fda52c790d38406801e547ec =
removed
>> this code from uncompress.h:
>>
>> =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(check_port(uart, shift))
>> =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>
>> which was in a while loop in putc(), with check_port defined as:
>>
>> =C2=A0 =C2=A0 #define UART_OMAP_MDR1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0=
8 =C2=A0 =C2=A0/* mode definition register */
>> =C2=A0 =C2=A0 #define check_port(base, shift) ((base[UART_OMAP_MDR1 =
<< shift] & 7) =3D=3D 0)
>>
>> and shift =3D 0. =C2=A0Without the break, putc() was silent. =C2=A0I=
f I put in
>> similar code back into putc():
>>
>> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 if ((uart_base[0x08] & 7) !=3D =
0)
>> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn;
>>
>> it boots.
>>
>> Unfortunately, I don't have access to the serial console, so I have =
no
>> idea if any of the serial port work was actually working (the Herald
>> is a phone, and the only output I have is USB, which can act as
>> serial, but I'm ill-equipped to make that work). =C2=A0I suspect thi=
s is
>> always returning true, and as such we're not getting serial output
>> through the uncompress. =C2=A0Not sure what's needed to fix this, bu=
t at
>> least that little bit of code makes it boot for me.
>
> OK. It's not a bug it's a feature :)
>
> If you don't have anything connected to the serial port, then
> DEBUG_LL should not do anything as it just waits for fifo to empty.
>
> Sounds like we should either have most of uncompress.h in ifdef
> CONFIG_DEBUG_LL so it does not do anything unless set.
>
> We may also want to also define DEBUG_LL_OMAP_NONE in uncompress.h
> to allow booting systems with no serial port with DEBUG_LL set,
> but I don't know if that's really needed.
>
> Does your system boot without any patches if DEBUG_LL is not set
> in your .config?
>
> Regards,
>
> Tony
>

No, it doesn't.  Seems like the debugging code is still trying to run,
even disabled.  If I add in that check, it'll boot with DEBUG_LL not
set, but won't without that.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
