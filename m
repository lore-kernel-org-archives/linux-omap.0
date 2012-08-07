From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS and USBHOST powerdomains not entering low-power states on
 37xx EVM
Date: Tue, 7 Aug 2012 04:05:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208070401530.21945@utopia.booyaka.com>
References: <alpine.DEB.2.00.1208031355450.28888@utopia.booyaka.com> <877gtb6723.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54066 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab2HGKFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 06:05:34 -0400
In-Reply-To: <877gtb6723.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Mon, 6 Aug 2012, Kevin Hilman wrote:

> Is this only happening on this 37xx platform?    Just curious, because
> it seems to be a problem on any OMAP3xxx SoC.

So far I've only run the baseline tests on 37xx, so wanted to state only 
what was observed here.

> ...it must be the usecounts that are not being updated.  This seems to
> be a side effect of the pre/post transition optimization I did.  A quick
> hack seems to indicate that that's indeed the case[1].  By default,
> omap_sram_idle() is now only calling the pre/post callbacks for MPU,
> NEON, PER, and CORE, and only if those domains are transitioning, so any
> other domains not explicitly managed by the idle path have lots their
> usecounting.  Oops.
> 
> I guess Tero's usecounting series should fix this up.

Thanks for the diagnosis.  Care to put together a patch to fix this for 
v3.6-rc?  The earliest point that the usecounting improvements could get 
in would be v3.7.  This problem is breaking the PM regression tests here 
that parse the powerdomain state count fields.


- Paul
