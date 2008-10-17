From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resend] [PATCH 0/3] OMAP2EVM : Touchscreen driver support
Date: Fri, 17 Oct 2008 14:41:43 -0700
Message-ID: <20081017214143.GB18573@atomide.com>
References: <dfeb90390809242231w1c7c5143jee3b54f03ee79415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59206 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbYJQVlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:41:46 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390809242231w1c7c5143jee3b54f03ee79415@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Arun KS <arunks@mistralsolutions.com> [080924 22:32]:
> Hi,
> 
> Please ignore all the previous patches I have send.
> I did some modifications and here are the final series.
> 
> Patch 1 : Adds mux settings required for mspi1 and gpio_85.
> Patch 2 : Adds support for ads7846 touchscreen driver on omap2evm.
> Patch 3 : Updates the defconfig of omap2evm board with mspi.
> 
> Now I am using cross-platform GPIO calls instead of the older
> OMAP-specific ones.

Pushing all three, sorry for the delay with these. BTW, one of
these patches was wrapped and required manual editing to make it apply,
so you might want to check your mailer settings.

Tony

> 
> Thanks,
> Arun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
