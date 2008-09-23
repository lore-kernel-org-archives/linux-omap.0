From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] watchdog fixes
Date: Tue, 23 Sep 2008 15:59:51 +0300
Message-ID: <20080923125951.GP5102@atomide.com>
References: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55280 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYIWM75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 08:59:57 -0400
Content-Disposition: inline
In-Reply-To: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>

* Felipe Balbi <felipe.balbi@nokia.com> [080923 14:34]:
> Hi Tony,
> 
> following we have omap versions of the watchdog patches.
> 
> As you can see in [1], they're already applied to Wim's
> tree and in fact, you only need the first patch from this
> series; the others can be fetched from Wim.
> 
> Felipe Balbi (3):
>   watchdog: sync mainline changes
>   watchdog: another ioremap() fix
>   watchdog: cleanup a bit omap_wdt.c
> 
>  drivers/watchdog/omap_wdt.c |  223 +++++++++++++++++++++++++------------------
>  1 files changed, 132 insertions(+), 91 deletions(-)

Thanks, pushed them to l-o tree while waiting for them to fall down
from them mainline kernel. Good job Felipe, that's one less driver
to merge!

Tony
