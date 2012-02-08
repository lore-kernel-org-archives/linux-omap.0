From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 8 Feb 2012 15:53:58 -0800
Message-ID: <20120208235358.GD16877@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com>
 <87ty312ae0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47242 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab2BHXyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:54:06 -0500
Content-Disposition: inline
In-Reply-To: <87ty312ae0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120208 14:35]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
> >> While testing on my OMAP3430 platform, this error message was emitted:
> >> 
> >> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
> >> 
> >> Trying to find this message was difficult because it was wrapped across
> >> several lines.  It also mis-spells "required", doesn't read very well,
> >> and has spaces lacking.  Let's replace it with a more concise:
> >> 
> >> omap_vc_init_channel: No PMIC info for vdd_core
> >> 
> >> While we're here, fix a simple spelling error in a comment.
> >> 
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> NAK.
> 
> Tony, please use the patches already in your cleanup branch (that came
> from my for_3.3/cleanup/pm) that fix this and also fix a similar problem
> for VP.

Ah OK, there's the VP part there too.

So that would be the following two patches then for me to
move to fixes from cleanup:

cd63040e00ea83729673acfea1675d85fde6ea59 ARM: OMAP: voltage: cleanup VC/VP error messages
af9a2ed9667b49e7e125eac526d8f655183ce53e ARM: OMAP2+: voltage: add check for missing PMIC info in VP init

And patches 1 and 5 for Russell to drop then.

Everybody OK with that?

Regards,

Tony
