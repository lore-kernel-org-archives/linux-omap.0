From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Thu, 31 Dec 2009 17:50:44 +0530
Message-ID: <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	<20091223174429.GD3512@atomide.com> <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	<5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60299 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZLaMVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 07:21:07 -0500
Received: by bwz27 with SMTP id 27so7914357bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 31 Dec 2009 04:21:04 -0800 (PST)
In-Reply-To: <5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 30, 2009 at 3:17 AM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> On Tue, Dec 29, 2009 at 12:38 PM, Steve Sakoman <sakoman@gmail.com> w=
rote:
>
>> I can confirm that this issue exists on Overo too. =A0Sadly, switchi=
ng
>> to 16 bit reads does not fix the issue for me. =A0I'll start digging=
 to
>> see if I can find what's broken.
>
> I can also confirm that there are days when I am not even capable of
> applying a patch properly :-(
>
> Switching to 16 bit read accesses does indeed fix the ECC issue on Ov=
ero too.
>
> Which still leaves us needing to find the root cause of the breakage =
=2E . .

There is a bug in nand prefetch read routine, which comes into effect
only if nand device is a 16-bit device (as we have in zoom boards).
This bug is effective only with below combination of conditions:
1. nand deivce, in use, is a 16 bit device
2. nand driver supports 'subpage' read
3. SW ECC is in use

This was not seen old  kernel (ex: .23), because when, in early days,
we tested this (nand prefetch read in LDP boards) there was no
'subpage read' support.
Later when we had subpage read in (.27) kernel, we had hw ecc enabled
always in our internal tree. So, we missed this bug.

Here is a patch to fix this issue:

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1bb799f..75004fe 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
 	u32 *p =3D (u32 *)buf;

 	/* take care of subpage reads */
-	for (; len % 4 !=3D 0; ) {
-		*buf++ =3D __raw_readb(info->nand.IO_ADDR_R);
-		len--;
+	if (len % 4) {
+		if (info->nand.options & NAND_BUSWIDTH_16)
+			omap_read_buf16(mtd, buf, len % 4);
+		else
+			omap_read_buf8(mtd, buf, len % 4);
+		p =3D (u32 *) (buf + len % 4);
+		len -=3D len % 4;
 	}
-	p =3D (u32 *) buf;

 	/* configure and start prefetch transfer */
 	ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
