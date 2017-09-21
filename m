From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] dmaengine: edma: Align the memcpy acnt array size
 with the transfer
Date: Thu, 21 Sep 2017 22:51:26 +0530
Message-ID: <20170921172126.GJ30097@localhost>
References: <20170918081626.12878-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170918081626.12878-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 18, 2017 at 11:16:26AM +0300, Peter Ujfalusi wrote:
> Memory to Memory transfers does not have any special alignment needs
> regarding to acnt array size, but if one of the areas are in memory mapped
> regions (like PCIe memory), we need to make sure that the acnt array size
> is aligned with the mem copy parameters.
> 
> Before "dmaengine: edma: Optimize memcpy operation" change the memcpy was set
> up in a different way: acnt == number of bytes in a word based on
> __ffs((src | dest | len), bcnt and ccnt for looping the necessary number of
> words to comlete the trasnfer.
> 
> Instead of reverting the commit we can fix it to make sure that the ACNT size
> is aligned to the traswnfer.

Applied, thanks

-- 
~Vinod
