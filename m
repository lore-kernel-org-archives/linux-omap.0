From: Brett Graham <graham@rowland.harvard.edu>
Subject: Re: Fwd: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 20:01:27 -0400
Message-ID: <47b23c40910201701k20f712aesd6795709535c48b2@mail.gmail.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
	<20091020221701.GM12576@atomide.com> <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com>
	<47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
	<alpine.DEB.2.00.0910201723480.22645@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:47170 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbZJUABn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 20:01:43 -0400
Received: by ewy3 with SMTP id 3so5445614ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 17:01:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0910201723480.22645@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

It's good to at least know that this doesn't seem to be a kernel
issue, and thanks for the strace advice (I am new to this level of
linux development). Here is the truncated output for devmem and the
minimal example:

--- devmem ---
open("/dev/mem", O_RDWR|O_SYNC)         =3D 3
fstat64(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 0), ...}) =3D=
 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x4001f000
write(1, "/dev/mem opened.\n", 17)      =3D 17
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x48088) =3D 0x4=
0020000
write(1, "Memory mapped at address 0x40020"..., 37) =3D 37
write(1, "Value at address 0x48088024 (0x4"..., 46) =3D 46
munmap(0x40020000, 4096)                =3D 0
close(3)                                =3D 0
io_submit(0, 0, 0xfbad2088 <unfinished ... exit status 0>
Process 1635 detached


--minimal python example--
open("/dev/mem", O_RDWR|O_SYNC|O_LARGEFILE) =3D 3
fstat64(3, {st_mode=3DS_IFCHR|0640, st_rdev=3Dmakedev(1, 1), ...}) =3D =
0
dup(3)                                  =3D 4
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x48088) =3D 0x4=
0020000
--- SIGBUS (Bus error) @ 0 (0) ---
+++ killed by SIGBUS +++
Process 1633 detached

It looks like python decided to add a O_LARGEFILE and duplicate the
file descriptor. I'm still not sure what's going on here that's
causing the problem as both mmap2 calls are identical.

I don't mean to bombard this list with a problem that isn't related to
the kernel, so I'll post this to a python list somewhere. Thanks a
million for your help so far, this is driving me nutty! Also if any
more info would help just let me know.

On Tue, Oct 20, 2009 at 7:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 20 Oct 2009, Brett Graham wrote:
>
>> If I run the following commads:
>> devmem2 0x48004a40 w 0x0000038a # select 32kHz clock
>> devmem2 0x48004a10 w 0x03007052 # enable iclk for gpt11
>> devmem2 0x48004a00 w 0x03007000 # enable fclk for gpt11
>>
>> which all run sensibly and alter the registers, then I try to previo=
us
>> minimum example on address 0x48088024 (TCLK for gpt11) I get the
>> following error:
>> Unhandled fault: external abort on non-linefetch (0x1018) at 0x40020=
024
>> Bus error
>>
>> What puzzles me is that when I use devmem2 to read or write to the
>> same register, everything works fine.
>
> Consider running strace on devmem2 and comparing it to the strace of =
your
> Python code? =C2=A0That should show you any differences. =C2=A0If dev=
mem2 works,
> it's unlikely to be a kernel problem.
>
>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
