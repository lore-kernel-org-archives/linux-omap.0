From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Remove unpaired sysc_clkdm_deny_idle()
Date: Mon, 9 Sep 2019 07:27:12 +0530
Message-ID: <40e5c2a1-3682-584a-4eb9-4d96901bbfda@ti.com>
References: <20190906200154.6510-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190906200154.6510-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On 07/09/19 1:31 AM, Tony Lindgren wrote:
> Commit d098913a10f8 ("bus: ti-sysc: Fix clock handling for no-idle
> quirks") fixed handling for no-idle quirk modules that are not enabled
> by the bootloader.
> 
> But it also caused unpaired clockdomain calls that won't allow idling
> the system. That's because clkdm_allow_idle_nolock() and
> clkdm_deny_idle_nolock() have usage count with clkdm->forcewake_count.
> 
> Let's drop the unpaired sysc_clkdm_deny_idle() to fix idling of devices.

Tested-by: Keerthy <j-keerthy@ti.com>

I believe still the previous fix [1] for nfs boot is still not on 
linux-next. Are you planning on more testing or it will be queued as fixes?


[1] https://lkml.org/lkml/2019/9/5/616

- Keerthy

> 
> Fixes: d098913a10f8 ("bus: ti-sysc: Fix clock handling for no-idle quirks")
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/bus/ti-sysc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2363,7 +2363,6 @@ static void ti_sysc_idle(struct work_struct *work)
>   	 */
>   	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE |
>   				 SYSC_QUIRK_NO_IDLE_ON_INIT)) {
> -		sysc_clkdm_deny_idle(ddata);
>   		sysc_disable_main_clocks(ddata);
>   		sysc_disable_opt_clocks(ddata);
>   		sysc_clkdm_allow_idle(ddata);
> 
