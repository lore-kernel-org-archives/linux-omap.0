From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] drivers: bus: omap_interconnect: Fix rand-config build
 warning
Date: Wed, 17 Oct 2012 19:04:04 +0530
Message-ID: <507EB3CC.6060005@ti.com>
References: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36506 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034Ab2JQNeS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 09:34:18 -0400
In-Reply-To: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net

(Looping Arnd and Olof)

On Wednesday 17 October 2012 06:58 PM, Lokesh Vutla wrote:
> When building omap_l3_noc/smx drivers as modules, the following
> warning appears:
>
> CC [M]  drivers/bus/omap_l3_smx.o
> drivers/bus/omap_l3_smx.c:291: warning: data definition has no type or storage class
> drivers/bus/omap_l3_smx.c:291: warning: type defaults to 'int' in declaration of 'postcore_initcall_sync'
> drivers/bus/omap_l3_smx.c:291: warning: parameter names (without types) in function declaration
> drivers/bus/omap_l3_smx.c:287: warning: 'omap3_l3_init' defined but not used
> CC [M]  drivers/bus/omap_l3_noc.o
> drivers/bus/omap_l3_noc.c:260: warning: data definition has no type or storage class
> drivers/bus/omap_l3_noc.c:260: warning: type defaults to 'int' in declaration of 'arch_initcall_sync'
> drivers/bus/omap_l3_noc.c:260: warning: parameter names (without types) in function declaration
> drivers/bus/omap_l3_noc.c:256: warning: 'omap4_l3_init' defined but not used
>
> Adding module_init() and macros in omap_l3_noc/smx drivers when building
> as modules to remove the above warning.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
Thanks for the fix Lokesh. Looks fine to me.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

