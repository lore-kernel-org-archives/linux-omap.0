From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
Date: Fri, 06 Jun 2008 09:46:47 -0500
Message-ID: <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com>
References: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59841 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbYFFOq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 10:46:56 -0400
In-Reply-To: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org



On Fri, 6 Jun 2008 18:42:56 +0530, "arun c"
<arunedarath@mistralsolutions.com> wrote:
>  static int __init omap2430_i2c_init(void)
>  {
> -	omap_register_i2c_bus(1, 400, NULL, 0);
>  	omap_register_i2c_bus(2, 2600, NULL, 0);
> +	omap_register_i2c_bus(1, 400, NULL, 0);

maybe there's a hw restriction that you must initiliaze
hs bus first?
Could you check on i2c chapter of your trm?

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

