From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Tue, 3 May 2011 02:22:38 -0700
Message-ID: <20110503092237.GM2092@atomide.com>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
 <1304006259-7939-2-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64914 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751746Ab1ECJWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 05:22:41 -0400
Content-Disposition: inline
In-Reply-To: <1304006259-7939-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org

* green@linuxhacker.ru <green@linuxhacker.ru> [110428 08:55]:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Bare-bones board file, comes with serial console, gpio keys,
> MMC/SDCard and USB support.

Good to see that. Unfortunately you probably have to do few
more rebases on the devel-cleanup branch because of the code
consolidation effort. We'll have to wait a bit and see what
new platform code we can merge after that is all the
consolidation is sorted out.

Please also post your series with linux-arm-kernel mailing
list Cc'd. Few comments below too.

> +#include <mach/gpio.h>

This should be linux/gpio.h nowadays.

> +	if(is_encore_board_evt2()) {

You should have if ( here with space.

Maybe run scripts/checkpatch.pl --strict on the patch?

> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -962,7 +962,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
>  uemd			MACH_UEMD		UEMD			3281
>  ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
>  rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
> +encore			MACH_ENCORE		ENCORE			3284
>  hkdkc100		MACH_HKDKC100		HKDKC100		3285
>  ts42xx			MACH_TS42XX		TS42XX			3286
>  aebl			MACH_AEBL		AEBL			3287

For this you need to follow the instructions at www.arm.linux.org.uk.

Regards,

Tony
