From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when
 interrupts are disabled
Date: Fri, 13 Aug 2010 21:15:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008132112090.24267-100000@netrider.rowland.org>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39327 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756728Ab0HNBPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 21:15:38 -0400
In-Reply-To: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Tue, 10 Aug 2010, Kevin Hilman wrote:

> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts will likely be disabled when
> runtime PM for these devices is initiated.
> 
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled.  However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:

...

> Unconditionally enabling interrupts late in the idle sequence is not
> desired behavior.  To fix, use the save/restore versions of the
> spinlock API.
> 
> Reported-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, but
> since the locks are taken and released in separate functions, this
> seems better than changing the function APIs to pass around the flags.

There are restrictions on what you're allowed to do with the flags, but 
I don't remember exactly what they are.

In any case, I don't really like this change.  It seems that we would 
be better off preventing the runtime PM calls from occurring in the 
first place while interrupts are disabled.  In fact, it's hard to see 
what could cause this to happen at all.

Alan Stern

