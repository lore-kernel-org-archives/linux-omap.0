From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
Date: Thu, 15 Nov 2012 22:45:26 +0200
Message-ID: <20121115204526.GC12466@arwen.pp.htv.fi>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4109972483857544890=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4109972483857544890==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline

--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
> +static struct of_device_id omap_counter_match[] __initdata =3D {

not directly related to $SUBJECT, but shouldn't this be static const
__initconst ?

--=20
balbi

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpVRmAAoJEIaOsuA1yqRE/FUQAKLs38oDp3rS7EabQeIwVCee
QAjpdr1HSKzDPdoxERtZE7gkKmEPPZ9L+46tXIRR/NaV+UU+4oI8nlh6PHZB9shr
L3Mx/Aw1F2eKrCQWQ6qTOmuwwbRCPzvtNoz/aDigzcfEplAd/N/zDWVvMjV1xK0E
kc3md2UKm4FE6ktsgU68Mf2ndW5ypk8YRv5VifjzGMRVCS/yJ2WY4M0G95X2GrN8
7enHSNQkDW2N/N75s5i2ZUkmAMQrulPjbh/NDAe66Q/JASpNPQwsYsjb9ZhEFeIc
jF1dNLy1cE5pKF95vCMT61xvkQTSfZa6GC/TRaaWllpPZwrxoRoF+oWlmdgdTSKD
EVaAIwX7Gn+C0FhxgIZFszurQcfcLZUgnFnwQXJusA4jNmsUeSftsrbUjbsu7J5F
kOFdVUg7BPVucvg4kWnAWqFfspoasd4J3412+xw+m/7E7aQZ5bMEvomk6Ete0FD4
rMuKhe9KaxK5z9yezglFTjM8Zzr98pd+YI1KTcYlVOt5Mvsgbb2d9QH/r+gOqEJD
qSlV9yJlRfF5I6RRz9t0pN5lb0ZD9W2UMk0YVAcR/VfHD2dqnLWe6Ad2VtdMuJL6
SB7u8jzTOx6TDaHEwl2HxVsChKtODYBwSq6OpI+PruXNP5G/L3MoXG3BHl3qGsAd
XMSJpCd9WsjLOTTab5K8
=3dHv
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--


--===============4109972483857544890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4109972483857544890==--
