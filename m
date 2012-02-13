From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.3-rc3
Date: Mon, 13 Feb 2012 22:59:14 +0000
Message-ID: <201202132259.14589.arnd@arndb.de>
References: <20120213174557.GB1426@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61743 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab2BMXFb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 18:05:31 -0500
In-Reply-To: <20120213174557.GB1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 13 February 2012, Tony Lindgren wrote:
> Hi Arnd and Olof,
> 
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> This contains a DT boot fix that was found sitting in the omap DT branch,
> omap2 related PM fix for serial port, and few compile and warning fixes.
> 
> Note that Russell also has a series of omap fixes queued up that will get
> merged via his tree. There should not be any conflicts between these
> two series.

Thanks, merged into the fixes branch.

	Arnd

