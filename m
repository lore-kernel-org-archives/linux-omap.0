From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] Add support for OMAP35x processors
Date: Sun, 11 Jan 2009 00:16:18 +0200
Message-ID: <20090110221618.GI25493@frodo>
References: <1231617637-18704-1-git-send-email-premi@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46740 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZAJWQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 17:16:25 -0500
Content-Disposition: inline
In-Reply-To: <1231617637-18704-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Sun, Jan 11, 2009 at 01:30:37AM +0530, Sanjeev Premi wrote:
> +config MACH_OMAP_LDP
> +	bool "OMAP3 LDP board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> +
>  config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX

This will prevent that we build a kernel for both 3430sdp and any
35xx-based board, right ?

>  
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP35XX

why removed ARCH_OMAP3 ??

-- 
balbi
