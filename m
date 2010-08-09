From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Fix sev instruction usage for multi-omap
Date: Mon, 9 Aug 2010 10:48:47 +0300
Message-ID: <20100809074846.GC32480@atomide.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com>
 <20100806070301.GA23778@atomide.com>
 <20100806070519.GB23778@atomide.com>
 <4C5FA33E.6020308@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49511 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab0HIHsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 03:48:54 -0400
Content-Disposition: inline
In-Reply-To: <4C5FA33E.6020308@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Bryan Wu <bryan.wu@canonical.com> [100809 09:35]:
> 
> I also did similar thing these days. And yes, with these 2 CONFIG_SMP related
> patches in omap3_defconfig, I can built a single for omap2/3/4 with CONFIG_SMP=y.
> 
> But the kernel still doesn't boot on both omap3 beagle board and omap4 panda
> board on my side.
> 
> I'm very glad to help this out.

Yeah let's try to figure out what needs to be done to boot it. To me it
looks like we should be able to get omap3 & 4 kernel working with CONFIG_SMP
with (hopefully) minor changes.

Then getting omap2 working will require more work as some instructions
require CONFIG_CPU_32v6K extensions, and 24xx does not support that.

Regards,

Tony
