From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] legacy gpio phaseout (IV) ...
Date: Tue, 25 Nov 2008 14:31:51 -0800
Message-ID: <20081125223149.GV11997@atomide.com>
References: <1227622334-27227-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61926 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYKYWbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 17:31:52 -0500
Content-Disposition: inline
In-Reply-To: <1227622334-27227-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081125 06:13]:
> Let's do this gpiolib conversion in smaller steps...
> 
> At this time I applied David's four conversion patches for (OMAP and mainline)
> on top of mainline. Then I applied my previous set, dropped out the conflicting
> files and applied that set on top of linux-omap and did these two commits.
> 
> However, some files have huge offsets like -89 lines when applying back to
> mainline. But applies anyway.
> 
> Have to look what to do for remaining conflicting files.

OK, pushing these two today and adding them to omap-upstream queue.

I've also deleted your earlier gpio converions patches from my inbox
while waiting for your refreshed patches.

Tony
