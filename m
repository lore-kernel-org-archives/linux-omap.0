From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers
Date: Thu, 01 Sep 2011 20:22:01 +0200
Message-ID: <1876183.c78P8V3ZbL@wuerfel>
References: <1314900722-10252-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab1IASWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 14:22:41 -0400
In-Reply-To: <1314900722-10252-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
> The suspend/resume _noirq handlers were #ifdef'd out in the
> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
> struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thansk for the fast response!
