From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Mon, 11 Jan 2010 12:00:53 +0530
Message-ID: <ce9ab5791001102230j7923ef01j6f17b7ca9fafde56@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	<20091223174429.GD3512@atomide.com> <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	<5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
	<ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
	<1263113195.7315.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44477 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0AKGbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 01:31:16 -0500
Received: by bwz27 with SMTP id 27so31940bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 10 Jan 2010 22:31:14 -0800 (PST)
In-Reply-To: <1263113195.7315.129.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Sun, Jan 10, 2010 at 2:16 PM, Artem Bityutskiy <dedekind1@gmail.com>=
 wrote:
> On Thu, 2009-12-31 at 17:50 +0530, Vimal Singh wrote:
>> There is a bug in nand prefetch read routine, which comes into effec=
t
>> only if nand device is a 16-bit device (as we have in zoom boards).
>> This bug is effective only with below combination of conditions:
>> 1. nand deivce, in use, is a 16 bit device
>> 2. nand driver supports 'subpage' read
>> 3. SW ECC is in use
>>
>> This was not seen old =A0kernel (ex: .23), because when, in early da=
ys,
>> we tested this (nand prefetch read in LDP boards) there was no
>> 'subpage read' support.
>> Later when we had subpage read in (.27) kernel, we had hw ecc enable=
d
>> always in our internal tree. So, we missed this bug.
>>
>> Here is a patch to fix this issue:
>>
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 1bb799f..75004fe 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
>> =A0 =A0 =A0 u32 *p =3D (u32 *)buf;
>>
>> =A0 =A0 =A0 /* take care of subpage reads */
>> - =A0 =A0 for (; len % 4 !=3D 0; ) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D __raw_readb(info->nand.IO_ADDR_=
R);
>> - =A0 =A0 =A0 =A0 =A0 =A0 len--;
>> + =A0 =A0 if (len % 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, buf, =
len % 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf, l=
en % 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) (buf + len % 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len -=3D len % 4;
>> =A0 =A0 =A0 }
>> - =A0 =A0 p =3D (u32 *) buf;
>>
>> =A0 =A0 =A0 /* configure and start prefetch transfer */
>> =A0 =A0 =A0 ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x=
0);
>
> Pushed this patch to my l2-mtd-2.6.git/dunno.
>

I have posted this patch formally in patch series:
[PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues

Corresponding patch is:
[PATCH 3/3][NAND][OMAP] : Fixing issue in oamp nand driver in prefetch =
mode read

Can you please give a look for this patch series?

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
