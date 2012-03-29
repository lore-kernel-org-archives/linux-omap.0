From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes for merge window
Date: Wed, 28 Mar 2012 22:01:23 -0700
Message-ID: <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
References: <20120321180536.GK9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65327 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab2C2FBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 01:01:23 -0400
Received: by ghrr11 with SMTP id r11so1253501ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 22:01:23 -0700 (PDT)
In-Reply-To: <20120321180536.GK9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Hi Tony,

On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here's a set of fixes that would be nice to get merged during
> the merge window before the GPIO changes get merged to avoid
> boot issues on many omap boards.
>
> The changes queued in the GPIO tree require getting rid of
> OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
> dynamically allocated GPIO interrupt ranges.

Sorry for the slow response on this, we've been focused on getting the
main pulls going in. I'm about to start a fixes branch now and looked
at this pull request.

I replied to one of the original patches in this branch, they need to
be fixed before they can go in:

http://marc.info/?l=linux-omap&m=133299716528617&w=2

Also, that way we can get a clean branch based on current mainline
without merge conflicts.


-Olof
