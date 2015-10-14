From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 00/25] dmaengine/ARM: Merge the edma drivers into one
Date: Wed, 14 Oct 2015 15:57:55 +0530
Message-ID: <20151014102755.GL27370@localhost>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 24, 2015 at 01:01:47PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> Cover letter:
> 
> with this series the edma two driver setup will be changed to have only one
> driver to support eDMA3. The legacy edma interface will be removed and eDMA can
> only be used via dmaengine API from this point on.
> In order to do the merge the following improvements has been done:
> - One driver instance per eDMA:
>  - Any number of eDMA instances are supported (both legacy and DT boot)
> - Not relying on global variables, arrays, etc
> - Code simplification and optimizations in several places

One question though, after this move and merge are we still left with edma
in arm/ ?

-- 
~Vinod
