From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 484/493] arm: remove use of __devexit
Date: Wed, 21 Nov 2012 20:59:23 +0900
Message-ID: <0e5a01cdc7df$a5ad12b0$f1073810$%kim@samsung.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13815 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab2KUL7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 06:59:24 -0500
In-reply-to: <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Bill Pemberton' <wfp5p@virginia.edu>, gregkh@linuxfoundation.org
Cc: 'Russell King' <linux@arm.linux.org.uk>, 'Eric Miao' <eric.y.miao@gmail.com>, 'Haojian Zhuang' <haojian.zhuang@gmail.com>, 'Tony Lindgren' <tony@atomide.com>, 'Ben Dooks' <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Bill Pemberton wrote:
> 
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> ---

[...]

>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c  | 2 +-
>  arch/arm/plat-samsung/adc.c              | 2 +-

For above s3c24xx and samsung,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd

