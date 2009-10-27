From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] AM35xx: Runtime detection of the device
Date: Tue, 27 Oct 2009 18:11:15 +0200
Message-ID: <20091027161115.GA16494@nokia.com>
References: <1256652150-5710-1-git-send-email-premi@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34720 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbZJ0QL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 12:11:29 -0400
Content-Disposition: inline
In-Reply-To: <1256652150-5710-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sanjeev Premi <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Oct 27, 2009 at 03:02:30PM +0100, ext Sanjeev Premi wrote:
> Add support to detect AM3505/AM3517 devices at runtime.
> Also updates the CPU names printed during boot.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   43 ++++++++++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 1c15112..87efb73 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -242,6 +242,21 @@ void __init omap3_check_revision(void)
>  			omap_revision = OMAP3630_REV_ES1_0;
>  		}
>  		break;
> +	case 0xb868:
> +		/* Handle OMAP35xx/AM35xx devices
> +		 *
> +		 * Set the device to be OMAP3517 here. Actual device
> +		 * is identified later based on the features.
> +		 */
> +		switch (rev) {
> +		case 0:
> +			omap_revision = OMAP3505_REV(rev);
> +			break;
> +		default:
> +			/* Use the latest known revision as default */
> +			omap_revision = OMAP3505_REV(rev);

if both are the same, what's the point of having this switch ?

> +		}
> +		break;
>  	default:
>  		/* Unknown default to latest silicon rev as default*/
>  		omap_revision = OMAP3630_REV_ES1_0;
> @@ -267,20 +282,36 @@ void __init omap3_cpuinfo(void)
>  	 * and CPU class bits.
>  	 */
>  	if (cpu_is_omap3630())
> -		strcpy(cpu_name, "3630");
> +		strcpy(cpu_name, "OMAP3630");
> +	else if (omap_rev() && OMAP35XX_CLASS) {
> +		/*
> +		 * AM3517, AM3505 devices
> +		 */
> +		if (omap3_has_sgx()) {
> +			omap_revision = OMAP3517_REV(rev);
> +			strcpy(cpu_name, "AM3517");
> +		}
> +		else {

according to CodingStyle this should be:

		} else {

-- 
balbi
