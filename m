From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7] usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
Date: Thu, 9 Dec 2010 10:41:40 +0530
Message-ID: <AANLkTimHXnpWggSyDarXiPOYrDjC15EUMM43K6GBc4AH@mail.gmail.com>
References: <1291824097-7098-1-git-send-email-hemahk@ti.com>
	<4CFFACBD.80304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CFFACBD.80304-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 8, 2010 at 9:35 PM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> =
wrote:
> Hello.
>
> Hema HK wrote:
>
>> Added the TWL6030-usb transceiver option in the Kconfig
>
>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>
> [...]
>
>> Index: linux-2.6/drivers/usb/otg/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/drivers/usb/otg/Kconfig
>> +++ linux-2.6/drivers/usb/otg/Kconfig
>> @@ -59,6 +59,18 @@ config TWL4030_USB
>> =A0 =A0 =A0 =A0 =A0This transceiver supports high and full speed dev=
ices plus,
>> =A0 =A0 =A0 =A0 =A0in host mode, low speed.
>> =A0+config TWL6030_USB
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
>> + =A0 =A0 =A0 =A0 UTMI PHY is embedded in OMAP4430.The internal PHY =
configurations
>> APIs
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0^^
> =A0 Space missing after period.
I will fix it.

Regards,
Hema
>
> WBR, Sergei
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
