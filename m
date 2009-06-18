From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe,
	trigger timer reload
Date: Thu, 18 Jun 2009 16:59:09 +0200
Message-ID: <20090618145909.GM32136@infomag.iguana.be>
References: <1244841512-12013-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:37616 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753577AbZFRO7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2009 10:59:08 -0400
Content-Disposition: inline
In-Reply-To: <1244841512-12013-1-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: wim@iguana.be, linux-omap@vger.kernel.org

Hi Ulrik,

> This patch contains two bugfixes:
> 
> 1)In omap_wdt_probe() the watchdog is reset and disabled. This
> requires register access and the clks needs to be enabled temporarily
> 
> 2)In omap_wdt_open() the timer register needs to be reloaded
> to trigger a new timer value (the default of 60s)
> 
> Tested on OMAP34xx platform (Zoom1)
> 
> Reviewed-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>

These fixes have been added to the linux-2.6-watchdog-next tree.

Kind regards,
Wim.

