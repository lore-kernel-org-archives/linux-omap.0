From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 01:06:06 -0700
Message-ID: <CAFm5wm1xVbC_=+hUnHp4g7XVihhN_=qyJDPzD3zz32Zt7jEtJw@mail.gmail.com>
References: <1311033103-15854-1-git-send-email-vikram.pandita@ti.com>
 <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
 <CAFm5wm1kruM0WCoAsC7Ps09TsaCUA6G6NBT24q0QY6-_B9AAog@mail.gmail.com> <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC0054@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC0054-tzSpAVkrWRmIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 19, 2011 at 12:46 AM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> Pandita, Vikram wrote:
>> On Mon, Jul 18, 2011 at 11:22 PM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
<snip>
> But you can't just change authorship when the entire functional code
> is the same. (It doesn't matter much to me - I'm not as active on
> MUSB as I used to be; it's just the principle of the thing).

Moiz fixed the second part of your patch - which was not there on your
original work:

<snip>
+                                       if (use_mode_1) {
+                                               transfer_size =
min(request->length - request->actual,
+
channel->max_len);
                                               musb_ep->dma->desired_mode = 1;
+                                       } else {
+                                               transfer_size =
min(request->length - request->actual,
+                                                               (unsigned)len);
+
musb_ep->dma->desired_mode = 0;+
if (use_mode_1) {
+                                               transfer_size =
min(request->length - request->actual,
+
channel->max_len);
                                               musb_ep->dma->desired_mode = 1;
+                                       } else {
+                                               transfer_size =
min(request->length - request->actual,
+                                                               (unsigned)len);
+                                               musb_ep->dma->desired_mode = 0;
<snip end>

The history is:

Original author on .35 or .32 kernel : Anand Gadiyar
Fixes done by and some more forward ports: Moiz Sonasath
Tested on 3.0 and code cleanups, commit message updates, community
comment fixes: Vikram Pandita

Wonder if original author did not act all this while, is there
anything wrong in changing authorship with proper accreditation to
original author?
For future pushes, i would really like to learn what the linux
community suggests the right approach for such cases.

As i said, i am open to change and will repost as decided - there is
no attempt to sabotage anyone's work here :-)


>
>> We have been carrying this optimisation around in product kernels for
>> a long time now and we keep redoing on each migration,
>> with the downside of sometimes loosing the authorship.
>>
>> > (and if I remember correctly several
>> > attempts to get this merged upstream)? I don't see any
>> > functional changes from my original patch.
>>
>> Wonder what were the reasons for not getting accepted?
>> Can you re-ignite the discussion why it cannot be taken in then?
>
> You've already re-ignited this discussion. I haven't tested the patch
> with the current kernel (and will do so soon), but if it does still
> work and there are no objections, it ought to be merged.
>
> - Anand
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
