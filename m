From: Brett Graham <graham@rowland.harvard.edu>
Subject: Fwd: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 19:16:29 -0400
Message-ID: <47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
	<20091020221701.GM12576@atomide.com> <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:25831 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbZJTXQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 19:16:45 -0400
Received: by ey-out-2122.google.com with SMTP id d26so947171eyd.5
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 16:16:49 -0700 (PDT)
In-Reply-To: <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

If I run the following commads:
devmem2 0x48004a40 w 0x0000038a # select 32kHz clock
devmem2 0x48004a10 w 0x03007052 # enable iclk for gpt11
devmem2 0x48004a00 w 0x03007000 # enable fclk for gpt11

which all run sensibly and alter the registers, then I try to previous
minimum example on address 0x48088024 (TCLK for gpt11) I get the
following error:
Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020024
Bus error

What puzzles me is that when I use devmem2 to read or write to the
same register, everything works fine.

On Tue, Oct 20, 2009 at 6:17 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Brett Graham <graham@rowland.harvard.edu> [091020 15:06]:
>> I'm trying to mmap /dev/mem in python to access various registers on=
 a
>> gumstix overo (with an omap 3530 processor). Here is the code I'm
>> using (as a minimal example):
>> ----------------------------
>> import os, mmap
>> MAP_MASK =3D mmap.PAGESIZE - 1
>> addr =3D (see below)
>>
>> f =3D os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
>> m =3D mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_WRITE |
>> mmap.PROT_READ, offset=3Daddr & ~MAP_MASK)
>> m.seek(addr & MAP_MASK)
>> c =3D m.read_byte()
>> print c
>> m.close()
>> os.close(f)
>> ----------------------------
>>
>> If I use: addr =3D 0x48002178 everything works swimmingly. However, =
if I
>> use: addr =3D 0x48088024 (or all the addresses I've tried > 0x480440=
00)
>> I get the following error
>>
>> Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020=
024
>> Bus error
>>
>> and python crashes. I'm basing the mmap flags and options off of
>> devmem2.c. If I remove the O_SYNC flag from the os.open command, I c=
an
>> read and write to registers fine, but randomly I will get the
>> Unhandled fault error and things will not work correctly.
>>
>> Am I using the right command to write to the omap registers? should =
I
>> be using the O_SYNC flag? Any ideas where these errors are coming
>> from?
>
> Sounds like you need to enable ick and fck for the device you're tryi=
ng
> to read.
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
