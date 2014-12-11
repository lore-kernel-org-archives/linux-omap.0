From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Thu, 11 Dec 2014 09:56:52 -0800
Message-ID: <20141211175651.GC2990@atomide.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
 <20141210145433.GC4602@saruman>
 <20141211005238.GC5585@earth.universe>
 <20141211142333.GE20762@saruman>
 <20141211174434.GA2022@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63708 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932990AbaLKSAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2014 13:00:06 -0500
Content-Disposition: inline
In-Reply-To: <20141211174434.GA2022@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [141211 09:46]:
> On Thu, Dec 11, 2014 at 08:23:33AM -0600, Felipe Balbi wrote:
> > true, but I'm still a bit iffy wrt that. ABI compatibility breaks and
> > all
> 
> Moving the hwmod data to device tree will break the ABI
> compatibility anyways. You wont be able to use an old DT with the
> new kernel, since then you are missing the hwmod data (assuming
> there won't be a fallback hwmod data kept in the kernel source).

Right, the way to deal with that is to do the following:

1. Once we have the binding in place, start printing out warnings
   and deprecate the old built in data.

2. For missing sysc data, we just keep printing warnings and won't
   idle or enable the devices. This keeps the optional boot console
   UART working based on the bootloader settings.

3. We may want to keep the UART and system timer data around forever
   to be able to print sane error messages.

> > > IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
> > > hwmod database should reference the compatible values. This depends
> > > on omap3 being DT only of course.
> > 
> > don't you think it's too late for that ? We need to support the current
> > form of dts files forever. It's an ABI afterall.
> 
> As I described above the ABI *will* break if hwmod data is removed from
> the kernel.

Right, there is no way we can support incomplete device tree
bindings except for devices that are enabled by the bootloader
already. But we can take our time removing the built-in device
data, there's no need to do it all at once.

> OTOH where is the ABI breakage when hwmod database in kernel is
> built from the compatible value? The compatible values are already
> part of the ABI, so there are no new properties needed. The ti,hwmod
> property can be marked as deprecated (and maybe removed after some
> years).

Yes we can keep it around but don't have to do anything with it
eventually. For the legacy systems, we can have built in mapping
of compatible values to ti,hwmods along the clock aliases.

Regards,

Tony
