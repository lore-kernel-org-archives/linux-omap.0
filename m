From: Ganeshan N <nganeshan1@yahoo.com>
Subject: Re: OMAP3 EHCI USB HS mode performance issue
Date: Tue, 3 Feb 2009 21:11:33 -0800 (PST)
Message-ID: <683751.37901.qm@web112217.mail.gq1.yahoo.com>
References: <701709.89130.qm@web112201.mail.gq1.yahoo.com> <19F8576C6E063C45BE387C64729E739403FA81A9C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n65.bullet.mail.sp1.yahoo.com ([98.136.44.190]:39792 "HELO
	n65.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750987AbZBDFLe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Feb 2009 00:11:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ajay,
I am transfering 100MB file to pen drive.=A0 I have tried with pen driv=
e with different manufacturer (Tanscend, SanDisk, Kingston).=A0 I am us=
ing OMAP35x EVM.=20

Thanks & Regards
Ganeshan

----- Original Message ----
=46rom: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
To: Ganeshan N <nganeshan1@yahoo.com>; "linux-omap@vger.kernel.org" <li=
nux-omap@vger.kernel.org>
Sent: Wednesday, February 4, 2009 10:02:15 AM
Subject: RE: OMAP3 EHCI USB HS mode performance issue

> I am using OMAP3 based board,=A0 running git based kernel 2..6.28, an=
d=A0enabled "EHCI HCD (USB 2.0)
> support",=A0PHY mode.
>=20
> EHCI HS performance is measured using Catalyst, USB analyzer.=A0

Are you doing bulk transfer to a pen drive to measure performance? If s=
o then try using any USB hard disk.=20
Which OMAP3 board are you using?

Ajay

>=A0I supposed to get 480
> Mbits/s(theoritically), but getting around 80 Mbits/s for write and a=
round 128 Mbits/s for read.
> Please suggest me some method/option to increase HS USB EHCI performa=
nce.
>=20
> Thanks in advance
> Regards
> Ganeshan
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html



     =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
