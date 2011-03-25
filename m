From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC addresses for eth0 and wlan0
Date: Fri, 25 Mar 2011 12:39:53 +0100
Message-ID: <201103251239.54243.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <20110324212737.14936.21228.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61722 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1CYLkC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 07:40:02 -0400
In-Reply-To: <20110324212737.14936.21228.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Green <andy.green@linaro.org>

On Thursday 24 March 2011, Andy Green wrote:
> This patch registers a network device notifier callback to set the mac
> addresses for the onboard network assets of Panda correctly, despite the
> drivers involved have used a random or all-zeros MAC address.
> 
> The technique was suggested by Alan Cox on lkml.
> 
> It works by device path so it corrects the MAC addresses even if the
> drivers are in modules loaded in an order that changes their interface
> name from usual (eg, the onboard module might be "wlan1" if there is a
> USB wireless stick plugged in and its module is inserted first.)
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andy Green <andy.green@linaro.org>

It looks like this is the best solution so far.

Acked-by: Arnd Bergmann <arnd@arndb.de>
