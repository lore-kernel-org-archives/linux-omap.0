From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 17:24:01 +0800
Message-ID: <AANLkTikSU_QgRNahQU3Rrb1KZ0vCNZ4FTz59hOmDaaUD@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
	<4D5DF547.7010703@ti.com>
	<AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
	<AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59234 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1BSJYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 04:24:03 -0500
Received: by yib18 with SMTP id 18so1945779yib.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 01:24:02 -0800 (PST)
In-Reply-To: <AANLkTimt934X7G8DSnqVQ03fbggD9-SHWW3-QPQp+yAq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: archit taneja <archit@ti.com>, Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

Thanks for your reply.

2011/2/19 Felipe Contreras <felipe.contreras@gmail.com>:
> On Sat, Feb 19, 2011 at 9:41 AM, Ming Lei <tom.leiming@gmail.com> wro=
te:
>>> It looks like an issue with what you have selected in the menuconfi=
g. Could
>>> you ensure you have DPI and VENC selected, and in displays Generic =
DPI panel
>>> and sharp-ls panel selected.
>>
>> Even after enabling all this options above, there is still the failu=
re
>> message on my pandaboard(2.6.38-rc5-next-20110217):
>>
>> [ =A0 =A00.000000] Kernel command line: console=3DttyO2,115200n8 vra=
m=3D16M
>> root=3D/dev/mmcblk0p2 rw earlyprintk rootfstype=3Dext3 rootwait
>> ......
>> [ =A0 =A02.847625] omapfb omapfb: no displays
>> [ =A0 =A02.851562] omapfb omapfb: failed to setup omapfb
>> [ =A0 =A02.856719] omapfb: probe of omapfb failed with error -22
>
> Note that the command line parameters are ignored since 2.6.36, you

I don't think the 'vram=3D16M' is ignored by kernel, which can be found=
 below:

[    0.000000] Memory: 1008MB =3D 1008MB total
[    0.000000] Memory: 1006160k/1006160k available, 42416k reserved,
245760K highmem

The 16M bytes is reserved by the para vram=3D16M'.

> need to specify CONFIG_OMAP2_VRAM_SIZE.

Same with before even CONFIG_OMAP2_VRAM_SIZE is configured
as 16M Bytes.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
