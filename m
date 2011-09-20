From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Tue, 20 Sep 2011 22:01:18 +0200
Message-ID: <201109202201.18574.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:65026 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab1ITUBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 16:01:24 -0400
In-Reply-To: <20110917014623.GC2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Saturday 17 September 2011, Tony Lindgren wrote:
> Please pull the first part of omap cleanup from:
> 
> git://github.com/tmlind/linux.git cleanup
> 
> This series cleans up early_init functions and removes
> CHIP_IS macro usage. This makes it easier to have SoC
> specific init functions so adding support for new omap
> variants does not require patching all over the place.

Thanks, pulled.

Note that we are trying to get everyone to use the similar
prefixes for patch summaries, so it would be nice if you could
change 'OMAP: powerdomain:' to 'ARM: OMAP: powerdomain' or
'ARM: omap/powerdowmain:' in the future.

	Arnd
