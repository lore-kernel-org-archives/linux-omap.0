From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Wed, 21 Sep 2011 16:12:33 +0200
Message-ID: <201109211612.33504.arnd@arndb.de>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com> <CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com> <20110920231340.GT18894@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56444 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1IUONQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 10:13:16 -0400
In-Reply-To: <20110920231340.GT18894@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Grant Likely <grant.likely@secretlab.ca>

On Wednesday 21 September 2011, Tony Lindgren wrote:
> * Ohad Ben-Cohen <ohad@wizery.com> [110920 01:34]:
> > On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > 
> > I'm wondering how hwspinlock updates like this should go upstream.
> > 
> > The first hwspinlock batch was picked by Tony, because it involved a
> > bulk of OMAP changes.
> > 
> > Hwspinlock isn't OMAP-specific anymore though (we gained support for
> > STE's u8500) and the vast majority of changes are in drivers/. We're
> > still very much ARM-related, though this may change too at some point
> > (c6x has a similar "hardware semaphore" peripheral like the u8500
> > does).
> > 
> > Tony, if you're still willing to pick up these updates I'd be happy to
> > send you pull requests of course.
> 
> I'd prefer for Greg to take these as these are drivers.
> 
> If he's not taking it at this point based on it being ARM only,
> I can take it then.

Sorry for replying late, I had accidentally ignored the entire thread.

My feeling is that it would be best for Ohad to send these directly
to Linus, since it's basically a standalone subsystem and he's listed
as the maintainer (well, after this series at least).

I'm also fine with any of the other paths like

ohad->GregKH->torvalds
ohad->arnd->torvalds
ohad->tmlind->torvalds
ohad->tmlind->arnd->torvalds

	Arnd
