From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
Date: Thu, 11 Feb 2016 10:41:45 +0100
Message-ID: <56BC5759.80000@metafoo.de>
References: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/11/2016 10:08 AM, Peter Ujfalusi wrote:
> We need the callback to support the dmaengine_terminate_sync().
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Looks good, but I noticed a slight race condition in
edma_completion_handler(). You need to fetch echan->desc while holding the
vchan.lock. Otherwise this can race against terminate_all() and the callback
might get scheduled even though terminate_all() completed and then there is
a race where the synchronize() operation could be called before the callback
gets scheduled, which means it doesn't do its intended job. Highly unlikely
to happen, but theoretically possible.
