From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Sat, 2 Jan 2010 07:02:36 -0800
Message-ID: <5e088bd91001020702q3021cea2ve5d71ffff7fc1c62@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	 <20091223174429.GD3512@atomide.com>
	 <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	 <5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
	 <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:21300 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0ABPCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jan 2010 10:02:37 -0500
Received: by qw-out-2122.google.com with SMTP id 8so1548835qwh.37
        for <linux-omap@vger.kernel.org>; Sat, 02 Jan 2010 07:02:36 -0800 (PST)
In-Reply-To: <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Thu, Dec 31, 2009 at 4:20 AM, Vimal Singh <vimal.newwork@gmail.com> =
wrote:
> On Wed, Dec 30, 2009 at 3:17 AM, Steve Sakoman <sakoman@gmail.com> wr=
ote:
>> On Tue, Dec 29, 2009 at 12:38 PM, Steve Sakoman <sakoman@gmail.com> =
wrote:
>>
>>> I can confirm that this issue exists on Overo too. =A0Sadly, switch=
ing
>>> to 16 bit reads does not fix the issue for me. =A0I'll start diggin=
g to
>>> see if I can find what's broken.
>>
>> I can also confirm that there are days when I am not even capable of
>> applying a patch properly :-(
>>
>> Switching to 16 bit read accesses does indeed fix the ECC issue on O=
vero too.
>>
>> Which still leaves us needing to find the root cause of the breakage=
 . . .
>
> There is a bug in nand prefetch read routine, which comes into effect
> only if nand device is a 16-bit device (as we have in zoom boards).
> This bug is effective only with below combination of conditions:
> 1. nand deivce, in use, is a 16 bit device
> 2. nand driver supports 'subpage' read
> 3. SW ECC is in use
>
> This was not seen old =A0kernel (ex: .23), because when, in early day=
s,
> we tested this (nand prefetch read in LDP boards) there was no
> 'subpage read' support.
> Later when we had subpage read in (.27) kernel, we had hw ecc enabled
> always in our internal tree. So, we missed this bug.
>
> Here is a patch to fix this issue:
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..75004fe 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
> =A0 =A0 =A0 =A0u32 *p =3D (u32 *)buf;
>
> =A0 =A0 =A0 =A0/* take care of subpage reads */
> - =A0 =A0 =A0 for (; len % 4 !=3D 0; ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D __raw_readb(info->nand.IO_AD=
DR_R);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 len--;
> + =A0 =A0 =A0 if (len % 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_=
16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, bu=
f, len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf=
, len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) (buf + len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D len % 4;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 p =3D (u32 *) buf;
>
> =A0 =A0 =A0 =A0/* configure and start prefetch transfer */
> =A0 =A0 =A0 =A0ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, =
0x0);

I tested this on Overo and can confirm that it fixes the issue.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
