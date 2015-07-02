From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Wed, 1 Jul 2015 23:22:35 -0700
Message-ID: <20150702062234.GZ4156@atomide.com>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
 <Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
 <20150518102715.34e29c33@perruche.parrot.biz>
 <20150518145919.GC10274@atomide.com>
 <CAK8F28mdedXgL660SqTLeNZ7hVHOmRR7YwuTdkyY3XmnZ97_Zw@mail.gmail.com>
 <CALmG-ARrzJ=kRH-958F20WPH+=VCpjrgMuyn9MWv4uj2dnSRpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALmG-ARrzJ=kRH-958F20WPH+=VCpjrgMuyn9MWv4uj2dnSRpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tom Mises <tommises-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-uvc-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tom Mises <tommises-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150701 11:24]:
> On Mon, May 18, 2015 at 8:59 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > For the memcpy part with DMA this patch should help too:
> >
> > [PATCH] dmaengine: omap-dma: Add support for memcpy
> 
> The patch should help, but not out of the box as far as I understand.
> My understanding is that to take advantage of this, it would be
> necessary to explicitly call the DMA API either by replacing memcpy()
> in uvc_video_decode_data() or by modyfying the memcpy()
> implementation. Is that correct?

Yes you should be able to configure the DMA to do memory-to-memory
copy where both source and destination address is looping over
the desired buffer size. Ideally you would move the data from camera
directly to the buffer without doing a memcpy inbetween.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
