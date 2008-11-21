From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAP tree][RFC 2.6.28-rc2-omap 0/9]
Date: Fri, 21 Nov 2008 14:18:52 -0800
Message-ID: <20081121221852.GF4927@atomide.com>
References: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55090 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbYKUWSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:18:53 -0500
Content-Disposition: inline
In-Reply-To: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081031 05:20]:
> This is from the "Continue phasing out legacy GPIO calls" set I sent earlier
> and include files which are in linux-omap tree only.
> 
> This is generated on top of David's recent 4+5 "legacy gpio phaseout.." patches
> in linux-omap tree.
> 
> Note that this still includes the drivers/leds/leds-omap.c which should vanish
> and board-palmtt.c which should be converted to use leds-gpio.c instead.

Pushing this series to l-o tree.

Tony
