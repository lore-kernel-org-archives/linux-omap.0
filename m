From: Ganeshan N <nganeshan1@yahoo.com>
Subject: Re: OMAP3 EHCI USB HS mode performance issue
Date: Fri, 6 Feb 2009 00:52:18 -0800 (PST)
Message-ID: <643558.86208.qm@web112207.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n75.bullet.mail.sp1.yahoo.com ([98.136.44.51]:45093 "HELO
	n75.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752462AbZBFIwT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Feb 2009 03:52:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ajay,

I have tested with USB hard disk and getting ~264 Mbps.=A0 Is there any=
 option/method to increase the performance?

with regards
Ganeshan=20



----- Original Message ----
=46rom: Ganeshan N <nganeshan1@yahoo.com>
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>; "linux-omap@vger.kernel.or=
g" <linux-omap@vger.kernel.org>
Sent: Wednesday, February 4, 2009 11:34:14 AM
Subject: Re: OMAP3 EHCI USB HS mode performance issue

Hi Ajay,
Thanks a lot for your valuable inputs.=A0=A0 I will keep you posted wit=
h my observations on this after testing with USB hard disk.

Thanks & Regards
Ganeshan



----- Original Message ----
=46rom: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
To: Ganeshan N <nganeshan1@yahoo.com>; "linux-omap@vger.kernel.org" <li=
nux-omap@vger.kernel.org>
Sent: Wednesday, February 4, 2009 11:13:36 AM
Subject: RE: OMAP3 EHCI USB HS mode performance issue

> I am transfering 100MB file to pen drive.=A0 I have tried with pen dr=
ive with different manufacturer
> (Tanscend, SanDisk, Kingston).=A0 I am using OMAP35x EVM.

We have observed lower throughput with pen drive so it's better if you =
take the performance numbers
from any USB hard disk.=20

I think you are using OMAP35x EVM with Mistral daughter card. With Mist=
ral DC, I am getting a read/write throughput of ~160Mbps on EHCI with U=
SB HDD and CPUIDLE=3Doff.

Regards,
Ajay

>=20
> Thanks & Regards
> Ganeshan
>=20
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
