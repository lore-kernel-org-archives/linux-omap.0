From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 08:21:57 -0800
Message-ID: <20110217162157.GQ20795@atomide.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-7-git-send-email-balbi@ti.com>
 <4D5D25F9.8030907@ti.com>
 <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
 <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
 <4D5D3D0B.8090106@ti.com>
 <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50804 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab1BQQWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 11:22:22 -0500
Content-Disposition: inline
In-Reply-To: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <balbi@ti.com> [110217 07:25]:
> 
> Tony, what do you prefer ? Do we clear out the dependency, or you queue
> all the patches I have manually ??

Let's apply Benoit's hwmod data patches first into omap-for-linus,
then rebasing other patches to that should be trivial and I can
pull in your patches.

Regards,

Tony
