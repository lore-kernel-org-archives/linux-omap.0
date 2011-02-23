From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] ARM: smp: Select local timers vs dummytimersupportruntime
Date: Thu, 24 Feb 2011 00:41:38 +0530
Message-ID: <b9ea630b656efc370b6c5da78dedd41d@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
 <20110220110341.GA15494@n2100.arm.linux.org.uk> <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
 <20110223163635.GA16041@n2100.arm.linux.org.uk> <780a7a77ef7a93b801ca178e1518e05b@mail.gmail.com>
 <2d63c430d007703753afa4ae98902341@mail.gmail.com> <20110223190305.GB16041@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44274 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840Ab1BWTLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 14:11:40 -0500
Received: by mail-qy0-f173.google.com with SMTP id 36so3815150qyk.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:11:39 -0800 (PST)
In-Reply-To: <20110223190305.GB16041@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, February 24, 2011 12:33 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; tony@atomide.com; David Brown; Daniel
> Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs
> dummytimersupportruntime
>
> On Wed, Feb 23, 2011 at 11:28:11PM +0530, Santosh Shilimkar wrote:
> > Patch 6759/1 and patch 6760/1 in patch system
>
> Was there any difference between 6760 and 6753 ?
Nope.
I just rebased them together and pushed
