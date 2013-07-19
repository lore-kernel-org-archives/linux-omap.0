From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/4] arm: dts: dra7: Add initial status for the devices.
Date: Fri, 19 Jul 2013 12:27:39 -0600
Message-ID: <51E9851B.40309@wwwdotorg.org>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com> <1374251050-10033-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45621 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761029Ab3GSS1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 14:27:42 -0400
In-Reply-To: <1374251050-10033-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: tony@atomide.com, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, balbi@ti.com

On 07/19/2013 10:24 AM, Sourav Poddar wrote:
> This patch disabled I2C/SPI/UART device initially(status = "disabled").
> This devices will only be probed, if the devices are 
> present in the dts file(status = "okay").

>  			interrupts = <0 72 0x4>;
>  			ti,hwmods = "uart1";
>  			clock-frequency = <48000000>;

Those lines (and I assume the whole file) is indented with TABs.

> +                        status = "disabled";

Whereas all the new lines use spaces.
