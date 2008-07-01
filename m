From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP: DISPC: Fix to disable also interface clocks
Date: Tue, 1 Jul 2008 12:13:43 +0300
Message-ID: <20080701091343.GE9696@kedavra.cpe.vivax.com.br>
References: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44784 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYGAJN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 05:13:57 -0400
Content-Disposition: inline
In-Reply-To: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jul 01, 2008 at 10:12:41AM +0300, Jouni Hogander wrote:
>  static void enable_lcd_clocks(int enable)
>  {
> -	if (enable)
> +	if (enable) {
> +		clk_enable(dispc.dss_ick);
>  		clk_enable(dispc.dss1_fck);
> -	else
> +	}
> +	else {

should be } else { according to CodingStyle ;-)

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
