From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 14:18:28 +0100
Message-ID: <20120517131828.GA9650@n2100.arm.linux.org.uk>
References: <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com> <201205041923.07620.arnd@arndb.de> <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com> <4FA7F009.5010003@wwwdotorg.org> <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com> <4FA94B49.5050500@wwwdotorg.org> <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com> <4FAAC111.9020308@wwwdotorg.org> <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com> <4FABF445.3030105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49341 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760961Ab2EQNTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 09:19:16 -0400
Content-Disposition: inline
In-Reply-To: <4FABF445.3030105@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, May 10, 2012 at 11:00:53AM -0600, Stephen Warren wrote:
> To solve Russell's HW, we need some way of representing the mux directly
> in DT irrespective of how the DMA controller or DMA client specify what
> they're connected to. Anything else isn't representing the HW in DT.

Note that it's now no longer _just_ my hardware.

The Spear family of SoCs have a very similar setup - they mux the DMA
request signals between the PL08x and their peripherals.  It looks like
each of the 16 DMA requests to the PL08x can be independently muxed
between four possibilities via a common register.

See arch/arm/plat-spear/pl080.c in current arm-soc.
