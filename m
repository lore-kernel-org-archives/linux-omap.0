From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb: musb: tusb6010_omap: Do not reset the other
 direction's packet size
Date: Fri, 12 May 2017 13:58:20 -0500
Message-ID: <20170512185820.GC651@uda0271908>
References: <20170512134848.468-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512134848.468-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 12, 2017 at 04:48:48PM +0300, Peter Ujfalusi wrote:
> We have one register for each EP to set the maximum packet size for both
> TX and RX.
> If for example an RX programming would happen before the previous TX
> transfer finishes we would reset the TX packet side.
> 
> To fix this issue, only modify the TX or RX part of the register.
> 
> Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
> Bin,
> 
> I have separated the patch from the tusb DMAengine conversion series and that
> will depend on this patch.

Applied. Thanks.
-Bin.
