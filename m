From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCHv3 6/7] ARM: OMAP2+: CM: increase the module disable timeout
Date: Tue, 19 Jun 2012 16:46:32 +0400
Message-ID: <4FE074A8.5010109@mvista.com>
References: <20120618061037.30632.28539.stgit@dusk> <20120618061611.30632.51094.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38745 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2FSMrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 08:47:17 -0400
Received: by eaak11 with SMTP id k11so1950494eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 05:47:16 -0700 (PDT)
In-Reply-To: <20120618061611.30632.51094.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

Hello.

On 18-06-2012 10:16, Paul Walmsley wrote:

> Increase the timeout for disabling an IP block to five milliseconds.
> This is to handle the usb_host_fs idle latency, which takes almost
> four milliseconds after a host controller reset.

> This is the second of two patches needed to resolve the following
> boot warning:

> omap_hwmod: usb_host_fs: _wait_target_disable failed

> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Tero Kristo<t-kristo@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 6b0aedc..a428305 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,6 +30,7 @@
>   #include<plat/mmc.h>
>   #include<plat/dmtimer.h>
>   #include<plat/common.h>
> +#include<plat/usb.h>

    How this hunk is related?

WBR, Sergei
