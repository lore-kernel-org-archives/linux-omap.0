From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 04/49] clk: mux: add support for registering mux clock
 from descriptor
Date: Fri, 20 Dec 2013 10:55:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312201054390.20802@utopia.booyaka.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52286 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3LTKzC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 05:55:02 -0500
In-Reply-To: <1387452260-23276-5-git-send-email-t-kristo@ti.com>
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
> index 9fa279d..7dd6842 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -393,6 +393,26 @@ struct clk_mux {
>  	spinlock_t	*lock;
>  };
>  
> +/**
> + * struct clk_mux_desc - init descriptor for multiplexer clock
> + *
> + * @desc:	handle between common and hardware-specific interfaces

As mentioned in

http://patchwork.ozlabs.org/patch/294253/

please remove the blank line between the summary line and the arguments.
Documentation/kernel-doc-nano.txt says:

"The @argument descriptions must begin on the very next line following
this opening short function description line, with no intervening
empty comment lines."


- Paul
