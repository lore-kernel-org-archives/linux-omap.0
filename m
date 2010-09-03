From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 5/5] OMAP McSPI: Adapt McSPI driver to use omap hwmod
Date: Fri, 3 Sep 2010 18:23:02 +0530
Message-ID: <AANLkTikEE=Bx2jJ2efNZg=gptBECqW6xMnvx_-mJBAdY@mail.gmail.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
	<1281708323-18989-2-git-send-email-charu@ti.com>
	<1281708323-18989-3-git-send-email-charu@ti.com>
	<1281708323-18989-4-git-send-email-charu@ti.com>
	<1281708323-18989-5-git-send-email-charu@ti.com>
	<1281708323-18989-6-git-send-email-charu@ti.com>
	<AANLkTi=qN2nOJ4nRmS=C0kBa7y3=13iQ-ZEHHw5FeGne@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56331 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab0ICMxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 08:53:05 -0400
Received: by ewy23 with SMTP id 23so1021546ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 05:53:03 -0700 (PDT)
In-Reply-To: <AANLkTi=qN2nOJ4nRmS=C0kBa7y3=13iQ-ZEHHw5FeGne@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com

Grant,

Thanks for the review. Comments inlined.


On Sat, Aug 14, 2010 at 4:39 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
>> From: Govindraj.R <govindraj.raja@ti.com>
>>
>> This patch converts the McSPI driver to use pm_runtime apis while
>> implementing it in HWMOD FW way.
>
> Hi Govindraj,
>
> Some comments below. =A0Short version is that this patch seems to lum=
p a
> number of (mostly) unrelated changes (the register map, HWMOD stuff,
> and runtime pm) that makes it hard to review and understand. =A0I cou=
ld
> use some help understanding what the intent of the patch is, and it
> would also help to split it up.
>
> Cheers,
> g.

Sure, I will split this patch as below.

1.) reg map update
2.) hwmod update(like removing dma macros etc.) + runtime (if split,
git bisect can break)
     (Since clock handling will be done with hwmod)

<snip>

>> + =A0 =A0 =A0 [OMAP2_MCSPI_RX0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x13=
c,
>> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_REV] =A0 =A0 =A0 =A0 =A0 =A0=3D 0x000,
>> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_HWINFO] =A0 =A0 =A0 =A0 =3D 0x004,
>> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_SYSCONFIG] =A0 =A0 =A0=3D 0x010,
>> +};
>
> Other than an 0x100 offset for omap4 and the addition of revision
> registers, these two register maps are identical. =A0Is it really wor=
th
> having a complete register map table for two things that aren't reall=
y
> different? =A0It looks overengineered.
>
> Personally I'd handle this by having two base address pointers; the
> regs pointer and the info/revision pointer. =A0omap4 would have the
> revision base set, and omap2 would not.
>

Yes will have a single table for register offset, pass a
0x100(probably named as offset deviation)
value from platform data to be added while read/write to registers for
omap4 and others can have 0

<snip>

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->mode =3D OMAP2_MCSPI_MASTER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->dma_mode =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->force_cs_mode =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->fifo_depth =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case 3:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>
> HWMOD appears to have the purpose of making device instantiation data
> driven. =A0If so, shouldn't these parameters also be extracted from t=
he
> HWMOD data?

Yes these params can be passed from hwmod data
This has to part of dev attribute data that can be passed from hwmod da=
ta.


<snip>

>> - =A0 =A0 =A0 mcspi->ick =3D clk_get(&pdev->dev, "ick");
>> - =A0 =A0 =A0 if (IS_ERR(mcspi->ick)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "can't get mcspi_i=
ck\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(mcspi->ick);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1a;
>> - =A0 =A0 =A0 }
>> - =A0 =A0 =A0 mcspi->fck =3D clk_get(&pdev->dev, "fck");
>> - =A0 =A0 =A0 if (IS_ERR(mcspi->fck)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "can't get mcspi_f=
ck\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(mcspi->fck);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> - =A0 =A0 =A0 }
>> -
>
> I'm obviously missing some context here. =A0The driver doesn't seem t=
o
> manage the clocks anymore. =A0What code does now?

hwmod layer is handling all clocks now.

<snip>

>> +
>> =A0static struct platform_driver omap2_mcspi_driver =3D {
>> =A0 =A0 =A0 =A0.driver =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D =A0 =A0 =A0 =A0 "omap2_mcspi=
",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap2_mcspi",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &omap_mcspi_dev_pm_ops=
,
>
> nit: Unrelated whitespace changes.
>

Will correct this in next version.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
