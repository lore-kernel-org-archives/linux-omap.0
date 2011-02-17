From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 10:18:49 -0800
Message-ID: <20110217181849.GV20795@atomide.com>
References: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
 <4D5D44AF.5050805@ti.com>
 <20110217162000.GP20795@atomide.com>
 <20110217162209.GA13425@legolas.emea.dhcp.ti.com>
 <20110217165953.GR20795@atomide.com>
 <4D5D5770.9020501@ti.com>
 <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
 <4D5D59E5.6020307@ti.com>
 <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
 <4D5D5F13.2010602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:31903 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093Ab1BQSTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 13:19:13 -0500
Content-Disposition: inline
In-Reply-To: <4D5D5F13.2010602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

* Cousson, Benoit <b-cousson@ti.com> [110217 09:45]:
> 
> Done, boot tested, and that does remove the warning about the
> missing opt clock you had with the previous data.
> 
> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> 
> Just let me know if it does break anything else.

Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
and devel-mcspi branches.

Tony
