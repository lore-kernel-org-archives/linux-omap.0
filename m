From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 05/49] clk: gate: add support for registering gate
 clock from descriptor
Date: Fri, 20 Dec 2013 10:56:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312201055110.20802@utopia.booyaka.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52309 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3LTK4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 05:56:04 -0500
In-Reply-To: <1387452260-23276-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thu, 19 Dec 2013, Tero Kristo wrote:

> New clk_register_desc() call can be used to register this clock type now.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7dd6842..27a9765 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -269,10 +269,29 @@ struct clk_gate {
>  	spinlock_t	*lock;
>  };
>  
> +/**
> + * struct clk_gate_desc - init descriptor for gating clock
> + *
> + * @desc:	handle between common and hardware-specific interfaces

I like the kernel-doc-nano, but as mentioned in

http://patchwork.ozlabs.org/patch/294253/

please remove the blank line between the summary line and the arguments.
Documentation/kernel-doc-nano.txt says:

"The @argument descriptions must begin on the very next line following
this opening short function description line, with no intervening
empty comment lines."


- Paul
