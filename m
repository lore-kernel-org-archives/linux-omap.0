From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Thu, 22 Nov 2012 15:42:14 +0200
Message-ID: <50AE2BB6.8080406@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>
 <50AE1DC0.3030002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2848856818512311166=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50AE1DC0.3030002@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Archit Taneja <archit@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2848856818512311166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE43AFD3C6C999B3119087FA"

--------------enigEE43AFD3C6C999B3119087FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 14:42, Archit Taneja wrote:
> Hi,
>=20
> On Thursday 22 November 2012 04:33 AM, Russell King - ARM Linux wrote:
>> This one is nice and long, from last nights boot test.  Looks like it =
was
>> introduced sometime in the last couple of weeks.  Full log at:
>>
>> http://www.arm.linux.org.uk/developer/build/result.php?type=3Dboot&idx=
=3D518
>>
>> and config:
>> http://www.arm.linux.org.uk/developer/build/file.php?type=3Dconfig&idx=
=3D2786
>=20
> Doing a bisect results in this commit:
>=20
> commit 0c7018e232c5526869250e57da8043a86a45b5de
> Author: Rajendra Nayak <rnayak@ti.com>
> Date:   Thu Oct 18 12:20:06 2012 +0300
>=20
>     ARM: OMAP4: suspend: Program all domains to retention
>=20
>     Remove the FIXME's in the suspend sequence since
>     we now intend to support system level RET support.
>=20
>     Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>     Signed-off-by: Tero Kristo <t-kristo@ti.com>
>     Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>=20
> I guess this commit will allow DSS to go to a lower power state. So wha=
t
> might be happening is:
>=20
> - After returning back from the lower power state, the DISPC base
> address register hasn't been restored. Leading to a fetch from a bad
> address. Resulting in an OCP error.
>=20
> or
>=20
> -  DSS never came back to ON state, and it's not able to access
> registers. I doubt this possibility because we got an OCP error
> interrupt from DISPC.

It seems that the problem is that dispc never restores the context,
because get_ctx_loss_count always returns 1. I enabled pwrdm debug
prints, and pwrdm_get_context_loss_count() always returns 1 for dss,
even if the register contents have obviously been lost.

Does the pwrdm mistakenly think that in RET state the DSS still keeps
the register contents?

 Tomi



--------------enigEE43AFD3C6C999B3119087FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQriu2AAoJEPo9qoy8lh71JpMP/2e5DPimZdrAZNfIcKyb17HB
b9e9Oc2c9Rn16Eyt2BeHtpRwhs8sGA4FMsLV4kVUULYInLV8231xAWqFw9KXwlWU
OSg8yeopNDl11SpPB84E/HA06uYV+2vMFHmno/7lgX9ZLORv89INZVOhD0+jdqMO
UawKWmGY9riUHAgZlRQ3vUnH3wwiVzUGrNOk+8ZpZ1tAN6SCPtvrlzKWVyBJy9XX
9rQozpsCYIkh8Pt3tCw2/mO2+f77rLFU8qBTsIR+T/xs/JI+9N1ziPlZqfkoKhsv
48PE5YzDCpR07nK5ar1EtIVL2pHJliRK0o0n4wDdkLX+m2vg1f/6Ejqmljm0EtfW
adQXqZZirvKwGyPCbaK1deow2i5EOnbToVBpV0igfJmNifWmPe2t1NcPi5GNm+xP
+7A/zjwInQUblZMm/oQjOhxym1uqD29dJ4wmPJJQMFZmpRjSIscvNHljb1iAqB38
f1GZKFmyf9G58mcrV97PilaBPje8791CDDJJKVhdPVlh3yz8a6Rj3UhHfgIdnK8N
M29pVppgyl7sDG7a/15K8qiydBrys2uH1C+O4svyx2qtB04HEYQJ7GSYt4IeUb78
QBTrudQUCGIDgQdSnHgbBQQaq6JGogwCBgqvxMi2Eb/UYgFhsmw3KdeZGUyat1pa
/q+PiwgEyEo4fdgakGSP
=NOk/
-----END PGP SIGNATURE-----

--------------enigEE43AFD3C6C999B3119087FA--


--===============2848856818512311166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2848856818512311166==--
