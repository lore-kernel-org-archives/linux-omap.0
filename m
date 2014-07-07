From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/13] uio_pruss: add support for devicetree and am33xx
Date: Mon, 7 Jul 2014 17:50:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407071733500.28318@utopia.booyaka.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com> <20140707084824.GA83417@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54548 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaGGRuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 13:50:10 -0400
In-Reply-To: <20140707084824.GA83417@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Heider <a.heider@gmail.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Mon, 7 Jul 2014, Andre Heider wrote:

> On Sun, Jun 29, 2014 at 06:21:34PM +0200, Andre Heider wrote:
> > 
> > this series adds PRUv2 support to uio_pruss through devicetree, makes the
> > device usable on am33xx and enables it on beaglebone black.
> > Inspired by old patches from Matt Porter found in a downstream tree.
> > 
> > To archieve that this series:
> > * adds a flag to omap_hwmod.c to get PRUSS out of hardreset (patch 5 and 6)

...

> > * is the hardreset thing I did there the right thing to do? I think the
> >   proper way would be a reset controller (which apparently doesn't yet exist
> >   for this SoC?) and let the driver deassert/assert on probe/remove?
> > * the platform device path has a clk_enable() / clk_put() calls. Are those
> >   now redundant with the introduced pm_runtime_enable() pm_runtime_disable()
> >   calls?

Probably you only need pm_runtime_{get,put}_*() calls, unless you're 
changing clock parents or rates in your driver code.

> @OMAP guys: any comments? The series depends on patch 5 and 6; both touch
> common hwmod code.

I'd suggest splitting the series into three independent pieces if 
possible:

1. UIO code, for the UIO maintainer(s)
2. DT pieces for Tony
3. hwmod pieces for me

That way they can be cleanly merged by the respective maintainers.

As far as the hwmod piece goes, I'd be willing to merge your code as a 
temporary workaround for the issue, and marking it as such; but I'd be 
concerned about power management-related interactions (i.e., does the 
PRUSS need to be reset upon return from deep idle states, etc.)


- Paul
