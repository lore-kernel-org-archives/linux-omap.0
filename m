From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 07/10] ARM: OMAP3: update cpuidle latency and threshold
 figures
Date: Wed, 20 Jun 2012 16:31:31 +0530
Message-ID: <4FE1AD8B.305@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com> <1339686361-11526-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:55998 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753893Ab2FTLBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 07:01:39 -0400
Received: by obbwc20 with SMTP id wc20so14221097obb.17
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 04:01:38 -0700 (PDT)
In-Reply-To: <1339686361-11526-8-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Thursday 14 June 2012 08:35 PM, Jean Pihet wrote:
>   		{
>   			.enter		  = omap3_enter_idle_bm,
> -			.exit_latency	  = 3000 + 8500,
> -			.target_residency = 15000,
> +			.exit_latency	  = 4080 + 801,
> +			.target_residency = 215000,
>   			.flags		  = CPUIDLE_FLAG_TIME_VALID,
>   			.name		  = "C6",
>   			.desc		  = "MPU OFF + CORE RET",
>   		},
>   		{
>   			.enter		  = omap3_enter_idle_bm,
> -			.exit_latency	  = 10000 + 30000,
> -			.target_residency = 30000,
> +			.exit_latency	  = 4300 + 13000,
> +			.target_residency = 215000,

Is the target_residency same for both these states?

>   			.flags		  = CPUIDLE_FLAG_TIME_VALID,
>   			.name		  = "C7",
>   			.desc		  = "MPU OFF + CORE OFF",

