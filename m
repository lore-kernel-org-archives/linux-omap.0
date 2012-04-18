From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a
 manager_info parameter
Date: Wed, 18 Apr 2012 17:58:25 +0300
Message-ID: <1334761105.2027.67.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1334561027-28569-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pKIwAShTwj8RWqLttp6T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37377 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752748Ab2DRO6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 10:58:31 -0400
Received: by lbjn8 with SMTP id n8so2474701lbj.20
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 07:58:28 -0700 (PDT)
In-Reply-To: <1334561027-28569-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-pKIwAShTwj8RWqLttp6T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
> DISPC manager size and DISPC manager blanking parameters(for LCD managers=
)
> follow the shadow register programming model. Currently, they are program=
med
> directly by the interface drivers.
>=20
> Make timings(omap_video_timing struct) an overlay_manager_info member, th=
ey are
> now programmed via the apply mechanism used for programming shadow regist=
ers.
>=20
> The interface driver now call the function dss_mgr_set_timings() which ap=
plies
> the new timing parameters, rather than directly writing to DISPC register=
s.

I don't think that works correctly. The omap_overlay_manager_info is
supposed to be set with set_manager_info() by the user of omapdss, to
configure the manager's features. The timings are not supposed to be set
via that mechanism, but with dssdev->set_timings().

This is similar to the info and extra_info for overlay. info has stuff
that omapdss doesn't change, it just uses what the user gives.
extra_info, on the other hand, has omapdss private stuff that the user
does not see. Timings are clearly private stuff in this sense, because
they are set via dssdev->set_timings().=20

One reason for this is the programming model we use. If the user of
omapdss does get_info() for two overlays, changes the infos, and then
calls set_info() for both overlays and finally apply() for the manager,
we don't do any locking there because omapdss presumes the info is
handled by one user. If, say, the dpi.c would change the info and call
apply at the same time, the configuration could go badly wrong.

So I think what should be done is to add similar "extra" flags and code
to mgr_priv_data that we have for ovl_priv_data, and add
omap_video_timings to mgr_priv_data (the same way as we have, say,
fifo_low for ovl_priv_data).

And then add similar function to dss_ovl_write_regs_extra() for manager,
and a function like dss_apply_ovl_fifo_thresholds() for timings. And
finally a non-static function to set the timings (used by dpi.c etc),
which calls the similar function to dss_apply_ovl_fifo_thresholds(), and
dss_write_regs() and dss_set_go_bits().

 Tomi


--=-pKIwAShTwj8RWqLttp6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPjtaQAAoJEPo9qoy8lh71EgEQAILXg7RY+gu/5Gb9RgroOU0+
sAi+ZNiwvmh/pUc19zmQV6jfZIZu1bfc1u0Kugl42KdPT8a1nLoVUUDqiE/IkkVr
OpQPh/CdyARhFRntmVug+KPb7JZDE2rfPUXuFla2P2L0edv10cAxrYKdd9e1KCYY
qLgQr5FdM7m21UaJZq3RIfu8BuluXsv2f+tJ7hYZ6ueQaDoh5WXWLcy6Uw6iVRMW
+Fzgz9miwZHueiQtt/nkHBDuWmWGVbEwTzO77AqpjXynDkWLzEus00vDQDs7P7PK
woJ+aqWeU7IRzkSDFWu2fdNj5HmqYjpAF7hc0O9pTr/UMj5HM4NxjKYeGiBOuJ1z
+hbfSIP7cV6lJLpmCR69oEHh6d/ZT7Rw+U95C6LRC5ksF1HOqgoS3HKtUV0WblF+
dRHGdamzW83EPuJw0sD+YgxazOSfardsd8gj6HT/dxNJimHyyjLAkNySERQZZ/eG
TUII23wJ2efPUhdvTX4RfE1lLi2ov3QSeNFAWDUjZ6zw15JsgObmrgsf9Vcjy/yj
gXIW0hzM8ksf2EtPxdzQFH+D3sKNDH9eRMTouiK7pZzec9nqH74apnyrgawPvwtS
Pf3RyD6xwRL+9++QYkN1Wf7cSSUHga71DuW++/fmUMiqoZ7od+Kbgpv5y/z/pwld
nY+HYR/Dna8/urOuHd6m
=9B9Y
-----END PGP SIGNATURE-----

--=-pKIwAShTwj8RWqLttp6T--

