From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 10/10] mtd: nand: omap2: use gpmc provided irqs
Date: Sat, 25 Aug 2012 14:48:46 +0300
Message-ID: <1345895326.1815.4.camel@kyv>
References: <cover.1344609341.git.afzal@ti.com>
	 <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/uxSJ0+p92TXOJM09xU6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59637 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2HYLsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Aug 2012 07:48:51 -0400
Received: by bkwj10 with SMTP id j10so825458bkw.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Aug 2012 04:48:49 -0700 (PDT)
In-Reply-To: <c5a608a70a875191e1323958c74fb2ac8dfa34b3.1344609341.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com


--=-/uxSJ0+p92TXOJM09xU6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 15:14 +0530, Afzal Mohammed wrote:
> GPMC platform initialization provides it's clients
> with interrupts that can be used through struct
> resource. Make use of it for irq mode functionality.
>=20
> Also now write protect disable is done by GPMC,
> hence remove it.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-/uxSJ0+p92TXOJM09xU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQOLueAAoJECmIfjd9wqK0YwQP/232SMimRqDgehn69+IwaLsI
AI1Yaqe2SGUNe69iMdcFBLckCB7nHpstSNWYka6QRtpmsfBD3rcvXEXq04cneSz2
t8PZXHnq0aeuVakVt/t0GIiSfKgngIagfBBCRhKYtyh1P59RLKB+UfQfCA7YeVE5
57MDx1RAK9bz228uaIHEukvtaidvxgA3ZeMMrmm4u8BkgElCAkIvgPuIWoFfu9Qe
8T3iuF2jJff6QEisSpFNjLmKX6UdjQYY0njiHhPimSa8moWZrsCTuZDKPqCC7ZMx
2XFor6SGn7d716/dZYnhC4KDI9FHVpD5PihWoh3hkaXRLAM0SLUCiI6jE6r3JlfE
CwnZ0tYwCc9aXOE8GG04fYnaySt9JbfykT/yMSag2q3gIxzkJiiEM239CpqH+wpF
2/A9iTjm1Vwlxpr3wyw045XoQ8J19PeXPew/jLmQzJp0zBn4O9N0X5yMyscmw64m
AhfutzvXjE3wntYIxNQZs0PYK97XyGZsCGfKimkjlo79fX+rWgvlM1fN/yrgdvG9
zqmZeHLM0Q4fOl4dzwprPRXqXAEFJEKqbbjLHowzLyXJwlkyhNyu/dPLvEF0fdu6
eyrgmT5RDlixJHV0sD7c68bpjp6VrxPrAYBdSYEuMvQhScfx6YzHqpQqITw9IZ15
H8cts8G4zLW9YqrGd0r1
=/nwL
-----END PGP SIGNATURE-----

--=-/uxSJ0+p92TXOJM09xU6--

