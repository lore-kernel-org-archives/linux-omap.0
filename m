From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] omap mailbox: add initial omap3 support
Date: Sat, 22 Nov 2008 13:57:47 +0200
Message-ID: <20081122115746.GC6289@frodo>
References: <1227313717-26399-1-git-send-email-Hiroshi.DOYU@nokia.com> <1227313717-26399-2-git-send-email-Hiroshi.DOYU@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54094 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212AbYKVL6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 06:58:44 -0500
Content-Disposition: inline
In-Reply-To: <1227313717-26399-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

On Sat, Nov 22, 2008 at 02:28:36AM +0200, Hiroshi DOYU wrote:
> @@ -30,7 +30,7 @@
>  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
>  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
>  
> -static unsigned long mbox_base;
> +static void __iomem *mbox_base;

ohh. you did :-) forget my previous comment


-- 
balbi
