From: Tony Lindgren <tony@atomide.com>
Subject: Re: [omap:tmp-merge 31/47] drivers/mfd/twl-core.c:49:22: fatal
 error: plat/cpu.h: No such file or directory
Date: Mon, 17 Sep 2012 09:56:43 -0700
Message-ID: <20120917165643.GL4521@atomide.com>
References: <20120917003526.GB12394@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58898 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752376Ab2IQQ4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 12:56:46 -0400
Content-Disposition: inline
In-Reply-To: <20120917003526.GB12394@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org

* Fengguang Wu <fengguang.wu@intel.com> [120916 17:41]:
> Hi Tony,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git tmp-merge
> head:   a742996f4643b4e9612fe081d146035964cfbd87
> commit: 7d7e1eba7e92c2f9c76db80adc24836e7a114bfb [31/47] ARM: OMAP2+: Prepare for irqs.h removal
> config: x86_64-randconfig-s331 (attached as .config)
> 
> All related error/warning messages:
> 
> drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> compilation terminated.
> 
> vim +49 drivers/mfd/twl-core.c
>     44	#include <linux/regulator/machine.h>
>     45	
>     46	#include <linux/i2c.h>
>     47	#include <linux/i2c/twl.h>
>     48	
>   > 49	#include <plat/cpu.h>
>     50	
>     51	#include "twl-core.h"
>     52	
>     53	/*
>     54	 * The TWL4030 "Triton 2" is one of a family of a multi-function "Power

OK thanks for letting me know. That include needs to be ifdeffed until
we remove all cpu_is_omap usage from drivers. I'll take a look and will
also check if other drivers may have the same issue.

Regards,

Tony
