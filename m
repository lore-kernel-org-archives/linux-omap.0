From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] OMAP: Update the search() interface of omap_hdq.
Date: Fri, 7 Nov 2008 17:52:13 +0200
Message-ID: <20081107155212.GG21860@frodo>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com> <1226065287-3066-2-git-send-email-stanley.miao@windriver.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48027 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYKGPwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 10:52:22 -0500
Content-Disposition: inline
In-Reply-To: <1226065287-3066-2-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 07, 2008 at 09:41:25PM +0800, Stanley.Miao wrote:
>  /* W1 search callback function */
> -static void omap_w1_search_bus(void *_hdq, u8 search_type,
> -	w1_slave_found_callback slave_found)
> +static void omap_w1_search_bus(void *_hdq, struct w1_master *master_dev,
> +		u8 search_type,w1_slave_found_callback slave_found)

Please fix this:

ERROR: space required after that ',' (ctx:VxV)
#74: FILE: drivers/w1/masters/omap_hdq.c:241:
+		u8 search_type,w1_slave_found_callback slave_found)

-- 
balbi
