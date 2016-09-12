From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Mon, 12 Sep 2016 09:35:10 -0400
Message-ID: <20160912133510.GC13192@bill-the-cat>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <57D1B668.3070001@gmail.com>
 <CAL_JsqKYqQpDrLbV0DZ-CvHfeHsXvMc-gncc9obir4gehriXOw@mail.gmail.com>
 <20160909141055.GZ4990@bill-the-cat>
 <CAALWOA_kSghc91PGMTSE9MVbJm7SHjmVrcPfXwN_Fd+snYZdkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA_kSghc91PGMTSE9MVbJm7SHjmVrcPfXwN_Fd+snYZdkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2016 at 03:11:17AM +0200, Matthijs van Duin wrote:
> On 8 September 2016 at 15:38, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > Yes, in theory a device can go from disabled to okay, but that's
> > generally never been supported. Linux takes the simple approach of
> > "disabled" means ignore it. I think we'll see that change with
> > overlays.
> 
> No need for future tense there, overlays are being used on a daily
> basis on the BeagleBone and have already been for years.
> 
> > I don't agree. Generally, disabled means the h/w is there, but don't
> > use it. There may be some cases where the hardware doesn't exist for
> > the convenience of having a single dts, but that's the exception.
> 
> Yes and no. What matters is whether "don't use it" means "you can't
> put it to good use" or "don't even try to reach the peripheral, bad
> things will happen". Right now it's used for both cases.
> 
> Ideally the latter case would be removed from the kernel's view entirely.

What do you mean by "you can't put it to good use" ?  Is that the case
of stuff that's say exposed via a header and could be used but isn't (ie
the cape/hat/chip/etc case) or the IP block is still OK but just not
exposed at all?

What we're trying to address here is the case of "don't even try to
use the peripheral, bad things will happen.  But please properly idle
the IP block!".

-- 
Tom
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
