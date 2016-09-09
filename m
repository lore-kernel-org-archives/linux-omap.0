From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Fri, 9 Sep 2016 10:10:55 -0400
Message-ID: <20160909141055.GZ4990@bill-the-cat>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <57D1B668.3070001@gmail.com>
 <CAL_JsqKYqQpDrLbV0DZ-CvHfeHsXvMc-gncc9obir4gehriXOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKYqQpDrLbV0DZ-CvHfeHsXvMc-gncc9obir4gehriXOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 08, 2016 at 09:43:03PM -0500, Rob Herring wrote:
> On Thu, Sep 8, 2016 at 2:05 PM, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On 09/08/16 06:38, Rob Herring wrote:
> >> On Wed, Aug 31, 2016 at 4:41 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >>> * Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160831 13:51]:
[snip]
> >>>> Why not just create a new property that describes the hardware?
> >>>> Perhaps something like:
> >>>>
> >>>>    incomplete = "pins_output", "buggy_dma";
> >>>
> >>> New property for incomplete works for me. Rob, got any comments here?
> >>
> >> Pins not muxed out or connected on the board has to be the #1 reason
> >> for disabled status. I don't think we need or want another way to
> >> express that.
> >
> > How is that expressed now?
> 
> status = "disabled";

It might be worth repeating that the problem that needs to be solved is
that we have an IP block that exists in some sense but needs to be shut
down (or some similar case the driver can handle) rather than ignored
like today.  This is not the same as having 5 UARTs available from the
SoC but only one is actually in some useful physical state, so list all
5 in the dtsi, status disabled, and then in the board dts file enable
the exposed ones.

-- 
Tom
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
