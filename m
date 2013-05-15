From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: musb: Fix LapDock enumeration on omap for boot and slow
 cable insertion
Date: Wed, 15 May 2013 17:05:37 +0300
Message-ID: <20130515140537.GC26183@arwen.pp.htv.fi>
References: <20130503175016.GV28721@atomide.com>
 <20130503180132.GW28721@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130503180132.GW28721-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2013 at 11:01:33AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [130503 10:55]:
> > Looks like we can get VBUS interrupt before the ID interrupt

how can this happen ? VBUS interrupt happens when you connect to a port
which is sourcing VBUS to you, while ID interrupt happens when ID is
grounded, meaning that you should be sourcing VBUS.

Have you hacked a Hub to backfeed 5V to OMAP by any chance ?

--=20
balbi

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRk5YxAAoJEIaOsuA1yqREQn4P+wbn9L+flpMJx0JWq3hKAwEK
Ej4Xhx67aZRtSZD8edSIkfDsoU6Tvf9GPOZduurItXP788/vtzPCVZQPSQuIeU7n
VG2EydZ5o5NvLAOCpUajWHkUv+bDwHsDyyHYnc2zmk/7X7gvgIGpf8SCIal6Tgqc
xWDoUToEIdlVRyPWTMjBKrrQT6d5hvNG8O1w8sTxpzpRghqCXB9GoLHUgoDW5DoL
GEg741uM6k2gqObUyMpyeqO1lGHw0JUsAq6z4a19KSESaYt6QPRIY/6hND/Fx4lt
J24MlnOuwBhOfvHl6zcddakEz5NZIJmNbguvq7smgNVprgDetZfS4nNEQ76jOC6P
bY3sQ1k87g9RjymBMA4oVHV4S1TTG+NEqkIAj3Asm/b8L+HZTdpPPM/uiAt4RcTN
B2e9MSNnt6SNSWjtYHqxr0wE9iXAvS2FjQlm3d8nXpDlaIX+QaawEToya56/nUIf
KlPXBxO+CmXJfjooyJYGdf3rgVWhQ8fbWBrJOKFuJJIM+R/N/61dyTLehhZv2zpY
PZHnnERhdn0AhxaS5o6x5VT8Q4Bu0xSpDLdq0KxeDA1CBdArIXtaYcIg15Id4uHn
Z2xB4CvSyBPQpleCkYznw7tXoOCyN2xIMLLFVcEQp6gbrLXsw6HbXYOeXk+S62re
CkBPf0DFOMF1PGhDw6SF
=I3nS
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
