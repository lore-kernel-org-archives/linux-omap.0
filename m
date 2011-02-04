From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 4 Feb 2011 16:41:49 +0000
Message-ID: <20110204164149.GB21122@arm.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
 <36192288611a2912eca9abc99a4353ff@mail.gmail.com>
 <AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com>
 <9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49209 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1BDQmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:42:01 -0500
Received: by wwa36 with SMTP id 36so2547437wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:42:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Fri, Feb 04, 2011 at 04:46:57PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Dave Martin [mailto:dave.martin@linaro.org]
> > Sent: Friday, February 04, 2011 4:33 PM
> > To: Santosh Shilimkar
> > Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; Jean Pihet=
-
> > XID; linux-omap@vger.kernel.org; Nicolas Pitre
> > Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility
> > fixes
> >
> > On Fri, Feb 4, 2011 at 10:45 AM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> > > Dave,
> > >> -----Original Message-----
> > >> From: Dave Martin [mailto:dave.martin@linaro.org]
> > >> Sent: Thursday, February 03, 2011 11:33 PM
> > >> To: linux-arm-kernel@lists.infradead.org
> > >> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> > >> linux-omap@vger.kernel.org; Nicolas Pitre
> > >> Subject: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility
> > fixes
> > >>
> > >> This set of patches, along with some other patches under
> > >> discussion on alkml, should enable omap3 and omap4 kernels to be
> > >> built with CONFIG_THUMB2_KERNEL.
> > >>
> > >> This patch set builds on recent cleanup done by the omap
> > >> maintainers.
> > >>
> > >> It is also more aggressive than my last post: all affected
> > >> low-level code is now built in Thumb-2. =A0At least some of this
> > >> code definitely works, but whether the Secure firmware can talk
> > >> to Thumb-2 code properly is unproven:
> > >> in particular, I could use some help/advice from the omap
> > >> community for validating that the low-level power management
> > >> interactions actually work with this patch set.
> > >>
> > >> I've done simple "does it boot?" testing by building a single
> > >> kernel with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL enabled
> > >> which works on Beagle xM A2 and Panda A1.
> > >
> > > I have boot tested this series on OMAP3430 and OMAP4430. Also
> > > tested the RETENTION and OFF mode in suspend on OMAP3.
> >
> > Which tree did you use to test this?  It didn't seem to work for me
> > --
> > sometimes the system wouldn't suspend, complaining about USB suspen=
d
> > errors; and other times I couldn't bring it out of suspend (by
> > poking
> > a USB input device).
> >
> > I might be doing something wrong...
> >
> I should have mentioned this.
> Used Kevins pm branch to test these features.
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it

Have you tried this kernel on Beagle xM with CONFIG_SMP and
CONFIG_SMP_ON_UP enabled?  For me it hangs just after
"Uncompressing Linux ... ok, booting the kernel".

I haven't worked out why this happens as yet.

Also, I'm still not sure I'm testing the power management
features correctly.  Do you know what config options I need to poke?
Also, how do I resume after echo mem >/sys/power/state?

Cheers
---Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
