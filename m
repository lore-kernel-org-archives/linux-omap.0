From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra DMA issue on
 RTL-1.4
Date: Wed, 12 May 2010 23:26:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03216237DA@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>,<20100512175113.GA3285@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100512175113.GA3285@gandalf>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> On Wed, May 12, 2010 at 05:19:36PM +0530, Ajay Kumar Gupta wrote:
> > MUSB RTL version 1.4 has a hardware issue when TX and RX DMA channels are
> > simultaneously enabled which results in DMA lockup.
> 
> I've seen it on rtl1.8 also if I remember correctly.
> 

I'm fairly certain that this is not the case with RTL1.8, and if it is I'm very
much interested in getting to the bottom of it. Do you have a test case
that reproduces the lockup? Or a description of your use-case, or
a register dump at failure, or any other clues?

> > Use system DMA for all RX channels as a workaround of this issue as this
> > will have minimal throughput overhead based on the fact that Rx transfers
> > are done in DMA mode-0 on OMAP34x/35x platforms.
> >
> > Another approach to use PIO mode in opposite direction would increase the
> > cpu loading and thus using system DMA is preferred workaround.
> >
> > Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> I think falling back to pio is better than this patch. It will most
> likely be only one transfer. Another approach is to allocate dma
> channels on a transfer basis. This is way too big of a problem.

Which one is better depends on how many endpoints are doing,
transfers in parallel, I suppose.

I did post the a patch for the other approach (to fall back to PIO).
I haven't received a response to that yet. I'm okay with either approach.


- Anand--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
