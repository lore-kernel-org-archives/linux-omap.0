From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 6/7] omap gpmc reworked suspend patch for v3.11 merge window
Date: Thu, 20 Jun 2013 21:43:28 +0200
Message-ID: <201306202143.28976.arnd@arndb.de>
References: <0M3kR7-1TyPb31W1B-00qrci@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965317Ab3FTTnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 15:43:35 -0400
In-Reply-To: <0M3kR7-1TyPb31W1B-00qrci@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit b3f5525c55ce5cb67af06f04dbbf28358da23a2c:
> 
>   ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-part2-signed
> 
> for you to fetch changes up to b536dd412b4364df2f9495c6550ee38f6ad3b0fe:
> 
>   ARM: OMAP2+: gpmc: Low power transition support (2013-06-18 03:46:39 -0700)
> 
> ----------------------------------------------------------------
> GPMC suspend patch that was left out of the earlier
> omap-for-v3.11/gpmc-signed branch because of a compile error
> it caused. The compile error is fixed in this version.
> 

Pulled into next/drivers, thanks!

	Arnd
