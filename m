From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sat, 7 Dec 2013 09:53:01 -0800
Message-ID: <20131207175300.GQ26766@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201312070918.32471@pali>
 <20131207134818.GA933@earth.universe>
 <201312071457.38836@pali>
 <20131207165104.GD11015@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64557 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab3LGRxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 12:53:04 -0500
Content-Disposition: inline
In-Reply-To: <20131207165104.GD11015@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

* Tony Lindgren <tony@atomide.com> [131207 08:52]:
> 
> I think we can check the configuration from the L3 registers.
> Looks like we no longer have those defined after purging the
> unused defines a while back, but I think the registers for the
> configuration are L3_PM_READ_PERMISSION etc registers.

Hmm I must have grepped in the wrong directory. We do have those
defined in the mainline kernel.

Regards,

Tony
