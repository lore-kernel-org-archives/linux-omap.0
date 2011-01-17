From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 10/14] ARM: v6k: select TLS register code according to V6
 variants
Date: Mon, 17 Jan 2011 17:23:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101171717090.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:15913 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1AQWXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:23:44 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LF60017CU6Y0RF0@vl-mh-mrz21.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 17 Jan 2011 17:23:22 -0500 (EST)
In-reply-to: <E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> If CONFIG_CPU_V6 is enabled, we may or may not have the TLS register.
> Use the conditional code which copes with this variability.  Otherwise,
> if CONFIG_CPU_32v6K is set, we know we have the TLS register on all
> supported CPUs, so use it unconditionally.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Note: this is becoming a bit confusing and prone to mistake when we have:

	CONFIG_CPU_V6
	CONFIG_CPU_V6K
	CONFIG_CPU_32v6
	CONFIG_CPU_32v6K

I don't know what to suggest for a less similar naming scheme between 
the CPU design and the allowed instruction set though.


> ---
>  arch/arm/include/asm/tls.h |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
> index e71d6ff..60843eb 100644
> --- a/arch/arm/include/asm/tls.h
> +++ b/arch/arm/include/asm/tls.h
> @@ -28,15 +28,14 @@
>  #define tls_emu		1
>  #define has_tls_reg		1
>  #define set_tls		set_tls_none
> -#elif __LINUX_ARM_ARCH__ >= 7 ||					\
> -	(__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
> -#define tls_emu		0
> -#define has_tls_reg		1
> -#define set_tls		set_tls_v6k
> -#elif __LINUX_ARM_ARCH__ == 6
> +#elif defined(CONFIG_CPU_V6)
>  #define tls_emu		0
>  #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
>  #define set_tls		set_tls_v6
> +#elif defined(CONFIG_CPU_32v6K)
> +#define tls_emu		0
> +#define has_tls_reg		1
> +#define set_tls		set_tls_v6k
>  #else
>  #define tls_emu		0
>  #define has_tls_reg		0
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
