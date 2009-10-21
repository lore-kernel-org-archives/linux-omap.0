From: Brett Graham <graham@rowland.harvard.edu>
Subject: Re: Fwd: mmap /dev/mem in python
Date: Wed, 21 Oct 2009 08:20:36 -0400
Message-ID: <47b23c40910210520r248e8886h4aa7bb9f68238a89@mail.gmail.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>
	<20091020221701.GM12576@atomide.com> <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com>
	<47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
	<alpine.DEB.2.00.0910201723480.22645@utopia.booyaka.com> <47b23c40910201701k20f712aesd6795709535c48b2@mail.gmail.com>
	<alpine.DEB.2.00.0910201817100.22645@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43263 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbZJUMUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 08:20:52 -0400
Received: by ewy3 with SMTP id 3so5960455ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2009 05:20:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0910201817100.22645@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Doh! Thank you! This looks to be the problem, I've made some changes
to the code (calling mmap.read(4) rather than mmap.read_bye()) and
everything seems to be working.

On Tue, Oct 20, 2009 at 8:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 20 Oct 2009, Brett Graham wrote:
>
>> --minimal python example--
>> open("/dev/mem", O_RDWR|O_SYNC|O_LARGEFILE) =3D 3
>> fstat64(3, {st_mode=3DS_IFCHR|0640, st_rdev=3Dmakedev(1, 1), ...}) =3D=
 0
>> dup(3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4
>> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x48088) =3D =
0x40020000
>> --- SIGBUS (Bus error) @ 0 (0) ---
>> +++ killed by SIGBUS +++
>> Process 1633 detached
>
> Your script:
>
>>> m =3D mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_WRITE =
|
>>> mmap.PROT_READ, offset=3Daddr & ~MAP_MASK)
>>> m.seek(addr & MAP_MASK)
>
> So the mmap() is working fine, based on the output above...
>
>>> c =3D m.read_byte()
>
> ... but the above line is going to fail. =C2=A0GPTIMER registers need=
 16-
> or 32-bit accesses[1].
>
>
> - Paul
>
> 1. OMAP34xx TRM 16.3.2:
>
> "CAUTION
> The GP timer registers are limited to 32-bit and 16-bit data accesses=
;
> 8-bit access is not allowed and can corrupt the register content."
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
