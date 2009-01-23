From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Thu, 22 Jan 2009 18:04:39 -0800
Message-ID: <20090123020436.GK7172@atomide.com>
References: <1231826765.13843.105.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54862 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbZAWCEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 21:04:41 -0500
Content-Disposition: inline
In-Reply-To: <1231826765.13843.105.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

* Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090112 22:08]:
> Feel free to revert this patch.

OK, reverted from linux-omap master and omap-2.6.28 branches. Also
dropped from omap-fixes queue.

> There appears to be problems with the noised filters
> not obeying the i2c standard.
> 
> I will come up with a new patch in the future.

OK

Tony
