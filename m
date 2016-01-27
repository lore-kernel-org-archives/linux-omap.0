From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmaengine: edma: Remove dynamic TPTC power management
 feature
Date: Wed, 27 Jan 2016 07:54:23 -0800
Message-ID: <20160127155422.GH19432@atomide.com>
References: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160127 01:12]:
> The dynamic or on demand pm_runtime does not work correctly on am335x and
> am437x due to interference with hwmod.

Hmm care expand a bit what is the problem with this "interference"?

Regards,

Tony
