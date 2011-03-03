From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] cbus-retu-wdt: Make the watchdog driver fully
 preemptible
Date: Wed, 2 Mar 2011 17:33:08 -0800
Message-ID: <20110303013308.GI20560@atomide.com>
References: <1299082307.13604.12.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45943 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1CCBdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:33:17 -0500
Content-Disposition: inline
In-Reply-To: <1299082307.13604.12.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Michael Buesch <mb@bu3sch.de> [110302 08:09]:
> Make the WDT driver fully preemptible.
> This is required in order to apply a locking fix to retu_write_reg.
> It also improves power management by using round_relative_jiffies().

Thanks, seems to stay running, so applying all your remaining patches
to the cbus branch.

Tony
