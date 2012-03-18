From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 18:22:38 +0000
Message-ID: <20120318182238.3A7D43E07BF@localhost>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203150922.06379.arnd@arndb.de> <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de> <20120317104751.4F00E3E0910@localhost> <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35012 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2CRSWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 14:22:42 -0400
Received: by wibhj6 with SMTP id hj6so2938744wib.1
        for <linux-omap@vger.kernel.org>; Sun, 18 Mar 2012 11:22:41 -0700 (PDT)
In-Reply-To: <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>

On Sun, 18 Mar 2012 10:22:41 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> * Grant Likely wrote:
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

okay.

g.

