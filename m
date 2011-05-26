From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Thu, 26 May 2011 16:37:00 -0700
Message-ID: <BANLkTin=QRJ703gGuJCBOiZnDaX4wKgg7w@mail.gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-4-git-send-email-nm@ti.com>
 <87oc2p82q0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40119 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755356Ab1EZXhZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 19:37:25 -0400
Received: by mail-ww0-f42.google.com with SMTP id 4so5298252wwk.5
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 16:37:20 -0700 (PDT)
In-Reply-To: <87oc2p82q0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Moiz Sonasath <m-sonasath@ti.com>

On Thu, May 26, 2011 at 16:24, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> From: Moiz Sonasath <m-sonasath@ti.com>
>>
>> For OMAP4460, GPIO-7 of bank1 is used for controling
>> the TPS modes, hence GPIO1 should not be reset
>> during init as reset will cause the TPS voltage to
>> drop to 0.9 V.
>
> ouch. =A0I knew one of these days something like this was going to ha=
ppen
> with GPIO resets.
>
> Re: $SUBJECT, hwmod is not an acronym. =A0Please use lower case.
>
>> Originally from:
>> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommitdiff;h=3D52ae=
4f0de03b17c064d9ce90a580230f1a596ec1
>>
>> [nm@ti.com: upstream version]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 27 +++++++++++++=
+++++++++++---
>> =A01 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 2f51a5a..27319c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1745,7 +1745,7 @@ static struct omap_hwmod_opt_clk gpio1_opt_clk=
s[] =3D {
>> =A0 =A0 =A0 { .role =3D "dbclk", .clk =3D "gpio1_dbclk" },
>> =A0};
>>
>> -static struct omap_hwmod omap44xx_gpio1_hwmod =3D {
>> +static struct omap_hwmod omap443x_gpio1_hwmod =3D {
>> =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_gpio_hwmod_class=
,
>> =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_gpio1_irqs,
>> @@ -1761,7 +1761,27 @@ static struct omap_hwmod omap44xx_gpio1_hwmod=
 =3D {
>> =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &gpio_dev_attr,
>> =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_gpio1_slaves,
>> =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_gpio1_slaves=
),
>> - =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44XX)=
,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +static struct omap_hwmod omap446x_gpio1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "gpio1",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_gpio_hwmod_class,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_INIT_NO_RESET,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_gpio1_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_gpio1_irqs),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "gpio1_ick",
>> + =A0 =A0 .prcm =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4430_=
CM_WKUP_GPIO1_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D gpio1_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(gpio1_opt_clks),
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &gpio_dev_attr,
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_gpio1_slaves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_gpio1_slaves),
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4460)=
,
>> =A0};
>
> This is a board-specific problem that you've "fixed" in a way that
> affects every 4460-based device.
>
> Rather than setting the flag in the hwmod data, you need to fix this
> in a board-specific way.
>
> The hwmod layer provides an API for this: omap_hwmod_no_setup_reset()
> which should be called by board-specific code.
>

aah - a better solution.. thanks.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
