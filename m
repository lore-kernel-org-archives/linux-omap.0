From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] reworked omap usb pdata changes for v3.9 merge window
Date: Tue, 19 Feb 2013 21:30:33 +0000
Message-ID: <201302192130.33509.arnd@arndb.de>
References: <20130215003543.GF11806@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59962 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758795Ab3BSVaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 16:30:39 -0500
In-Reply-To: <20130215003543.GF11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 15 February 2013, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Roger Quadros reworked the OMAP USB patches that were causing
> a conflict in Linux next and we requested to be dropped from
> Linux next and reworked to remove the dependencies between
> core SoC code and the driver code.
> 
> Below is a pull request for the mach-omap2 specific parts, the
> rest is driver specific and queued by Samuel in the MFD tree
> and Greg for the USB changes.
> 
> I've left it unresolved so you can merge it into one of your
> branches as a dependency so we can avoid the merge conflict
> in Linux next. A link to the merge resolution done by Stephen
> is in the pull request. Let me know if you want me to resolve
> it instead. 

I've pulled them into next/soc now. I was wondering whether to
put them into the late/omap branch instead, but this seemed
like the easiest way to resolve the conflict, and the patches
are simple enough.

	Arnd
