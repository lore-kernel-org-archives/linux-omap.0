From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 11:06:50 +0200
Message-ID: <AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
	<4D5DF547.7010703@ti.com>
	<AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38877 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab1BSJGv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 04:06:51 -0500
Received: by bwz15 with SMTP id 15so1433889bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 01:06:50 -0800 (PST)
In-Reply-To: <AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: archit taneja <archit@ti.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

On Sat, Feb 19, 2011 at 9:41 AM, Ming Lei <tom.leiming@gmail.com> wrote=
:
>> It looks like an issue with what you have selected in the menuconfig=
=2E Could
>> you ensure you have DPI and VENC selected, and in displays Generic D=
PI panel
>> and sharp-ls panel selected.
>
> Even after enabling all this options above, there is still the failur=
e
> message on my pandaboard(2.6.38-rc5-next-20110217):
>
> [ =C2=A0 =C2=A00.000000] Kernel command line: console=3DttyO2,115200n=
8 vram=3D16M
> root=3D/dev/mmcblk0p2 rw earlyprintk rootfstype=3Dext3 rootwait
> ......
> [ =C2=A0 =C2=A02.847625] omapfb omapfb: no displays
> [ =C2=A0 =C2=A02.851562] omapfb omapfb: failed to setup omapfb
> [ =C2=A0 =C2=A02.856719] omapfb: probe of omapfb failed with error -2=
2

Note that the command line parameters are ignored since 2.6.36, you
need to specify CONFIG_OMAP2_VRAM_SIZE.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
