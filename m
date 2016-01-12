From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2plus_defconfig: enable SPLIT and DWARF4
Date: Tue, 12 Jan 2016 10:52:08 -0600
Message-ID: <87mvsad9l3.fsf@ti.com>
References: <1452547572-23515-1-git-send-email-balbi@ti.com>
 <20160111233438.GB12777@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4690596224805435993=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160111233438.GB12777@atomide.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4690596224805435993==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Felipe Balbi <balbi@ti.com> [160111 13:26]:
>> CONFIG_DEBUG_INFO_SPLIT will split debug info on
>> .dwo files. This will generate a smaller vmlinux and
>> smaller .ko modules, which will be easier to ship on
>> certain products.
>>=20
>> CONFIG_DEBUG_INFO_DWARF4 will generate debug info in
>> DWARF4 format, which ends up being larger, but
>> improves the probability of resolving variables in
>> optmized code.
>
> Nice, this makes my initramfs go down from about 17MB
> to 4.7 MB :)

That's nice, let's just hope nobody has issues with this patch.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlS85AAoJEIaOsuA1yqRE6S4P/iRtVzgu1SAN1L+7hlOvfwjv
ZNtU0HmLQssQvhpHIdRiNV+apQKrgDRR4xyf1KA1DHiCRYLymR+5uGOGp4/jK678
UU0knXtJ17T2KFP4/hysNiAlfZrjbXZEB9i15ZQAB5Poae3/srYiuRCN3scjAGtf
0R5QTNoFb3ecD9G4zOzvAVvvk71aiq0qS/IqM+aiC/23kF58tDP9/Mxzs/TazQqL
HotELeInZ5JVsjZIoemsInxqRNPU/B/e4l+0m4iEhuPhQog/iQVJLwnJEaDvYOJx
rb5bnD3psH/bZ3RXm1qCeKVxf2M7tXczQIxQxfMUrUIA5N0Nvc+3xulheKyfz6wl
y3mvFYsmCwWCCyP3q/7Vj2XssRhRKhFBETL0WcWQ8L09luc0x5ZyUIQRFfBc6BZp
kYzeMFoISjO7yqYmg6c7N7zEq8wODRZGvAmG2ePIFfCMYedFZzH52eE4m1cczEm+
j39wNq/5p6AOuNyhe1u+NUjtb7lMajSgLC8ssV4GTVn9RLHt8s++XVScoK2JiWU5
wYcxgD5Z1TaJluR/CC1+IU4oswskIh2htkIHHX1ot008uGMQOWVcyedIpg4LfHJ2
2LxqD8uAwkbl/XegLOSDC/YQsNHT7adga8tCv+xEYuuM5/xlLxCAhB5yTAn3+GXv
tIMyncVyOKaf/Gk1abyc
=Q7jh
-----END PGP SIGNATURE-----
--=-=-=--


--===============4690596224805435993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4690596224805435993==--
