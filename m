From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the default behavior
 of LDO's
Date: Wed, 22 Jun 2011 20:36:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6268E5@dbde02.ent.ti.com>
References: <1308702281-12665-1-git-send-email-girishsg@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D626714@dbde02.ent.ti.com>
 <BANLkTikApwh-YF-1FQC707skvk080Nyxaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757991Ab1FVPGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 11:06:30 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MF6RaL012390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 10:06:29 -0500
In-Reply-To: <BANLkTikApwh-YF-1FQC707skvk080Nyxaw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Ghongdemath, Girish=20
> Sent: Wednesday, June 22, 2011 7:23 PM
> To: Premi, Sanjeev
> Cc: linux-omap
> Subject: Re: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the=20
> default behavior of LDO's
>=20
> On Wed, Jun 22, 2011 at 6:18 AM, Premi, Sanjeev <premi@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >> Ghongdemath, Girish
> >> Sent: Wednesday, June 22, 2011 5:55 AM
> >> To: linux-omap
> >> Cc: Ghongdemath, Girish
> >> Subject: [PATCH 1/2] OMAP4 :TWL6030: Regulator set the
> >> default behavior of LDO's
> >>
> >> TWL6030 below table shows the default state each LDO's can
> >> be put into.
> >>
> >
> > [sp] Can you point to the relevant document instead of drawing
> > =A0 =A0 the full table here?
>=20
> This info not available as is in public TRM's or any doc.=20
> Relevant schematics
> will help..

[sp] In this case, it is possibly more useful to add the information
     as comment - next to the code where specific LDOs are being marked
     always_on.

     It should address another concern from Balaji on sync between
     code and description.

~sanjeev

>=20
> Regards,
>=20
> Girish
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
