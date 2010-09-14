From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Tue, 14 Sep 2010 14:46:22 +0400
Message-ID: <4C8F527E.40408@ru.mvista.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com> <1283873014-32511-6-git-send-email-tom.leiming@gmail.com> <4C8E18AD.8000502@ru.mvista.com> <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com> <4C8E4882.6040600@ru.mvista.com> <4C8E50CC.3080705@ru.mvista.com> <20100914065604.GD2601@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914065604.GD2601-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 14-09-2010 10:56, Felipe Balbi wrote:

>> Oops, I've been too fast and haven't realized that the check done he=
re
>> _is_ actually wrong. It causes ZLP send to trigger too fast in the D=
MA
>> case. So please fix this patch. Felipe, please drop it for now.

> patch is not even touching that part of the code,

    Yeah, and that's the problem.

> not even
> reading/writing TXCSR_TXPKTRDY bit care to explain please.

    If a DMA interrupt comes when the whole transfer is not yet complet=
e (and=20
other Ming Lei's patches are making this possible), it will pass due to=
 the=20
'=EDs_dma' condition above the patched code:

                 if (is_dma || request->actual =3D=3D request->length) =
{

and then it will hit the code sending the final ZLP (above this patched=
 code too):

                         /*
                          * First, maybe a terminating short packet. So=
me DMA
                          * engines might handle this by themselves.
                          */
                         if ((request->zero && request->length
                                 && request->length % musb_ep->packet_s=
z =3D=3D 0)
#ifdef CONFIG_USB_INVENTRA_DMA
                                 || (is_dma && (!dma->desired_mode ||
                                         (request->actual &
                                                 (musb_ep->packet_sz - =
1))))
#endif
                         ) {

before the transfer is complete while it should only be hit when and on=
ly when=20
the whole transfer is complete. The current code doesn't look correct a=
s well=20
though, all due to this '=EDs_dma' condition. Surely this needs fixing.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
