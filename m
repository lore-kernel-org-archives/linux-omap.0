From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Date: Sat, 2 Feb 2019 07:18:13 +0100
Message-ID: <20190202071813.6234d8a6@kemnade.info>
References: <20190202055827.12956-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433797329975995673=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--===============1433797329975995673==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/brBhm643RtDYZ=JIaq78N0f"; protocol="application/pgp-signature"

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat,  2 Feb 2019 06:58:27 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.
> The debugfs file can still be used to override the default.

oops, this should be an rfc. So take it a bit with care.

Regards,
Andreas

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxVNiUACgkQl4jFM1s/
ye8pEw/+L6fsxsK4dvYlZo/y0VgLNEYvdJs2w2yZEVoWmygXS2stsavD/y6Ap3my
hSUIbVNJ438d5CFjQjgeSYhdhYHofuRDbZNuPv1JxKeIPvLlRanfL0OCmolOZJhA
VO2ptqAM571hmbrfuT5ejB/uAO/jFEMX3DJWskHJbW3aaUm1OfLplw7GKa+zK5+A
kc+vss0BHhFDJoSOI00qr9v1h57QHV6xsSqnBkWozbnPM5Cyqvzq2Kqx3Vjw/RkG
CAB+dbIrS3YUISMAbglnSSgoJQCHA3u+Kx3zoXxP/0MV6pYHqtn8knjW+lxRAqlr
u1SuN4zvWs60hb6vh6E9kmUrYzGm0ewLlbbNq3ICZC8EBxvPXPVZNoM+phgLIF9U
ixTLjN/5oDmJmCEblLXKsMhtzAwCj5iip1yxaMMmER9PNERSR9YLoAWOfDt/aycu
VqJK8FA4pmruclyHD6tgGaVVQ/WiGV5snp/IkvlD9iRQ5EPXxaF5pz+LVOIywyp/
Hxvs8d76qUhBgqqPxVQJy1gMO2uOUA2jOzeAWVWQe/FRJSt+wcdQbEHegiBO8E6a
A1SMOsFGiI06myc4US2YtfkN5UiKDUnNoZKNwgjNjzXaqI64O0H+MZDyI7IEBDSU
h6c9cgLJKuY9TNWo4X0tfGBiOhx2pqSS+94/IdXgPffEDORBB9c=
=USJC
-----END PGP SIGNATURE-----

--Sig_/brBhm643RtDYZ=JIaq78N0f--


--===============1433797329975995673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1433797329975995673==--
