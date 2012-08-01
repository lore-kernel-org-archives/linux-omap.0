From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 RESEND] OMAPDSS: DISPC: Improvements to DIGIT sync
 signal selection
Date: Wed, 01 Aug 2012 09:28:41 +0300
Message-ID: <1343802521.2645.6.camel@deskari>
References: <1343779019-10611-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gdfZAf/7wak+b6ElShdf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47535 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753859Ab2HAG2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 02:28:49 -0400
Received: by lboj14 with SMTP id j14so182725lbo.35
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 23:28:46 -0700 (PDT)
In-Reply-To: <1343779019-10611-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-gdfZAf/7wak+b6ElShdf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-31 at 18:56 -0500, Ricardo Neri wrote:
> DSS code wrongly assumes that VENC is always available as source for the =
external
> sync signal for the display controller DIGIT channel. One cannot blindly =
write/read
> the value of DSS_CONTROL[15] as in certain processors (e.g., OMAP5) this =
operation
> may not be valid. If the the sync source is not read correctly, the calle=
rs of
> dss_get_hdmi_venc_clk_source might make wrong assumptions about, for inst=
ance,
> video timings.
>=20
> Logic is added to correctly get the sync signal based on the available di=
splays
> in the DIGIT channel. The source is set only if both VENC and HDMI are su=
pported.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
> v3: instead of BUG_ON calls, select only if both VENC and HDMI are availa=
ble.

I think they do make sense. For example, if somebody calls this function
and tries to set the switch to VENC on an OMAP that doesn't have VENC,
something is wrong. Your new version just skips the register write in
that case, which is ok, but I think we should also yell that something
is wrong.

I'd have the BUG_ONs there, but change them to WARN_ON. I think we
should generally try to have less BUGs and more WARNs. Also, please keep
the comment about the bits being written (VENC_HDMI_SWITCH), it helps to
understand the code.

 Tomi


--=-gdfZAf/7wak+b6ElShdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGMyZAAoJEPo9qoy8lh71p3IP/izhZYzvA07tujjFIMluKJ+N
zjMo6UkbrIf8GTAGPhD4pQqCe0Suln6qYwqcTzAmShqZCmW/+ah1s7pTg6Qag8yU
e3ZGyE640oGW6Jaat7Hcw6YqLhm2FM+ttnlG3SLkApCBYT2ZoNbvqrgIFBEi+zF5
6kKWlWPAjvvIbR0E0iP0CMjHKazQ8q32v3iCqvEABsPD6sYYBtiEaeScx9wzDm/j
krsHZQboLa0Czikm0sQpDgP5m6JM+PVMjCfUJBnGHjq8IuBVRr6Ay3nNBHP9WKQP
oi4OX04g7FemOrP+ydjDj3jOFc0+HM80YOY0mTg4uHP3beQ+zlPd4TU7ZbD0FGrh
2njfNqXRoMSX4vTKG9Q3nqGtAzsEozdm2SjQOrT/tpsVp49HMOiOBtB6J306Xyil
w1KPyhEVzceLI14qGRSq6dxdykCNUwv3t6ZjtZ6hOmqhNXT4kzhROChFM4+sV6bJ
clu98p8e9mR67ALcFMw0AIH13DwTiEoEIPYQsUxXqviCt7KejS9KKxT0PMcJ7vnl
ofwmVkrCJobBb9eU1w7jzxg5b+P20fthG15rPhlUYCWU6LjkCpzYboi6ZwZYlpqe
gjcQ9bla5QuTDlVANAQ29nfdn9uQ7/sCgei3LVvjRz2N/0yxOVLX4OdGUULwLuAE
tfv4XkysKVmloBv0HCO5
=tng5
-----END PGP SIGNATURE-----

--=-gdfZAf/7wak+b6ElShdf--

