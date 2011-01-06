From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4 PM: To correct voltages in MPU OPP Table
Date: Thu, 06 Jan 2011 06:21:38 -0600
Message-ID: <4D25B3D2.4030802@ti.com>
References: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38637 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145Ab1AFMVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 07:21:48 -0500
Received: by mail-yi0-f45.google.com with SMTP id 21so4821280yie.32
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 04:21:47 -0800 (PST)
In-Reply-To: <1294295222-20035-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shweta.gulati@ti.com
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

it is pretty unfortunate that I have to NAK this patch in the public ML 
as well.

shweta.gulati@ti.com wrote, on 01/06/2011 12:27 AM:
> From: Shweta Gulati<shweta.gulati@ti.com>
>
> There is a mismatch in voltages specified in OPP table of MPU
> and voltage specified in voltage table 'omap44xx_vdd_mpu_volt_data'
> This Patch corrects MPU OPP Table as
> well as enable OPP-Turbo and OPP-SB  for MPU by default.
>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> ---
> The patch is generated on top of Kevin's PM branch. It's needed for SR
> functionality on the current pm branch. Have tested SR with this patch
> with different OPP configurations from boot loader.
>
>   arch/arm/mach-omap2/opp4xxx_data.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index a11fa56..4f35361 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -25,13 +25,13 @@
>
>   static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>   	/* MPU OPP1 - OPP50 */
> -	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
> +	OPP_INITIALIZER("mpu", true, 300000000, 930000),
>   	/* MPU OPP2 - OPP100 */
> -	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
> +	OPP_INITIALIZER("mpu", true, 600000000, 1100000),


Did we finalize on the nominal voltages yet?

As of yesterday's discussion, we were still debating about the actual 
voltage at OMAP ball level, while there is a secondary voltage called 
cap voltage - we have been discussing on this for some time. I suggest 
strongly that we dont touch this for the time being (the voltage in 
mainline is slightly higher - let it be so till the h/w folks finalize 
things).

>   	/* MPU OPP3 - OPP-Turbo */
> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
> +	OPP_INITIALIZER("mpu", true, 800000000, 1260000),
I disagree.  This is not $subject. Also - not all boards will be capable 
of supporting all higher frequencies rt? - remember the 3630 experience? 
is'nt it wiser to enable it based on board capabilities - e.g. similar 
to the patch I did for beagle XM yesterday - we wont be able to enable 
higher frequencies on SDP3630 as we have not guarenteed with PDN 
analysis that it is ok.

>   	/* MPU OPP4 - OPP-SB */
> -	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
> +	OPP_INITIALIZER("mpu", true, 1008000000, 1350000),
>   	/* L3 OPP1 - OPP50 */
>   	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
>   	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */


-- 
Regards,
Nishanth Menon
