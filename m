From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/7] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT
 init
Date: Tue, 16 Aug 2016 10:14:46 +0200
Message-ID: <20160816081446.buo35qiazutq57qy@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-2-git-send-email-sre@kernel.org>
 <20160814084956.GB21321@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22o7guaehhjjzaqt"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160814084956.GB21321@amd>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--22o7guaehhjjzaqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Aug 14, 2016 at 10:49:56AM +0200, Pavel Machek wrote:
> It would be nice to have a line about why it is needed,
> unfortunately include/linux/serial_core.h is not exactly helpful.
>
> Plus you'll need to sign off the patch.

I should have had another look at the long patch
descriptions before sending the patchset ;)

-- Sebastian

--22o7guaehhjjzaqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsstzAAoJENju1/PIO/qaN5kP/jBiGQ/u9sk1kaJuuWv8uh2b
q7e1P8hPI+ghOsSJ4uqZfoFMMwztUgitH0xil6SFOFxyhazF1KyhEUYQ4TTqpieC
BxkwqxMkbWVFJlNWaF/LJFDdL7WadgRiP2dYkCQesjEzjVmu/xwzoidcm4lG2nGJ
wssWf4n4Ri/T7goz/VJssb1O/+V2NC5r2bf5L03282ymh1XfmJR/uGx7RUNTQgl2
NpwBa3r9LYH4CWnro1oQPjzVuAFQCfI+dsn39mdqxAJLqLt5gpSFjaZhAvO2PfHf
1cOW469bTuVm3IYIyEeFMp3B67UYt8XVEyLF7ArXWfPMZ4ip4tnGgc/U5M2H2N8o
XyaM606UhbQoyRHIKsPQFxAeMUrxH7hHPx+B5pb59Pq4t1DKb+CjgJxf1DMZgyVz
OvPyBXZDNYZB4MYocvENvh9/8m5RykWpkfDHetDgC1jJZlvkTlhP4Vw/e/gh+rk5
hLrAtla04iE00YyULKHSNftnlp1m3vEW7fwm2WH/aAKE1MtAhqFzIf7Wwp/4iyGc
B1J9sjmZkZGvCsGQXhd1kxTyblbpEeQe63JO06TP29451t2Qp3MtBtmcuGMCjpBP
H/kMwjV1nejiUXhaa20t+ZpsHjnwSXPD1BTt6Wsncx/zGGUfSHeIriv0U9dGIESI
llNB5kQwkqTJZz7Mae9r
=U1HA
-----END PGP SIGNATURE-----

--22o7guaehhjjzaqt--
