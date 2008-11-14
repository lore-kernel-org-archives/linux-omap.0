From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 10:56:26 +0100
Message-ID: <1A6706AF-F068-4DDC-86B1-312CB3817447@student.utwente.nl>
References: <hvaibhav@ti.com> <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:55104 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbYKNJ4i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 04:56:38 -0500
In-Reply-To: <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org


Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende geschreven:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach- 
> omap2/board-omap3evm.c
>
> +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);

omap_set_gpio_dataout changed to gpio_set_value 12 hours ago on l-o git

regards,

Koen
