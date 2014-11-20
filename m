From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/3] omap gpmc changes for v3.19
Date: Thu, 20 Nov 2014 08:08:36 -0800
Message-ID: <20141120160836.GO7046@atomide.com>
References: <pull-1415814409-868361>
 <pull-1415814409-868361-2>
 <201411201202.41698.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38068 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756742AbaKTQIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 11:08:52 -0500
Content-Disposition: inline
In-Reply-To: <201411201202.41698.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [141120 03:04]:
> On Wednesday 12 November 2014, Tony Lindgren wrote:
> > GPMC (General Purpose Memory Controller) changes for omaps. These
> > changes allow us to drop dependencies to bootloader timings now
> > that the known device tree entries have been fixed. So we can now
> > require proper timings to be configured and get rid of the legacy
> > smsc91x code.
> > 
> > Note that this branch has a dependency to the related device tree
> > branch sent in a separate pull request as timings are now required.
> 
> Does this mean you are breaking compatibility with old dtb files?
> 
> Can you be more specific which machines are affected?

Not breaking compability. We had timings missing in the .dts files
for a few devices that caused all kinds of hacks in the GPMC code.

Now those are all fixed up and we are actually using the bindings.

Regards,

Tony
