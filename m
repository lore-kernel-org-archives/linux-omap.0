From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Regression: next-20160518: Clk? on BeagleBoard-X15
Date: Thu, 19 May 2016 20:35:29 +0300
Message-ID: <573DF961.4070705@ti.com>
References: <573DDFE6.8010209@ti.com> <20160519165719.GW5995@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8203202971330313068=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160519165719.GW5995@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Rhyland Klein <rklein@nvidia.com>, Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8203202971330313068==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eqkpjxLErPOENM0gJB1h6874JXrjcIJmP"

--eqkpjxLErPOENM0gJB1h6874JXrjcIJmP
Content-Type: multipart/mixed; boundary="6gQDmo2SNI1mAVjFfMOStMQfAOJCKocmA"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
 Rhyland Klein <rklein@nvidia.com>, Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <573DF961.4070705@ti.com>
Subject: Re: Regression: next-20160518: Clk? on BeagleBoard-X15
References: <573DDFE6.8010209@ti.com> <20160519165719.GW5995@atomide.com>
In-Reply-To: <20160519165719.GW5995@atomide.com>

--6gQDmo2SNI1mAVjFfMOStMQfAOJCKocmA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/05/16 19:57, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160519 08:48]:
>> I have'nt bisected yet, but the platform seems to have booted on
>> next-20160517
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160517/omap2plu=
s_defconfig/am57xx-evm.txt
>>
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160518/omap2plu=
s_defconfig/am57xx-evm.txt
>=20
> Seems to be commit ac78f9bdcf38 ("drivers/of: Fix depth when
> unflattening devicetree").
>=20
> Rob, you need to start playing golf or something between -rc6 and
> the end of the merge window or something :)

I'm not sure if it's related, but I'm seeing this on omap4 panda, next-20=
160519:

[    0.000000] Unable to handle kernel paging request at virtual address =
af6ec820
=2E..
[    0.000000] [<c071ced4>] (unflatten_dt_nodes) from [<c071d5a4>] (__unf=
latten_device_tree+0xe8/0x254)
[    0.000000]  r10:c0de3140 r9:ef6b44a4 r8:c15b77c0 r7:00000000 r6:cffee=
000 r5:00038358
[    0.000000]  r4:c0de00c0
[    0.000000] [<c071d4bc>] (__unflatten_device_tree) from [<c0c4a050>] (=
unflatten_device_tree+0x28/0x40)
[    0.000000]  r9:0000000c r8:c0d07ca8 r7:c159f4f4 r6:c0d520f8 r5:c0c598=
4c r4:c0c491a0
[    0.000000] [<c0c4a028>] (unflatten_device_tree) from [<c0c04754>] (se=
tup_arch+0x770/0xbb4)
[    0.000000]  r5:c0c5984c r4:c0d02908
[    0.000000] [<c0c03fe4>] (setup_arch) from [<c0c009c8>] (start_kernel+=
0x50/0x3c4)
[    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c0d02900 r6:c0c5b=
a44 r5:c0d029ac
[    0.000000]  r4:c0de3214
[    0.000000] [<c0c00978>] (start_kernel) from [<8000807c>] (0x8000807c)=

[    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c0d07de8 r6:c0c5b=
a44 r5:c0d029ac
[    0.000000]  r4:c0de3214

 Tomi


--6gQDmo2SNI1mAVjFfMOStMQfAOJCKocmA--

--eqkpjxLErPOENM0gJB1h6874JXrjcIJmP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPflhAAoJEPo9qoy8lh71R2IQAJmSJ0hEh3Q19AdgHulfBX/+
/yRUtVDZDDuVTKEoquzUX1DW30XM4WJyoU4YG96FW5vBagGONElFCdFopBHOsA2p
9qFkwo4075UiW6AJqZuRYm4mEPGAs+L+NdSpac1G6HR/Z0TA27FgIupiqrW+2YZo
ojTT/a0tUxWtnSgvkZOrTqC5CHY3HQCfLPuyj0O00NZ7a+1vnrFdnqTmPr3B+3yz
4/ScmvhO60rKSK85srtLYPUYjEh1KT8Uk7BpdFY/DQaWSkmDsfw4I5mJ8aFPlRe2
u8YcNSEHOu0TQJ3VNMsluvXke0XcxC4nz0Tw6zOuVmoSDkTVkc103otrHed0+exK
yGSyCAol4CUtI6McMuJ+oe3n2WYaviuvlU6dgBBFfxGTrpoZUELflEMIWy2tk+8G
JcMg5DdSzjDsBKshkfq6p1vxSj59drbE9zHkvoy/wOFaOYLNkdgzzK2QQr4zhvgD
ZRjGYpmrAYXyqgDxPg2jlA8grKajjLM5nchSTqCqhS6sMbkT7JhXCsGCAa8U+FEg
sLt07rp2pelugzjz2+Fq0AiJGJ7OsZlHOcmm66u3ptKPp8xPUbX/gEPqlkqgPhao
xqCHTbjvcNHP5RvQB8LeCwBw0ekwx5/5aky5oAEaFQYlnlo2adhfoiWdzhYpFNkS
h+MiHGOI7RegYAQ4Yw6n
=g3Yj
-----END PGP SIGNATURE-----

--eqkpjxLErPOENM0gJB1h6874JXrjcIJmP--


--===============8203202971330313068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8203202971330313068==--
