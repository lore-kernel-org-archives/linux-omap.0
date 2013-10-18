From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/2] omap board removal for some omap3 boards for
 v3.13 merge window
Date: Fri, 18 Oct 2013 08:53:07 -0700
Message-ID: <20131018155306.GK15154@atomide.com>
References: <526041db.41abe00a.33b7.00a1SMTPIN_ADDED_BROKEN@mx.google.com>
 <87hacews6o.fsf@linaro.org>
 <20131018152450.GI15154@atomide.com>
 <CAAwP0s0hMPQ-s1p2VZy4+PRSRKZHL40q5AewEmFqoofP=pNiaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11988 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753043Ab3JRPxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 11:53:14 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s0hMPQ-s1p2VZy4+PRSRKZHL40q5AewEmFqoofP=pNiaQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Javier Martinez Canillas <martinez.javier@gmail.com> [131018 08:46]:
> On Fri, Oct 18, 2013 at 5:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Kevin Hilman <khilman@linaro.org> [131018 07:49]:
> >> Hi Tony,
> >>
> >> Tony Lindgren <tony@atomide.com> writes:
> >>
> >> > The following changes since commit f41509ad0d4c11d0911630440749d409ce2aa1aa:
> >> >
> >> >   Merge branches 'omap-for-v3.13/dt' and 'omap-for-v3.13/quirk' into omap-for-v3.13/board-removal (2013-10-14 11:33:07 -0700)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >
> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/board-removal-signed
> >> >
> >> > for you to fetch changes up to f0c09b7c3b4e6b2fe501b3e888797b470de8320c:
> >> >
> >> >   ARM: OMAP2+: Remove legacy support for zoom platforms (2013-10-15 17:38:21 -0700)
> >> >
> >> > ----------------------------------------------------------------
> >> > Changes needed to drop legacy booting support for some
> >> > omap3 boards.
> >> >
> >> > Note that that these are based on a merge of the
> >> > following for the dependencies:
> >> >
> >> > - v3.12-rc5 for fixes to pinctrl mask
> >> > - omap-for-v3.13/dt-signed to avoid pointless merge conflicts
> >> > - omap-for-v3.13/quirk-signed for legacy pdata handling
> >> >
> >> > ----------------------------------------------------------------
> >> > Aaro Koskinen (2):
> >> >       ARM: dts: add minimal DT support for Nokia N950 & N9 phones
> >> >       ARM: OMAP2: delete board-rm680
> >> >
> >> > Tony Lindgren (6):
> >> >       ARM: dts: Shared file for omap GPMC connected smsc911x
> >> >       ARM: dts: Add common support for omap3-evm
> >> >       ARM: dts: Add basic support for TMDSEVM3730 (Mistral AM/DM37x EVM)
> >> >       ARM: dts: Add basic support for zoom3
> >>
> >> This patch introduces a build failure when compiling the DTBs:
> >>
> >>   [...]
> >>   DTC     arch/arm/boot/dts/omap3-zoom3.dtb
> >> ERROR (phandle_references): Reference to non-existent node or label "wl12xx_gpio"
> >
> > Oops sorry, looks like the common support for omap3-evm has a
> > pinctrl entry that should be in the omap3-evm-37xx only. I guess
> > I did not run make dtbs after adding the omap3-evm-37xx parts.
> > The patch below fixes it for me.
> >
> > Do you want a new pull request or just the fix below?
> >
> 
> Hi Tony,
> 
> If you do a new pull request, it would be great if you can include:
> 
> [PATCH v2 1/1] ARM: OMAP2+: remove legacy support for IGEP boards [1]

Sure I can do that, let's wait and see what Kevin prefers though.

Regards,

Tony
 
> [1]: https://patchwork.kernel.org/patch/3068681/
