From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: Possible bug in onenand_base ?
Date: Thu, 6 May 2010 12:46:10 +0900
Message-ID: <z2p9c9fda241005052046j3fea69a4v91f3d5fd86648fac@mail.gmail.com>
References: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44040 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0EFDqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 23:46:11 -0400
Received: by vws12 with SMTP id 12so1670880vws.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 20:46:10 -0700 (PDT)
In-Reply-To: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Enric_Balletb=F2_i_Serra?= <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

Hi,

Can you add this statement at below the code?
printk("%s[%d] page %d, %d, %d\n", __func__, __LINE__, page, (int)
onenand_addr(this, block), ((int) addr >> this->page_shift) &
this->page_mask);

In my test environment, it displays the correct page number.
(addr - onenand_addr(this, block) >> this->page_shift is same as
'(addr >> this->page_shift) & this->page_mask'.

Thank you,
Kyungmin Park

On Fri, Apr 30, 2010 at 7:05 PM, Enric Balletb=F2 i Serra
<eballetbo@gmail.com> wrote:
> Hello all,
>
> After commit 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd:
> Flex-OneNAND support) the onenand support for my device is broken.
>
> Before this commit when I run the nandtest program all is ok
> ---
> # nandtest /dev/mtd3
> ECC corrections: 0
> ECC failures =A0 : 0
> Bad blocks =A0 =A0 : 0
> BBT blocks =A0 =A0 : 0
> 002c0000: checking...
> Finished pass 1 successfully
> --
>
> Introduced commit 5988af2319781bc8e0ce418affec4e09cfa7790 the nandtes=
t
> fails with:
> ---
> # nandtest /dev/mtd3
> ECC corrections: 0
> ECC failures =A0 : 0
> Bad blocks =A0 =A0 : 0
> BBT blocks =A0 =A0 : 0
> 00000000: reading...
> [ =A0299.092041] onenand_wait: ECC error =3D 0x8488
> =A0 =A0( ... lots of ECC errors ... )
> [ =A0299.092041] onenand_wait: ECC error =3D 0x8488
> ECC failed at 00000000
> 00000000: checking...
> compare failed. seed 1804289383
> Byte 0x1 is 5a should be da
> Byte 0x3 is 82 should be 92
> Byte 0x4 is 10 should be 1a
> =A0 =A0( ... )
> ---
>
> Investigating a little I see a significant difference introduced by
> this patch. In line
>
> 347: =A0 =A0 =A0 =A0page =3D (int) (addr - onenand_addr(this, block))=
 >>
> this->page_shift; =A0 (patch applied)
>
> instead of
>
> 347: =A0 =A0 =A0 =A0page =3D (int) (addr >> this->page_shift); =A0(wi=
thout patch)
>
> I applied commit 5988af2319781bc8e0ce418affec4e09cfa7790 and replaced
> the line 347 and now works again. Fantastic, but I suspect this is no=
t
> the proper solution (probably this breaks other onenands devices, I
> can't test).
>
> I'm just introducing in OneNAND devices so anyone can help me to
> understand and solve the problem ? Note that my device is a Numonyx
> 4-Gbit DDP (DUAL DIE PLAN) OneNAND flash memory ( 2 dice of 2Gb, 2KB
> page )
>
> Thanks in advance,
>
> ///:~Enric
>
> ---
> diff --git a/drivers/mtd/onenand/onenand_base.c
> b/drivers/mtd/onenand/onenand_base.c
> index 081f97d..b1d50a3 100644
> --- a/drivers/mtd/onenand/onenand_base.c
> +++ b/drivers/mtd/onenand/onenand_base.c
> @@ -344,7 +344,7 @@ static int onenand_command(struct mtd_info *mtd,
> int cmd, loff_t addr, size_t le
>
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block =3D (int) onenand_block(this, ad=
dr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 page =3D (int) (addr - onenand_addr(thi=
s, block)) >> this->page_shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 page =3D (int) (addr >> this->page_shif=
t);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ONENAND_IS_2PLANE(this)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Make the even block=
 number */
> ---
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
