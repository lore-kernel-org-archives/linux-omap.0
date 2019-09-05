From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Fix clock handling for no-idle quirks
Date: Thu, 5 Sep 2019 17:17:04 +0300
Message-ID: <49ce192d-697b-48e2-2b18-47acb370739b@ti.com>
References: <20190905140337.19373-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905140337.19373-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org



On 05/09/2019 17:03, Tony Lindgren wrote:
> NFSroot can fail on dra7 when cpsw is probed using ti-sysc interconnect
> target module driver as reported by Keerthy.
> 
> Device clocks and the interconnect target module may or may not be
> enabled by the bootloader on init, but we currently assume the clocks
> and module are on from the bootloader for "ti,no-idle" and
> "ti,no-idle-on-init" quirks as reported by Grygorii Strashko.
> 
> Let's fix the issue by always enabling clocks init, and
> never disable them for "ti,no-idle" quirk. For "ti,no-idle-on-init"
> quirk, we must decrement the usage count later on to allow PM
> runtime to idle the module if requested.
> 
> Fixes: 1a5cd7c23cc5 ("bus: ti-sysc: Enable all clocks directly during init to read revision")
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Reported-by: Keerthy <j-keerthy@ti.com>
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/bus/ti-sysc.c | 48 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 11 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thank you, Tony.

-- 
Best regards,
grygorii
