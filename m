From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: OMAP3 display  patches
Date: Tue, 29 Jun 2010 15:39:02 +0300
Message-ID: <20100629123902.GZ9381@nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDB3A55F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39550 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0F2MjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 08:39:20 -0400
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDB3A55F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "Mittal, Mukund" <mmittal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Tue, Jun 29, 2010 at 02:20:36PM +0200, ext Nagarajan, Rajkumar wrote=
:
>=20
> Tomi,
>=20
> Would you please check if there are no further comments and can you p=
lease pull the following patches in?
>
> https://patchwork.kernel.org/patch/106498/

This one seems to have two separate changes in the same patch. Needs
splitting.

> https://patchwork.kernel.org/patch/106670/

I think this one needs a (cpu_is_omap3630() && id =3D=3D OMAP_DSS_VIDEO=
2)
check in store() so that the user gets a proper error if he tries to
write an unsupported value.

> https://patchwork.kernel.org/patch/107547/

You never addressed any of my comments so asking Tomi to pull this
seems rather premature.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
