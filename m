From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: OMAP3 EHCI USB HS mode performance issue
Date: Wed, 4 Feb 2009 11:13:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA81AA16@dbde02.ent.ti.com>
References: <701709.89130.qm@web112201.mail.gq1.yahoo.com>
 <19F8576C6E063C45BE387C64729E739403FA81A9C6@dbde02.ent.ti.com>
 <683751.37901.qm@web112217.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59310 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbZBDFnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 00:43:46 -0500
In-Reply-To: <683751.37901.qm@web112217.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ganeshan N <nganeshan1@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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
=20
>=20
> Thanks & Regards
> Ganeshan
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
