From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/9] ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header
 inclusions
Date: Fri, 18 Jan 2013 16:31:01 +0400
Message-ID: <50F94085.3030704@mvista.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com> <1358493569-17142-2-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:59859 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab3ARMbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 07:31:14 -0500
Received: by mail-lb0-f176.google.com with SMTP id k6so2642626lbo.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 04:31:12 -0800 (PST)
In-Reply-To: <1358493569-17142-2-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On 18-01-2013 11:19, Vaibhav Bedia wrote:

> Some of the included header files are not needed so
> remove them.

> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Change from RFC version:
> 	No change

>   arch/arm/mach-omap2/cm33xx.h |    7 +------
>   1 files changed, 1 insertions(+), 6 deletions(-)

> diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
> index 5fa0b62..8009e13 100644
> --- a/arch/arm/mach-omap2/cm33xx.h
> +++ b/arch/arm/mach-omap2/cm33xx.h
> @@ -17,16 +17,11 @@
>   #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
>   #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -
>   #include "common.h"
>
>   #include "cm.h"
>   #include "cm-regbits-33xx.h"
> -#include "cm33xx.h"
> +#include "iomap.h"

    You don't comment on this addition in the changelog...

WBR, Sergei

