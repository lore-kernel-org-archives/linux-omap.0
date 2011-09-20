From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Tue, 20 Sep 2011 12:07:48 +0300
Message-ID: <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54100 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab1ITJIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 05:08:09 -0400
In-Reply-To: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Grant Likely <grant.likely@secretlab.ca>

On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> This series includes a new u8500 hwspinlock driver from Mathieu,
> a core fix from Juan and several other cleanups/fixes
> (some of which were reported by Arnd while reviewing Mathieu's
> driver).
=2E..
> =A0Documentation/hwspinlock.txt =A0 =A0 =A0 =A0 =A0 =A0 | =A0 74 ++++=
+++-----
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 15 +++
> =A0arch/arm/mach-omap2/hwspinlock.c =A0 =A0 =A0 =A0 | =A0 =A08 +-
> =A0drivers/hwspinlock/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 27 ++=
+--
> =A0drivers/hwspinlock/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 =
+
> =A0drivers/hwspinlock/hwspinlock_core.c =A0 =A0 | =A0204 ++++++++++++=
+++++++-----------
> =A0drivers/hwspinlock/hwspinlock_internal.h | =A0 40 ++++--
> =A0drivers/hwspinlock/omap_hwspinlock.c =A0 =A0 | =A0127 +++++++-----=
-------
> =A0drivers/hwspinlock/u8500_hsem.c =A0 =A0 =A0 =A0 =A0| =A0198 ++++++=
+++++++++++++++++++++++
> =A0include/linux/hwspinlock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 46 ++=
+++--
> =A010 files changed, 516 insertions(+), 225 deletions(-)

I'm wondering how hwspinlock updates like this should go upstream.

The first hwspinlock batch was picked by Tony, because it involved a
bulk of OMAP changes.

Hwspinlock isn't OMAP-specific anymore though (we gained support for
STE's u8500) and the vast majority of changes are in drivers/. We're
still very much ARM-related, though this may change too at some point
(c6x has a similar "hardware semaphore" peripheral like the u8500
does).

Tony, if you're still willing to pick up these updates I'd be happy to
send you pull requests of course.

Otherwise, I'll appreciate if anyone has any suggestions ?

I'll of course set up a tree for this and ask Stephen to take it to
linux-next as expected (unless someone just prefers to pick up the
acked patches into his tree).

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
