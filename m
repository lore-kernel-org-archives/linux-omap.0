From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: Fetch echan->edesc while holding lock
 in edma_comletion_handler
Date: Mon, 22 Feb 2016 08:21:37 +0530
Message-ID: <20160222025136.GS19598@localhost>
References: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org, lars@metafoo.de
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 11, 2016 at 03:17:48PM +0200, Peter Ujfalusi wrote:
> In order to avoid possible race condition when client drivers are using
> dmaengine_terminate_sync() call to disable the channel.

Applied, thanks

-- 
~Vinod
