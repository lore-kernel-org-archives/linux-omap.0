From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 04/13] OMAPDSS: hdmi: Make hdmi structure public
Date: Thu, 7 Aug 2014 10:04:27 +0300
Message-ID: <53E324FB.7060000@ti.com>
References: <cover.1403894190.git.jsarha@ti.com> <536afa4069bd73195b05aee3097c86d7e517ae7e.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mO8tOErt0ND4aRjh2qJqpRa9U8GsXWd2F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53619 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbaHGHEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2014 03:04:46 -0400
In-Reply-To: <536afa4069bd73195b05aee3097c86d7e517ae7e.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--mO8tOErt0ND4aRjh2qJqpRa9U8GsXWd2F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/06/14 21:38, Jyri Sarha wrote:
> Name the anonymous hdmi struct as omap_hdmi. Move the struct definition=
 to
> hdmi.h and turn core member into a pointer to deal with it's different
> definitions for omap4 and omap5. Make associated changes to hdmi4.c
> and hdmi5.c.

I didn't understand this one. Why did you make struct hdmi_core_data a
pointer?

 Tomi



--mO8tOErt0ND4aRjh2qJqpRa9U8GsXWd2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4yT7AAoJEPo9qoy8lh71I28P/jaUn4Q8HixcB++Q12K80hmM
XLDcy5LKMAvXf7E+1evvwiZN4nG8d7/lnd7bqoQ2JXldESDw4UdKiJjevhPY8DBx
2tN5roZvb1TMDUovyl9uDiofiv+lFi9nOPVQ6Rss738x8+t+ncug3tss0Pf+zYJt
oSHtNuCEfLSghqjFPuROW3alNFk8lKBng+z1/DP/mEIPon/oOwSRPkQBTP74UIpV
9NzSYYp8ITILMS7PCwmTQdvswSgNaZjAQmzFrqP6gXEQpKcaZHXKt27Ni6Ocfe6+
Ud5vtAjgBjh8umownRTMJcB4HUdMRW8VLyeld6LEpYku2yLbFyseevFMOTmQdBgZ
p/zi6urX3HKWM7+Q6EH6z7c15ejqQhvJ1r/F+/Aax8c/tR8hlSJzji7pqGC3c+0K
mhMbK5yrsv+UTsvZLGrImpF4hsZcggc6yHlfKYD9VgFqdv28rLhB5TNPM/lGXzOF
pGequeCW88JYlhicyh7IF208oaqOXnSJYazEXAhBdlymo4gEG9YHBjB7vRYcKhrv
SMRPA85d9ItWR0/B0yk+r/3jSfoAVp6Kdz/IluC/llQuG5C7RAfQNM2TKZmKxYbf
lq6Su7pE5T59+rjA6jgdMbNFMg48JM9hipl56NiGmTcux4NQpdc4TmSW9omcUOJS
UY4ZFuqBD3fRucfQSCri
=xkXO
-----END PGP SIGNATURE-----

--mO8tOErt0ND4aRjh2qJqpRa9U8GsXWd2F--
