From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 3/8] bus: ti-sysc: Fix handling of forced idle
Date: Tue, 23 Jul 2019 13:31:35 -0500
Message-ID: <4336e7ef-3857-e42f-e67c-94809acc59b8@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723112811.44381-4-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/23/19 6:28 AM, Tony Lindgren wrote:
> For some devices we can get the following warning on boot:
> 
> ti-sysc 48485200.target-module: sysc_disable_module: invalid midlemode
> 
> Fix this by treating SYSC_IDLE_FORCE like we do for the other bits
> for idlemodes mask.
> 
> Fixes: d59b60564cbf ("bus: ti-sysc: Add generic enable/disable functions")
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/bus/ti-sysc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -949,7 +949,7 @@ static int sysc_best_idle_mode(u32 idlemodes, u32 *best_mode)
>  		*best_mode = SYSC_IDLE_SMART_WKUP;
>  	else if (idlemodes & BIT(SYSC_IDLE_SMART))
>  		*best_mode = SYSC_IDLE_SMART;
> -	else if (idlemodes & SYSC_IDLE_FORCE)
> +	else if (idlemodes & BIT(SYSC_IDLE_FORCE))
>  		*best_mode = SYSC_IDLE_FORCE;
>  	else
>  		return -EINVAL;
> 
