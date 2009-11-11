From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 1/3] Fixing compilation warning for 'nand/omap2.c'
Date: Wed, 11 Nov 2009 10:10:35 +0530
Message-ID: <ce9ab5790911102040r5cfbe5a3v310a2316a11825b@mail.gmail.com>
References: <ce9ab5790910292321nf230810v353c23f9c1ce1931@mail.gmail.com>
	<ce9ab5790910300142s615c7d59h15bb2d46d4f76574@mail.gmail.com>
	<1257236323.21596.56.camel@localhost> <ce9ab5790911030038p31bb69cfs1ba86cd70b243e4c@mail.gmail.com>
	<1257237728.21596.65.camel@localhost> <ce9ab5790911030101t256e49e8iaf26c733e6472157@mail.gmail.com>
	<1257862827.21596.760.camel@localhost> <1257863201.21596.766.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62653 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455AbZKKEku convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 23:40:50 -0500
Received: by bwz27 with SMTP id 27so696298bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 20:40:55 -0800 (PST)
In-Reply-To: <1257863201.21596.766.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Tue, Nov 10, 2009 at 7:56 PM, Artem Bityutskiy <dedekind1@gmail.com>=
 wrote:
> On Tue, 2009-11-10 at 16:20 +0200, Artem Bityutskiy wrote:
>> On Tue, 2009-11-03 at 14:31 +0530, Vimal Singh wrote:
>> > >> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.=
c
>> > >> index 090ab87..92573d5 100644
>> > >> --- a/drivers/mtd/nand/omap2.c
>> > >> +++ b/drivers/mtd/nand/omap2.c
>> > >> @@ -501,11 +501,13 @@ static void omap_read_buf_dma_pref(struct
>> > >> mtd_info *mtd, u_char
>> > >
>> > > :-) It is the same again.
>> > >
>> > > Try to send the e-mail to yourself, then save it and apply with =
git-am.
>> > > If it works, send to the mailing list.
>> >
>> > Below patch applies. Sorry for noise... :(
>> >
>> > Thanks,
>> > vimal
>> >
>> >
>> > From eebbd81141b196af2dc3f7a2650ce16b6b0d76ae Mon Sep 17 00:00:00 =
2001
>> > From: Vimal Singh <vimalsingh@ti.com>
>> > Date: Fri, 30 Oct 2009 11:31:34 +0530
>> > Subject: [PATCH] Fixing compilation warning for 'nand/omap2.c'
>> >
>> > Fixing below warning in compilation:
>> > drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
>> > drivers/mtd/nand/omap2.c:508: warning: passing argument 2 of
>> > 'omap_nand_dma_transfer' discards qualifiers from pointer target t=
ype
>> >
>> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> > ---
>> > =A0drivers/mtd/nand/omap2.c | =A0 =A06 ++++--
>> > =A01 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> > index 090ab87..92573d5 100644
>> > --- a/drivers/mtd/nand/omap2.c
>> > +++ b/drivers/mtd/nand/omap2.c
>> > @@ -501,11 +501,13 @@ static void omap_read_buf_dma_pref(struct
>> > =A0static void omap_write_buf_dma_pref(struct mtd_info *mtd,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const u_char *buf, int len)
>> > =A0{
>> > + =A0 u_char *p =3D (u_char *)buf;
>> > +
>> > =A0 =A0 if (len <=3D mtd->oobsize)
>> > - =A0 =A0 =A0 =A0 =A0 omap_write_buf_pref(mtd, buf, len);
>> > + =A0 =A0 =A0 =A0 =A0 omap_write_buf_pref(mtd, p, len);
>> > =A0 =A0 else
>> > =A0 =A0 =A0 =A0 =A0 =A0 /* start transfer in DMA mode */
>> > - =A0 =A0 =A0 =A0 =A0 omap_nand_dma_transfer(mtd, buf, len, 0x1);
>> > + =A0 =A0 =A0 =A0 =A0 omap_nand_dma_transfer(mtd, p, len, 0x1);
>> > =A0}
>>
>> I think that you should instead remove the 'const' modifier from the
>> 'omap_write_buf_dma_pref()' function. Indeed, if it has the 'const'
>> modifier, it should never change the bugger.
>
> Sorry, s/bugger/buffer/
> :-)

Write calls are intended to copy data bytes from supplied buffer to
NAND. So yes, these calls are not supposed to change this buffer.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
