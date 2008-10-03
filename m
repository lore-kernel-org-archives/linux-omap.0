From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch] ehci-omap: (mostly) cosmetic cleanups
Date: Fri, 3 Oct 2008 11:01:58 +0300
Message-ID: <20081003080154.GE10743@frodo>
References: <200810030003.34109.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58055 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJCICQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 04:02:16 -0400
Content-Disposition: inline
In-Reply-To: <200810030003.34109.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 03, 2008 at 12:03:33AM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Various cleanups to the OMAP EHCI bus glue:
> 
>  - Whitespace fixes.
> 
>  - Busy-wait loops should really have timeouts, but lacking
>    that ... at least cpu_relax() in the body.
> 
>  - Debug messages should end with newlines, so they don't
>    break the next message; should not embed newlines; and
>    should otherwise be clean and correctly spelled.
> 
>  - The probe() method should have initialized the SBRN value,
>    so the driver didn't report "USB 0.0 started".
> 
>  - The MODULE_ALIAS() was missing its "platform:" prefix;
>    doing it right means the module could hotplug/coldplug.
> 
> No real functional change except for the hotplug/coldplug thing.

I actually sent this patch (besides SBRN init) way back in time but
Vikram and Anand (??) asked to hold on that patch since some patches
would come from TI for ehci and ohci.

Never saw those patches till now.

-- 
balbi
