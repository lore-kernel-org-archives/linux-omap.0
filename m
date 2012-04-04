From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Date: Wed, 04 Apr 2012 15:20:22 -0700
Message-ID: <4F7CC926.5050300@ti.com>
References: <1332807568-638-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46927 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753556Ab2DDWU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 18:20:26 -0400
Received: by dadz9 with SMTP id z9so917534dad.33
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 15:20:25 -0700 (PDT)
In-Reply-To: <1332807568-638-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Hi Dave,

On 03/26/2012 05:19 PM, Kevin Hilman wrote:
> The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
> builds for OMAP2+ platforms.
>
> This 'depends on' was in the original patch from Russell King, but was
> erroneously removed by me when making this option user-selectable in
> commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
> patch remedies that.
>
> Apologies to Russell King for breaking his originally working patch.
>
> Also, thanks to Grazvydas Ignotas for reporting the same problem.
>
> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Grazvydas Ignotas<notasas@gmail.com>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
> Dave, this applies on top of your current fixes branch, and fixes a
> problem introduced there by me.  Please merge for v3.4-rc.  Thanks.

Can you pick this up for v3.4-rc?

Thanks,

Kevin

>   drivers/cpufreq/Kconfig.arm |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 82f1aa9..555a57b 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -4,6 +4,7 @@
>
>   config ARM_OMAP2PLUS_CPUFREQ
>   	bool "TI OMAP2+"
> +	depends on ARCH_OMAP2PLUS
>   	default ARCH_OMAP2PLUS
>   	select CPU_FREQ_TABLE
>
