From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/3] omap timer changes for v3.10 merge window
Date: Mon, 8 Apr 2013 19:40:12 +0200
Message-ID: <201304081940.12773.arnd@arndb.de>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57969 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab3DHRkS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:40:18 -0400
In-Reply-To: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 04 April 2013, Tony Lindgren wrote:
>  arch/arm/mach-omap2/board-cm-t3517.c |   2 +-
>  arch/arm/mach-omap2/board-generic.c  |   2 +-
>  arch/arm/mach-omap2/common.h         |   3 +-
>  arch/arm/mach-omap2/timer.c          | 124 ++++++++++++++++++-----------------
>  4 files changed, 66 insertions(+), 65 deletions(-)

BTW, do you have any plans to move the timer.c file to drivers/clocksource?

I think that's where most of them are heading now.

	Arnd
