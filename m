From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] [OMAPZOOM] [UPDATE] DSPBRIDGE: Memory lock for DMM.
Date: Tue, 7 Apr 2009 15:59:44 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23781F8A@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287FB05ED@dlee06.ent.ti.com>
	 <269694c00904071319i1ba7f00cie08d9ecf9ffe2ce2@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23781F34@dlee03.ent.ti.com>
 <269694c00904071349w141e1b7cjae10e70f8ac994af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36712 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759281AbZDGU7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 16:59:53 -0400
In-Reply-To: <269694c00904071349w141e1b7cjae10e70f8ac994af@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <2ameya@gmail.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya,

>=20
> get_page() function has following check inside it:
> VM_BUG_ON(atomic_read(&page->_count) =3D=3D 0);
>=20
> Why we need to repeat it again?
> I guess we can completely remove following check which is in my
> opinion completely
> redundant:

-- This check in get_page is conditional check and this is to catch the=
 cases when page count starts with "0", which I think is still a possib=
le condition if the user space buffer was never touched. So I am not su=
re if we can rely on this.

>=20
> if (page_count(pg) < 1) {
> }

-- This is to just to extend the check for the bad Page count.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Ameya Palande [mailto:2ameya@gmail.com]
> Sent: Tuesday, April 07, 2009 3:49 PM
> To: Kanigeri, Hari
> Cc: Guzman Lugo, Fernando; Pandita, Vikram; linux-omap@vger.kernel.or=
g
> Subject: Re: [PATCH 1/4] [OMAPZOOM] [UPDATE] DSPBRIDGE: Memory lock f=
or
> DMM.
>=20
> Hi Hari,
>=20
> On Tue, Apr 7, 2009 at 11:27 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Ameya,
> >
> >> If this is the case then what is the point of having following cod=
e?
> >> if (page_count(pg) < 1) =A0<-- This will always evaluate to FALSE.
> >
> > -- As you mentioned this case shouldn't be hit. This check is to on=
ly to
> ensure that the >translations from user space VA to Physical address =
is
> taking place correctly and flag the >user if something went bad.
>=20
> get_page() function has following check inside it:
> VM_BUG_ON(atomic_read(&page->_count) =3D=3D 0);
>=20
> Why we need to repeat it again?
> I guess we can completely remove following check which is in my
> opinion completely
> redundant:
>=20
> if (page_count(pg) < 1) {
> }
>=20
> Cheers,
> Ameya.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
