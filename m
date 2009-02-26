From: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 15:57:56 +0900
Message-ID: <4d34a0a70902252257lc8b3a1duc6cbd6de2cbd2840@mail.gmail.com>
References: <4d34a0a70902252154p56733ae8g7a989112503251b@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91C14@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91C14-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 26, 2009 at 3:37 PM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> <snip>
>
>> Now I know that, in addition to HSUSB_MC_NINT disabled by the previo=
us
>> patch [ARM: OMAP: Disable USB interrupt in the musb_resume()
>> function], USBTLL_SWAKEUP and USBHOST_SWAKEUP can be also wake-up
>> source events to PRMC module. Sorry I didn't know that time. The
>> remote wake uses these two SWAKEUP. David, is my previous patch is
>> still NAK?
>
> USBTLL_SWAKEUP and =A0USBHOST_SWAKEUP are not for MUSB.
>

But they are used to wake up request. Can I ask what they are for?

>
> - Anand



--=20
Q1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
