From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Tue, 14 Sep 2010 21:51:09 +0400
Message-ID: <4C8FB60D.1080906@ru.mvista.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com> <1283873014-32511-6-git-send-email-tom.leiming@gmail.com> <4C8E18AD.8000502@ru.mvista.com> <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com> <4C8E4882.6040600@ru.mvista.com> <4C8E50CC.3080705@ru.mvista.com> <20100914065604.GD2601@legolas.emea.dhcp.ti.com> <4C8F527E.40408@ru.mvista.com> <20100914105402.GD7554@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100914105402.GD7554-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

=46elipe Balbi wrote:

>>    If a DMA interrupt comes when the whole transfer is not yet=20
>> complete (and
>> other Ming Lei's patches are making this possible),

    Oh, here I mixed some other patch with Ming Lei's ones...

>> it will pass due to the

> than this is the actual problem, no ? If we're using mode1 dma (as we
> are on tx path), we should only get dma interrupt when the whole
> transfer has been completed.

    The Inventra DMA controller has serious DMA length limitation, so t=
he whole=20
transfer may take more than one DMA.

>> '=EDs_dma' condition above the patched code:

>>                 if (is_dma || request->actual =3D=3D request->length=
) {

>> and then it will hit the code sending the final ZLP (above this=20
>> patched code too):

> but this was already there before the patch.

    Yes, and here lies the problem.

>>                         /*
>>                          * First, maybe a terminating short packet.=20
>> Some DMA
>>                          * engines might handle this by themselves.
>>                          */
>>                         if ((request->zero && request->length
>>                                 && request->length %=20
>> musb_ep->packet_sz =3D=3D 0)
>> #ifdef CONFIG_USB_INVENTRA_DMA
>>                                 || (is_dma && (!dma->desired_mode ||
>>                                         (request->actual &
>>                                                 (musb_ep->packet_sz =
-=20
>> 1))))
>> #endif
>>                         ) {

>> before the transfer is complete while it should only be hit when and=
=20
>> only when
>> the whole transfer is complete. The current code doesn't look correc=
t=20
>> as well
>> though, all due to this '=EDs_dma' condition. Surely this needs fixi=
ng.

> likewise, this was there before the patch. I don't think the real
> problem lies with this patch, it's been there for a while, don't you
> agree ?

    Then what problem this patch fixes, if not this one?

> the problem is not on the extra if () added below the quoted code,
> it's on the quoted code itself, which wasn't changed in any way.

    Let me repeat: in the PIO mode the added check is just duplicate, i=
n the DMA=20
mode it's added too late in the code, after ZLP/short packet send is tr=
iggered.
We should modify the check at the top of that code instead.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
