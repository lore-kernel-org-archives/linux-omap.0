From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 1/2] OMAP: Add OMAP_LDP platform support.
Date: Thu, 04 Dec 2008 19:28:12 +0800
Message-ID: <1228390092.7392.53.camel@localhost>
References: <001b01c955f4$e4f08940$aed19bc0$@com.cn>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55452 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYLDLVo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2008 06:21:44 -0500
In-Reply-To: <001b01c955f4$e4f08940$aed19bc0$@com.cn>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sam Duan <sam_duan@ovt.com.cn>
Cc: linux-omap@vger.kernel.org

The first patch(PATCHv2 1/3) in this thread have fixed this problem. It
has not been pushed in. 

Stanley.

On Thu, 2008-12-04 at 17:44 +0800, Sam Duan wrote:
> Hi Stanley,
> 
> I git clone the
> tree(http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.gi
> t)
> and configured the kernel with omap_ldp_defconfig but met some compile
> errors.
> It seems like the line "gpio_direction_input(eth_gpio) " was not patched in.
> It's "omap_set_gpio_direction(eth_gpio, 1)" at Line343 in
> arch/arm/mach-omap2/board-ldp.c which caused an error "implicit
> declaration";
> I replaced omap_set_gpio_direction(eth_gpio, 1) with
> gpio_direction_input(eth_gpio) but the same error appeared with
> drivers/video/omap/lcd_ldp.c for "omap_set_gpio_direction" and
> "omap_set_gpio_dataout".
>  
> Did I miss some other patches? Are there any patchs can make the kernel
> compiled with omap_ldp_defconfig?
> Thanks
> Sam
> 
