From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: Possible bug in onenand_base ?
Date: Wed, 05 May 2010 08:56:19 +0300
Message-ID: <1273038979.3702.57.camel@localhost>
References: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33166 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883Ab0EEGCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 02:02:54 -0400
In-Reply-To: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, kyungmin.park@samsung.com, "Hunter Adrian (Nokia-D/Helsinki)" <adrian.hunter@nokia.com>

Probably Adrian could comment on this?

On Fri, 2010-04-30 at 12:05 +0200, Enric Balletb=C3=B2 i Serra wrote:
> Hello all,
>=20
> After commit 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd:
> Flex-OneNAND support) the onenand support for my device is broken.
>=20
> Before this commit when I run the nandtest program all is ok
> ---
> # nandtest /dev/mtd3
> ECC corrections: 0
> ECC failures   : 0
> Bad blocks     : 0
> BBT blocks     : 0
> 002c0000: checking...
> Finished pass 1 successfully
> --
>=20
> Introduced commit 5988af2319781bc8e0ce418affec4e09cfa7790 the nandtes=
t
> fails with:
> ---
> # nandtest /dev/mtd3
> ECC corrections: 0
> ECC failures   : 0
> Bad blocks     : 0
> BBT blocks     : 0
> 00000000: reading...
> [  299.092041] onenand_wait: ECC error =3D 0x8488
>     ( ... lots of ECC errors ... )
> [  299.092041] onenand_wait: ECC error =3D 0x8488
> ECC failed at 00000000
> 00000000: checking...
> compare failed. seed 1804289383
> Byte 0x1 is 5a should be da
> Byte 0x3 is 82 should be 92
> Byte 0x4 is 10 should be 1a
>     ( ... )
> ---
>=20
> Investigating a little I see a significant difference introduced by
> this patch. In line
>=20
> 347:        page =3D (int) (addr - onenand_addr(this, block)) >>
> this->page_shift;   (patch applied)
>=20
> instead of
>=20
> 347:        page =3D (int) (addr >> this->page_shift);  (without patc=
h)
>=20
> I applied commit 5988af2319781bc8e0ce418affec4e09cfa7790 and replaced
> the line 347 and now works again. Fantastic, but I suspect this is no=
t
> the proper solution (probably this breaks other onenands devices, I
> can't test).
>=20
> I'm just introducing in OneNAND devices so anyone can help me to
> understand and solve the problem ? Note that my device is a Numonyx
> 4-Gbit DDP (DUAL DIE PLAN) OneNAND flash memory ( 2 dice of 2Gb, 2KB
> page )
>=20
> Thanks in advance,
>=20
> ///:~Enric
>=20
> ---
> diff --git a/drivers/mtd/onenand/onenand_base.c
> b/drivers/mtd/onenand/onenand_base.c
> index 081f97d..b1d50a3 100644
> --- a/drivers/mtd/onenand/onenand_base.c
> +++ b/drivers/mtd/onenand/onenand_base.c
> @@ -344,7 +344,7 @@ static int onenand_command(struct mtd_info *mtd,
> int cmd, loff_t addr, size_t le
>=20
>  	default:
>  		block =3D (int) onenand_block(this, addr);
> -		page =3D (int) (addr - onenand_addr(this, block)) >> this->page_sh=
ift;
> +		page =3D (int) (addr >> this->page_shift);
>=20
>  		if (ONENAND_IS_2PLANE(this)) {
>  			/* Make the even block number */
> ---
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
