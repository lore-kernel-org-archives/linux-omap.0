From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Omapfb issue
Date: Sat, 23 Jan 2010 11:03:32 +0200
Message-ID: <94a0d4531001230103s37d2a92co9171b13fa0d72147@mail.gmail.com>
References: <0AAE131817A2E34DA8AD5EB0BADB2AD74ACD39D14D@kor-exch2k7.phoenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:36061 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0AWJDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jan 2010 04:03:35 -0500
Received: by iwn16 with SMTP id 16so808089iwn.33
        for <linux-omap@vger.kernel.org>; Sat, 23 Jan 2010 01:03:34 -0800 (PST)
In-Reply-To: <0AAE131817A2E34DA8AD5EB0BADB2AD74ACD39D14D@kor-exch2k7.phoenix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Karthick Tharakraj <Karthick_Tharakraj@phoenix.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 21, 2010 at 4:26 AM, Karthick Tharakraj
<Karthick_Tharakraj@phoenix.com> wrote:
>
> Hello everyone,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 We are facing=
 an issue with Framebuffer (omapfb) driver while starting Xorg.
>
> Currently we are using Devkit8000 and trying to boot Linux with our i=
nhouse rootfs. =C2=A0While booting the X throws an error saying:
>
> (EE) omapfb(0): FBIOBLANK: Invalid argument

Maybe it's related to this change?
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3Dc958557eb6e5f0fa15aeda3b6f952051b4179394

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
