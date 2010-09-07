From: venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 7 Sep 2010 18:48:35 +0530
Message-ID: <AANLkTik8m2hzWCdFaVxRmv-5f=Sv5nPo1rs7PKK8CCVS@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<0dfed6f7fe2c07da3ce8108a4c5620c3@secure211.sgcpanel.com>
	<AANLkTinGSXdfWBABm9dmGDxnbf-_udg0ZvVCyH8FX-aO@mail.gmail.com>
	<e07f55b5f77ea471f41353190431bc78@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e07f55b5f77ea471f41353190431bc78-WEDJutINlwSqfKURHDCIgFDQ4js95KgL@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Venkii,
On Tue, Sep 7, 2010 at 6:16 PM, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote=
:
> Hi,
>
> On Tue, 7 Sep 2010 11:49:38 +0900, venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
>>> let me see if I understand you right. The consumption is higher
>>> when the cable is kept plugged or the consumption is higher if
>>> you boot with usb cable pugged and remove it afterwards ?
>> =A0 >> The consumption is higher if boot without usb cable.If boot w=
hen
>> the cable is kept plugged
>> =A0 >> and remove it afterwards, then normal.
>
> ok, so that's what I had observed and my original patch is the one
> you want. You probably _also_ want this one though due the WARN
  >>> Is WARN_ON created issue? or
  >>> As you mentioned earlier, if (!regulator_is_enabled(twl->usb3v1)
regulator_enable(twl->usb3v1); would be required?
  >>> could you please provide more details?
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
