From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 1/17] OMAP2/3/4:dmtimer:add device names to flck nodes
Date: Thu, 30 Sep 2010 22:16:05 +0200
Message-ID: <4CA4F005.6000208@ti.com>
References: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366Ab0I3UQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 16:16:10 -0400
In-Reply-To: <1285059060-26316-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 9/21/2010 10:51 AM, DebBarma, Tarun Kanti wrote:
> From: Thara Gopinath<thara@ti.com>
>
> This patch adds device name info to OMAP2 dmtimer fclk nodes so

You should avoid using "that patch" in a changelog, since we already 
know it is a patch.

You can read 4.c in "The perfect patch" from Andrew Morton: 
http://userweb.kernel.org/~akpm/stuff/tpp.txt

> that the fclk nodes can be retrieved by doing a clk_get with the
> corresponding device pointers.

...or device name.

> Signed-off-by: Partha Basak<p-basak2@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/clock2420_data.c |   26 +++++++++++++++-----------
>   arch/arm/mach-omap2/clock2430_data.c |   26 +++++++++++++++-----------
>   arch/arm/mach-omap2/clock3xxx_data.c |   26 +++++++++++++++-----------
>   arch/arm/mach-omap2/clock44xx_data.c |   24 ++++++++++++++----------
>   4 files changed, 59 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index 37d65d6..6378e6d 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1765,29 +1765,33 @@ static struct omap_clk omap2420_clks[] = {
>   	CLK(NULL,	"virt_prcm_set",&virt_prcm_set, CK_242X),
>   	/* general l4 interface ck, multi-parent functional clk */
>   	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
> +	/*
> +	 * gpt1 will be modified in subsequent patch when dmtimers
> +	 * will be fully converted to platform device
> +	 */
>   	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
>   	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
> -	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
> +	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_242X),

That comment is not necessarily only for you, but do we have to start 
device id at 0?
I think it is really confusing to name the famous gptimer1 device with 
"dmtimer.0".

 From that list it looks like this is not even consistent across IPs. 
McBSP start at 1 for example.


Since we are in the name discussion, I'd like as well to potentially 
stop using the dmtimer / gptimer confusing naming convention, and 
replace that with a simple name "timer". Or potentially "omap_timer".
Dual Mode timer does not mean at lot and General Purpose timer is not 
that better.

We already started that discussion with Kevin some time ago but didn't 
really conclude.

Tony, Paul and Kevin,
Do you have any opinion on that subject?

Regards,
Benoit


