From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] dmtimer changes for v3.2 merge window
Date: Fri, 30 Sep 2011 22:13:42 +0200
Message-ID: <201109302213.42435.arnd@arndb.de>
References: <20110928220237.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58824 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab1I3UNq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 16:13:46 -0400
In-Reply-To: <20110928220237.GE6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 29 September 2011, Tony Lindgren wrote:
> Please pull omap dmtimer changes from:
> 
> git://github.com/tmlind/linux.git dmtimer
> 
> This series completes the system timer separation from the
> driver like features. It also adds support for v2 ip that is
> available for some timers starting with omap4.
> 
> After this series arch/arm/plat-omap/dmtimer.c could be
> moved to live under drivers somewhere, but there is still
> discussion going on which features should be supported in
> a generic way.
> 
> This series depends on the cleanup you pulled earlier.
> As this series adds some new features like runtime PM suppport,
> I've kept it separate from cleanup.

Looks really nice. I've put it into another top-level branch
named next/dmtimer for now. I'm open for suggestions on whether
I should generally push branches like this separately Linuswards
or better aggregate multiple standalone features into a single
branch. 

	Arnd
