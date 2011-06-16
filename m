From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3.0] OMAP: drop __initdata tags from static struct
	platform_device declarations
Date: Thu, 16 Jun 2011 23:18:32 +0100
Message-ID: <20110616221832.GB9698@n2100.arm.linux.org.uk>
References: <201106170002.46387.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33758 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454Ab1FPWTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 18:19:13 -0400
Content-Disposition: inline
In-Reply-To: <201106170002.46387.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

On Fri, Jun 17, 2011 at 12:02:46AM +0200, Janusz Krzysztofik wrote:
> Pointers to statically declared platform device structures which are 
> registered with platform_device_register() are then used during run time 
> to access these structure members, for example from platform_uevent() 
> and much more. Therefore, these structures should never be placed inside 
> sections which are dropped after boot. Fix platform devices incorrectly 
> tagged with __initdata which happen to exist inside OMAP sub-trees.

It would be a good idea to cc the authors of the patches which
introduced this stuff, so that they learn that registering platform
devices marked with __initdata is a bad idea.  We live in hope that
doing so will prevent it happening in the future.

