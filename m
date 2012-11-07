From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer and Counter DT Updates for v3.8
Date: Tue, 6 Nov 2012 16:47:03 -0800
Message-ID: <20121107004703.GS6801@atomide.com>
References: <50941812.2070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33160 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751428Ab2KGArH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 19:47:07 -0500
Content-Disposition: inline
In-Reply-To: <50941812.2070501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [121102 12:01]:
> Hi Tony,
> 
> Please pull the remaining patches to migrate OMAP timers and counters
> over to use device-tree. I recommend applying this after Benoit's DT
> series for v3.8 [1]. 
> 
> This branch contains ...
> - Handling OMAP3 secure timers with device-tree
> - Requesting timer by capability/feature
> - Adds new DT machine descriptor for OMAP3 GP devices
> - Look-up of clocksource/events timers from DT
> - Migrate dmtimer driver to use DT
> 
> Cheers
> Jon
> 
> [1] http://marc.info/?l=linux-omap&m=135179007210696&w=2
>  
> 
> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git@github.com:jonhunter/linux.git dev-dt-timer

Thanks pulling into omap-for-v3.8/dt branch.

Regards,

Tony
 
> for you to fetch changes up to 9883f7c8dd21acb90697582ca331f3f8a66ac054:
> 
>   ARM: OMAP2+: Add device-tree support for 32kHz counter (2012-11-02 13:16:31 -0500)
> 
> ----------------------------------------------------------------
> Jon Hunter (5):
>       ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
>       ARM: OMAP: Add function to request a timer by capability
>       ARM: OMAP3: Add generic machine descriptor for boards with OMAP3 GP devices
>       ARM: OMAP: Add DT support for timer driver
>       ARM: OMAP2+: Add device-tree support for 32kHz counter
> 
>  arch/arm/mach-omap2/board-generic.c       |   17 +++
>  arch/arm/mach-omap2/timer.c               |  203 ++++++++++++++++++++++++-----
>  arch/arm/plat-omap/dmtimer.c              |   93 ++++++++++++-
>  arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
>  4 files changed, 275 insertions(+), 39 deletions(-)
