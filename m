From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 15:10:14 +0000
Message-ID: <201203181510.14428.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120317104751.4F00E3E0910@localhost> <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63651 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab2CRPKa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 11:10:30 -0400
In-Reply-To: <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>

On Sunday 18 March 2012, Thierry Reding wrote:
> Not enough information to check signature validity.  Show Details
>   * Grant Likely wrote:
> > On Thu, 15 Mar 2012 11:27:36 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> > > So if we decide to explicitly allow specifying names, then we can always add
> > > a pwm-names property (or <name>-pwm-names respectively) to use as label and
> > > fallback to the user OF device node name if that property is not present.
> > 
> > After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
> > I definitely prefer the fixed property name plus a separate names property.
> > It is easier to use common code with that scheme, and easier to statically
> > check for correctness.
> 
> Okay. Would everyone be happy with "pwms" and "pwm-names"?

Sounds good. I would have suggested "pwm", but the plural also works since
that is used for "interrupts", too.

	Arnd
