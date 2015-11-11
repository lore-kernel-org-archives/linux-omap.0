From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Wed, 11 Nov 2015 13:31:54 -0600
Message-ID: <877flos579.fsf@saruman.tx.rr.com>
References: <1447261631-26362-1-git-send-email-balbi@ti.com>
 <56439641.6070901@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230779687716855257=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56439641.6070901@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1230779687716855257==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> Felipe,
>
> On 11/11/2015 07:07 PM, Felipe Balbi wrote:
>> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>=20
>> McASP3 is used by default on DRA7x based boards for audio.
>
> While this patch works, it is not the correct one(s) to apply.
> https://lkml.org/lkml/2015/10/30/91
> is the series which should have been applied to 4.4.
>
> Paul acked the series, but for some reason it missed the initial ARM
> pull for 4.4

okay, cool. Hopefully Tony will apply shortly.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQ5esAAoJEIaOsuA1yqRE3pQP/iPjURXa8uy7ac9ysBmrtAKQ
Satavk12JZE9zV4ZMO58rP3JcYPbRjX/7+uVwxE40q43egORM5NBqWyqLvz1mGQ7
0ypZ9384Kx/sEZXQ+H2E+3irb0lhwGoVS2+sJiyc48w6vRyQcsIkVjlbYSwz7uk+
0Sf0v7DUtkzJmpJqIVAXn9Q+iM05b4p3R4BZTa0MALRBD+1n6xmTzfTr8M/LIPeO
RXLkjaoHHNCL+3k+evX91ohjoxN/moS5xZLCbG+irnJS4llaMOC67/OsUHiwJjXh
GxFxZDHSoQAcaS769CigETNaPV6PjhnfKM1lIh/Ztq7sEcZ0c2OE/3ZaEaLFPWLQ
SmURS+4fExKaglnwVeuc8X6tZUuJY090DfKVP7ZKE3RM5XMpkL3WMUGKfZ7fNHvt
UEdnepCjC1wKLnk4YZ+4TpqCc/et2T1sByWooy2h6/KDoQALfzpzzxuicvPlnICM
1M23mUvqqOMXCJLCCpmf/zFWSauVSC0hH7B05g9TJE54/R0NRqwzJTRNU2JfSo9Z
yvc+RbwdQmsBw6SH09hv+DmgLQoxjWm6Qfboz4qTeb64D2BsBShF8hvk8hcRRAX/
uuzKTGR6Y3aLtr3dVYZS0kX38sBnQh93L92ceOsUxAUUqcHJlxAUUKlo8L4An/VW
lpdrI3efKPwaHFcthjUK
=rv2X
-----END PGP SIGNATURE-----
--=-=-=--


--===============1230779687716855257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1230779687716855257==--
