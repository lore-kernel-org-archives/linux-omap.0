From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Thu, 4 Sep 2008 18:56:32 +0530
Message-ID: <03da01c90e91$db22af60$LocalHost@wipultra1303>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-21-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com> <200808311406.14234.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbYIDN05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 09:26:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

Hi Dave,

>OK, this one may need cleanup ... but I don't disagree that it
>should go upstream.
I had fixed several comments provided by Pierre and Russell before Tony merged this patch. But then we have further added several fixes on top of the driver. Do you have any specific comments when you mean cleanup?

Regards,
Madhu
----- Original Message ----- 
From: "David Brownell" <david-b@pacbell.net>
To: "Felipe Balbi" <me@felipebalbi.com>
Cc: <linux-omap@vger.kernel.org>; "Felipe Balbi" <felipe.balbi@nokia.com>
Sent: Monday, September 01, 2008 2:36 AM
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver


On Saturday 30 August 2008, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> drivers/mmc/host/Kconfig | 13 +-
> drivers/mmc/host/Makefile | 1 +
> drivers/mmc/host/omap_hsmmc.c | 1069 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 1082 insertions(+), 1 deletions(-)
> create mode 100644 drivers/mmc/host/omap_hsmmc.c

OK, this one may need cleanup ... but I don't disagree that it
should go upstream.

Now the process for getting it there involves posting to LKML
and probably CCing the MMC maintainer...

One reason I'd like to see this particular driver upstream is
so that folk using www.beagleboard.org hardware can stand a
real chance of using mainline kernels for development.  That's
a small set of drivers, so that's a very achievable goal.



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


