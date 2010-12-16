From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [OMAP 1710] Mainline Broken
Date: Thu, 16 Dec 2010 09:08:46 -0800
Message-ID: <87r5dhfxwh.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
	<AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:43518 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab0LPRIu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 12:08:50 -0500
Received: by pxi20 with SMTP id 20so720445pxi.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 09:08:49 -0800 (PST)
In-Reply-To: <AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com>
	(Belisko Marek's message of "Thu, 16 Dec 2010 16:35:22 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Belisko Marek <marek.belisko@gmail.com> writes:

> Hi,
>
> On Thu, Dec 16, 2010 at 4:30 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> Did anyone observe this? I am using omap_generic_1710_defconfig
>>
>> [...]
>> input: omap-keypad as /devices/platform/omap-keypad/input/input0
>> TCP cubic registered
>> NET: Registered protocol family 17
>> Registering the dns_resolver key type
>> eth0: link up
>> IP-Config: Complete:
>> =C2=A0 =C2=A0 device=3Deth0, addr=3D172.24.191.106, mask=3D255.255.2=
52.0, gw=3D172.24.188.1,
>> =C2=A0 =C2=A0 host=3Dmyomap, domain=3D, nis-domain=3D(none),
>> =C2=A0 =C2=A0 bootserver=3D172.24.191.66, rootserver=3D172.24.191.66=
, rootpath=3D
>> VFS: Mounted root (nfs filesystem) on device 0:10.
>> Freeing init memory: 128K
>> Kernel panic - not syncing: Attempted to kill init!
>
> Seems your userspace is broken. Try add user_debug=3D31 to command li=
ne
> to see what exactly happens.

Looks like you're mounting an NFS rootfs.  Was it compiled for armv5?
My hunch would be you're trying to run an armv6/armv7 userspace on the
1710 which is armv5.

To get more debugging, ensure these are enabled in your defconfig:

CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_USER=3Dy
CONFIG_DEBUG_ERRORS=3Dy

and in addition to cmdline suggested by Marek, add user_debug=3D0xf

This will give verbose output for userspace exceptions as well and
possibly confirm my hunch.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
