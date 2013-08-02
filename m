From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAP: Panda DVI fix and a cleanup
Date: Fri, 2 Aug 2013 14:58:19 +0300
Message-ID: <51FB9EDB.8010600@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7868678808274434545=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7868678808274434545==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="g7PHkrGKrJgaaPN3IG9e9bVs0aG8chRj2"

--g7PHkrGKrJgaaPN3IG9e9bVs0aG8chRj2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/07/13 12:06, Tomi Valkeinen wrote:
> Hi Tony,
>=20
> Here's a fix for 3.11 that makes EDID read for DVI work again.
>=20
> I also included a cleanup patch that removes the non-DT support functio=
ns that
> are no longer called from anywhere. It's not a fix, but as we're in qui=
te early
> rcs, I thought it would be nice to remove the dead code.
>=20
> Up to you if you want to include that one for 3.11 or not. If not, I'll=
 include
> it in a board file series for 3.12 that I'll send soon.
>=20
>  Tomi
>=20
> Tomi Valkeinen (2):
>   ARM: OMAP: dss-common: fix Panda's DVI DDC channel
>   ARM: OMAP2+: Remove legacy DSS initialization for omap4
>=20
>  arch/arm/mach-omap2/dss-common.c | 49 +-------------------------------=
--------
>  arch/arm/mach-omap2/dss-common.h |  2 --
>  2 files changed, 1 insertion(+), 50 deletions(-)
>=20

Ping.

 Tomi



--g7PHkrGKrJgaaPN3IG9e9bVs0aG8chRj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+57bAAoJEPo9qoy8lh71yuUP/0/RJmT12xtNn2OPBgzyfVbx
8aJTmhMjru93HJbcUSuniMNZj6l5QLrbwonoDFNQMH1JA2EgfGuVaF4Xc+7gxQzN
frPKKHNfXQNeM6BDc2N4FNEmvRONzyNoCemmDoAyiihGSP6/uwUYRBR1Gl61QdPf
Rf/x+nsKlGpnEvE+mkL8H7tOGXGHUOx0W3EkmQZ7wf4V7UbqD6udlOjB/r8ZZgFp
YJaUauQ91Ee/dj6vv9h6haJyJsjyKSKNKWh2JyCQB2UtP+sZ8Hb4Xx3rPc9TAYQ+
xzo67S8Bkt5GK+gZFRsGWn4sN4GtupXmEw3jFA9JAIiMLX1hesbH2BQYoeNoYW0q
SZ6xDgrYQ+9yzi3LsNdo7djxamilNbY4SBq8NwfV6Kr3oImla9Kb2eGk3BR+ihr4
2a4cgm5gQCfaIz8z9qfrhI133crpHu4mHBEDjLlzlTQPPfNx30ua3O4seNVVhkkt
klt/DmPR/Jdie1MpduBXLtAWNbLpTyW3w2toLJIJXtldL4jSQwYc22SSIE25D13U
M+/zQjj2ouBWKPKO+9nOrWYmcNRcYVKosbaAbizVwe4pnRxbmAeEpELuF3EOzlrA
fWYJO07dKPAqG66PU4vqB6ja1ocqOuIKgZaPOCt/ZsngNwT/+DSLnIkydrj6deko
lizAKygfVFI1JoAiYOIw
=bqD1
-----END PGP SIGNATURE-----

--g7PHkrGKrJgaaPN3IG9e9bVs0aG8chRj2--


--===============7868678808274434545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7868678808274434545==--
