From: "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>
Subject: RE: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Fri, 22 Aug 2008 07:17:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870229F52486@dbde02.ent.ti.com>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>
 <48AD8526.8080206@gmail.com>,<200808211215.37760.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200808211215.37760.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Dmitry Krivoschekov <dmitry.krivoschekov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Without these changes DMA on DaVinci has never worked traditionally.
We fixed this issue pretty early in DaVinci program ~2006 on the 2.6.10
treee.  We are now in the process of forward porting the musb patches
from that tree to the git tree.

We did some performance enhancements/bug fixes on that tree and hope to make
it available to the general community w.r.t MUSB.  This (specific to DaVinci)
 and the following patches (musb generic) are in that direction.

I discussed with Kevin on the DaVinci Git tree and Filipe here and they recommended that
I take the changes to linux-usb, linux-omap tree (w.r.t musb changes) to get a wider 
audience for review and acceptance.

Kevin would then pull in the changes as part of his regular synch ups.

This patch (+ CPPI DMA changes) in a different form has already been 
tested in the DaVinci git community and it resolved the USB DMA issues and
improved performance considerably as communicated by the community
members like Neuros.

I will be submitting the CPPI DMA changes as a seperate patch as it is big
and based on preliminary review needs to be broken down significantly to
enable better review and acceptance.

Thanks for your comments.

regards
swami

________________________________________
From: David Brownell [david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
Sent: Friday, August 22, 2008 12:45 AM
To: Dmitry Krivoschekov; Subbrathnam, Swaminathan
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; Kevin Hilman
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet

On Thursday 21 August 2008, Dmitry Krivoschekov wrote:
> why don't rely on an endpoint interrupt which is generated
> after a USB transaction is complete?

That's what I thought *was* working a couple years ago...

I take it that something broke since then?  Or is this
a corner case which didn't always work right?

I'm not sure this would be appropriate for mainline
until the DaVinci code can run there.  There are a
bunch of arch/arm/mach-davinci updates needed first.
I know Kevin was looking at some of this, but just
now I think enabling MUSB on a 2.6.27-rc4 DaVinci
config means a broken build.

- Dave--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
