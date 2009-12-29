From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Tue, 29 Dec 2009 12:38:48 -0800
Message-ID: <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	 <20091223174429.GD3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:59357 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZL2Uit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 15:38:49 -0500
Received: by qyk30 with SMTP id 30so5317309qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 12:38:48 -0800 (PST)
In-Reply-To: <20091223174429.GD3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 23, 2009 at 9:44 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Vimal Singh <vimal.newwork@gmail.com> [091223 01:32]:
>> In omap nand driver we used to do 32-bit reads (in function
>> omap_read_buf_pref, using 'ioread32_rep' i.e.: __raw_readsl), and it
>> was working fine till some time back. But now, somehow, this has got
>> some problem. Reads are not being done successfully, and driver give=
s
>> lots for error reprot like below:
>>
>> td->read(0x604 bytes from 0x1fc) returned ECC error
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> uncorrectable error :
>> mtd->read(0x520 bytes from 0x2e0) returned ECC error
>>
>> While if we change 32-bit reads to 16-bit reads (using 'ioread16_rep=
'
>> i.e.: __raw_readwl) makes it working fine. (A patch to do this is
>> listed below at the bottom of this mail.)
>>
>> I have not seen any change in routine '__raw_readsl'.
>> So, could someone help me find out the root cause the issue?
>>
>> Thanks for any input.
>
> Maybe an issue with the GPMC timings?

I can confirm that this issue exists on Overo too.  Sadly, switching
to 16 bit reads does not fix the issue for me.  I'll start digging to
see if I can find what's broken.

Steve


> Regards,
>
> Tony
>
>>
>> --
>> Regards,
>> Vimal Singh
>>
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index aaef170..dc493f5 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -288,14 +288,14 @@ static void omap_read_buf_pref(struct mtd_info
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 struct omap_nand_info, mtd);
>> =A0 =A0 =A0 uint32_t pfpw_status =3D 0, r_count =3D 0;
>> =A0 =A0 =A0 int ret =3D 0;
>> - =A0 =A0 u32 *p =3D (u32 *)buf;
>> + =A0 =A0 u16 *p =3D (u16 *)buf;
>>
>> =A0 =A0 =A0 /* take care of subpage reads */
>> - =A0 =A0 for (; len % 4 !=3D 0; ) {
>> + =A0 =A0 for (; len % 2 !=3D 0; ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D __raw_readb(info->nand.IO_ADD=
R_R);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 len--;
>> =A0 =A0 =A0 }
>> - =A0 =A0 p =3D (u32 *) buf;
>> + =A0 =A0 p =3D (u16 *) buf;
>>
>> =A0 =A0 =A0 /* configure and start prefetch transfer */
>> =A0 =A0 =A0 ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x=
0);
>> @@ -308,10 +308,10 @@ static void omap_read_buf_pref(struct mtd_info
>> *mtd, u_char *buf, int len)
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_pre=
fetch_status();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_count =3D ((pfpw_status =
>> 24) & 0x7F) >> 2;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32_rep(info->nand_pr=
ef_fifo_add, p, r_count);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_count =3D ((pfpw_status =
>> 24) & 0x7F) >> 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread16_rep(info->nand_pr=
ef_fifo_add, p, r_count);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p +=3D r_count;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D r_count << 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D r_count << 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (len);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable and stop the PFPW engine */
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
