From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Wed, 23 Jun 2010 17:56:39 -0500
Message-ID: <4C229127.1000009@ti.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com> <87k4ppqyk2.fsf@deeprootsystems.com> <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61951E1F-DEBF-450C-AF06-E0119DA3B33E-oe7qfRrRQfcdWmXj+hCI//P6llvjuJOh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Anders, David" <x0132446-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 6/23/2010 4:12 PM, Koen Kooi wrote:
>> Shouldn't this be a board-specific option, and not set for every
>> OMAP4-based config?
>
> If that's true, why do the  davinci and blackfin archs force it?

DaVinci only has an internal PHY, I don't think that there is anyway to 
use an external PHY with DaVinci like you can with OMAP4. Not sure about 
blackfin...

Jon

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
