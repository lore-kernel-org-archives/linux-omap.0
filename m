From: "Sam Duan" <sam_duan@ovt.com.cn>
Subject: Re: [PATCH 1/2] OMAP: Add OMAP_LDP platform support.
Date: Thu, 4 Dec 2008 17:44:22 +0800
Message-ID: <001b01c955f4$e4f08940$aed19bc0$@com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [220.248.103.35] ([220.248.103.35]:43925 "EHLO mail.ovt.com.cn"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbYLDJpJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2008 04:45:09 -0500
Content-Language: zh-cn
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "'Stanley.Miao'" <stanley.miao@windriver.com>

Hi Stanley,

I git clone the
tree(http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.gi
t)
and configured the kernel with omap_ldp_defconfig but met some compile
errors.
It seems like the line "gpio_direction_input(eth_gpio) " was not patched in.
It's "omap_set_gpio_direction(eth_gpio, 1)" at Line343 in
arch/arm/mach-omap2/board-ldp.c which caused an error "implicit
declaration";
I replaced omap_set_gpio_direction(eth_gpio, 1) with
gpio_direction_input(eth_gpio) but the same error appeared with
drivers/video/omap/lcd_ldp.c for "omap_set_gpio_direction" and
"omap_set_gpio_dataout".
 
Did I miss some other patches? Are there any patchs can make the kernel
compiled with omap_ldp_defconfig?
Thanks
Sam

