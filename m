From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP PM EMU fix for v3.3
Date: Fri, 27 Jan 2012 11:02:39 -0800
Message-ID: <20120127190239.GC9339@atomide.com>
References: <87liw8agk4.fsf@ti.com>
 <AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34475 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab2A0TCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 14:02:43 -0500
Content-Disposition: inline
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan.Gowda@elektrobit.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

Hi,

* Madhusudhan.Gowda@elektrobit.com <Madhusudhan.Gowda@elektrobit.com> [120127 10:25]:
> Hi Tony,
> 
> Please pull the PM EMU off mode fix for v3.3

It's best that Kevin queues this as it affects PM. Or it
at least needs an ack from Kevin.

Regards,

Tony
 
> Thanks
> Gowda
> 
> The following changes since commit
> 1c6ece3c23e58d0dbc687407d606f3560ded582a:
> 
>   Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6
> (2012-01-26 16:48:37 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/elektrobit/linux.git linux-omap-emu-fix
> 
> Madhusudhan Gowda (1):
>       ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
> 
>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
>  arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
>  arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> 
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information
> intended solely for the addressee. If you have received this
> e-mail in error, please do not disclose it to anyone, notify
> the sender promptly, and delete the message from your system.
> Thank you.
> 
