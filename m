From: Tony Lindgren <tony@atomide.com>
Subject: Re: getnstimeofday() and suspend
Date: Wed, 13 Aug 2008 17:00:19 +0300
Message-ID: <20080813140016.GE27446@atomide.com>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65170 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYHMN6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:58:12 -0400
Content-Disposition: inline
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

* Tero.Kristo@nokia.com <Tero.Kristo@nokia.com> [080813 15:59]:
> Hi,
> 
> I noticed an interesting feature in the getnstimeofday() function when
> used with suspend. System clock is effectively reset to the value it was
> just before suspend. You can see this behavior e.g. with this command
> line:
> 
> 	date && echo mem > /sys/power/state && date
> 
> With approx. 2 minutes in suspend state the output for me was this:
> 
> / # date && echo mem > sys/power/state && date
> Thu Jan  1 00:13:40 UTC 1970PM: Syncing filesystems ...
> done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s)
> Successfully put all powerdomains to target state
> Restarting tasks ... done.
> Thu Jan  1 00:13:42 UTC 1970
> 
> I.e., the calendar clock was only advanced 2 seconds. The time you spend
> in suspend does not matter, the end result is the same, it will reset
> the time to the value it was before suspend.
> 
> Is this behavior intended?

Hmm, well it should get the value straight from the 32KiHZ sync timer.
Does that get stopped somehow during suspend?

Tony