>   	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
> -	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
> +	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_242X),
>   	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
> -	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
> +	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_242X),
>   	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
> -	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
> +	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_242X),
>   	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
> -	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
> +	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_242X),
>   	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
> -	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
> +	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_242X),
>   	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
> -	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
> +	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_242X),
>   	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
> -	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
> +	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_242X),
>   	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
> -	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
> +	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_242X),
>   	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
> -	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
> +	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_242X),
>   	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
> -	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
> +	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_242X),
>   	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
>   	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
>   	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
> diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
> index b33118f..ae9b44e 100644
> --- a/arch/arm/mach-omap2/clock2430_data.c
> +++ b/arch/arm/mach-omap2/clock2430_data.c
> @@ -1851,29 +1851,33 @@ static struct omap_clk omap2430_clks[] = {
>   	CLK(NULL,	"virt_prcm_set",&virt_prcm_set, CK_243X),
>   	/* general l4 interface ck, multi-parent functional clk */
>   	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
> +	/*
> +	 * gpt1 will be modified in subsequent patch when dmtimers
> +	 * will be fully converted to platform device
> +	 */
>   	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
>   	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
> -	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
> +	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_243X),
>   	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
> -	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
> +	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_243X),
>   	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
> -	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
> +	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_243X),
>   	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
> -	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
> +	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_243X),
>   	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
> -	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
> +	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_243X),
>   	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
> -	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
> +	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_243X),
>   	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
> -	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
> +	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_243X),
>   	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
> -	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
> +	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_243X),
>   	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
> -	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
> +	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_243X),
>   	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
> -	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
> +	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_243X),
>   	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
> -	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
> +	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_243X),
>   	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
>   	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X),
>   	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index dfdce2d..1cdcaf5 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3248,8 +3248,8 @@ static struct omap_clk omap3xxx_clks[] = {
>   	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
>   	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
>   	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
> -	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
> +	CLK("dmtimer.9",	"fck",	&gpt10_fck,	CK_3XXX),
> +	CLK("dmtimer.10",	"fck",	&gpt11_fck,	CK_3XXX),
>   	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2 | CK_AM35XX),
>   	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2 | CK_AM35XX),
>   	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
> @@ -3334,6 +3334,10 @@ static struct omap_clk omap3xxx_clks[] = {
>   	CLK(NULL,	"usbhost_48m_fck",&usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
>   	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
>   	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
> +	/*
> +	 * gpt1 will be changed in subsequent patch when dmtimer
> +	 * is fully converted to platform device.
> +	 */
>   	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
>   	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
>   	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
> @@ -3349,14 +3353,14 @@ static struct omap_clk omap3xxx_clks[] = {
>   	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
>   	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
>   	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
> -	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
> +	CLK("dmtimer.1",	"fck",	&gpt2_fck,	CK_3XXX),
> +	CLK("dmtimer.2",	"fck",	&gpt3_fck,	CK_3XXX),
> +	CLK("dmtimer.3",	"fck",	&gpt4_fck,	CK_3XXX),
> +	CLK("dmtimer.4",	"fck",	&gpt5_fck,	CK_3XXX),
> +	CLK("dmtimer.5",	"fck",	&gpt6_fck,	CK_3XXX),
> +	CLK("dmtimer.6",	"fck",	&gpt7_fck,	CK_3XXX),
> +	CLK("dmtimer.7",	"fck",	&gpt8_fck,	CK_3XXX),
> +	CLK("dmtimer.8",	"fck",	&gpt9_fck,	CK_3XXX),
>   	CLK(NULL,	"per_32k_alwon_fck",&per_32k_alwon_fck, CK_3XXX),
>   	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
>   	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
> @@ -3396,7 +3400,7 @@ static struct omap_clk omap3xxx_clks[] = {
>   	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
>   	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
>   	CLK(NULL,	"secure_32k_fck",&secure_32k_fck, CK_3XXX),
> -	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
> +	CLK("dmtimer.11",	"fck",	&gpt12_fck,	CK_3XXX),
>   	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
>   	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
>   	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index a0e369e..7398158 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2574,17 +2574,21 @@ static struct omap_clk omap44xx_clks[] = {
>   	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
>   	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
>   	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
> +	/*
> +	 * gpt1 will be changed in subsequent patch when dmtimer
> +	 * will be fully converted to platform device.
> +	 */
>   	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
> -	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
> -	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
> -	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
> -	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
> -	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
> -	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
> -	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
> -	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
> -	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
> -	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
> +	CLK("dmtimer.9",	"fck",		&timer10_fck,	CK_443X),
> +	CLK("dmtimer.10",	"fck",		&timer11_fck,	CK_443X),
> +	CLK("dmtimer.1",	"fck",		&timer2_fck,	CK_443X),
> +	CLK("dmtimer.2",	"fck",		&timer3_fck,	CK_443X),
> +	CLK("dmtimer.3",	"fck",		&timer4_fck,	CK_443X),
> +	CLK("dmtimer.4",	"fck",		&timer5_fck,	CK_443X),
> +	CLK("dmtimer.5",	"fck",		&timer6_fck,	CK_443X),
> +	CLK("dmtimer.6",	"fck",		&timer7_fck,	CK_443X),
> +	CLK("dmtimer.7",	"fck",		&timer8_fck,	CK_443X),
> +	CLK("dmtimer.8",	"fck",		&timer9_fck,	CK_443X),
>   	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
>   	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
>   	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),

