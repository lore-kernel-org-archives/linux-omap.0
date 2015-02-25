From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/8 v2] ARM OMAP2+ GPMC: don't undef DEBUG
Date: Wed, 25 Feb 2015 13:01:34 +0200
Message-ID: <54EDAB8E.1030202@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 24/02/15 22:05, Robert ABEL wrote:
> OMAP2+ GPMC driver undefines DEBUG, which makes it unnecessarily
> hard to turn DEBUG on. Remove the offending lines.
> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  drivers/memory/omap-gpmc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 24696f5..5cabac8 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -12,8 +12,6 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#undef DEBUG
> -
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> 
