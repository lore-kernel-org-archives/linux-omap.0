From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 11:09:16 +0000
Message-ID: <201209191109.16529.arnd@arndb.de>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <201209172042.11860.arnd@arndb.de> <5058F35A.8040702@firmworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59689 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2ISLJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 07:09:29 -0400
In-Reply-To: <5058F35A.8040702@firmworks.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mitch Bradley <wmb@firmworks.com>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, linux-omap <linux-omap@vger.kernel.org>, Alexander Schulz <alex@shark-linux.de>

On Tuesday 18 September 2012, Mitch Bradley wrote:
> There is a delicious irony here with respect to Shark.  Shark has real
> Open Firmware.  It's the platform that I used for the first OFW port to
> ARM.  We (the Shark design team) had a version of NetBSD that would run
> on Shark without any native drivers, calling into the Open Firmware
> drivers.  It was very useful for bringup.

Very interesting, thanks for sharing this bit of history. Are you aware
of other ARM systems using open firmware that we still support in Linux
(besides the XO-1.75)?

> Is there ever a point when old architectures leave the Linux tree, or
> will people have to see grep hits from them until the end of time?

As long as someone is interested in keeping an architecture or driver
alive, it stays. If something is causing problems and we have reason
to assume it will never be used again with current kernels, we toss
them out. Russell has recently removed support for ARMv3 CPUs, but
some of the StrongARM targets (especially SA-1100) are still being
actively used, so the CPU support is not going away any time soon.

If you have a bunch of Shark machines for testing and would like to
port it over to device tree passing from its open firmware, you are
definitely welcome ;-)

	Arnd
