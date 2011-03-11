From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Fri, 11 Mar 2011 14:03:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C192D49@dbde02.ent.ti.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com>
 <4D67E0C0.4080805@ti.com>
 <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54506 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab1CKIeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 03:34:02 -0500
In-Reply-To: <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, March 10, 2011 8:08 AM
> To: Cousson, Benoit
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
>=20
>=20
> Hi,
>=20
> I just queued a patch to fix the SmartReflex problem.  It's the part =
that
> fixes the incorrect data:
>=20
>     http://marc.info/?l=3Dlinux-omap&m=3D129972435510631&w=3D2
>=20
> Beno=EEt, if you are happy with it, care to send an Acked-by:?  Also,=
 I
> guess we should revisit the other part of your patch at some point.

[sp] Thanks. I will be able to try this fix next week.

>=20
> Sanjeev, now AM3517 shouldn't need that nasty hack any more.  I hope =
you
> won't need a separate array for AM35xx hwmods, either.  I guess we ne=
ed to
> clean up the OMAP3 id.c revision bits.

 [sp] Let me know what problem you see. I can take a look while trying =
this
     Patch

~sanjeev

>=20
>=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
