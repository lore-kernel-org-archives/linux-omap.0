From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers
Date: Thu, 1 Sep 2011 23:57:39 +0200
Message-ID: <201109012357.39873.rjw@sisk.pl>
References: <1314900722-10252-1-git-send-email-khilman@ti.com> <1876183.c78P8V3ZbL@wuerfel>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57942 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757961Ab1IAVzs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 17:55:48 -0400
In-Reply-To: <1876183.c78P8V3ZbL@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Thursday, September 01, 2011, Arnd Bergmann wrote:
> On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
> > The suspend/resume _noirq handlers were #ifdef'd out in the
> > !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
> > struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.
> > 
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thansk for the fast response!

I'll apply the patch when kernel.org is back in order.

Thanks,
Rafael
