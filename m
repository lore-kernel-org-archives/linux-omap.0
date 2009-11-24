From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP3: enabling CPU idle leads to panic
Date: Wed, 25 Nov 2009 01:51:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>,<873a43wzfm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40695 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932678AbZKXUVZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 15:21:25 -0500
In-Reply-To: <873a43wzfm.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Sergey Lapin <slapinid@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Kevin Hilman [khilman@deeprootsystems.com]
Sent: Tuesday, November 24, 2009 11:57 PM
To: Sergey Lapin; Premi, Sanjeev
Cc: linux-omap@vger.kernel.org
Subject: Re: OMAP3: enabling CPU idle leads to panic

Sergey Lapin <slapinid@gmail.com> writes:

> I use PM branch merged with linux-omap branch.

Not sure what this means.  PM branch is already based at linux-omap
master branch.  You'll need to be more specific, ideally with commit
IDs.

[sp] I will also need the last commit from pm branch - if not the id; the
commit header to start.

[snip]--[snip]

>
> addr2line -e vmlinux c003b5c0
> /home/slapin/linux-omap-my-2.6.git/arch/arm/mach-omap2/powerdomain.c:452
> It is in function
> int pwrdm_for_each_clkdm(), where pwrdm is NULL.
> farther investigations found that "core_pwrdm" is defined only for 24xx,
> but I use 3525, and it is being searched.

[sp] I am a little confused here. core_pwrdm is defined for 34xx as well.
Other than sgx, there isn't any difference between 3530 and 3525.
See the definition at:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/powerdomains34xx.h;hb=867d320b6c30d2478358eafeca0e1a6c60cf06c3#l203

>
> This is where variable allocated. If I add BUG_ON(!core_pd), it crashes here.
> arch/arm/mach-omap2/cpuidle34xx.c:348:        core_pd = pwrdm_lookup("core_pwrdm");
> Otherwise it crashes the above way. Any ideas on how to fix this?

[sp] Have you hand-picked the commits from pm branch and applied against
 master?

Best regards,
Sanjeev

PS: responding thru a web client. It doesn't seem to support quoting the original message.


I think there is still ongoing work on support for the 3525.  I'm
guessing the clock/pwrdm init still needs work for that SoC.

I have no 3525 hardware, but maybe Sanjeev has more details.

Kevin

