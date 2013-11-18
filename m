From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [BUG] PandaBoard hangs before starting init while booting v3.12
Date: Mon, 18 Nov 2013 14:08:58 -0500
Message-ID: <874n79plx1.fsf@gmail.com>
References: <87hab9agjr.fsf@gmail.com> <20131118185722.GS10317@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:45458 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3KRTJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 14:09:05 -0500
Received: by mail-qe0-f42.google.com with SMTP id t9so1656455qeq.1
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 11:09:04 -0800 (PST)
In-Reply-To: <20131118185722.GS10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Tony Lindgren <tony@atomide.com> writes:

> * Ben Gamari <bgamari.foss@gmail.com> [131118 07:14]:
>> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
>> linux-next (30121118). I'm booting with a brand new u-boot
>> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
>>=20
>> In both cases the device appears to hang shortly before one would expect
>> init to start as seen in the boot output below. I'm booting with the
>> omap4-panda-es devicetree. As far as I can tell, the machine is
>> completely dead and will not respond to even sysrq. I have a PandaBoard
>> A4 which apparently has no trouble with the same kernel image.
>
> Do you have the same version of u-boot in both cases?
>
Yes.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAEBAgAGBQJSimXKAAoJEErkyLZmeNiDQCIIAMYQXmrtHGaEyjcgSf0gvp54
oydXmEIM93siBixqHfkP8tek4zLOmWRv992BloMgJwrnioTdiPPcIcriEF0TW3lz
1ALOfaNyV8UQpv/nc4fMY4AtdRu/AAlQTwFuT1gB1I88Ktv3Mg5SqcFIczHWlKTE
+H/f8Z4DsKQWwb0TNEEndkXN743KK0j+P+n3I353AU8BsEWa2I61J1X7o6FEr7RS
W674KL0NWoLA3dlbZV0JlcfN/FTQlF/tifHPBy8TzHQW/uyhBsrmOyTonv/ZHypB
8DFP/ED97W/xjJg7YwVvqhGtFCeyl5EHvIiUaLRMlhNW51olrTHY3QdbfqmIPM4=
=GTYv
-----END PGP SIGNATURE-----
--=-=-=--
