From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next - multi-omap image fails to boot on omap3/4
Date: Thu, 21 Oct 2010 09:15:45 -0700
Message-ID: <20101021161545.GC3616@atomide.com>
References: <4CBDAFFF.2030409@ti.com>
 <20101019182149.GC3038@atomide.com>
 <AANLkTikYGwH-kQV3b+gqDYOKVvuiXOU=kBDVLy3ryNjR@mail.gmail.com>
 <20101019225726.GE3038@atomide.com>
 <20101019233204.GA30991@atomide.com>
 <AANLkTikrVJ3bw3aKE6V7uH9DmheVDihedNOP+wypYunC@mail.gmail.com>
 <AANLkTimqymuGdD3_SX2RVj=6a9j+ODKy8ipYZ-6hqw+S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64821 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0JUQPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 12:15:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimqymuGdD3_SX2RVj=6a9j+ODKy8ipYZ-6hqw+S@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [101019 23:21]:
> On Wed, Oct 20, 2010 at 5:16 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> > On Wed, Oct 20, 2010 at 5:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Tony Lindgren <tony@atomide.com> [101019 15:48]:
> >>> * Gadiyar, Anand <gadiyar@ti.com> [101019 11:26]:
> >>> > On Tue, Oct 19, 2010 at 11:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>> > > * Anand Gadiyar <gadiyar@ti.com> [101019 07:41]:
> >>> > >> Hi all,
> >>> > >>
> >>> > >> linux-next, as of 20101019, built with the omap2plus_defconfig fails
> >>> > >> to boot on omap3 and omap4. (I've disabled CONFIG_ARCH_OMAP2 or
> >>> > >> CONFIG_SWP_EMULATE to get the image to build). Building with only
> >>> > >> ARCH_OMAP3 allows the resultant image to boot up on OMAP3. Likewise,
> >>> > >> an image built with only ARCH_OMAP4 boots up on OMAP4 boards.
> >>> > >>
> >>> > >> earlyprintk does not provide any additional prints after
> >>> > >> "Uncompressing Linux... done, booting the kernel."
> >>> > >>
> >>> > >> Any ideas where to look?
> >>> > >
> >>> > > Hmm I did a quick test merge of linux-omap master and rmk/devel
> >>> > > branches and that boots just fine.
> >>> > >
> >>> > > So it's probably something that already got fixed in rmk/devel
> >>> > > but is not yet in next, or something that came from elsewhere,
> >>> > > or something that we have in omap-testing branch that's not in
> >>> > > for-next for some reason.
> >>> >
> >>> > I tried bisecting linux-next between v2.6.36-rc8 and HEAD, but
> >>> > there's a commit in between that breaks the build. I'll take another
> >>> > stab at this in a while.
> >>>
> >>> Looks like current next at 80f8f1f8b33750d954beb386c0c8142d0c01c25c
> >>> boots again except on 2430sdp it produces a NULL pointer at ubi_io_write.
> >>
> >> Oops, sorry it's still broken, wrong tree.
> >>
> >
> > I've started bisecting again - I needed to pick commit 5bac0926121e
> > (driver core: platform_bus: allow runtime override of dev_pm_ops) to
> > solve the build break.
> >
> > Will report back if I find something.
> >
> 
> I tried disabling CONFIG_SMP and CONFIG_SMP_ON_UP, and the resulting
> image booted up just fine.

Looks like it's caused by this patch:

"ARM: hotplug cpu: Keep processor information, startup code & __lookup_processor_type"

It's probably trashing registers it shouldn't. Will take a look and post
something to linux-arm-kernel.

Tony
