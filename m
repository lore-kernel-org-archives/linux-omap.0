From: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: High CPU usage when video streaming on EHCI, 3.17.8 kernel with
 DMA enabled
Date: Thu, 21 May 2015 14:20:57 -0700
Message-ID: <CAK8F28mdedXgL660SqTLeNZ7hVHOmRR7YwuTdkyY3XmnZ97_Zw@mail.gmail.com>
References: <CALmG-ASRge4g6euyUEaxrLryvNR_tFSRexFSDZ5HNuzx_W4AyA@mail.gmail.com>
 <Pine.LNX.4.44L0.1505170956410.2774-100000@netrider.rowland.org>
 <20150518102715.34e29c33@perruche.parrot.biz> <20150518145919.GC10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150518145919.GC10274-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tom Mises <tommises-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 18, 2015 at 7:59 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> [PATCH] dmaengine: omap-dma: Add support for memcpy

Hi Tom,

To follow up on your corresponding mail to the gumstix list [1], I
tried on the 3.17.8 kernel on an Overo COM (DM37390) with the
suggested dmaengine patch applied.  Using "hdparm -t --DIRECT
/dev/sda" with a USB hard drive attached via the USB EHCI port, I see
a read speed of ~24MB/s (vs ~33MB/s on my laptop).  I see the same
behaviour on a recent kernel (from tony/omap-for-v4.2/cleanup,
otherwise works nicely on an Overo FWIW) with and without the
dmaengine patch.

What would be the expected USB read speed for an OMAP3 platform?

--Ash
[1] http://gumstix.8.x6.nabble.com/Low-USB-speed-on-Overo-td4969907.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
