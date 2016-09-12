From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Mon, 12 Sep 2016 09:38:54 -0400
Message-ID: <20160912133854.GD13192@bill-the-cat>
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

[snip]
> On 8 September 2016 at 16:20, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> > Minor point here
> 
> It's not minor, it's quite crucial.
> 
> > maintaining dts per paper spin is just too impossible to maintain
> 
> Even if the per-spin dtsi just consists of including the common dtsi
> and then applying /delete-node/ per peripheral that is disabled in
> efuse? (or through firewalling, e.g. on HS devices)
> 
> > the variations if maintained as seperate dts might infact end up being
> > larger in number than all the dts we have in arch/arm/boot/dts
> 
> There are 813 dts files there. Even if there were a dra7xx and am57xx
> for every value of x (and there really isn't) you wouldn't get
> anywhere near there.
> 
> But, fair enough, efuse bits are definitely an excellent way to get
> combinatorial explosion.
> 
> Afaik those feature bits are readable through the control module on TI
> SoCs though. Assuming such a thing is the norm in SoC world maybe a
> "delete-if" property referencing some sort of test on register bits of
> a referenced syscon node might do the trick?
> 
> On the cortex-A8 doing auto-detection would be a feasible alternative,
> by reusing the existing exception mechanism to trap synchronous
> aborts, but e.g. the Cortex-A15 seems to use async aborts for *every*
> bus error, which makes things just very awful.

I think this still misses one of the keys which is that for the IP block
that has been efused (or whatever) into being unusable it's also still
true that the IP block needs to be properly turned off.  The IP in
question wasn't removed from the SoC but rather an ice pick was jammed
into a critical path meaning you can't use it and now it's in zombie
state.  The kernel needs to know about it so that it can finish the job.

-- 
Tom
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
