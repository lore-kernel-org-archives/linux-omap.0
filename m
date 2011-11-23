From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 40/65] OMAPDSS: APPLY: add mutex
Date: Wed, 23 Nov 2011 12:17:00 +0200
Message-ID: <1322043420.28917.39.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-41-git-send-email-tomi.valkeinen@ti.com>
	 <4ECCC158.80902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-p9YWrJoAHLqXlN4AIukh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:52315 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750711Ab1KWKRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:17:10 -0500
In-Reply-To: <4ECCC158.80902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-p9YWrJoAHLqXlN4AIukh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 15:18 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> > The functions in apply.c, called mostly via function pointers in overla=
y
> > and overlay_manager structs, will be divided into two groups. The other
> > group will not sleep and can be called from interrupts, and the other
> > group may sleep.
>=20
> Small sentence issue above, both groups are called the 'other group'.

Thanks, fixed.

> >
> > The idea is that the non-sleeping functions may only change certain
> > settings in overlays and managers, and those settings may only affect
> > the particular overlay/manager. For example, set the base address of th=
e
> > overlay.
> >
> > The blocking functions, however, will handle more complex configuration
> > changes. For example, when an overlay is enabled and fifo-merge feature
> > is used, we need to do the enable in multiple steps, waiting in between=
,
> > and the change affects multiple overlays and managers.
> >
> > This patch adds the mutex which is used in the blocking functions to
> > have exclusive access to overlays and overlay managers.
>=20
> Previously, when we changed the links between 'overlay->managers' and=20
> 'manager->devices', it wasn't protected by a lock. Why is it needed now?

Previously many places were missing a lock =3D).

> As an example, suppose we are changing a manager's device to some other=
=20
> display. Is this lock preventing someone else to get the older=20
> 'mgr->device' rather than the new one?

Hmm. We need some lock there, that's for sure, as set/unset manager are
changing the manager's list of overlays. However, it is also protected
by the spinlock, so in that sense mutex is not necessary.

I have to say I'm not sure if mutex is needed at this point. However,
consider the end result when fifo-merge is used:

dss_ovl_enable() will take the mutex, then it does the configuration in
multiple steps, doing multiple spin_lock & spin_unlocks, waiting in
between.

If we had only a spinlock in set/unset_manager, the manager could be
changed while dss_ovl_enable is doing the process of enabling the
overlay.

So I may have added mutexes or spinlocks a bit early in the series to
some places, but I don't see any harm in that. It'd be rather difficult
to try to find the exact spots where a lock becomes a requirement.

 Tomi


--=-p9YWrJoAHLqXlN4AIukh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzMgcAAoJEPo9qoy8lh71R+0P/3rytH7j0Tk7O/Z/g+nUpEBA
ANTqBb65H2czgBRaF+2QOL72UwVhJkmB0ZM5YD9f6DyHCswvh3crHXx35WYsbggs
sscskPvjAgwMeFc2qF6IDP5wJJt2rKN/5g56qQ+3vR8B4DbbAcFj4Oqee1WqbQqa
2jb9hLwoJ5nvYlz5LnZQyD4ks3sKMhj4pfgM+S9daExfLr3rkdPjJ8ohOLkza6U7
T3v0q+xlFJzugkzyiOhu/orsW5GxFDblYkQI3VUdFkrKKiXAlkPFC6y5R4h9l4OE
+bu110mx98FRjQPKBclhy2pV6wIlTsONn0JUeXqzmmqVU/ejYCvLu5TAHlNYKC1M
1W/uQZU1sv6W/wGX900jzI2KMZbf+SwebsA5L0rqjcctEWtOZ4gTdxM/LvpJwchg
QpAHmcI49mwZ4qH9TYUzKMRMpQtavTb8zGM4cow6y892qeBmUSDkaeTb/PJLSzD3
P2FOFBQqppDrRyEfilCXULQK3bcAH6Fhm9uZa4DUxbcgTtGRyfRYChXC+hKSPPTy
X91aUxiJnvomKPpaP2cd4hdmEUw2vQ5VS0/flytztbYl9ZwOH75XOiQYgSmlvGUT
Tpdp+b4UfP5b5VNxVBNZojSivLPwMR9ePvfyxm6scdagL+KWCrDrf6kqmpm9gmEJ
3ZV9N84Dh8zhBNMjmRPt
=4SW+
-----END PGP SIGNATURE-----

--=-p9YWrJoAHLqXlN4AIukh--

