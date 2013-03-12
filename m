From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 12 Mar 2013 16:53:08 +0200
Message-ID: <513F4154.5040904@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1363093583-28285-1-git-send-email-archit@ti.com> <513F3658.3000300@ti.com> <513F3DE5.2090903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE961935DA8BF2729C06F3A32"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36964 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086Ab3CLOxM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 10:53:12 -0400
In-Reply-To: <513F3DE5.2090903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

--------------enigE961935DA8BF2729C06F3A32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-12 16:38, Archit Taneja wrote:

>> memcmp on two structs is often not a good idea. There could be padding=

>> bytes there, with uninitialized data. I'm not sure if that's the case
>> here, though, but it could well change any time (perhaps even dependin=
g
>> on compiler version).
>=20
> I saw usage of memcmp on structs in the kernel, but then most of them
> were in drivers and not core, and could be mistakes :)
>=20
> adding '__attribute__((packed))' to omap_video_timings might be helpful=

> I suppose. But I don't know if it's safe to do a memcmp even with a
> packed struct.

I think it's safe to use memcmp if you know that both structs have been
initialized to zero with memset.

>> I'm still pondering whether it'd just be simpler to require all the
>> dssdrv ops to be filled, probably using a helper macro in the panel
>> drivers... Did you consider that approach? I'm not saying to go for it=
,
>> I'm saying I can't make my mind which would be better =3D).
>=20
> I didn't consider it mainly because I thought we were going to get rid
> of our private omapdss panel drivers with CDF panels, and efforts in
> fixing it wouldn't be much useful. But if there isn't any other good
> alternative, then I can try to see what macros look like.

Well, even if I was slightly optimistic earlier, I now have a feeling
CDF may take a while. I think we should just go for omapdss dev model
change first.

One thing to note about the ops is that NULL is currently used to convey
information, something like "this ops is not possible or valid". So
adding all the ops may not quite work. For example, adding update op for
auto-update panels could tell that the panel supports manual update.
(Well, for that particular case we have a flag, but you get the idea).

But if we can add only some of the ops to the drivers, and there is no
information lost when we won't have NULLs, I guess that could be the
simplest option. Then we don't need to add extra code in each place we
use the ops.

> Of course, simpler options for this patch would be to do a manual
> compare of the fields instead of a memcmp, or adding default ops in
> omap_dss_register_driver.

Adding default ops in omap_dss_register_driver() is not good. It
prevents us from having the ops as const in the future, and is also not
possible when we either move to CDF or change the omapdss dev model.

So I think either we need to handle the NULLs as you do in this patch,
or add the ops to the panels. But the ops could still be the default
versions offered by the omapdss.

> One thing about common panel driver functions in general is that they
> won't use the panel driver's locking. So if a panel driver doesn't
> create a get_timings() op assuming that omapdss will make a default fun=
c
> for it, we would miss out on the panel lock. I don't know if that's
> really bad, and doing a memcmp or anything else in omapdrm also doesn't=

> help with this case.

That's true. The locking is a bit of a mess (read: broken =3D) anyway
currently.

 Tomi



--------------enigE961935DA8BF2729C06F3A32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRP0FUAAoJEPo9qoy8lh71rjwP/3cLi6ElL+NzqJM83zsqYOlH
P5crRWm3Qt3j+dylB6OAdmbKQEsbEs6VyMtaPqUhNVBnx7n9pHWubc+GX5asWr9Y
O9MK8uAL8J9LX+WbzI1BOmMhSx/cTjFpDgvcBHB8/uob8i22VlWyzOquYQf18v65
wjrtnOpJmFJY0F6Vwpzlrr6pllVLT6sOpXAtkXcB8+mqlry3LdJtzks1Eyu2KCh1
XxqRlfV3EjgEA+D/J1bRmVQbeHoRDEr/b79SiASpNLSnkS57GPEYth3AgDreQop3
bMYnmo/iweIY3g0ztQ8asltbaQkKVT+TG8fwWwK3yrZqZ36U7E6M2IUfJRGEyPjn
0Sy0KgvspGamGL7FHp73w5OUruvdmChl96Vpk1dULT36Ul/r+SC1ezQxk5UdFJxp
Xy6y9Z0jPMK2c/rJtGeNZVIyW9z7NBBvIjS4DCga3rOjn0OnFdqLxgmWvk4gnrUt
fqT+bLxOm1aC0xg5Zi1Y4WjzK1AYFiFsIS5Fj3/lqAQh5LrIONLMTf1U1iyC4jlB
a4SV9JgfO2td0iafEeuExwqVj2ABwAEgPtTP2hq6fEtEqZw1oY7n6OFh13vrXLXl
fUbtMerhj0CD4T6FC+UBgxgZtuQD9yFij/D2k9V/G5dD3GmroQKOz5QVFPxWGgTm
afoVPMEfhygqnIT8OHnQ
=L0iJ
-----END PGP SIGNATURE-----

--------------enigE961935DA8BF2729C06F3A32--
