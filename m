From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
Date: Tue, 30 Jul 2013 15:19:35 -0500
Message-ID: <51F81FD7.2060707@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-30-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab3G3UUB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 16:20:01 -0400
In-Reply-To: <1374564028-11352-30-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> clk-3xxx.c now contains the clock init functionality for omap3, including
> DT clock registration and adding of static clkdev entries.
>
> This patch also splits the OMAP3 clock registration code under mach-omap2
> to use OMAP3 subtype specific clk init functions.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/Makefile          |    2 +-
>   arch/arm/mach-omap2/cclock3xxx_data.c | 3641 ---------------------------------

Tony and a lot of people is not going to like removing support for 
non-dt boot for OMAP3 before "it's time is due" ;)



-- 
Regards,
Nishanth Menon
