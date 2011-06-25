From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH 9/9] OMAP2+: cpuidle only influences the MPU state
Date: Sat, 25 Jun 2011 06:23:31 -0700
Message-ID: <4E05E153.9030006@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com> <1308926286-30445-10-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:53187 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483Ab1FYNXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Jun 2011 09:23:35 -0400
Received: by yib19 with SMTP id 19so1489632yib.9
        for <linux-omap@vger.kernel.org>; Sat, 25 Jun 2011 06:23:34 -0700 (PDT)
In-Reply-To: <1308926286-30445-10-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On 6/24/2011 7:38 AM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Since cpuidle is a CPU centric framework it decides the MPU
> next power state based on the MPU exit_latency and target_residency
> figures.
>
> The rest of the power domains get their next power state programmed
> from the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework,
> via the device wake-up latency constraints.
>
> Note: the exit_latency and target_residency figures of the MPU
> include the MPU itself and the peripherals needed for the MPU to
> execute instructions (e.g. main memory, caches, IRQ controller,
> MMU etc). Some of those peripherals can belong to other power domains
> than the MPU subsystem and so the corresponding latencies must be
> included in this figure.
>
With above comment, I was expecting that the latency numbers
in the table will change.

> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++-------------------------
>   1 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4bf6e6e..b43d1d2 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -37,26 +37,26 @@
>   #ifdef CONFIG_CPU_IDLE
>
>   /*
> - * The latencies/thresholds for various C states have
> + * The MPU latencies/thresholds for various C states have
>    * to be configured from the respective board files.
>    * These are some default values (which might not provide
>    * the best power savings) used on boards which do not
>    * pass these details from the board file.
>    */
>   static struct cpuidle_params cpuidle_params_table[] = {
> -	/* C1 */
> +	/* C1 . MPU WFI + Core active */
>   	{2 + 2, 5, 1},
> -	/* C2 */
> +	/* C2 . MPU WFI + Core inactive */
>   	{10 + 10, 30, 1},
> -	/* C3 */
> +	/* C3 . MPU CSWR + Core inactive */
>   	{50 + 50, 300, 1},
> -	/* C4 */
> +	/* C4 . MPU OFF + Core inactive */
>   	{1500 + 1800, 4000, 1},
> -	/* C5 */
> +	/* C5 . MPU RET + Core RET */
>   	{2500 + 7500, 12000, 1},
> -	/* C6 */
> +	/* C6 . MPU OFF + Core RET */
>   	{3000 + 8500, 15000, 1},
> -	/* C7 */
> +	/* C7 . MPU OFF + Core OFF */
>   	{10000 + 30000, 300000, 1},

Latency numbers still seems to include CORE PD latency as
well. Am I missing something Jean?

Regards
Santosh
