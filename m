From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v9 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Thu, 9 Jun 2016 10:11:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606091008210.1697-100000@iolanthe.rowland.org>
References: <5201761f-4efa-f941-b05f-e4a2b91c75c0@cogentembedded.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5201761f-4efa-f941-b05f-e4a2b91c75c0-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 9 Jun 2016, Sergei Shtylyov wrote:

> Hello.
> 
> On 6/9/2016 10:31 AM, Roger Quadros wrote:
> 
> >>>>> The OTG core will use struct otg_hcd_ops to interface
> >>>>> with the HCD controller.
> >>>>
> >>>>    Host controller driver (HCD) controller? Maybe just HC? :-)
> >>>
> >>> OK.
> >>
> >>    OTOH, my googling has shown that HCD may stand for both HC driver and HC device... The host controller device sounds a bit tautological however...
> >
> > Yeah I always meant it to be Host Controller Device :).
> 
>     The question here is more what was meant by the previous Linux USB 
> authors. :-)

I have always used "HCD" to mean Host Controller Driver, and I believe 
that's what other people have done too.

If I want to refer to a Host Controller Device, I would write either
"HC" or "host controller".

Admittedly, this means that struct usb_hcd has a slightly illogical 
name.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
