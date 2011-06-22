From: "Ghongdemath, Girish" <girishsg@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: Regulator: Specify system has fully specified constraints
Date: Wed, 22 Jun 2011 17:32:54 -0500
Message-ID: <BANLkTikrfgHpMTDckUKYSBB1u5YrrT=AQw@mail.gmail.com>
References: <1308702288-12787-1-git-send-email-girishsg@ti.com>
	<BANLkTim6sY=2qQ7isxhKSWgjCWCrc5UX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36113 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759132Ab1FVWcz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 18:32:55 -0400
Received: by mail-yi0-f54.google.com with SMTP id 13so662536yic.41
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 15:32:54 -0700 (PDT)
In-Reply-To: <BANLkTim6sY=2qQ7isxhKSWgjCWCrc5UX4g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Jun 22, 2011 at 5:12 PM, Pandita, Vikram <vikram.pandita@ti.com=
> wrote:
> On Tue, Jun 21, 2011 at 5:24 PM, Girish S G <girishsg@ti.com> wrote:
> <snip>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-oma=
p2/board-4430sdp.c
>> index 04b7770..46f6800 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -560,6 +560,9 @@ static struct i2c_board_info __initdata sdp4430_=
i2c_4_boardinfo[] =3D {
>> =A0};
>> =A0static int __init omap4_i2c_init(void)
>> =A0{
>> + =A0 =A0 =A0 /* This will allow unused regulator to be shutdown */
>> + =A0 =A0 =A0 regulator_has_full_constraints();
>> +
>
> Any particular reason to keep this call in i2c_init() function?
> Does not look very intuitive to have generic regulator disable call i=
n
> an i2c init function !

In the regulator late init call the core will decide on regulator
status, so this has to be specified
before the pmic/twl data is registered.


Regards,
Girish

>
>
>> =A0 =A0 =A0 =A0omap4_pmic_init("twl6030", &sdp4430_twldata);
>> =A0 =A0 =A0 =A0omap_register_i2c_bus(2, 400, NULL, 0);
>> =A0 =A0 =A0 =A0omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo=
,
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index 3415a5e..c425f9f 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -412,6 +412,9 @@ static struct i2c_board_info __initdata panda_i2=
c_eeprom[] =3D {
>>
>> =A0static int __init omap4_panda_i2c_init(void)
>> =A0{
>> + =A0 =A0 =A0 /* This will allow unused regulator to be shutdown */
>> + =A0 =A0 =A0 regulator_has_full_constraints();
>> +
>
> ditto
>
>> =A0 =A0 =A0 =A0omap4_pmic_init("twl6030", &omap4_panda_twldata);
>> =A0 =A0 =A0 =A0omap_register_i2c_bus(2, 400, NULL, 0);
>> =A0 =A0 =A0 =A0/*
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
