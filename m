From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: plat-omap: counter_32k: Fix build error due to
 IS_ERR
Date: Tue, 7 Dec 2010 14:13:09 +0200
Message-ID: <20101207121309.GF2576@legolas.emea.dhcp.ti.com>
References: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36786 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566Ab0LGMNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 07:13:13 -0500
Received: by mail-ew0-f52.google.com with SMTP id 23so7251834ewy.39
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 04:13:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 07, 2010 at 05:39:37PM +0530, Sourav Poddar wrote:
>Fix the following build error by including linux/err.h
>arch/arm/plat-omap/counter_32k.c: In function 'omap_init_clocksource_32k':
>arch/arm/plat-omap/counter_32k.c:167: error: implicit declaration of
>                                      function 'IS_ERR'
>
>The above error is due to the following commit:
>subject: arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
>commit: 235fbace0334c846c21e902f330020122fc85955
>
>Created on linux-omap-2.6 branch: omap-fixes
>
>Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>Reviewed-by: Charulatha V <charu@ti.com>
>Acked-by: Felipe Balbi <balbi@ti.com>

BTW, since this isn't in mainline yet, Tony you might want to fold into
the orignal patch and just a note that Sourav has updated the commit to
fix a compile error together with SOB ??

-- 
balbi
