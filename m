From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 13:28:42 +0200
Message-ID: <20110711132842.10606a31@maggie>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:36801 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab1GKL2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:28:53 -0400
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Michael =?UTF-8?B?QsO8c2No?= <mb@bu3sch.de>

On Mon, 11 Jul 2011 14:17:13 +0300
Felipe Balbi <balbi@ti.com> wrote:

> Hi Tony,
> 
> here's the complete series... I'll stop playing
> with these for a while. If you have some free time
> to boot test on n8x0, I'd be really glad ;-)
> 
> Maybe Michael could test too ??
> 
> Felipe Balbi (22):
>   cbus: tahvo: convert spinlock into mutex
>   cbus: tahvo: move to __devinit/__devexit sections
>   cbus: tahvo: a switch looks better
>   cbus: tahvo: don't go over 80 columns
>   cbus: tahvo: drop the tasklet
>   cbus: retu: set IRQF_ONESHOT flag
>   cbus: tahvo: git it a context structure
>   cbus: tahvo: pass tahvo to IRQ handler
>   cbus: tahvo: introduce __tahvo_(read/write)_reg
>   cbus: tahvo: drop some unneded defines
>   cbus: retu: IRQ demux optimization
>   cbus: tahvo: give it an irq_chip
>   cbus: tahvo: start using irq_chip
>   cbus: tahvo: usb: fix up to use threaded irqs
>   cbus: tahvo drop the legacy interfaces
>   cbus: tahvo: usb: drop unused variable
>   cbus: tahvo: no need to mask interrupts on exit
>   cbus: tahvo: drop the get_status hack
>   cbus: tahvo: drop more unused interfaces
>   cbus: tahvo: pass child device pointer
>   cbus: tahvo: drop backlight interfaces
>   cbus: tahvo: drop static global pointer
> 
>  arch/arm/mach-omap1/board-nokia770.c |    6 -
>  arch/arm/mach-omap2/board-n8x0.c     |    6 -
>  drivers/cbus/retu.c                  |   18 +-
>  drivers/cbus/tahvo-usb.c             |   58 ++---
>  drivers/cbus/tahvo.c                 |  462 ++++++++++++++++++----------------
>  drivers/cbus/tahvo.h                 |   16 +-
>  6 files changed, 283 insertions(+), 283 deletions(-)
> 

I currently lack a bit of time for testing, however I'll check it
I can test them at some point. Don't hold your breath, though.

Are you planning to implement a backlight driver for tahvo? I'm actually
using the functionality that you removed in this patchset in the OpenWRT
distribution.
