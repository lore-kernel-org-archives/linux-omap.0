From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: tidspbridge broken?
Date: Mon, 4 Oct 2010 10:59:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304680CC90F@dlee03.ent.ti.com>
References: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37343 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756389Ab0JDP76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:59:58 -0400
In-Reply-To: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "Menon, Nishanth" <nm@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Hi,

Felipe Contreras wrote:
> Hi,
> 
> I was trying the iommu patches but I noticed the tidspbridge driver
> doesn't work at all, I found two critical issues: 
> 
> First, the platform device is missing, so there's no way the driver
> can work. It seems to have been dropped from the migration to staging
> which happened some time ago... I would have expected somebody to
> notice a thing like this. I already have patches that fix this.   

Yes this is missing from beginning, I seeked advice on whether to send a patch for this or not, and since it would be touching mach dependent files it would be out of the scope of staging tree, however if needed:

http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=4dcb41d484653d162b2bc6e1bf226c2dad0b953c

This was meant to placed under dspbridge wiki, I still have to do that one.

> 
> And second, since 2.6.35, ioremap() doesn't work on RAM, so this
> driver cannot work anymore unless 309caa9 is reverted. I am reserving
> the memory with memblock, but it still fails the ioremap(), and
> __va() doesn't seem to work (don't know why).   
>

Yes that's true, so far the only solution I have seen is to move the allocation on memory outside kernel control, I believe framebuffer has the same problem, but I haven't contacted them to see if we can align on a common solution.
 
> Has anyone tried the driver on 2.6.36-rcX?

Yes I have, I was rebasing your mailbox hwmod patches but seems something has changed since they don't work, I was trying to write my own version.

After that, I was planning the migration from bridge tasklet to a process context, and see how it works, since the spin_lock method used in the mailbox driver also causes an invalid locking condition.

Regards,

Omar