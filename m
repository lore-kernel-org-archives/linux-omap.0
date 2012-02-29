From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 5/5] Clean-up for omap
Date: Wed, 29 Feb 2012 21:20:06 +0000
Message-ID: <201202292120.07286.arnd@arndb.de>
References: <0M0SaL-1SHLTi0asf-00u7ia@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49464 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab2B2VUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 16:20:11 -0500
In-Reply-To: <0M0SaL-1SHLTi0asf-00u7ia@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
> This is mostly changes needed for io.h removal, and one
> patch to remove unused flag for McSPI. Note that these
> are based on RMK's for-armsoc.
> 
> Also, these cause a minor merge conflict for mach-omap2/Kconfig
> with the fixes-non-critical posted in this series of pull
> requests.

Hmm, I did not see the conflict in this one, but I saw one in the
dt branch that I fixed.

I pulled this one into next/cleanup.

	Arnd
