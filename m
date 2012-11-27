From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/1] net: cpts: fix for build break after ARM SoC
 integration
Date: Tue, 27 Nov 2012 13:47:09 +0100
Message-ID: <20121127124708.GA31484@netboy.at.omicron.at>
References: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:38191 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2K0MrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 07:47:20 -0500
Content-Disposition: inline
In-Reply-To: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

On Tue, Nov 27, 2012 at 03:57:14PM +0530, Mugunthan V N wrote:
>   CC      drivers/net/ethernet/ti/cpts.o
> drivers/net/ethernet/ti/cpts.c:30:24: fatal error: plat/clock.h: No such file or directory
> compilation terminated.
> make[4]: *** [drivers/net/ethernet/ti/cpts.o] Error 1
> make[3]: *** [drivers/net/ethernet/ti] Error 2
> make[2]: *** [drivers/net/ethernet] Error 2
> make[1]: *** [drivers/net] Error 2
> 
> fix for build break as the header file is removed from plat-omap as part of
> the below patch

Acked-by: Richard Cochran <richardcochran@gmail.com>
