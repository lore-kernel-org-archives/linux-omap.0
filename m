From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Wed, 27 Jul 2011 09:20:02 +0530
Message-ID: <CABb+yY30bYN=c+oAdt1-bufLq2g2RtgCUefDzNTfW33Wu-wE1g@mail.gmail.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
	<CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
	<CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com>
	<CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
	<CAFm5wm2ng-fs0OgUG+h1JaF3_LBp93fHw2Vap2oD_j7Ok0NNnw@mail.gmail.com>
	<20110726150655.GK32582@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110726150655.GK32582-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 26, 2011 at 8:36 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Wed, Jul 20, 2011 at 09:48:53AM -0700, Pandita, Vikram wrote:
>> > This *today happens to be only UMS* is my exact point here.
>> > Can you guarantee no other function driver will ever expect only
>> > full packet xfers and treat short as errors ?
>> >
>>
>> We are trying to test if short_not_ok may not be needed at all. But
>> all gadgets need to be tested on MUSB for that.
>> We will need wider help from MUSB maintainer/author(anand g) to
>> determine if removing short_not_ok is fine on MUSB for _all_ gadgets.
>>
>> To be safe we only enable for UMS use case today that is definitely
>> working fine.
>>
>> Time for Maintainer/author to pitch in !!
>
> I'm thinking on allowing this patch to go in if nobody has really strong
> arguments against it. The real fix, though, would need a bigger re-write
> of the endpoint IRQ handling and that would need more time to write and
> stabilize. Together with the huge amount of HW issues MUSB has, it's
> quite a task (been there, done that).

Please note that I never objected to the _code_.

I just think if the _comments_ could be made UMS agnostic... for ex if it works
for other protocols just fine(quite possible) in future the reader
might wonder what
is UMS specific about the code snippet.

Please feel free to go ahead and apply the patch.

thnx
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
