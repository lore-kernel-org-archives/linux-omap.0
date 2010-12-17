From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [OMAP 1710] Mainline Broken
Date: Fri, 17 Dec 2010 13:50:26 -0800
Message-ID: <877hf883x9.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
	<AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com>
	<87r5dhfxwh.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373A9363D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57550 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0LQVub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 16:50:31 -0500
Received: by yxt3 with SMTP id 3so540264yxt.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 13:50:30 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373A9363D@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Fri, 17 Dec 2010 13:52:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Thursday, December 16, 2010 10:39 PM
>> To: Belisko Marek
>> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
>> Subject: Re: [OMAP 1710] Mainline Broken
>>=20
>> Belisko Marek <marek.belisko@gmail.com> writes:
>>=20
>> > Hi,
>> >
>> > On Thu, Dec 16, 2010 at 4:30 PM, DebBarma, Tarun Kanti
>> > <tarun.kanti@ti.com> wrote:
>> >> Did anyone observe this? I am using omap_generic_1710_defconfig
>> >>
>> >> [...]
>> >> input: omap-keypad as /devices/platform/omap-keypad/input/input0
>> >> TCP cubic registered
>> >> NET: Registered protocol family 17
>> >> Registering the dns_resolver key type
>> >> eth0: link up
>> >> IP-Config: Complete:
>> >> =C2=A0 =C2=A0 device=3Deth0, addr=3D172.24.191.106, mask=3D255.25=
5.252.0,
>> gw=3D172.24.188.1,
>> >> =C2=A0 =C2=A0 host=3Dmyomap, domain=3D, nis-domain=3D(none),
>> >> =C2=A0 =C2=A0 bootserver=3D172.24.191.66, rootserver=3D172.24.191=
=2E66, rootpath=3D
>> >> VFS: Mounted root (nfs filesystem) on device 0:10.
>> >> Freeing init memory: 128K
>> >> Kernel panic - not syncing: Attempted to kill init!
>> >
>> > Seems your userspace is broken. Try add user_debug=3D31 to command=
 line
>> > to see what exactly happens.
>>=20
>> Looks like you're mounting an NFS rootfs.  Was it compiled for armv5=
?
>> My hunch would be you're trying to run an armv6/armv7 userspace on t=
he
>> 1710 which is armv5.
>>=20
>> To get more debugging, ensure these are enabled in your defconfig:
>>=20
>> CONFIG_DEBUG_BUGVERBOSE=3Dy
>> CONFIG_DEBUG_USER=3Dy
>> CONFIG_DEBUG_ERRORS=3Dy
>>=20
>> and in addition to cmdline suggested by Marek, add user_debug=3D0xf
>>=20
>> This will give verbose output for userspace exceptions as well and
>> possibly confirm my hunch.
>>=20
>> Kevin
>
> I checked .config and it shows: CONFIG_CPU_32v5=3Dy

This is a kernel config option.  I was asking about your userspace.
Your kernel is obviously booting fine, but it crashes as soon as
userspace starts.

Is your *userspace* compiled for armv5?  I'm guessing not.

Kevin

> With regard to additional log here they are!!
>
> [...]
> [1] init: obsolete system call 00000000.
> Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01)
> Kernel panic - not syncing: Attempted to kill init!
> Backtrace:
> [...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
