From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
Date: Fri, 31 Aug 2012 10:15:09 +0300
Message-ID: <1346397309.18766.5.camel@lappyti>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
	 <1346230576-20004-3-git-send-email-rnayak@ti.com>
	 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
	 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
	 <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-TPB0XKqxIp/Jr96uraD3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:56988 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751366Ab2HaHPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 03:15:23 -0400
Received: by lagy9 with SMTP id y9so2081719lag.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 00:15:16 -0700 (PDT)
In-Reply-To: <5040586D.2020406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>


--=-TPB0XKqxIp/Jr96uraD3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:

> The only little problem was that during bootup, when hwmods are setup,=
=20
> only the 'parent' hwmod was able to get reset properly, all the other=20
> 'child' hwmods don't have modulemode bits tied to them, and hence=20
> weren't able to reset. So we got some error prints.
>=20
> Once DSS driver kicks in, the driver ensures the parent is enabled for=
=20
> any child to be enabled, so we don't face the issue again.
>=20
> So, if DSS driver is not built in, and if the bootloader left DSS in a=
=20
> bad state, the DSS clocks might remain messed up all the time since=20
> hwmod fwk wasn't able to reset them.
>=20
> I think this is why we didn't proceed with remove "dss_fck" as a slave=
=20
> clock. If this issue is minor, we could go ahead and remove it.

I wonder if we could handle this with a custom reset function. We
already have a reset func for dss core. If I remember right, the main
point for that is the fact that omap4 doesn't have a softreset for dss
core, so we manually write the default values to registers.

For omap2/3 this would be simple: skip the resets for all other dss
submodules, and dss core's reset would enable all the clocks and set the
softreset bit. This would reset all the submodules also.

Omap4 is more tricky. I guess we'd need to enable all the clocks, clear
manually dss core's registers, and then set softreset bits in all the
submodules. So in this case dss core would need to have information
about the other submodules.

 Tomi


--=-TPB0XKqxIp/Jr96uraD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQGR9AAoJEPo9qoy8lh71TgcQAJqUP/hWL+7y1uuygope7Q0j
4aHCJpMlJv/oxVFg9LdTQH6cMZSaZpExxNTR/cjseSZUDwqWFqR/YCEl5mx/SC+i
8/BcXVO5Z/tRtpnG+NKrg7M5W2W26gMNtb3Z2wGKFf/cMc8nKsN/HxPCe112yIqK
vx/iOotZ2W+yVVw/TBSSIJkUsv8gFHxOIo9nPHQpniWyJM6uQHwJq04Q9zJBe7Wf
xw40F25pCGjK0ZSOyNBUFkzxkG+utdKoONsjSJkik9+m8aEyRbESabn2xViLhQKj
AYsLMV+z3ilY1PSFzabW+ze8537J4zlp6YfuLQHaGRNUOvIFUFNehu/R8JvyxYcg
aO1P+VLJw7elZOfErUA8RJpa94I6pCAHnrUwvAMyKGJh1CIu5JfoXeMGOckgJHlC
yGemSpLYWVBqP31W3bASPDWblcEHFMcpKWrWnfQtWtFw9Mi8kMR5EWIvsoK/FIkf
88/9g5InfwWyTDtfXDtCPCNbVgnoF5ots6+zcZ1AS5to+Nb81sPlG0Cn9X183cJC
EEqOvaj+qn+TpuvJnu3hbaE8XNujDk/FarsuVumKStHc8wSc+srLWLpZjx9Wejp+
vD+A7CtiZTtW05iAL5AGxpvxf4ydsxRYpqFKz/X/APb6y8az3j0HHnzPU5JpNd91
ptNOCkzagWh2FwhdXHQv
=fLdq
-----END PGP SIGNATURE-----

--=-TPB0XKqxIp/Jr96uraD3--

