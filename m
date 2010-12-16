From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [OMAP 1710] Mainline Broken
Date: Thu, 16 Dec 2010 16:35:22 +0100
Message-ID: <AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57919 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab0LPPfX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 10:35:23 -0500
Received: by qwa26 with SMTP id 26so3344824qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 07:35:22 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Dec 16, 2010 at 4:30 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> Did anyone observe this? I am using omap_generic_1710_defconfig
>
> [...]
> input: omap-keypad as /devices/platform/omap-keypad/input/input0
> TCP cubic registered
> NET: Registered protocol family 17
> Registering the dns_resolver key type
> eth0: link up
> IP-Config: Complete:
> =C2=A0 =C2=A0 device=3Deth0, addr=3D172.24.191.106, mask=3D255.255.25=
2.0, gw=3D172.24.188.1,
> =C2=A0 =C2=A0 host=3Dmyomap, domain=3D, nis-domain=3D(none),
> =C2=A0 =C2=A0 bootserver=3D172.24.191.66, rootserver=3D172.24.191.66,=
 rootpath=3D
> VFS: Mounted root (nfs filesystem) on device 0:10.
> Freeing init memory: 128K
> Kernel panic - not syncing: Attempted to kill init!
Seems your userspace is broken. Try add user_debug=3D31 to command line
to see what
exactly happens.
> Backtrace:
> [<c0032104>] (dump_backtrace+0x0/0x114) from [<c027ecd4>] (dump_stack=
+0x18/0x1c)
> =C2=A0r7:c0826000 r6:c0826000 r5:c0304ce8 r4:c0320254
> [<c027ecbc>] (dump_stack+0x0/0x1c) from [<c027ed38>] (panic+0x60/0x18=
8)
> [<c027ecd8>] (panic+0x0/0x188) from [<c0047414>] (do_exit+0x74/0x600)
> =C2=A0r3:60000013 r2:c0826000 r1:c08260f8 r0:c02d6cff
> [<c00473a0>] (do_exit+0x0/0x600) from [<c0047a38>] (do_group_exit+0x9=
8/0xcc)
> [<c00479a0>] (do_group_exit+0x0/0xcc) from [<c00535e4>] (get_signal_t=
o_deliver+0x304/0x33c)
> =C2=A0r7:c08ba484 r6:c0828000 r5:c0829ee4 r4:00000004
> [<c00532e0>] (get_signal_to_deliver+0x0/0x33c) from [<c0030fb8>] (do_=
notify_resume+0x7c/0x638)
> [<c0030f3c>] (do_notify_resume+0x0/0x638) from [<c002eb14>] (work_pen=
ding+0x24/0x28)
>
> --
> Tarun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

thanks,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
