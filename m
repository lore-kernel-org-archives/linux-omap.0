From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Motorola motmdm support
Date: Sat, 29 Dec 2018 10:49:54 +0100
Message-ID: <20181229094953.GA15358@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3527118055956247394=="
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
To: ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3527118055956247394==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Motorola phones use "interesting" setup.

There's qmi and "normal" (but very buggy) AT interface on
them. Unfortunately that uses USB and uses too much power (which is a
problem on phone).

Plus there's /dev/motmdm1, motmdm3 and motmdm9, multiplexed over
serial line.

It uses subset of AT commands (good) with slightly modified
protocol... it says ":OK" instead of "OK" and puts ~ before
unsolicited messages.

Other major difference is that commands need to be sent to the right
device. It seems motmdm1 is for status and call control, and motmdm9
is for incoming sms.

I guess that right way to do this is to introduce
drivers/motorolamodem (or can we just have drivers/motorola?).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwnQ0EACgkQMOfwapXb+vIlpACfdZwoTKBUL/EgJ6gjFymPjzoh
sKcAn3ZZLF48o2hnOR897C+zQ/r8gpDP
=pWRk
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============3527118055956247394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3527118055956247394==--
