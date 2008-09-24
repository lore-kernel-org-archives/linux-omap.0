From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 7/9]HDQ driver:replace semaphore with mutex
Date: Wed, 24 Sep 2008 14:50:31 +0300
Message-ID: <20080924115031.GO24627@gandalf.research.nokia.com>
References: <56530.192.168.10.89.1222255887.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48475 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbYIXLw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:52:27 -0400
Content-Disposition: inline
In-Reply-To: <56530.192.168.10.89.1222255887.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 05:01:27PM +0530, ext Madhusudhan Chikkature wrote:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> This patch replaces the usage of semaphore by mutex.
> 
> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/w1/masters/omap_hdq.c |   42 ++++++++++++++++++++++--------------------
>  1 files changed, 22 insertions(+), 20 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24
> 11:13:12.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 11:49:45.000000000
> +0530
> @@ -55,7 +55,7 @@ static int w1_id;
>  struct hdq_data {
>  	struct device		*dev;
>  	void __iomem		*hdq_base;
> -	struct	semaphore	hdq_semlock;
> +	struct  mutex		hdq_mutex;
>  	int			hdq_usecount;
>  	struct	clk		*hdq_ick;
>  	struct	clk		*hdq_fck;

Please, fix these two:

CHECK: struct  mutex definition without comment
#58: FILE: w1/masters/omap_hdq.c:58:
+	struct  mutex		hdq_mutex;

CHECK: spinlock_t definition without comment
#63: FILE: w1/masters/omap_hdq.c:63:
+	spinlock_t		hdq_spinlock;

total: 0 errors, 0 warnings, 2 checks, 732 lines checked

-- 
balbi
