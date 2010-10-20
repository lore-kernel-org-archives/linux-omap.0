From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 19:22:17 +0300
Message-ID: <AANLkTim-QeP0hfSVGUd-tHWso9HQv25TwapBBZ1KPD3=@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
	<4CBD9FD5.506@nokia.com>
	<AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
	<4CBE9E69.6060803@nokia.com>
	<AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
	<4CBEB312.7060400@nokia.com>
	<AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
	<20101020125407.GE2433@legolas.emea.dhcp.ti.com>
	<AANLkTi=+6bC=JALdCDKW_BS-jnNk3zFPuWuBT+aY=Utx@mail.gmail.com>
	<20101020151527.GF2883@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38757 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0JTQWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 12:22:19 -0400
In-Reply-To: <20101020151527.GF2883@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Roger Quadros <roger.quadros@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>

On Wed, Oct 20, 2010 at 6:15 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Oct 20, 2010 at 09:52:06AM -0500, Felipe Contreras wrote:
>>
>> TWL4030_USB is inside drivers/usb/Kconfig and drivers/usb/otg/Kconfi=
g,
>> which means in order to achieve the same on the board config you wou=
ld
>> have to do:
>>
>> default y if USB_SUPPORT && (USB || USB_GADGET) && ARCH_OMAP3
>>
>> Seems to be more convoluted to me.
>>
>> Besides, I think TWL4030_USB and the full description of it doesn't
>> give any hints to the people reading drivers/usb/otg/Kconfig what is
>> it used for. 'default y if ARCH_OMAP3' achieves that.
>
> no it doesn't. No user will 'cat drivers/usb/otg/Kconfig | grep -A 10
> TWL4030' and check the 'default y if ARCH_OMAP3
>
> if you think help is not enough, fix help.

Users would not need to care... if they enable USB and USB_GADGET, it
will be selected automatically for OMAP3, which is what users would
expect.

I was talking more about developers.

How should the help be fixed?
"Select y if you are using an OMAP3 system that has TWL4030"

>> Plus, there is no big change:
>>
>> config USB_MUSB_HDRC
>> - =C2=A0 =C2=A0 =C2=A0 select TWL4030_USB if MACH_OMAP_3430SDP
>>
>> config TWL4030_USB
>> + =C2=A0 =C2=A0 =C2=A0 default y if ARCH_OMAP3
>>
>
> what's the problem with:
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index ab784bf..3af9580 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -215,6 +215,7 @@ config MACH_NOKIA_RX51
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select OMAP_PACKAGE_CBB
> + =C2=A0 =C2=A0 =C2=A0 select TWL4030_USB
> =C2=A0config MACH_OMAP_ZOOM2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "OMAP3 Zoom2 board"
>

1) Do you think all the OMAP3 boards should add that?
2) What if you don't want to use USB?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
