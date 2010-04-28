From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 28 Apr 2010 08:56:24 +0300 (EEST)
Message-ID: <20100428.085624.183054155.Hiroshi.DOYU@nokia.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41221 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab0D1F4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 01:56:42 -0400
In-Reply-To: <1272390982-14882-5-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 27 Apr 2010 19:56:22 +0200

> The underlying buffering implementation of mailbox
> is converted from block API to kfifo due to the simplicity
> and speed of kfifo.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
>  arch/arm/plat-omap/mailbox.c              |  108 +++++++++++++----------------
>  2 files changed, 52 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
> index 729166b..014cc58 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -7,6 +7,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/blkdev.h>

Also the above is not necessary?

>  #include <linux/interrupt.h>
> +#include <linux/kfifo.h>
