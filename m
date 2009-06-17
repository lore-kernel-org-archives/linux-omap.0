From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 07:23:59 -0700
Message-ID: <20090617142358.GW6605@atomide.com>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com> <4A38F387.1050502@gmail.com> <20090617141137.GJ6374@everest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55429 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbZFQOX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:23:58 -0400
Content-Disposition: inline
In-Reply-To: <20090617141137.GJ6374@everest>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>, linux-omap@vger.kernel.org

* Amit Kucheria <amit.kucheria@verdurent.com> [090617 07:19]:
> On 09 Jun 17, Eugeny S. Mints wrote:
> > Amit Kucheria wrote:
> >> Reset twl4030.h to what is upstream. Patches to restore twl4030_power
> >> functionality will follow directly to lkml.
> >>
> >>   
> > development against upstream is great. But what will be left for
> > this mail list if we send all patches directly to lkml?
> 
> I think the idea is that (and Tony should correct me here if I'm wrong)
> core OMAP code is handled here while peripheral drivers will all go
> directly to their respective susbsystem maintainers upstream.

Yeah, so for the twl4030 patches that's mostly drivers/mfd.

If we pile up things to linux-omap, that code never goes anywhere
and keeps piling up!

And now for the first time ever, we have pretty much all we need
working in the mainline kernel! So that should be the stable base
for any distros or prodcuts starting with 2.6.31.

Tony
