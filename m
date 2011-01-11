From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to handle deps
Date: Tue, 11 Jan 2011 19:50:25 +0530
Message-ID: <327d60b24fab12f48959caa67ba83c51@mail.gmail.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com>
 <1294237365-10893-2-git-send-email-rnayak@ti.com> <1294237365-10893-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1101101808530.5731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47807 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932122Ab1AKOU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 09:20:28 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so19906858bwz.20
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 06:20:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101101808530.5731@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, January 11, 2011 7:02 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
b-cousson@ti.com
> Subject: Re: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to
handle deps
>
> On Wed, 5 Jan 2011, Rajendra Nayak wrote:
>
> > Define the following architecture specific funtions for omap2/3
> > .clkdm_add_wkdep
> > .clkdm_del_wkdep
> > .clkdm_read_wkdep
> > .clkdm_clear_all_wkdeps
> > .clkdm_add_sleepdep
> > .clkdm_del_sleepdep
> > .clkdm_read_sleepdep
> > .clkdm_clear_all_sleepdeps
> >
> > Convert the platform-independent framework to call these functions.
> > With this also move the clkdm lookups for all wkdep_srcs and
> > sleepdep_srcs at clkdm_init.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile                     |    2 +
> >  arch/arm/mach-omap2/clockdomain.c                |   80
++++++---------
> >  arch/arm/mach-omap2/clockdomain.h                |    2 +
> >  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  113
++++++++++++++++++++++
> >  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
>
> This is definitely a good start, but a lot of OMAP4 stuff still needs
> to be done.
>
> For example, OMAP4 has static wakeup dependencies just like OMAP2/3;
> described in section 3.1.1.1.7.3 "Wake-Up Dependency" of the OMAP4430
TRM
> Rev. L.
>
> OMAP4 also has static sleep dependencies just like OMAP3; described in
> section 3.1.1.1.7.1 "Static Dependency" of the OMAP4430 TRM
> Rev. L.

I already have some patches to support static dependencies for OMAP4.
Still working towards getting the autogen scripts in place, they seem to
be a bit out of sync with whats in mainline today for clockdomains.
I can post early patches as RFC to get your views on it.

The only difference wrt OMAP3 is there is no control on OMAP4 to
set/clear sleep and wakeup dependencies separately and hence
they are called Static dependency and not 'Static wakeup' or 'Static
sleep'.
Setting a static dependency between clock domains on OMAP4 means setting
sleep *as well as* wakeup dependency.

>
> The dynamic wakeup dependencies (section 3.1.1.1.7.2 of the TRM) and the
> hardware inactivity timer are new for OMAP4.
>
> What's the plan to add support for these?

I will be working on supporting these as well. Can be supported easily on
top
of the clockdomain split series. Still need to get the autogen scripts
updated
to generate the dynamic dependency data.

>
> Based on a brief look, it would seem to make sense to add support now
for
> static sleep dependencies.  These seem quite similar to the OMAP3
> implementation, in that they are between clockdomains.

Again like I said above, my next patch series will add support for static
(sleep
and wakeup) dependencies. The other 'wakeup dependency' that the TRM
section 3.1.1.1.7.3 talks about is slightly different. See my comments
below.

>
> Dynamic wakeup dependencies and the prescaler timer configuration should
> be fairly easy to add since it is a new feature, and thus no OMAP2/3
> implementation is needed.  The dyndep stuff is between clockdomains, so
> there shouldn't be any interaction needed with the hwmod code by my
> reading.
>
> Static wakeup dependency support appears a little more tricky, since the
> dependencies are between modules and clockdomains on OMAP4, rather than
> between clockdomains and clockdomains as they were on OMAP2/3.  One way
to
> handle this would be to change the existing wkdep interface for all
OMAPs
> to be between modules and clockdomains; then for the OMAP2/3
> implementations, use the hwmod code/data to get the clockdomain of the
> module's main_clk.  Another is to add a separate interface to add wkdeps
> between a module and clockdomain, use that for OMAP4, but use the
existing
> clockdomain-to-clockdomain interface for OMAP2/3.  It might be necessary
> to do both until the hwmod data is more complete, then perhaps phase out
> the latter interface.  Thoughts?

The wakeup dependency here (between a module and a clock domain)
is very different from the static dependency (between clock domains) and
is
very much like what the PM_<processor>_GRPSEL registers handled in OMAP3.
They are used to control which processor is woken up on a given module/
peripheral wakeup event. I have not given much thought on this for now but
looks like this needs to be handled in some way using hwmod itself.
I need to work some more to see how this can be handled.

Regards,
Rajendra

>
>
> - Paul
