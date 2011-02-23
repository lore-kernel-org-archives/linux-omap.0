From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: smp: Select local timers vs dummytimersupport runtime
Date: Wed, 23 Feb 2011 23:28:11 +0530
Message-ID: <2d63c430d007703753afa4ae98902341@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
 <20110220110341.GA15494@n2100.arm.linux.org.uk> <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
 <20110223163635.GA16041@n2100.arm.linux.org.uk> <780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56982 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753914Ab1BWR6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 12:58:15 -0500
Received: by qwk3 with SMTP id 3so2832842qwk.9
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 09:58:12 -0800 (PST)
In-Reply-To: <780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Wednesday, February 23, 2011 10:09 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com; David Brown; Daniel
> Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> Subject: RE: [PATCH 1/5] ARM: smp: Select local timers vs
> dummytimersupport runtime

[....]

> >
> > Grr.  This conflicts horribly with the Versatile stuff.  Can you
> > recreate
> > against what currently appears in devel rather than mainline
> please?
> Ok. I will pull your devel branch and rebase it

Done.
Patch 6759/1 and patch 6760/1 in patch system

Regards,
Santosh
