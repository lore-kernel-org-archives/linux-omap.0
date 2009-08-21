From: John Sarman <johnsarman@gmail.com>
Subject: Re: Oops on shutdown?
Date: Fri, 21 Aug 2009 16:25:13 -0400
Message-ID: <bb2708720908211325t408ae640r34c72178aa0dcf26@mail.gmail.com>
References: <5e088bd90908200834o5b816127offa6b592a99526ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:55931 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbZHUUZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 16:25:13 -0400
Received: by ywh3 with SMTP id 3so1401970ywh.22
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 13:25:14 -0700 (PDT)
In-Reply-To: <5e088bd90908200834o5b816127offa6b592a99526ca@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Aug 20, 2009 at 11:34 AM, Steve Sakoman<sakoman@gmail.com> wrot=
e:
> I've been doing a bit of testing on 2.6.31-rc5 on Overo with good
> results overall.

Related to the Gumstix Overo
How is the USB working on this version.  I am still stuck using the
2.6.20-rc8, with patches for the hwmod and mmc updates.  This is the
last version I can successfully use the USB host.

>
> The only major issue I see at the moment is an oops on shutdown/resta=
rt.
>
> Is anyone else seeing this?
>
> Rebooting... Internal error: Oops - undefined instruction: 0 [#1]
> Modules linked in: ipv6 udf libertas_sdio libertas lib80211 sg sr_mod
> cdrom uvcvideo videodev v4l1_compat ads7846
> CPU: 0 =A0 =A0Not tainted =A0(2.6.31-rc5-omap1 #1)
> PC is at 0xcf8ab014
> LR is at usb_hcd_platform_shutdown+0x20/0x28
> pc : [<cf8ab014>] =A0 =A0lr : [<c031ac00>] =A0 =A0psr: a0000013
> sp : cb307e60 =A0ip : 00000001 =A0fp : 00000001
> r10: 00000000 =A0r9 : cb306000 =A0r8 : c00eefc4
> r7 : 0000006c =A0r6 : fee1dead =A0r5 : c0635258 =A0r4 : c05bcae8
> r3 : cf8aae88 =A0r2 : cf802c20 =A0r1 : c05bcdc0 =A0r0 : cf8a4b60
> Flags: NzCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0Segmen=
t user
> Control: 10c5387d =A0Table: 8a31c019 =A0DAC: 00000015
> Process reboot (pid: 10985, stack limit =3D 0xcb3062f0)
> Stack: (0xcb307e60 to 0xcb308000)
> 7e60: c0635258 c02dcbc8 c00eefc4 c02d874c 00000000 00000000 28121969 =
c0121840
> 7e80: 400d8000 c012188c 01234567 c01219a0 00000000 cf8652c0 cb2eff40 =
400d8000
> 7ea0: ca31c000 00000200 cfbd5680 c01684ac 000000b2 00000000 00000000 =
cf8bc168
> 7ec0: cb307f10 000000d8 00000000 00000360 ca31d000 000000d0 c0639124 =
ffffffff
> 7ee0: 400d8000 cf8652c0 ca14dca0 c03a6110 00000200 400d8000 cf8652c0 =
c00f457c
> 7f00: ca14dca0 ca14dd40 00000000 ca990848 cf67b418 00200200 00100100 =
cf401398
> 7f20: cf67b418 00200200 00100100 cf67b418 cf80a620 c0189480 cf67b418 =
cf67b418
> 7f40: c05cacd4 c0189be0 ca990848 00000021 00000000 caba28a0 00000000 =
c017b630
> 7f60: 00000000 00000000 00000003 caba28a0 00000000 caba28a0 00000000 =
cb0bbe40
> 7f80: 00000006 c01784d4 00000003 cb0bbe40 caba28a0 00000000 00000001 =
00000004
> 7fa0: 00000058 c00eee40 00000000 00000001 fee1dead 28121969 01234567 =
0000006c
> 7fc0: 00000000 00000001 00000004 00000058 00000001 00000001 00000000 =
00000001
> 7fe0: 400e0880 bedd1cb0 00009210 400e0898 60000010 fee1dead 00000000 =
00000000
> Code: cf8a3000 00000158 cf8ab158 0000004e (ffffffff)
> ---[ end trace 59776612ba8fbf0c ]---
> Segmentation fault
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
