From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [CBUS PATCH 1/1] CBUS: Fix broken compilation
Date: Wed, 5 May 2010 21:38:55 +0300
Message-ID: <20100505183854.GE2274@gandalf>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
 <1273071929-17708-1-git-send-email-carlos.chinea@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58725 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0EESiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:38:14 -0400
Content-Disposition: inline
In-Reply-To: <1273071929-17708-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: tony@atomide.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, May 05, 2010 at 06:05:29PM +0300, Carlos Chinea wrote:
> Include explicitly slab.h in:
> 	drivers/cbus/cbus.c
> 	drivers/cbus/retu-headset.c
> 	drivers/cbus/retu-user.c
> 	drivers/cbus/retu-wdt.c
> 	drivers/cbus/tahvo-user.c
> 
> Compile tested with n8x0_defconfig
> 
> Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>

do you need to update your tree ? tony applied a patch from me already,
or did I miss something else ? I'm sure I compile with n770_defconf and
n8x0_defconfig.

-- 
balbi
