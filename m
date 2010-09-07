From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Tue, 07 Sep 2010 07:46:54 -0500
Message-ID: <e07f55b5f77ea471f41353190431bc78@secure211.sgcpanel.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com> <0dfed6f7fe2c07da3ce8108a4c5620c3@secure211.sgcpanel.com> <AANLkTinGSXdfWBABm9dmGDxnbf-_udg0ZvVCyH8FX-aO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinGSXdfWBABm9dmGDxnbf-_udg0ZvVCyH8FX-aO-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, 7 Sep 2010 11:49:38 +0900, venki kaps <venkiece2005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:
>> let me see if I understand you right. The consumption is higher
>> when the cable is kept plugged or the consumption is higher if
>> you boot with usb cable pugged and remove it afterwards ?
>   >> The consumption is higher if boot without usb cable.If boot when
> the cable is kept plugged
>   >> and remove it afterwards, then normal.

ok, so that's what I had observed and my original patch is the one
you want. You probably _also_ want this one though due the WARN

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
