From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Fri, 23 Nov 2012 10:46:34 +0200
Message-ID: <50AF37EA.3080400@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67B4C84864DC332EEE262FE1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab2KWIqm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Nov 2012 03:46:42 -0500
In-Reply-To: <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig67B4C84864DC332EEE262FE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-23 08:14, Steve Sakoman wrote:
> On Thu, Nov 22, 2012 at 12:47 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>=20
>>> I'll add the printk's to omapfb_setup_plane() that were requested by
>>> Tomi and report back.
>=20
> Today was a holiday, so family obligations didn't allow much time to
> look at this.
>=20
> I did however do a quick build with some printk's in
> omapfb_setup_plane() so I could narrow down where to start looking.
>=20
> I discovered that the error (omapdss OVERLAY error: check_overlay:
> paddr cannot be 0) is happening as a result of the
> ovl->set_overlay_info() call in the else clause of the code below:
>=20
>     if (pi->enabled) {
>         r =3D omapfb_setup_overlay(fbi, ovl, pi->pos_x, pi->pos_y,
>             pi->out_width, pi->out_height);
>         if (r) {
>             printk("omapfb_setup_plane: pi->enabled &
> omapfb_setup_overlay()\n");
>             goto undo;
>         }
>     } else {
>         struct omap_overlay_info info;
>=20
>         ovl->get_overlay_info(ovl, &info);
>=20
>         info.pos_x =3D pi->pos_x;
>         info.pos_y =3D pi->pos_y;
>         info.out_width =3D pi->out_width;
>         info.out_height =3D pi->out_height;
>=20
>         r =3D ovl->set_overlay_info(ovl, &info);
>         if (r) {
>             printk("omapfb_setup_plane: !pi->enabled &
> ovl->set_overlay_info failed\n");
>             goto undo;
>         }
>     }

Ok, so hmm... So the overlay is disabled, and the paddr is zero. Can you
put a printk at dss/apply.c:dss_olv_set_info, and print ovl->id and
info->paddr? And perhaps also to omapfb-main.c:omapfb_setup_overlay, at
the point where it sets info.paddr, as I think that's the only place
where omapfb sets paddr.

I don't know what's going on there, why the paddr is suddenly zero.
Looking at the log from Enric, SETUP_PLANE works fine just fine, and
then, for no reason, next SETUP_PLANE fails, and the log doesn't show
anything much happening between.

However, I think omapdss may have been more permissive in the past,
allowing paddr 0 if the overlay is disabled. I could add that back, but
I'd rather first understand what's happening here.

> I'll look at this more over as I get time over the coming days.
>=20
>> How can I reproduce this? Is there a downloadable rootfs somewhere tha=
t
>> I could try?
>=20
> The only downloadable rootfs I have is 3.5 based.  I'll try to get a
> 3.6 image posted in the next couple of days.
>=20
>> Could you also copy full kernel boot log to pastebin or such?
>=20
> OK, will do that with my next build.  I'll assume you want dss
> debugging enabled for that.

That's probably not needed. I mostly wanted to know if there's some dss
error/warning seen on the boot. But probably not if the problem happens
in the code above.

 Tomi



--------------enig67B4C84864DC332EEE262FE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrzfuAAoJEPo9qoy8lh71nTEP/0PQ84eHbIrnpX3AfRrfsqvU
3N/jCM/57c3oGY93N69C+vewDNv4V09o6Hei19w2K5YSUxg2eb/nQAR0YB7NILUJ
U1vedhzJ1761SQGQX64uneqTEZZOXD628rP+h9Ud0jQ3WLhAeDWmAQmE7ax5UEIK
bk1DtBViOg1UCayPJz/O3nCXRNgueB7UdTHb3jr4d+Ijmuo/Du9/B8hs07x5nGmU
fUQAHoDrKtAVP2/6aRCHha2cIwGmhJb/KLw177R1Ou/X2SPU7punfqZTIWXd4rXN
wxtjZfv0rU8OdgmNQw/XQ9TG/I5Uqv2tBNdvD5iK0wcy3vCG2XWvaIT440ssymO9
bu7CzsRwkUuBDS6S+ssOISJF1S3+HIaZiPTv+7C+c+JFy3LjjeL9INMbMLoP+RTK
ic4/OX7WfQCnHoXRedNSul2EBRU7gVLvAqSUzh7JmFPpa0Td2E81p1hECvrc/Ub/
Zru1V28XByBt6kscg2CIjLAIj2ASMSfUwb1ddlO0h9vnzC2N7fGkUHcyxJ04JDCl
4F3VHXPFY4bUu9mnL6EhaWn6U3rpNi5JxKQWTR9FEXhUu617quO0GAqmQQ7lJ9uq
ZOS9qiC4O5LHssp4FvQjmjbuYDohKkSvcHBK3olHa4EPZUS4XlaKWQeUwI+FUGT+
cq2COjqh6vaeePbOY91I
=n3k8
-----END PGP SIGNATURE-----

--------------enig67B4C84864DC332EEE262FE1--
