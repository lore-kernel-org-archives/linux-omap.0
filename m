From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst
 function
Date: Mon, 27 Nov 2017 08:59:42 -0800
Message-ID: <20171127165942.GQ28152@atomide.com>
References: <1510313212-29660-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510313212-29660-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [171110 03:29]:
> Referring TRM Am335X series:
> http://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
> 
> The LastPowerStateEntered bitfield is present only for PM_CEFUSE
> domain. This is not present in any of the other power domains. Hence
> remove the generic am33xx_pwrdm_read_prev_pwrst hook which wrongly
> reads the reserved bit fields for all the other power domains.
> 
> Reading the reserved bits leads to wrongly interpreting the low
> power transitions for various power domains that do not have the
> LastPowerStateEntered field. The pm debug counters values are wrong
> currently as we are incrementing them based on the reserved bits.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applying into omap-for-v4.15/fixes thanks.

Tony
