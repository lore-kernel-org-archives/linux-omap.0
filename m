From: Ruslan Ruslichenko <ruslan.ruslichenko@globallogic.com>
Subject: Re: [PATCH] mfd: twl-core: Clean up module by removing twl603x pdata handling
Date: Mon, 2 Dec 2013 15:07:39 +0200
Message-ID: <CAK9oHmxmwM0TLZHcgXM5ryLecxD=Ouogoh0Zni4C+d7r0sPwqQ@mail.gmail.com>
References: <1385036008-1727-1-git-send-email-ruslan.ruslichenko@globallogic.com>
	<20131127121908.GE3296@lee--X1>
	<CAK9oHmyq3wOwgzxPYOLjoHuHahPFJE=vEN+GZCzfu-ZFhk9_Hw@mail.gmail.com>
	<20131129091644.GB26086@lee--X1>
	<20131129171013.GM31534@atomide.com>
	<20131202110800.GC31626@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:34313 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3LBNHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 08:07:41 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so12529290obc.23
        for <linux-omap@vger.kernel.org>; Mon, 02 Dec 2013 05:07:39 -0800 (PST)
In-Reply-To: <20131202110800.GC31626@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>

Since add_children() never called in not-dt boot, this patch does not
change current
OMAP4 boot behavior and devices initialization.
Also as far as I see all these twl603x regulators (apart from CLK32KG)
and TWL usb
module now have dt-bindings support. Device tree support for CLK32KG
have been removed
since it should not be registered as regulator at all.
So this patch can merged safely.

On Mon, Dec 2, 2013 at 1:08 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > > > > Since currently nobody uses TWL603x platform data and all ne=
w
>> > > >
>> > > > Hmm... when you say nobody, how did you come to this conclusio=
n?
>> > > >
>> > > > Without digging into it and probably not that relevant, it
>> > > > appears there is some references to it in platform data still:
>> > > >
>> > > > $ git grep twl603 -- arch/ | grep -v dts
>> > > > arch/arm/mach-omap2/common.h:extern int omap4_twl6030_hsmmc_in=
it(struct
>> > > > omap2_hsmmc_info *controllers);
>> > > > arch/arm/mach-omap2/omap4-common.c:static int
>> > > > omap4_twl6030_hsmmc_late_init(struct device *dev)
>> > > > arch/arm/mach-omap2/omap4-common.c:             irq =3D
>> > > > twl6030_mmc_card_detect_config();
>> > > > arch/arm/mach-omap2/omap4-common.c:
>> > > > pdata->slots[0].card_detect =3D twl6030_mmc_card_detect;
>> > > > arch/arm/mach-omap2/omap4-common.c:static __init void
>> > > > omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>> > > > arch/arm/mach-omap2/omap4-common.c:     pdata->init =3D
>> > > > omap4_twl6030_hsmmc_late_init;
>> > > > arch/arm/mach-omap2/omap4-common.c:int __init
>> > > > omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>> > > > arch/arm/mach-omap2/omap4-common.c:
>> > > > omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
>> > > > arch/arm/mach-omap2/omap4-common.c:int __init
>> > > > omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>> > > > arch/arm/mach-omap2/omap_twl.c:static unsigned long
>> > > > twl6030_vsel_to_uv(const u8 vsel)
>> > > > arch/arm/mach-omap2/omap_twl.c:static u8 twl6030_uv_to_vsel(un=
signed long
>> > > > uv)
>> > > > arch/arm/mach-omap2/omap_twl.c: if (uv > twl6030_vsel_to_uv(0x=
39)) {
>> > > > arch/arm/mach-omap2/omap_twl.c:                 __func__, uv,
>> > > > twl6030_vsel_to_uv(0x39));
>> > > > arch/arm/mach-omap2/omap_twl.c: .vsel_to_uv             =3D
>> > > > twl6030_vsel_to_uv,
>> > > > arch/arm/mach-omap2/omap_twl.c: .uv_to_vsel             =3D
>> > > > twl6030_uv_to_vsel,
>> > > > arch/arm/mach-omap2/omap_twl.c: .vsel_to_uv             =3D
>> > > > twl6030_vsel_to_uv,
>> > > > arch/arm/mach-omap2/omap_twl.c: .uv_to_vsel             =3D
>> > > > twl6030_uv_to_vsel,
>> > > > arch/arm/mach-omap2/omap_twl.c: .vsel_to_uv             =3D
>> > > > twl6030_vsel_to_uv,
>> > > > arch/arm/mach-omap2/omap_twl.c: .uv_to_vsel             =3D
>> > > > twl6030_uv_to_vsel,
>> > > >
>> > > Looks like some misunderstanding is here. This patch *only* remo=
ves
>> > > platform data for TWL603x
>> > > which were used to create TWL sub-devices like regulators, adc's=
,
>> > > watchdogs, etc.
>> > > Previously it was set up in twl_common.c by omap4_pmic_init(), w=
hich was
>> > > called from board files
>> > > with specific pmic config.
>> > > Since now in Linux kernel 3.13 OMAP4 non-DT boot is not supporte=
d and all
>> > > OMAP4 board files
>> > > have been removed omap4_pmic_init() is never called and all TWL6=
03x
>> > > sub-devices are created
>> > > from device tree data.
>> >
>> > I'm not overly familiar with this driver (it looks like a big
>> > historical mess to me), or the current state of the OMAP4 platform=
, so
>> > I would like a second opinion on this.
>> >
>> > Tony would you be kind enough to oblige?
>>
>> We've moved omap4 to boot based on device tree only, so that legacy
>> platform data is no longer being used. It might be worth checking if
>> we do have bindings in place for all of that, or if some of it may
>> still be needed to be passed as auxdata while we wait for the bindin=
gs.
>
> Ruslan, do you know the answer to these concerns?
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20

Ruslan Ruslichenko | Software Engineer
GlobalLogic
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
