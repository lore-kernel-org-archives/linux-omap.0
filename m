From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCHv3 1/6] omap3: Add external VBUS power switch and
 overcurrent detect on IGEP v2 board.
Date: Sat, 2 Oct 2010 12:12:32 +0200
Message-ID: <AANLkTin0FBudq5saFhcuonrzK2LqU0UueiN_-C=B0N0j@mail.gmail.com>
References: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
	<1285967349-32767-2-git-send-email-eballetbo@gmail.com>
	<20101002080427.GC14377@esdhcp036161.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37068 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab0JBKMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 06:12:35 -0400
Received: by qwh6 with SMTP id 6so1997464qwh.19
        for <linux-omap@vger.kernel.org>; Sat, 02 Oct 2010 03:12:34 -0700 (PDT)
In-Reply-To: <20101002080427.GC14377@esdhcp036161.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <david.cohen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2010/10/2 David Cohen <david.cohen@nokia.com>:
> Hi,
>
> On Fri, Oct 01, 2010 at 11:09:04PM +0200, ext Enric Balletbo i Serra =
wrote:
>> GPIO for various devices are missing from the board initialization.
>> This patch adds support for the VBUS and over current gpios. =C2=A0W=
ithout this
>> patch, input/outputs from these two sources are ignored.
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 16 +++++++++++++=
+++
>> =C2=A01 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-om=
ap2/board-igep0020.c
>> index 175f043..07dbdb7 100644
>> --- a/arch/arm/mach-omap2/board-igep0020.c
>> +++ b/arch/arm/mach-omap2/board-igep0020.c
>> @@ -274,6 +274,22 @@ static int igep2_twl_gpio_setup(struct device *=
dev,
>> =C2=A0 =C2=A0 =C2=A0 igep2_vmmc1_supply.dev =3D mmc[0].dev;
>> =C2=A0 =C2=A0 =C2=A0 igep2_vmmc2_supply.dev =3D mmc[1].dev;
>>
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* REVISIT: need ehci-omap hooks for external V=
BUS
>> + =C2=A0 =C2=A0 =C2=A0* power switch and overcurrent detect
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if ((gpio_request(gpio + 1, "GPIO_EHCI_NOC") < 0) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_input(gpio + 1) < 0))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP2: Could not=
 obtain gpio for EHCI NOC");
>
> Shouldb't you return error if it can't request the GPIO?

I'm not sure what happens if I return and error, I see only prints a
debug message. Maybe the twl4030-gpio maintainer can explain if I need
return and error or not.

Other omap boards just don't check the gpio_request call and always
return 0. I don't consider this a critical error so maybe should be
better replace the pr_err with a pr_warning.

>
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* TWL4030_GPIO_MAX + 0 =3D=3D ledA, GPIO_USBH_=
CPEN
>> + =C2=A0 =C2=A0 =C2=A0* (out, active low)
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if ((gpio_request(gpio + TWL4030_GPIO_MAX, "GPIO_USB=
H_CPEN") < 0) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 (gpio_direction_output(gpio + TWL4030_=
GPIO_MAX, 0) < 0))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP2: Could not=
 obtain gpio for USBH_CPEN");
>
> Same here.
>
>> +
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0};
>>

Kind regards,
  Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
