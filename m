From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Thu, 2 Jun 2011 14:38:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106021436080.1674-100000@iolanthe.rowland.org>
References: <87lixkyxa8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56602 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752166Ab1FBSiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:38:04 -0400
In-Reply-To: <87lixkyxa8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

On Thu, 2 Jun 2011, Kevin Hilman wrote:

> OK.  I was trying to catch that by checking pm_runtime_suspended(), but
> now see that that cannot work in general.
> 
> The problem I'm trying to solve is how (or whether) I can use runtime PM
> from the system PM methods, specifically in the case where runtime PM
> has been disabled from userspace (or pm_runtime_forbid() has been
> called.)  
> 
> In a nutshell, what I'm after is for any pm_runtime_forbid() calls to be
> cancelled during system PM, thus allowing pending runtime PM events to
> occur during system PM.

There are a few approaches that might do what you want.  But I'd like 
to hear Rafael's opinion before making any suggestions.

Alan Stern

