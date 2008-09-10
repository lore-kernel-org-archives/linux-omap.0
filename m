From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Wed, 10 Sep 2008 20:38:30 +0100
Message-ID: <20080910193830.GB13467@flint.arm.linux.org.uk>
References: <27F9C60D11D683428E133F85D2BB4A534486D6A4@dlee03.ent.ti.com> <20080829.080313.110221229.Hiroshi.DOYU@nokia.com> <20080910.070827.145357958.Hiroshi.DOYU@nokia.com> <20080910154414.GB29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45922 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYIJTix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 15:38:53 -0400
Content-Disposition: inline
In-Reply-To: <20080910154414.GB29054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, x00omar@ti.com, h-kanigeri2@ti.com

On Wed, Sep 10, 2008 at 08:44:14AM -0700, Tony Lindgren wrote:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080909 21:08]:
> > Hi,
> > 
> > Although this TI bridge patches are not integrated and a bit
> > independent S/W component, it would be nice to get some comments just
> > on this bridge header file location from kernel maintainer's
> > perspective.
> > 
> > "arch/arm/plat-omap/include/mach/bridge"
> >   or "arch/arm/plat-omap/include/bridge"?
> 
> How about put the bridge specific headers under include/linux/dspbridge?
> Then you can have just the omap specific headers under
> arch/arm/plat-omap/include/mach.

There's an advantage to having them under arch/arm/plat-omap/include/dspbridge
- it's portable.  If ever they need to become more visible, they can be easily
moved to arch/arm/include/dspbridge or include/dspbridge instead.
