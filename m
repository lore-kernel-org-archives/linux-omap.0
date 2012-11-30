From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge
 window
Date: Thu, 29 Nov 2012 22:53:14 -0800
Message-ID: <20121130065314.GB6899@quad.lixom.net>
References: <pull-1353978372-642963>
 <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59419 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab2K3GxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 01:53:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so138273pad.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 22:53:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
> The following changes since commit 0f9cb211ba5db93d488fe6b154138231fdd0e22d:
> 
>   Merge tag 'v3.7-rc7' into next/cleanup (2012-11-25 21:34:34 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-multiplatform-v2-signed
> 
> for you to fetch changes up to 5ebb428d045ea9b908864547819786d5bcebad05:
> 
>   ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-26 13:19:23 -0800)

Tony,

Did you mean to base this branch on next/cleanup? We normally try to avoid
having vendor branches based on our common next/* branches, since it adds
dependencies that makes it hard to rebuild our branch if needed for some
reason.


-Olof
