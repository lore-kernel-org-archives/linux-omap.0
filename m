From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Mon, 16 Jan 2012 13:11:48 +0200
Message-ID: <1326712308.1875.18.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <1326386551.1896.41.camel@deskari> <87obu8sfx3.fsf@ti.com>
	 <1326432554.1700.6.camel@lappyti>  <87zkdrpfha.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/YLuim4ztMOvdhcpS89O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:39240 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753228Ab2APLLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 06:11:55 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id i14so1446633lam.6
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 03:11:51 -0800 (PST)
In-Reply-To: <87zkdrpfha.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-/YLuim4ztMOvdhcpS89O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-13 at 11:30 -0800, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> > pm_runtime_put() is called inside omapdss driver's .suspend callback. S=
o
> > I guess that means the system suspend has started. However, the logs
> > show that the runtime_suspend callback _is_ being called before the
> > system suspend is finished, so the workqueue can't be frozen...
>=20
> ...or there are other ways that the runtime_suspend callback is called.
>=20
> In order to ensure that devices are properly idled for system-wide
> suspend, The OMAP PM domain layer will call the drivers
> ->runtime_suspend callback during "late" suspend (using the PM domain's
> _noirq callbacks.)
>=20
> This is there so that even when runtime PM has been disabled (via
> userspace, or pm_runtime_forbid() calls) the driver can still be
> properly idled before suspend.
>=20
> In your case, I suspect you're seeing the driver's ->runtime_suspend
> callback called during late suspend, not by the PM workqueue.

Ok, that explains the invocation of the callbacks.

> I don't understand DSS enough to make sense of the logs you sent, so not
> sure how to be of more help.

Well, I think I can summarize the situation:

Normally, when the user wants to turn a display off, the panel drivers
call DSS functions to disable the corresponding output, leading to
pm_runtime_put() calls.

In system suspend case, the suspend callback initiates the turning off
of the displays, which again leads to pm_runtime_put() calls.

Now, you already said using pm_runtime_put_sync version is the correct
way when suspending. But to use that I need to either always use
pm_runtime_put_sync, or add an extra boolean which marks that we're
suspending, and pass that around, or make it a DSS global variable.

Both of those options sound a bit ugly to me. So my two questions are,

1) Is there something funny with the DSS architecture to have a problem
like this? I tried to grep around, but I didn't see any other driver
doing something like that (but I could've missed it).

2) why can't the PM framework handle this, by directing the
pm_runtime_put calls to the _sync version when suspending. Somehow it
feels strange to me that the driver needs to care about that.

 Tomi


--=-/YLuim4ztMOvdhcpS89O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFAX0AAoJEPo9qoy8lh71FJ0P/1JWTDgkjcmDnmSkt6A9xzDo
N/Xo290uX4/u/bPP8onp0Yn0XsCzr3IN/w26LNSvcx9QzyPDoBn+hJcqzhEDSG+h
bNPB4uxJcVix5tiZMHNp+QJuoFNLW2Kzkz5N3XbdzuamGwy7DZxpbp8ajlxhMa0d
s3GBPck7RCHrdgLNqLpFwFnyZuoRtebgt/w6kB1E8YPM6JGUIGPthebquzJfFdvM
2HS1Lc6G8mXTxuOghdZ0LTaVrjYvdbzDejrno269n+T0JSV521NgfDbnCy1BtoJD
FHWRehaYET3tgJer1XhoPyGC6gTiLtdFLy1WaT0uFvGkKWmM2fr14KD11NC/nyXJ
z/DmOIjbcxLwAlk3J6Ib3KeeE5yZIh1kOU/OGTIIu4ZNOs3e+P9cBpEpK0GDg5b3
/f5k3ru9TNjJNnbYxSnNi1jBVx2L5h44dQjYX7sF8PT7/hRe9kWYP41GWuL1381I
xkJYNKnbZVqgRs6oHhWh75q0F52hWcYqt9i7fiNomIvkuhpzoqpoMHpI4xL3pvAv
Qe5gZ5Lnnt3zC8vphmD0zl059BewECA3m6kb11uHp+s1HqSzlN05L2WORRE7odO7
JNIaejeuMQhFepW38Us4XYgN2PbK/OA6xQlkRBs67S9oEF1/UzUnu5p1m2SwQ6Bc
cM+AIgURRWdR4jjuAGWm
=9UWW
-----END PGP SIGNATURE-----

--=-/YLuim4ztMOvdhcpS89O--

