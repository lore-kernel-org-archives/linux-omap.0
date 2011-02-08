From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 11:16:35 +0000
Message-ID: <20110208111635.GA3333@arm.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
 <20110208110808.GA22877@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44318 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab1BHLQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 06:16:45 -0500
Received: by wwa36 with SMTP id 36so5891788wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 03:16:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208110808.GA22877@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Tue, Feb 08, 2011 at 11:08:08AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > For v6, wfi is architected as a defined MCR instruction, so
> > use that definition.
> > 
> > Doing a no-op instead of wfi() is probably bad, so for older
> > processors than v6, wfi() is not defined.  If needed, some CPU-
> > specific wfi() will have to be defined elsewhere.
> 
> This is something we kind-of already handle in a different way - see
> the individual processor idle function in arch/arm/mm/proc*.S.
> 
> There's various errata work-arounds older CPUs need for wfi (or rather
> its mcr equivalent) so maybe wfi() should just be an alias for a call
> to that function.  Or maybe we shouldn't have a wfi() macro at all.

OK-- I'll hold off on this for now.

The patch was prompted by a build failure, but I can't remember the
exact circumstances now...  if I hit the same problem again,
then it might be worth discussing further...

Cheers
---Dave
