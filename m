From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap2/3: Update revision identification
Date: Thu, 23 Sep 2010 09:56:37 -0700
Message-ID: <20100923165636.GL4211@atomide.com>
References: <1281973989-2484-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0IWQ4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 12:56:38 -0400
Content-Disposition: inline
In-Reply-To: <1281973989-2484-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [100816 08:46]:
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -366,21 +366,23 @@ static void __init omap3_cpuinfo(void)
>  		strcpy(cpu_rev, "1.0");
>  		break;
>  	case OMAP_REVBITS_01:
> -		strcpy(cpu_rev, "1.1");
> +		if (cpu_is_omap3630()) {
> +			strcpy(cpu_rev, "1.1");
> +		} else {
> +			strcpy(cpu_rev, "2.0");
> +		}
>  		break;

No { } brackets needed if it's one line + one line if else
statement.

>  	case OMAP_REVBITS_02:
> -		strcpy(cpu_rev, "1.2");
> -		break;
> -	case OMAP_REVBITS_10:
> -		strcpy(cpu_rev, "2.0");
> -		break;
> -	case OMAP_REVBITS_20:
> -		strcpy(cpu_rev, "2.1");
> +		if (cpu_is_omap3630()) {
> +			strcpy(cpu_rev, "1.2");
> +		} else {
> +			strcpy(cpu_rev, "2.1");
> +		}
>  		break;

Not needed here either.

> -	case OMAP_REVBITS_30:
> +	case OMAP_REVBITS_03:
>  		strcpy(cpu_rev, "3.0");
>  		break;
> -	case OMAP_REVBITS_40:
> +	case OMAP_REVBITS_04:
>  	/* FALLTHROUGH */
>  	default:
>  		/* Use the latest known revision as default */

Also, maybe just set a separate switch for 36xx?

In the long run it's best to avoid sprinkiling the cpu_is_omapxxxx
tests as that adds more places to patch when new omap xyz is
added.

> -#define OMAP2420_REV_ES2_0	0x24201024
> +#define OMAP2420_REV_ES1_0	(OMAP242X_CLASS)
> +#define OMAP2420_REV_ES2_0	(OMAP242X_CLASS | (OMAP_REVBITS_01 << 8))

No parens needed around OMAP242X_CLASS if it's just one value.
  
>  #define OMAP243X_CLASS		0x24300024
> -#define OMAP2430_REV_ES1_0	0x24300024
> +#define OMAP2430_REV_ES1_0	(OMAP243X_CLASS)

Not needed around OMAP243X_CLASS either. Please check
the other places too.

Regards,

Tony  
