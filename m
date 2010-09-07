From: venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 11:49:38 +0900
Message-ID: <AANLkTinGSXdfWBABm9dmGDxnbf-_udg0ZvVCyH8FX-aO@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<0dfed6f7fe2c07da3ce8108a4c5620c3@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0dfed6f7fe2c07da3ce8108a4c5620c3-WEDJutINlwSqfKURHDCIgFDQ4js95KgL@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Venkii.

On Tue, Sep 7, 2010 at 5:22 AM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote=
:
> Hi,
>
> On Tue, 7 Sep 2010 03:10:30 +0900, venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
>> Dear USB experts,
>>
>> =A0 Is the same fix valid for omap3430 + 2.6.32 Kernel?
>
> 3.6.32 ?? difficult to say. Why such an old kernel ? Although
> I doubt musb or twl4030-usb driver has changed that much, it's
> difficult to say.
>
>> =A0 I have been facing mp3 playback idle current consumption 20mA mo=
re
>> after booting without USB cable connected
>
> let me see if I understand you right. The consumption is higher
> when the cable is kept plugged or the consumption is higher if
> you boot with usb cable pugged and remove it afterwards ?
  >> The consumption is higher if boot without usb cable.If boot when
the cable is kept plugged
  >> and remove it afterwards, then normal.
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
