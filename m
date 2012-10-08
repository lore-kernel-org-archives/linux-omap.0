From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: fix return value check in
 omap_hsmmc_init_one()
Date: Mon, 8 Oct 2012 14:34:44 -0700
Message-ID: <20121008213444.GQ13011@atomide.com>
References: <CAPgLHd9RvEA1_dtaHOTCnuoboU3jcwzn_trwucu9kDqqdR1Lcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42490 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751232Ab2JHVeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:34:46 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd9RvEA1_dtaHOTCnuoboU3jcwzn_trwucu9kDqqdR1Lcw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [120920 23:31]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> not NULL pointer. The NULL test in the return value check should
> be replaced with IS_ERR().

Thanks applying into omap fixes.

Regards,

Tony
