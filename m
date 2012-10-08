From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: fix return value check in create_dss_pdev()
Date: Mon, 8 Oct 2012 14:32:12 -0700
Message-ID: <20121008213212.GP13011@atomide.com>
References: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923Ab2JHVcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:32:18 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [120920 23:29]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> not NULL pointer. The NULL test in the return value check should
> be replaced with IS_ERR().

Thanks applying into omap fixes.

Regards,

Tony
