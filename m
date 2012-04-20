From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Fri, 20 Apr 2012 14:34:59 +0300
Message-ID: <1334921699.2058.31.camel@deskari>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
	 <1334911137.2058.8.camel@deskari>
	 <CANOLnOP9ciznRxddjFSLuWALme57Woq0p6zP93U3tOFvd9em5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sY7rKz83zhdMxDlDAIh0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59262 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755553Ab2DTLfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:35:06 -0400
Received: by lagy4 with SMTP id y4so9673973lag.22
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 04:35:02 -0700 (PDT)
In-Reply-To: <CANOLnOP9ciznRxddjFSLuWALme57Woq0p6zP93U3tOFvd9em5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-sY7rKz83zhdMxDlDAIh0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-04-20 at 13:49 +0300, Grazvydas Ignotas wrote:
> On Fri, Apr 20, 2012 at 11:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> > On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
> >> VENC type (composite/svideo) doesn't have to be fixed by board wiring,
> >> it is possible to provide both connectors, which is what pandora does.
> >> Having to recompile the kernel for users who have TV connector types
> >> that's don't match default board setting is very inconvenient, especia=
lly
> >
> > You don't have to recompile the kernel, you could just set the venc typ=
e
> > in the board file depending on a boot parameter.
> >
> >> for users of a consumer device, so add support for switching VENC type
> >> at runtime over a new sysfs file venc_type.
> >
> > I really dislike adding new custom sysfs entries for omapdss, and I'd
> > like to avoid them if at all possible.
>=20
> Well some panels already have custom attributes, and venc could be
> considered as special panel type, so if it's allowed for panels, why
> not allow it for venc?

It's not really about "allowing". It's just that each new sysfs file is
a new non-standard custom API to userspace which we need to support
until the end of time. Adding new sysfs files carelessly will cause a
nightmare for me in the future, so by default I'm against new sysfs
files =3D).

> > Do you need to change the venc
> > type during runtime, or is it enough that it can be set during boot?
>=20
> We need this on runtime, otherwise it causes several issues:
> - reboot is required to change the setting, although there is no
> technical reason to really require it. This punishes users who want to
> try both settings or have both TV types (with a portable device this
> may sometimes happen).
> - having to provide a way for users to change this in kernel boot
> arguments. Note that many pandora users don't know how to handle boot
> scripts, so a bootloader menu of some sort would be needed or ability
> to edit u-boot environment from Linux, both of which would be
> needlessly complicated solutions.

Ok. Sounds like we need to have dynamic configuration. I'll review the
patch.

 Tomi


--=-sY7rKz83zhdMxDlDAIh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkUnjAAoJEPo9qoy8lh71NFAQAIDk8BX4GN1mm9V2gVDn33Ap
C42PR6GfXMrw7/+DTUK18kHKIZms37nIe75SlTkmtsKcrr+Qe09I2ZsLJf3tHjRb
xndoEGRdLv0uI6dQ/iFOJz7HUEHIpDXW8aGrUDlKTXXMmNfh0DgAJIA+ESdAVi5o
rCvd/ts1ci19ZVYbHmlRpjHXxtLEqaxa3VOvJnwtEusrFdssfgrv0UBOXSXq1K89
r/IzSp5hKzz50CXvDyNTUzdFlsWVvMgp+GW8ihb9pJLkuE+rtmFiGhZhHhFi09X0
xgZGkvidn6DOrRi9Voh0O77cYwOWY2/2uMk1HKxXdQX9+JiEfxki62udLIc9yd5L
Vs1u4ffg8BzXWxsc8rkHrwzavJqewXRAmakdcneCkStfLMP7pd1ujfA8N42KIGHg
vk9mxzL9686/2Lu5FYFHX5ggInSMqaL5A4QUqNpx5ackuK0lUDSa4Kf34jF4JuyZ
DWNXU4wDe/G3LP9G9tVZSbTnBuohRDuiUqLyNV/Go7kqqg1SNLwqdl3mnL0HeJO4
4aGfvK27uLY0p1f8LL20ljdc6UI+t7UxuOHROgrSEV7/kr7zzNh4OzJhtrnm808y
I+JRuZUW5/JCTv4wFf9SOgTk7XGm+aOdhqESgoWlfVPKIwV89yj8AZSFjfEqwtlQ
9AGpXv0sWm1yRRb7DexX
=6Lkb
-----END PGP SIGNATURE-----

--=-sY7rKz83zhdMxDlDAIh0--

