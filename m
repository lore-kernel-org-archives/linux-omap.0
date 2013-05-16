From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/2] mfd: twl-core: convert to module_i2c_driver()
Date: Fri, 17 May 2013 00:17:10 +0200
Message-ID: <20130516221710.GU22822@zurbaran>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com>
 <1366723151-23209-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366723151-23209-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On Tue, Apr 23, 2013 at 04:19:10PM +0300, Grygorii Strashko wrote:
> Shift TWL initialization to module/device init layer, because I2C now is
> not initialized on subsys init layer and shifted to module/device init
> layer instead.
> 
> The I2C <--> TWL dependency should be resolved in drivers/Makefile now.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/mfd/twl-core.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
I applied this one to mfd-next for now, and will move it to mfd-fixes if
someone confirms that this is indeed a fix.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
