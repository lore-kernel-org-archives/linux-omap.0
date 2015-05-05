From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Tue, 05 May 2015 12:54:38 +0200
Message-ID: <2213391.JZ0TJA9KXB@wuerfel>
References: <1430769717-4088-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56237 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbbEEKzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 06:55:05 -0400
In-Reply-To: <1430769717-4088-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> 
> For dropping the remaining omap3 legacy boot support, we still
> have the following board-*.c files:
> 
> BOARD                   REASON NEEDED
> board-ldp.c             Still used in RMKs boot test system
> board-omap3logic.c      Getting a .dts file for v4.2
> board-omap3pandora.c    Got a .dts file for v4.1
> board-rx51-*.c          Needs /proc/atags support for user space
> 
> I'm hoping we can drop those for v4.3 merge window, then keep
> the platform data around for one more merge window in case of
> reverting needed, then drop the platform data too for v4.4
> if no issues needing reverting are found.

Sounds great. Has there been a conclusion about what to do for the
rx51 /proc/atags support?

	Arnd
