From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH 3/4] omap4: pandaboard: Adding card detect support for MMC1
Date: Wed, 22 Sep 2010 14:13:09 +0530
Message-ID: <AANLkTi==h+sBQ08R2=XhjSNXjA5n6yFQWut=djrc2txo@mail.gmail.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
 <1285104244-32274-4-git-send-email-x0132446@ti.com> <AANLkTi=Us2g=+E50MRPXHuOnNYa2aV3tmxZj3sGS-kQ8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37752 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752362Ab0IVInb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 04:43:31 -0400
Received: by mail-ww0-f45.google.com with SMTP id 36so333819wwa.2
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 01:43:30 -0700 (PDT)
In-Reply-To: <AANLkTi=Us2g=+E50MRPXHuOnNYa2aV3tmxZj3sGS-kQ8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: David Anders <x0132446@ti.com>, jayabharath@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

On Wed, Sep 22, 2010 at 12:58 PM, Bryan Wu <bryan.wu@canonical.com> wro=
te:
> On Wed, Sep 22, 2010 at 5:24 AM, David Anders <x0132446@ti.com> wrote=
:
>> Adding card detect callback function and card detect configuration
>> function for MMC1 Controller.
>>
>> Signed-off-by: David Anders <x0132446@ti.com>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> ---
>>
>> patch depends on https://patchwork.kernel.org/patch/189952/
>>
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index 697c0bd..94e819c 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -77,9 +77,14 @@ static int omap4_twl6030_hsmmc_late_init(struct d=
evice *dev)
>> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platfor=
m_data;
>>
>> =A0 =A0 =A0 =A0/* Setting MMC1 Card detect Irq */
>> - =A0 =A0 =A0 if (pdev->id =3D=3D 0)
>> + =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_mmc_card_detect_config=
();
>
> It looks like we need this function from twl6030 driver, otherwise we
> will get this compiling error:
>
> ----
> In file included from arch/arm/mach-omap2/board-omap4panda.c:38:
> arch/arm/plat-omap/include/plat/usb.h:109: warning: return type
> defaults to 'int'
> arch/arm/mach-omap2/board-omap4panda.c: In function
> 'omap4_twl6030_hsmmc_late_init':
> arch/arm/mach-omap2/board-omap4panda.c:81: error: implicit declaratio=
n
> of function 'twl6030_mmc_card_detect_config'
> arch/arm/mach-omap2/board-omap4panda.c:86: error:
> 'twl6030_mmc_card_detect' undeclared (first use in this function)
> arch/arm/mach-omap2/board-omap4panda.c:86: error: (Each undeclared
> identifier is reported only once
> arch/arm/mach-omap2/board-omap4panda.c:86: error: for each function i=
t
> appears in.)
> arch/arm/mach-omap2/board-omap4panda.c: In function 'omap4_panda_init=
':
> arch/arm/mach-omap2/board-omap4panda.c:285: warning: unused variable =
'status'
> ----
>
> Thanks,
> -Bryan

I thought the dependent patch [1] took care of this in the header file?
(Haven't actually tried this out - will take a look in a bit)

[1] https://patchwork.kernel.org/patch/189952/

>
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed configu=
ring MMC1 card detect\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D T=
WL6030_IRQ_BASE +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect =3D twl603=
0_mmc_card_detect;
>> + =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
\
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
