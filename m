From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 11/23] ARM/dmaengine: edma: Merge the two drivers
 under drivers/dmaengine
Date: Mon, 14 Sep 2015 09:12:33 -0700
Message-ID: <20150914161233.GL4215@atomide.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
 <1441974442-8233-12-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441974442-8233-12-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150911 05:35]:
> Move the code out from arch/arm/common and merge it inside of the dmaengine
> driver.
> This change is done with as minimal change to the code as possible to avoid
> any possibilities to introducing regression.

You should check your git config so it uses -M option to git diff
to detect renames. Anyways, assuming you're just moving code, for
the omap parts:

Acked-by: Tony Lindgren <tony@atomide.com>
