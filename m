From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: Possible bug in onenand_base ?
Date: Mon, 12 Jul 2010 16:59:27 +0200
Message-ID: <AANLkTikDPqoO_VGJtBKWHutPOb60XAIUAYOu7kIRxMyQ@mail.gmail.com>
References: <u2v70c9a9111004300305n4c86774bm7ed70161ad72d830@mail.gmail.com>
	<z2p9c9fda241005052046j3fea69a4v91f3d5fd86648fac@mail.gmail.com>
	<k2x70c9a9111005060422v90e246daw19b1f71d57a890a1@mail.gmail.com>
	<g2x9c9fda241005060444x7f9c4360u334d3afb06f1e8b8@mail.gmail.com>
	<z2v70c9a9111005060602n7b7477ebueb197af05372bd5@mail.gmail.com>
	<AANLkTimwO5iU6zPUJeLwAxW3GZGz5ldSRLmp2vpTBem3@mail.gmail.com>
	<AANLkTiktbqSHHw572y1YGVw7XhZaim9Pg3lhoMmDBLXY@mail.gmail.com>
	<AANLkTin43tv-AiFjwNkUE7ijy_ADMtsZTrqo_PY3DpCE@mail.gmail.com>
	<1278583087.20321.0.camel@localhost>
	<AANLkTiludbDD8ndnQlqxyWeP7us-BxaEDHvKfDpw-AW8@mail.gmail.com>
	<1278584577.20321.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38289 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0GLO72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 10:59:28 -0400
Received: by pwi5 with SMTP id 5so1827356pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Jul 2010 07:59:27 -0700 (PDT)
In-Reply-To: <1278584577.20321.2.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Kyungmin Park <kmpark@infradead.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Rohit Hagargundgi <h.rohit@samsung.com>

Hello,

2010/7/8 Artem Bityutskiy <dedekind1@gmail.com>:
> On Thu, 2010-07-08 at 12:11 +0200, Enric Balletb=C3=B2 i Serra wrote:
>> Hello,
>>
>> 2010/7/8 Artem Bityutskiy <dedekind1@gmail.com>:
>> > On Thu, 2010-07-08 at 11:55 +0200, Enric Balletb=C3=B2 i Serra wro=
te:
>> >> Hello,
>> >>
>> >> I made new tests regarding this issue. Looks like the problem is
>> >> reading from the OneNAND device.
>> >
>> > Did you try older kernel and then bisecting who is responsible for=
 the
>> > breakage?
>>
>> Yes, before commit
>>
>> 5988af2319781bc8e0ce418affec4e09cfa77907 (mtd: Flex-OneNAND support)
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D5988af2319781bc8e0ce418affec4e09cfa77907
>>
>> my =C2=A0OneNAND is working, after the commit, the OneNAND support i=
s broken.
>
> Ok, we could revert it, but it is better to fix it. CCing the author =
of
> the commit.


Comparing the onenand_base.c file before commit

  5988af2319781bc8e0ce418affec4e09cfa77907 (mtd: Flex-OneNAND support)

and after the commit I made a little patch which seems solves the
issue. The patch has two parts.

The first part replaces line 380 with  'page =3D (int) (addr >>
this->page_shift);' like before apply the Flex-OneNAND support. I
suppose this is not the better solution, but with this the nandtest
tool works for me. Maybe the author of the commit can clarify this.

The second part (1964) adds two lines which I think are missed when
the Flex-OneNAND support was applied.

diff --git a/drivers/mtd/onenand/onenand_base.c
b/drivers/mtd/onenand/onenand_base.c
index 26caf25..a39d906 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -377,7 +377,7 @@ static int onenand_command(struct mtd_info *mtd,
int cmd, loff_t addr, size_t le

        default:
                block =3D onenand_block(this, addr);
-               page =3D (int) (addr - onenand_addr(this, block)) >>
this->page_shift;
+               page =3D (int) (addr >> this->page_shift);

                if (ONENAND_IS_2PLANE(this)) {
                        /* Make the even block number */
@@ -1961,6 +1961,9 @@ static int onenand_write_ops_nolock(struct
mtd_info *mtd, loff_t to,

                        /* In partial page write we don't update buffer=
ram */
                        onenand_update_bufferram(mtd, to, !ret && !subp=
age);
+                       ONENAND_SET_BUFFERRAM1(this);
+                       onenand_update_bufferram(mtd, to +
this->writesize, !ret && !subpage);
+
                        if (ret) {
                                printk(KERN_ERR "%s: write failed %d\n"=
,
                                        __func__, ret);

Best regards,

Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
