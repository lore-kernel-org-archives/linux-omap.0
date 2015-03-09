From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 14:41:29 -0700
Message-ID: <20150309214129.GK5264@atomide.com>
References: <20150309205157.GE5140@atomide.com>
 <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
 <20150309211306.GC22341@saruman.tx.rr.com>
 <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
 <20150309212014.GE22341@saruman.tx.rr.com>
 <20150309212622.GJ5264@atomide.com>
 <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150309 14:35]:
> On Mon, Mar 9, 2015 at 4:26 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [150309 14:21]:
> >> On Mon, Mar 09, 2015 at 04:17:29PM -0500, Bin Liu wrote:
> >> > On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> >> > > On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
> >> > >> Hi,
> >> > >>
> >> > >> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> > >> > Add a minimal driver for dm816x USB. Otherwise we can just use
> >> > >> > the existing musb_am335x and musb_dsps on dm816x.
> >> > >>
> >> > >> dm816x has the almost identical usbss as that in am335x, we should be
> >> > >> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
> >> > >
> >> > > Tony's using the same musb glue layers, this is just a phy driver,
> >> > > right ?
> >> >
> >> > Can the current am335x phy driver be adopted too? I remember it is
> >> > under drivers/usb/phy/.
> >>
> >> Tony will be best to answer, but according to our IRC discussions, it's
> >> too different. Tony ?
> >
> > Well we should check again between dm814x and am335x documentation
> > against the $subject driver as the dm816x docs were buggy and I may
> > have gotten a wrong idea initially.
> 
> Will it make our life a little easier by comparing the usb drivers for
> dm81xx and am335x in previous TI kernel releases? I cam dig out the
> source code if that helps.

Yeah that probably helps if you've dealt with dm814x earlier :)
Just don't look at the dm816x trm, only the errata pdf works for
dm816x phy.

Note that we still are missing basic support for dm814x in mainline,
I'm planning to tackle that at some point but I don't know when I'm
going to get to it..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
