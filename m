From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/9]HDQ driver: Remove global pointer
Date: Wed, 24 Sep 2008 14:45:17 +0300
Message-ID: <20080924114517.GM24627@gandalf.research.nokia.com>
References: <43035.192.168.10.89.1222255180.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16654 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYIXLqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:46:36 -0400
Content-Disposition: inline
In-Reply-To: <43035.192.168.10.89.1222255180.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 04:49:40PM +0530, ext Madhusudhan Chikkature wrote:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> This patch provides the necessary modifications to the driver to remove the
> global ptr hdq_data.
> 
> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/w1/masters/omap_hdq.c |  137 ++++++++++++++++++++++--------------------
>  1 files changed, 72 insertions(+), 65 deletions(-)
> 
> Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-08-18
> 14:48:26.000000000 +0530
> +++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-23 12:39:19.000000000
> +0530

Please, fix your mailer, it's wrapping the header lines preventing
git-am from working.

-- 
balbi
