From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/9] arch/arm/mach-omap2/devices.c: introduce missing
 kfree
Date: Thu, 26 Jan 2012 15:59:22 -0800
Message-ID: <20120126235922.GE29812@atomide.com>
References: <1324661974-17281-6-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40552 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2AZX7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 18:59:25 -0500
Content-Disposition: inline
In-Reply-To: <1324661974-17281-6-git-send-email-julia@diku.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Julia Lawall <julia@diku.dk> [111223 09:07]:
> pdata needs to be freed before leaving the function in an error case.

Thanks applying into fixes.

Tony
