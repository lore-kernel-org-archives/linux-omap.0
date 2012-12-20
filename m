From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] drivers: mailbox: framework creation
Date: Thu, 20 Dec 2012 11:33:25 -0800
Message-ID: <20121220193325.GH21056@atomide.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
 <20121220182835.GB21056@atomide.com>
 <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14045 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751796Ab2LTTdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 14:33:52 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Loic Pallardy <loic.pallardy-ext@stericsson.com>, arm@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Omar Ramirez Luna <omar.luna@linaro.org>

* Olof Johansson <olof@lixom.net> [121220 11:22]:
> On Thu, Dec 20, 2012 at 10:28 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@linaro.org> [121220 10:19]:
> >> On Tue, Dec 18, 2012 at 2:10 PM, Loic Pallardy
> >> <loic.pallardy-ext@stericsson.com> wrote:
> >>
> >> > OMAP and ST-Ericsson platforms are both using mailbox to communicate
> >> > with some coprocessors.
> >> > Based on OMAP existing mailbox framework, this series proposes a
> >> > generic framework, living under drivers/mailbox.
> >>
> >> I like this patch series so you have my Acked-by.
> >>
> >> Since it's a new subsystem and affects a few ARM architectures can
> >> we merge this into the ARM SoC tree once we have consensus,
> >> so we get some rotation in linux-next that way?
> >
> > Yes good idea.
> >
> >> Olof/Arnd?
> >
> > I suggest we set up an immutable branch against
> > v3.8-rc1 when it's out with only these patches in it.
> > Then we can all merge it in as needed. Maybe Arnd or
> > Olof can set up the branch?
> 
> I haven't reviewed the patches yet, but this flow sounds reasonable to me.

OK cool.
 
> > FYI, looks like I need to merge in this branch too to
> > avoid build errors with remoteproc enabled once I flip
> > on the multiplatform support for omap2+.
> 
> While we can make the branch stable, would it make sense to make
> remoteproc for omap depend on !multiplatform during the transition, to
> reduce dependencies a little? Either way works, but it'd be nice to
> keep them independent if we can.

Yes I'll update the omap multiplat fixups patch I posted yesterday.
I noticed it only after running make randconfig for a while.

Regards,

Tony
