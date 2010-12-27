From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: omapfb: no driver for display error with linux-2.6.37-rc7
Date: Mon, 27 Dec 2010 02:39:11 +0200
Message-ID: <AANLkTik0e2CG4V09PkufJBx-To66UAhoN66wBQmCbUWO@mail.gmail.com>
References: <6488240A-F0F8-469C-BCD3-B2B27AF51B6C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62057 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab0L0AjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Dec 2010 19:39:13 -0500
Received: by bwz15 with SMTP id 15so9257392bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Dec 2010 16:39:11 -0800 (PST)
In-Reply-To: <6488240A-F0F8-469C-BCD3-B2B27AF51B6C@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Dec 27, 2010 at 12:10 AM, Elvis Dowson <elvis.dowson@mac.com> w=
rote:
> =C2=A0 =C2=A0 =C2=A0 I'm getting the following error with linux-2.6.3=
7-rc7. Is there a .config setting that I'm missing?
>
> [ =C2=A0 =C2=A02.175872] omapfb omapfb: no driver for display
> [ =C2=A0 =C2=A02.180999] omapfb omapfb: failed to setup omapfb
>
> My bootargs are as follows:
>
> mmcargs=3Dsetenv bootargs console=3DttyO2,115200n8 vram=3D12M omapfb.=
vram=3D0:2M omapfb.mode=3D480x272MR-16@60 root=3D/dev/mmcblk0p2 rw root=
fstype=3Dext3 rootwait

Do you have a proper CONFIG_OMAP2_VRAM_SIZE in your config?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
