From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 13:59:58 +0300
Message-ID: <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
	<20101019103234.GI31170@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101019103234.GI31170@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 1:32 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Oct 19, 2010 at 05:03:28AM -0500, Felipe Contreras wrote:
>>
>> + =C2=A0 =C2=A0 =C2=A0 depends on (NOP_USB_XCEIV || TWL4030_USB)
>> + =C2=A0 =C2=A0 =C2=A0 default y if ARCH_OMAP3
>> + =C2=A0 =C2=A0 =C2=A0 default y if ARCH_DAVINCI || MACH_OMAP3EVM ||=
 BLACKFIN
>
> it could be only me, but I see these kind of dependencies tend to
> disaster. They can all grow to infinity. Soon, we will have another t=
wl
> family of devices, or we will have another MACH_* which will need
> nop_xceiv, etc etc.

The USB_MUSB_HDRC dependency on NOP_USB_XCEIV || TWL4030_USB is
already there, I'm just making it explicit. The rest are not
dependencies, just sensible defaults, and they are already in
drivers/usb/musb/Kconfig, I'm just moving them.

If you have a better approach to avoid manually selecting TWL4030_USB
on defconfigs, and making sure USB_MUSB_HDRC works, please share it.

--=20
=46elipe Contreras
