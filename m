From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: OMAP3 EHCI USB HS mode performance issue
Date: Wed, 4 Feb 2009 10:02:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81A9C6@dbde02.ent.ti.com>
References: <701709.89130.qm@web112201.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbZBDEc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 23:32:26 -0500
In-Reply-To: <701709.89130.qm@web112201.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ganeshan N <nganeshan1@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
