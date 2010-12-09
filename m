From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/7] usb: musb: TWL6030: Selecting TWL6030_USB transceiver
Date: Thu, 9 Dec 2010 10:42:43 +0530
Message-ID: <AANLkTin9yXiaRbeBfX27PaYQS7NE+0wS9FUdJyyKjBmb@mail.gmail.com>
References: <1291824130-7181-1-git-send-email-hemahk@ti.com>
	<4CFFAC6F.9000808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CFFAC6F.9000808-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 9:33 PM, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> =
wrote:
> Hello.
>
> Hema HK wrote:
>
>> Selecting the twl6030-usb for OMAP4430SDP and OMAP4 PANDA board and
>> adding OMAP4 internal phy code for compilation
>
>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> [...]
>
>> Index: linux-2.6/drivers/usb/musb/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/drivers/usb/musb/Kconfig
>> +++ linux-2.6/drivers/usb/musb/Kconfig
>> @@ -12,6 +12,7 @@ config USB_MUSB_HDRC
>> =A0 =A0 =A0 =A0depends on (ARM || (BF54x && !BF544) || (BF52x && !BF=
522 &&
>> !BF523))
>> =A0 =A0 =A0 =A0select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EV=
M || BLACKFIN)
>> =A0 =A0 =A0 =A0select TWL4030_USB if MACH_OMAP_3430SDP
>> + =A0 =A0 =A0 select TWL6030_USB if (MACH_OMAP_3430SDP || MACH_OMAP4=
_PANDA)
>
> =A0 Parens are not necessary. Though the previous code uses them...
>
OK.

Regards,
Hema
> WBR, Sergei
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
