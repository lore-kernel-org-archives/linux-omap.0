From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
Date: Mon, 12 Sep 2011 11:52:06 -0700
Message-ID: <87obypfvah.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:58979 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab1ILSwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 14:52:12 -0400
Received: by ywm21 with SMTP id 21so2992138ywm.16
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 11:52:11 -0700 (PDT)
In-Reply-To: <1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch adds the MPUSS OSWR (Open Switch Retention) support. The MPUSS
> OSWR configuration is as below.
> 	- CPUx L1 and logic lost, MPUSS logic lost, L2 memory is retained
>
> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
> anymore just like CORE power domain. The deepest state supported is OSWR.
> On OMAP4430 secure devices too, MPUSS off mode can't be used because of
> a bug which alters Ducati and Tesla states. Hence MPUSS off mode as an
> independent state isn't supported on OMAP44XX devices.
>
> Ofcourse when MPUSS power domain transitions to OSWR along
> with device off mode, it eventually hits off state since memory
> contents are lost.
>
> Hence the MPUSS off mode independent state is not attempted without
> device off mode. All the necessary infrastructure code for MPUSS
> off mode is in place as part of this series.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Compile failure for the !CONFIG_PM case:

[...]

> @@ -70,11 +71,18 @@ static inline int omap4_mpuss_init(void)
>  {
>  	return 0;
>  }
> -
> +static inline u32 omap4_mpuss_read_prev_context_state(void)
> +{
> +	return 0;
> +}

added here

>  static inline int omap4_finish_suspend(unsigned long cpu_state)
>  {}
>  static inline void omap4_cpu_resume(void)
>  {}
> +static inline u32 omap4_mpuss_read_prev_context_state(void)
> +{
> +	return 0;
> +}

same thing added here

Kevin
