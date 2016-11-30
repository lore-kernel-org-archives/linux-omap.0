From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: re-initialize dummy slot during system
 resume
Date: Wed, 30 Nov 2016 08:55:23 +0530
Message-ID: <20161130032522.GA6408@localhost>
References: <20161123092755.8522-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123092755.8522-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 23, 2016 at 02:57:55PM +0530, Vignesh R wrote:
> The last param set in a transfer should always be pointing to dummy
> param set in non-cyclic mode. When system wakes from low power state
> EDMA PARAM slots may be reset to random values. Hence, re-initialize
> dummy slot to dummy param set on system resume.

Applied, thanks

-- 
~Vinod
