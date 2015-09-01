From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA752: Add ID detect for ES2.0
Date: Tue, 1 Sep 2015 08:47:46 -0700
Message-ID: <20150901154746.GL4215@atomide.com>
References: <1439476340-20141-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439476340-20141-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150813 07:35]:
> From: Vishal Mahaveer <vishalm@ti.com>
> 
> ES2.0 is a minor variant of ES1.1. ES2.0 is an incremental revision
> with various fixes including the following:
> 	- reset logic fixes
> 	- few assymetric aging logic fixes
> 	- MMC clock rate fixes
> 	- Ethernet speed fixes
> 	- edma fixes for mcasp
> 
> NOTE: even though we use a compatible of dra742 and dra752, the usage in
> the Linux kernel is more or less interchangable - we use dra752 more
> often in the linux kernel compared to dra742 and 4.2-rc6
> 
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on linux-next next-20150812, applies to v4.2-rc6 as well.
> Definetly not a 4.2 material, for 4.3, this probably missed the first merge
> window for 4.3, will be great if it could be considered for the second merge
> window.

I'll apply this into omap-for-v4.3/fixes thanks,

Tony
