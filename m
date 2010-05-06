From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: Possible bug in onenand_base ?
Date: Thu, 6 May 2010 13:22:57 +0200
Message-ID: <k2x70c9a9111005060422v90e246daw19b1f71d57a890a1@mail.gmail.com>
References: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
	 <z2p9c9fda241005052046j3fea69a4v91f3d5fd86648fac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60056 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab0EFLW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 07:22:58 -0400
Received: by pwi5 with SMTP id 5so1220689pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 04:22:57 -0700 (PDT)
In-Reply-To: <z2p9c9fda241005052046j3fea69a4v91f3d5fd86648fac@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

Hi,

2010/5/6 Kyungmin Park <kyungmin.park@samsung.com>:
> Hi,
>
> Can you add this statement at below the code?
> printk("%s[%d] page %d, %d, %d\n", __func__, __LINE__, page, (int)
> onenand_addr(this, block), ((int) addr >> this->page_shift) &
> this->page_mask);

Yes,

With this code nandtest fails:

onenand_base.c

377:     default:
                block =3D onenand_block(this, addr);
/*  (line disabled)   page =3D (int) (addr >> this->page_shift); */
                  page =3D (int) (addr - onenand_addr(this, block)) >>
this->page_shift;

                printk("%s[%d] page %d, %d, %d\n", __func__, __LINE__,
page, (int)
                        onenand_addr(this, block), ((int) addr >>
this->page_shift) &
                        this->page_mask);

                if (ONENAND_IS_2PLANE(this)) {
                        /* Make the even block number */
                        block &=3D ~1;
                        /* Is it the odd plane? */
                        if (addr & this->writesize)
                                block++;
                        page >>=3D 1;
                }
                page &=3D this->page_mask;
                break;


--- start log nandtest fail ---
# nandtest -l 262144 /dev/mtd3
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 0
BBT blocks     : 0
00000000: writing...
[  243.144287] onenand_command[382] page 0, 2621440, 0
[  243.150787] onenand_command[382] page 2, 2621440, 2
[  243.156158] onenand_command[382] page 4, 2621440, 4
(...)
[  243.310729] onenand_command[382] page 60, 2621440, 60
[  243.316223] onenand_command[382] page 62, 2621440, 62
[  243.322204] onenand_command[382] page 0, 2752512, 0
[  243.327636] onenand_command[382] page 2, 2752512, 2
[  243.332977] onenand_command[382] page 4, 2752512, 4
(...)
[  243.487487] onenand_command[382] page 60, 2752512, 60
[  243.493041] onenand_command[382] page 62, 2752512, 62
00000000: reading...
[  243.498535] onenand_command[382] page 0, 2621440, 0
[  243.505249] onenand_wait: ECC error =3D 0x8488
[  243.509552] onenand_command[382] page 1, 2621440, 1
[  243.514587] onenand_wait: ECC error =3D 0x8488
[  243.518890] onenand_command[382] page 2, 2621440, 2
(...)
[  244.089050] onenand_command[382] page 62, 2621440, 62
[  244.094268] onenand_wait: ECC error =3D 0x8448
[  244.098602] onenand_command[382] page 63, 2621440, 63
[  244.103790] onenand_wait: ECC error =3D 0x8488
[  244.109191] onenand_command[382] page 0, 2752512, 0
[  244.114196] onenand_wait: ECC error =3D 0x8488
[  244.118469] onenand_command[382] page 1, 2752512, 1
[  244.123535] onenand_wait: ECC error =3D 0x8488
[  244.127838] onenand_command[382] page 2, 2752512, 2
(...)
[  244.698150] onenand_command[382] page 62, 2752512, 62
[  244.703369] onenand_wait: ECC error =3D 0x8448
[  244.707672] onenand_command[382] page 63, 2752512, 63
[  244.712890] onenand_wait: ECC error =3D 0x8488

ECC failed at 00000000
00000000: checking...
compare failed. seed 1804289383
Byte 0x1 is 5a should be da
Byte 0x3 is 82 should be 92
Byte 0x4 is 10 should be 1a
Byte 0x5 is 21 should be b7

--- end log nandtest fail ---


With this other code nandtest pass

onenand_base.c

377:     default:
                block =3D onenand_block(this, addr);
                page =3D (int) (addr >> this->page_shift);
/* (line disabled)  page =3D (int) (addr - onenand_addr(this, block)) >=
>
this->page_shift; */

                printk("%s[%d] page %d, %d, %d\n", __func__, __LINE__,
page, (int)
                        onenand_addr(this, block), ((int) addr >>
this->page_shift) &
                        this->page_mask);

                if (ONENAND_IS_2PLANE(this)) {
                        /* Make the even block number */
                        block &=3D ~1;
                        /* Is it the odd plane? */
                        if (addr & this->writesize)
                                block++;
                        page >>=3D 1;
                }
                page &=3D this->page_mask;
                break;

