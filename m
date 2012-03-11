From: Pavan Savoy <pavan.savoy@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Sun, 11 Mar 2012 14:13:43 -0600
Message-ID: <CAHd==dp1GNov4gqMzPLkJzX1A205HUMhTPtg28399FcPQFZH0A@mail.gmail.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
	<20120309183150.GH12083@atomide.com>
	<4F5D057A.3080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33732 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2CKUNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Mar 2012 16:13:45 -0400
Received: by bkcik5 with SMTP id ik5so2145171bkc.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 13:13:43 -0700 (PDT)
In-Reply-To: <4F5D057A.3080601@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mircea Gherzan <mgherzan@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Luciano Coelho <coelho@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, pandaboard@googlegroups.com

On Sun, Mar 11, 2012 at 2:05 PM, Mircea Gherzan <mgherzan@gmail.com> wr=
ote:
> Am 09.03.2012 19:31, schrieb Tony Lindgren:
>> Hi Luca,
>>
>> * Mircea Gherzan <mgherzan@gmail.com> [120306 14:23]:
>>> The "uim" deamon requires sysfs entries that are filled in using
>>> this platform data.
>>>
>>> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
>>> ---
>>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 14 ++++++++++++--
>>> =A0include/linux/ti_wilink_st.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 ++
>>> =A02 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach=
-omap2/board-omap4panda.c
>>> index b1d74d6..339e781 100644
>>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>>> @@ -27,6 +27,7 @@
>>> =A0#include <linux/i2c/twl.h>
>>> =A0#include <linux/regulator/machine.h>
>>> =A0#include <linux/regulator/fixed.h>
>>> +#include <linux/ti_wilink_st.h>
>>> =A0#include <linux/wl12xx.h>
>>>
>>> =A0#include <mach/hardware.h>
>>> @@ -56,12 +57,21 @@
>>> =A0#define HDMI_GPIO_HPD =A063 /* Hotplug detect */
>>>
>>> =A0/* wl127x BT, FM, GPS connectivity chip */
>>> -static int wl1271_gpios[] =3D {46, -1, -1};
>>> +static struct ti_st_plat_data wilink_platform_data =3D {
>>> + =A0 =A0.nshutdown_gpio =3D 46,
>>> + =A0 =A0.dev_name =A0 =A0 =A0 =3D "/dev/ttyO1",
>>> + =A0 =A0.flow_cntrl =A0 =A0 =3D 1,
>>> + =A0 =A0.baud_rate =A0 =A0 =A0=3D 3000000,
>>> + =A0 =A0.chip_enable =A0 =A0=3D NULL,
>>> + =A0 =A0.suspend =A0 =A0 =A0 =A0=3D NULL,
>>> + =A0 =A0.resume =A0 =A0 =A0 =A0 =3D NULL,
>>> +};
>>> +
>>> =A0static struct platform_device wl1271_device =3D {
>>> =A0 =A0 =A0.name =A0 =3D "kim",
>>> =A0 =A0 =A0.id =A0 =A0 =3D -1,
>>> =A0 =A0 =A0.dev =A0 =A0=3D {
>>> - =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &wl1271_gpios,
>>> + =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &wilink_platform_dat=
a,
>>> =A0 =A0 =A0},
>>> =A0};
>>>
>>> diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink=
_st.h
>>> index 2ef4385..3ca0269 100644
>>> --- a/include/linux/ti_wilink_st.h
>>> +++ b/include/linux/ti_wilink_st.h
>>> @@ -25,6 +25,8 @@
>>> =A0#ifndef TI_WILINK_ST_H
>>> =A0#define TI_WILINK_ST_H
>>>
>>> +#include <linux/skbuff.h>
>>> +
>>> =A0/**
>>> =A0 * enum proto-type - The protocol on WiLink chips which share a
>>> =A0 * =A0common physical interface like UART.
>>> --
>>
>> Just checking.. Can you please take a look at this patch
>> and confirm that this is how things are supposed to be done?
>>
>> To me passing some third driver's dev_name in pdata seems
>> pretty weird.. But then again maybe I just don't know how
>> this is supposed to work.
>
> This is what the ti_st driver expects in the platform data structure.
> More precisely, in kim_probe():
>
> =A0 =A0 =A0 =A0/* copying platform data */
> =A0 =A0 =A0 =A0strncpy(kim_gdata->dev_name, pdata->dev_name,UART_DEV_=
NAME_LEN);
> =A0 =A0 =A0 =A0kim_gdata->flow_cntrl =3D pdata->flow_cntrl;
> =A0 =A0 =A0 =A0kim_gdata->baud_rate =3D pdata->baud_rate;
> =A0 =A0 =A0 =A0pr_info("sysfs entries created\n");
>
> So IMHO the patch is a valid fix. However, one more patch [1] is stil=
l
> required to get BT and WLAN working on the PandaBoard.

The patch looks alright to me.
Yes, the UART to which BT chip is connected (along with other
technologies for which shared transport is required), the baud rate
which the UART supports & also a flag so as to check whether it
supports flow control - ideally is supposed to come from boot-loader,
device tree sort of configuration - if not can be hard-coded in the
relevant platform specific files like in this case.

This is picked up from ST as platform data as is read from the
user-space daemon, because unfortunately none of these configurations
can be done in kernel (the right way for TTY).

1 more patch or an addition to this patch to add the wl1271_device &
the btwilink device is also required to get ST probe & BT probe.
The btwilink driver is a platform device because UART devices don't
have a probe mechanism unlike say usb, i2c..

> Thanks,
> Mircea
>
> [1] http://elinux.org/images/8/8d/0001a-omap4-pandaboard-wlan-fix.pat=
ch
>



--=20
--Pavan Savoy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
