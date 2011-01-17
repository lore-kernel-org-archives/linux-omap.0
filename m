From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 13:37:14 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com>
References: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40435 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab1AQLiW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 06:38:22 -0500
In-Reply-To: <20110114194758.GM4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, rmk+kernel@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, 14 Jan 2011, Tony Lindgren wrote:
> Before I update out master branch, let's try to summarize the
> open issues after the merge window. Here's a list of issues
> in omap-fixes-for-linus that I'm aware of:
>
> - NFS root oopses while mounting root
>
> - omap4430 es1.0 hangs if L2X0 cache is enabled
>
> - omap4 panda powers down after boot (watchdog?)
>
> - omap3 ldp board powers down after boot?
>
> Any other issues?

Amstrad E3 fails during the boot. Bisection points to:

 	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
 	Author: Russell King <rmk+kernel@arm.linux.org.uk>
 	Date:   Tue Jan 11 16:23:04 2011 +0000

 	    ARM: sched_clock: allow init_sched_clock() to be called early

The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
defined for all OMAP.

A.