--- start log nandtest pass ---
# nandtest -l 262144 /dev/mtd3
ECC corrections: 0
ECC failures   : 33
Bad blocks     : 0
BBT blocks     : 0
00000000: writing...
[ 2024.624664] onenand_command[382] page 1280, 2621440, 0
[ 2024.631530] onenand_command[382] page 1282, 2621440, 2
[ 2024.637145] onenand_command[382] page 1284, 2621440, 4
(...)
[ 2024.796813] onenand_command[382] page 1340, 2621440, 60
[ 2024.802520] onenand_command[382] page 1342, 2621440, 62
[ 2024.808593] onenand_command[382] page 1344, 2752512, 0
[ 2024.814239] onenand_command[382] page 1346, 2752512, 2
(...)
[ 2024.979644] onenand_command[382] page 1404, 2752512, 60
[ 2024.985351] onenand_command[382] page 1406, 2752512, 62
00000000: reading...
[ 2024.990997] onenand_command[382] page 1280, 2621440, 0
[ 2024.997985] onenand_command[382] page 1281, 2621440, 1
[ 2025.003295] onenand_command[382] page 1282, 2621440, 2
(...)

[ 2025.326782] onenand_command[382] page 1342, 2621440, 62
[ 2025.332214] onenand_command[382] page 1343, 2621440, 63
[ 2025.338592] onenand_command[382] page 1344, 2752512, 0
[ 2025.343811] onenand_command[382] page 1345, 2752512, 1
[ 2025.349151] onenand_command[382] page 1346, 2752512, 2
(...)
[ 2025.672576] onenand_command[382] page 1406, 2752512, 62
[ 2025.677978] onenand_command[382] page 1407, 2752512, 63
00000000: checking...
=46inished pass 1 successfully
--- end log nandtest pass ---

>
> In my test environment, it displays the correct page number.
> (addr - onenand_addr(this, block) >> this->page_shift is same as
> '(addr >> this->page_shift) & this->page_mask'.
>

Looks like page number is wrong ?

Cheers,

Enric

> Thank you,
> Kyungmin Park
>
> On Fri, Apr 30, 2010 at 7:05 PM, Enric Balletb=C3=B2 i Serra
> <eballetbo@gmail.com> wrote:
>> Hello all,
>>
>> After commit 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd:
>> Flex-OneNAND support) the onenand support for my device is broken.
>>
>> Before this commit when I run the nandtest program all is ok
>> ---
>> # nandtest /dev/mtd3
>> ECC corrections: 0
>> ECC failures =C2=A0 : 0
>> Bad blocks =C2=A0 =C2=A0 : 0
>> BBT blocks =C2=A0 =C2=A0 : 0
>> 002c0000: checking...
>> Finished pass 1 successfully
>> --
>>
>> Introduced commit 5988af2319781bc8e0ce418affec4e09cfa7790 the nandte=
st
>> fails with:
>> ---
>> # nandtest /dev/mtd3
>> ECC corrections: 0
>> ECC failures =C2=A0 : 0
>> Bad blocks =C2=A0 =C2=A0 : 0
>> BBT blocks =C2=A0 =C2=A0 : 0
>> 00000000: reading...
>> [ =C2=A0299.092041] onenand_wait: ECC error =3D 0x8488
>> =C2=A0 =C2=A0( ... lots of ECC errors ... )
>> [ =C2=A0299.092041] onenand_wait: ECC error =3D 0x8488
>> ECC failed at 00000000
>> 00000000: checking...
>> compare failed. seed 1804289383
>> Byte 0x1 is 5a should be da
>> Byte 0x3 is 82 should be 92
>> Byte 0x4 is 10 should be 1a
>> =C2=A0 =C2=A0( ... )
>> ---
>>
>> Investigating a little I see a significant difference introduced by
>> this patch. In line
>>
>> 347: =C2=A0 =C2=A0 =C2=A0 =C2=A0page =3D (int) (addr - onenand_addr(=
this, block)) >>
>> this->page_shift; =C2=A0 (patch applied)
>>
>> instead of
>>
>> 347: =C2=A0 =C2=A0 =C2=A0 =C2=A0page =3D (int) (addr >> this->page_s=
hift); =C2=A0(without patch)
>>
>> I applied commit 5988af2319781bc8e0ce418affec4e09cfa7790 and replace=
d
>> the line 347 and now works again. Fantastic, but I suspect this is n=
ot
>> the proper solution (probably this breaks other onenands devices, I
>> can't test).
>>
>> I'm just introducing in OneNAND devices so anyone can help me to
>> understand and solve the problem ? Note that my device is a Numonyx
>> 4-Gbit DDP (DUAL DIE PLAN) OneNAND flash memory ( 2 dice of 2Gb, 2KB
>> page )
>>
>> Thanks in advance,
>>
>> ///:~Enric
>>
>> ---
>> diff --git a/drivers/mtd/onenand/onenand_base.c
>> b/drivers/mtd/onenand/onenand_base.c
>> index 081f97d..b1d50a3 100644
>> --- a/drivers/mtd/onenand/onenand_base.c
>> +++ b/drivers/mtd/onenand/onenand_base.c
>> @@ -344,7 +344,7 @@ static int onenand_command(struct mtd_info *mtd,
>> int cmd, loff_t addr, size_t le
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D (in=
t) onenand_block(this, addr);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page =3D (int) (a=
ddr - onenand_addr(this, block)) >> this->page_shift;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page =3D (int) (a=
ddr >> this->page_shift);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ONENAND_I=
S_2PLANE(this)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Make the even block number */
>> ---
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
