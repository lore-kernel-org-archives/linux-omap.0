From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 8 Mar 2010 19:06:00 -0800
Message-ID: <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
	<20100309004832.GK2900@atomide.com> <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
	<20100309024602.GQ2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f181.google.com ([209.85.216.181]:62942 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0CIDGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 22:06:20 -0500
Received: by pxi11 with SMTP id 11so1768918pxi.15
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 19:06:20 -0800 (PST)
In-Reply-To: <20100309024602.GQ2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

On Mon, Mar 8, 2010 at 6:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100308 17:49]:
>> On Mon, Mar 8, 2010 at 4:48 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Cory Maccarrone <darkstar6262@gmail.com> [100306 20:53]:
>>
>> > If you don't have any serial output with that, then try this:
>> >
>> > - reset some branch to 4f2c49fedf
>> > - make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .co=
nfig
>> > - check that you have earlyprintk also in the kernel cmdline
>> > - apply the following patch for the uncompress code
>> >
>>
>> This worked. =C2=A0I was able to boot in with DEBUG_LL enabled and
>> everything appears to be working properly.
>
> OK, then that means the debug-macro.S changes for busyuart macro
> are OK.
>
>> Any other hints? =C2=A0I'm going to start looking at the changes, I'=
m
>> beginning to understand them more.
>
> Well the next patch gets rid of the hardcoded port addresses.
> The debug port number is stored in uncompress.h based on the
> machine ID.
>
> Maybe try this next: Reset your test branch to commit
> 0c8219f0302d0d27fda52c790d38406801e547ec, then take a look at
> arch/arm/plat-omap/include/plat/uncompress.h in a text editor.
> Then see if there's an entry for your board in __arch_decomp_setup.
>
> Is the DEBUG_LL_OMAP7XX(1, herald) correct? Is port 1 the right
> UART to use?
>

That line is correct, as far as I'm aware.  It resolves to the same
configuration that was there previously.

> If there's no entry, then you need to add a DEBUG_LL_OMAP7XX line
> suitable for your board.
>
> If you see something like "Uncompressing Linux..." then your know
> the uncompress.h part is working. Once you get that working, then
> it's time to look at the debug-macro.S again, see the addruart
> macro that reads the debug port number from UART1 scratchpad
> register.
>
> Regards,
>
> Tony
>
>

Alright, I found it.  0c8219f0302d0d27fda52c790d38406801e547ec removed
this code from uncompress.h:

    -               if (check_port(uart, shift))
    -                       break;

which was in a while loop in putc(), with check_port defined as:

    #define UART_OMAP_MDR1         0x08    /* mode definition register =
*/
    #define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7=
) =3D=3D 0)

and shift =3D 0.  Without the break, putc() was silent.  If I put in
similar code back into putc():

    +       if ((uart_base[0x08] & 7) !=3D 0)
    +               return;

it boots.

Unfortunately, I don't have access to the serial console, so I have no
idea if any of the serial port work was actually working (the Herald
is a phone, and the only output I have is USB, which can act as
serial, but I'm ill-equipped to make that work).  I suspect this is
always returning true, and as such we're not getting serial output
through the uncompress.  Not sure what's needed to fix this, but at
least that little bit of code makes it boot for me.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
