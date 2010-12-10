From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7 V2] usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
Date: Fri, 10 Dec 2010 16:56:40 +0530
Message-ID: <AANLkTik+_yK5oPUG5uJZpm2gfdtPUgSRUtr6frJ6To31@mail.gmail.com>
References: <1291964675-7114-1-git-send-email-hemahk@ti.com>
	<20101210084126.GE2576@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101210084126.GE2576-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 2:11 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Fri, Dec 10, 2010 at 12:34:35PM +0530, Hema HK wrote:
>>
>> Added the TWL6030-usb transceiver option in the Kconfig
>>
>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>> ---
>> drivers/usb/otg/Kconfig | =A0 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> Index: usb/drivers/usb/otg/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- usb.orig/drivers/usb/otg/Kconfig
>> +++ usb/drivers/usb/otg/Kconfig
>> @@ -59,6 +59,18 @@ config TWL4030_USB
>> =A0 =A0 =A0 =A0 =A0This transceiver supports high and full speed dev=
ices plus,
>> =A0 =A0 =A0 =A0 =A0in host mode, low speed.
>>
>> +config TWL6030_USB
>> + =A0 =A0 =A0 tristate "TWL6030 USB Transceiver Driver"
>> + =A0 =A0 =A0 depends on TWL4030_CORE
>> + =A0 =A0 =A0 select USB_OTG_UTILS
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Enable this to support the USB OTG transceiver on =
TWL6030
>> + =A0 =A0 =A0 =A0 family chips. This TWL6030 transceiver has the VBU=
S and ID GND
>> + =A0 =A0 =A0 =A0 and OTG SRP events capabilities. For all other tra=
nsceiver
>> functionality
>> + =A0 =A0 =A0 =A0 UTMI PHY is embedded in OMAP4430. The internal PHY
>> configurations APIs
>> + =A0 =A0 =A0 =A0 are hooked to this driver through platform_data st=
ructure.
>> + =A0 =A0 =A0 =A0 The definition of internal PHY APIs are in the mac=
h-omap2 layer.
>> +
>
> When compiling with this patch:
>
> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_set_phy_clk':
> drivers/usb/otg/twl6030-usb.c:145: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_set_clock'
> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_phy_init':
> drivers/usb/otg/twl6030-usb.c:166: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_power'
> drivers/usb/otg/twl6030-usb.c:168: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_power'
> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_phy_shutdown':
> drivers/usb/otg/twl6030-usb.c:182: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_power'
> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_usb_probe':
> drivers/usb/otg/twl6030-usb.c:440: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_init'
> drivers/usb/otg/twl6030-usb.c: In function 'twl6030_usb_remove':
> drivers/usb/otg/twl6030-usb.c:462: error: 'struct twl4030_usb_data' h=
as
> no member named 'phy_exit'
> make[2]: *** [drivers/usb/otg/twl6030-usb.o] Error 1
> make[1]: *** [drivers/usb/otg] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> please fix ASAP or we will loose the merge window.

With this patch twl6030_usb file still not added for build, I am
wondering how are
you getting How are you getting build error?

Regards,
Hema
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
