From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: serial port input corruption with 2.6.32?
Date: Wed, 23 Dec 2009 15:06:06 -0600
Message-ID: <4551feaf0912231306gfebba89rf4e5b014c3a74fe7@mail.gmail.com>
References: <5e088bd90912231259k12dfafeckecbaaa1d29cec4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42379 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZLWVGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 16:06:10 -0500
Received: by ewy19 with SMTP id 19so6766803ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 23 Dec 2009 13:06:07 -0800 (PST)
In-Reply-To: <5e088bd90912231259k12dfafeckecbaaa1d29cec4ed@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Dec 23, 2009 at 2:59 PM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> I'm seeing some strange behavior with my console serial port with 2.6=
=2E32.
>
> Output seems fine -- no errors in the boot messages.
>
> However it seems that quite often the first character typed in a
> console session is garbled -- subsequent characters are OK:
>
> root@omap3:~# =EF=BF=BDs -l
> -sh: =EF=BF=BDs: not found
>
> If commands are typed in rapid succession this issue doesn't show up,
> but if several seconds pass since the last keystroke the first
> character is garbled once again.
>
> Anyone else seeing this? =C2=A0A search of this list didn't turn anyt=
hing
> up, but perhaps my google mojo is just bad today.
>
> Steve

Hey Steve,

I saw something similar while testing 2.6.32, by chance are you using
any power management patches?

I had to disable CONFIG_CPU_IDLE:

-CONFIG_CPU_IDLE=3Dy
-CONFIG_CPU_IDLE_GOV_LADDER=3Dy
-CONFIG_CPU_IDLE_GOV_MENU=3Dy
+# CONFIG_CPU_IDLE is not set

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
