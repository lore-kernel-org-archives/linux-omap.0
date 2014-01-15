From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Tue, 14 Jan 2014 20:04:21 -0600
Message-ID: <20140115020421.GA24195@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com> <20140109231513.GA11648@saruman.home>
 <52CFC2F1.706@ti.com> <20140110161352.GG6665@saruman.home>
 <52D02037.3090705@ti.com> <20140110185110.GM31323@atomide.com>
 <52D53084.1070105@ti.com> <20140114203613.GA604@saruman.home>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2467030499719424979=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140114203613.GA604@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2467030499719424979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 14, 2014 at 02:36:13PM -0600, Felipe Balbi wrote:
> > Felipe, care to run your randconfig magic for this?
>=20
> This branch builds just fine so far, I still have omap5 multiplaform and
> uniplatform builds, but since that was working before i'm assuming it
> won't break.

No build failures in any of my 18 seeds (5 randconfigs of each), I'd
attach logs, but it's a 2.8MiB tarball, if anyone cares enough, I can
send it.

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

cheers

--=20
balbi

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1eylAAoJEIaOsuA1yqREiVIQAJ5+0EjP7jgtleckAc2SZyGh
4a3SwAj518kVsaVcPxmgX9ocXuLQeVhc9BPcdB/NJvHL7Cpwdb6PKzL6yWSeOH9D
whWX2omacokzcqKyR1kFk2r7ayGQJl1XSbrf41yQucnnBSKnCKG8+CC6rTXIIPEI
cTpY/8brw3rgGN/jg7V/wPYwa9ICJ5E+FhjnkeymxqIvHSExrWQYdAfi/WhPvW2s
uhGLbFvBK4MeaHze4eN8wZE5nSkCXLzMP6pieR6EQl2IkS3JLAcIBQFC8KLq3FKl
dCB6XejP3xDMqbLJrXajA3i121E2qHfJpfiXp6YPMCCKj23DZijGEdkMwhNox/Jf
6wikDoBjrRj7P6htVGZ2c4jfKkiJHauTfIKCNYBaDhB/+mli0omFtsxYzXjl5FYy
AAetomxAB57VuQLHv2wYuJb/R8llFXePYd7AKWNtharbE7ZW6d6Ia4wqp7iGhMGr
zk309x85jwf0ktr3DUpibfKlNgBV6Wifbv0HoaN3QZk6h5pYby4Ibj2wsicBnkUV
kPV93cByzIh4U2+d5Dy6ha4+eWhcSfDGO5OsZNEVHMjkd0XpOkhj952G+6CeYiCX
UGIO3IZjK1DtIAFsQf9NexN+rrxL6taFZeDs2QZaEd2DAp2DTHabADnvXONcMM/J
mFMFhplRtmgoRTS0I7QA
=ezfL
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============2467030499719424979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2467030499719424979==--
