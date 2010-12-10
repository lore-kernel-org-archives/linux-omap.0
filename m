From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: Re: [PATCH 3/7 V2] usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
Date: Fri, 10 Dec 2010 17:14:42 +0530
Message-ID: <AANLkTikA6i2HytjzUJaei1_cCAnfbnSRv4BdcoGkjypt@mail.gmail.com>
References: <1291964675-7114-1-git-send-email-hemahk@ti.com>
	<20101210084126.GE2576@legolas.emea.dhcp.ti.com>
	<AANLkTik+_yK5oPUG5uJZpm2gfdtPUgSRUtr6frJ6To31@mail.gmail.com>
	<20101210114332.GG6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41611 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755076Ab0LJLon convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 06:44:43 -0500
In-Reply-To: <20101210114332.GG6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

On Fri, Dec 10, 2010 at 5:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 10, 2010 at 04:56:40PM +0530, Kalliguddi, Hema wrote:
>>
>> On Fri, Dec 10, 2010 at 2:11 PM, Felipe Balbi <balbi@ti.com> wrote:
>>>
>>> On Fri, Dec 10, 2010 at 12:34:35PM +0530, Hema HK wrote:
>>>>
>>>> Added the TWL6030-usb transceiver option in the Kconfig
>>>>
>>>> Signed-off-by: Hema HK <hemahk@ti.com>
>>>> Cc: Felipe Balbi <balbi@ti.com>
>>>> Cc: David Brownell <dbrownell@users.sourceforge.net>
>>>> ---
>>>> drivers/usb/otg/Kconfig | =A0 12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>
>>>> Index: usb/drivers/usb/otg/Kconfig
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- usb.orig/drivers/usb/otg/Kconfig
>>>> +++ usb/drivers/usb/otg/Kconfig
>>>> @@ -59,6 +59,18 @@ config TWL4030_USB
>>>> =A0 =A0 =A0 =A0 =A0This transceiver supports high and full speed d=
evices plus,
>>>> =A0 =A0 =A0 =A0 =A0in host mode, low speed.
>>>>
>>>> +config TWL6030_USB
>>>> + =A0 =A0 =A0 tristate "TWL6030 USB Transceiver Driver"
>>>> + =A0 =A0 =A0 depends on TWL4030_CORE
>>>> + =A0 =A0 =A0 select USB_OTG_UTILS
>>>> + =A0 =A0 =A0 help
>>>> + =A0 =A0 =A0 =A0 Enable this to support the USB OTG transceiver o=
n TWL6030
>>>> + =A0 =A0 =A0 =A0 family chips. This TWL6030 transceiver has the V=
BUS and ID GND
>>>> + =A0 =A0 =A0 =A0 and OTG SRP events capabilities. For all other t=
ransceiver
>>>> functionality
>>>> + =A0 =A0 =A0 =A0 UTMI PHY is embedded in OMAP4430. The internal P=
HY
>>>> configurations APIs
>>>> + =A0 =A0 =A0 =A0 are hooked to this driver through platform_data =
structure.
>>>> + =A0 =A0 =A0 =A0 The definition of internal PHY APIs are in the m=
ach-omap2
>>>> layer.
>>>> +
>>>
>>> When compiling with this patch:
>>>
>>> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_set_phy_clk':
>>> drivers/usb/otg/twl6030-usb.c:145: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_set_clock'
>>> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_phy_init':
>>> drivers/usb/otg/twl6030-usb.c:166: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_power'
>>> drivers/usb/otg/twl6030-usb.c:168: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_power'
>>> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_phy_shutdown':
>>> drivers/usb/otg/twl6030-usb.c:182: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_power'
>>> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_usb_probe':
>>> drivers/usb/otg/twl6030-usb.c:440: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_init'
>>> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_usb_remove':
>>> drivers/usb/otg/twl6030-usb.c:462: error: 'struct twl4030_usb_data'=
 has
>>> no member named 'phy_exit'
>>> make[2]: *** [drivers/usb/otg/twl6030-usb.o] Error 1
>>> make[1]: *** [drivers/usb/otg] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [drivers] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>
>>> please fix ASAP or we will loose the merge window.
>>
>> With this patch twl6030_usb file still not added for build, I am
>> wondering how are
>> you getting How are you getting build error?
>
> This is *the* patch that adds it to Kbuild :-) the previous patch
> already added Makefile change.
>
Agree. Got confused with omap_phy_internal.c file.
I am fixing it. I will send you the patches.
Regards,
Hema
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
