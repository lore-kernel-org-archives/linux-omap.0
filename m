From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RFC] MUSB: Fix index register corruption seen with
 g_ether and Windows host
Date: Wed, 6 Aug 2008 10:15:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8B2F@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8A84@dbde02.ent.ti.com>
 <386072610808052126o85e13cdm45925abdde96f159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <386072610808052126o85e13cdm45925abdde96f159-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> On Tue, Aug 5, 2008 at 11:48 PM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> > From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> >
> > If Indexed Mode register accesses are enabled, the ep0_rxstate() function calls
> > musb_g_ep0_giveback() before writing to the CSR register. When control returns
> > to this ep0_rxstate, the index register contents are over-written. This causes
> > the CSR register write to fail.
> >
> > Fixed by writing the correct value into the index register before
> > writing to the CSR.
> >
> > This was observed only in ep0_rxstate() with g_ether loaded and the device
> > connected to a MS Windows host PC. Anticipatively fixed ep0_txstate() as well.
> >
>
> Actually, I'm still struggling in a bug similar with this one on Blackfin.
> We ran following testcase 100 times, 10-20 times tastcases failed.
>
> ---
> $ ./testusb -D /proc/bus/usb/005/012 -t14 -c 15000 -s 256 -v 1
> unknown speed   /proc/bus/usb/005/012
> /proc/bus/usb/005/012 test 14 --> 75 (Value too large for defined data type)
> ---
>
> I reported this bug to our hardware designer and the omap list. Felipe
> said he did met this issue.
> From the capture data of USB analyzer, the peripheral musb sent out
> garbage data in the IN-STATUS stage.
> In that stage, the DATA length should be zero. But the peripheral sent
> out 1 byte or 2 bytes sometimes.
>
> Thanks
> -Bryan

Hi Bryan,

Could you tell me if you're using Indexed Mode or Flat mode?

I'll try this out on my boards and see what I get.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
