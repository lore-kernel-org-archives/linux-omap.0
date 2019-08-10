From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Motorola Droid 4 SMS sending
Date: Sun, 11 Aug 2019 01:14:04 +0200
Message-ID: <20190810231404.GA26417@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2687168709953268268=="
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


--===============2687168709953268268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Motorola Droid 4 runs packet protocol over serial... and its kernel
driver requires explicit "write()" boundaries at places where packet
boundaries should be.

So I can send SMS using low level g_at... functions (that are not
normally accessible), but not using g_at_chat_send().

If anyone has good idea for clean (or clean enough) solution, let me
know.

Best regards,
									Pavel

   snprintf(buf, sizeof(buf), "AT+GCMGS=3D\r");
   encode_hex_own_buf(pdu, pdu_len, 0, buf_pdu);

#if WANT_IT_BROKEN
        strcat(buf, buf_pdu+2);
        g_at_chat_send(data->send_chat, buf, none_prefix, NULL, data, NULL);
#else
        g_at_io_write(data->send_chat->parent->io, buf, strlen(buf));
 	g_at_io_write(data->send_chat->parent->io, buf_pdu, strlen(buf_pdu));
	g_io_channel_flush(data->send_chat->parent->io->channel, NULL);
#endif
		=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1PT7wACgkQMOfwapXb+vLHKQCbB1FXu15H78z7H1X+NaG1Y/pJ
UfsAn1FJ/Qlz2GsssMPxTbGJBNgwHcZZ
=YHx4
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

--===============2687168709953268268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2687168709953268268==--
