From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Incoming sms problem on Motorola Droid 4
Date: Tue, 8 May 2018 23:51:02 +0200
Message-ID: <20180508215102.GA5253@amd>
Reply-To: ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0124936794841356644=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.ofono.org/mailman/options/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono/>
List-Post: <mailto:ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ofono.org/mailman/listinfo/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Sender: "ofono" <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
To: ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============0124936794841356644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0

> AT+CNMI=3D?
< +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
< OK
ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> AT+CNMI=3D1,2,2,1,0
< OK
ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0

=2E.. unfortunately, with that configuration no messages are comming to
ofono and the other phone sees them as "delievery failed".

I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
PDU) messages. That works well enough for me.

Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
work well, either.

Any ideas how to debug this / what to try?

Thanks,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlryG8YACgkQMOfwapXb+vJMHQCfcLKpuvMsUeL+lwd58tMFjiZE
mqIAnRukPDQMkJTHVz/nUgIGM1ckM6eX
=QLm9
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--===============0124936794841356644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0124936794841356644==--
