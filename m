From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Thu, 7 Jan 2010 09:22:51 -0600
Message-ID: <4B45FC4B.9080302@ti.com>
References: <1262867408-9895-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0AGPWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 10:22:52 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07FMqqZ001159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 09:22:52 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o07FMqN3003548
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 09:22:52 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o07FMqVF025148
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 09:22:52 -0600 (CST)
In-Reply-To: <1262867408-9895-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Govindarajan, Sriramakrishnan had written, on 01/07/2010 06:30 AM, the 
following:
> From: Sriram <srk@ti.com>
> 
> OMAP platforms(like OMAP3530) include DSP or other co-processors
> for media acceleration. when carving out memory for the
> accelerators we can end up creating a hole in the memory map
> of sort:
> <kernel memory><hole(memory for accelerator)><kernel memory>
> 
> To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
> has to be enabled. For further information refer discussion at:
> http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.

pls check the link: I see "The document you were looking for was not found."
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5e0bcc5..88f628b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -699,6 +699,7 @@ config ARCH_OMAP
>  	select ARCH_HAS_CPUFREQ
>  	select GENERIC_TIME
>  	select GENERIC_CLOCKEVENTS
> +	select ARCH_HAS_HOLES_MEMORYMODEL
why enable this for all OMAPs?
>  	help
>  	  Support for TI's OMAP platform (OMAP1 and OMAP2).
>  


-- 
Regards,
Nishanth Menon
