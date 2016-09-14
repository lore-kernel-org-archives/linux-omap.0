From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Correct type2 descriptor's member
 types
Date: Wed, 14 Sep 2016 19:02:41 +0530
Message-ID: <20160914133241.GH13920@localhost>
References: <20160913075843.26691-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160913075843.26691-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 13, 2016 at 10:58:43AM +0300, Peter Ujfalusi wrote:
> The type of CDEI, CSEI, CDFI and CSFI is signed.
> This did not caused issue so far as we only use unsigned values.

Applied, thanks

-- 
~Vinod
