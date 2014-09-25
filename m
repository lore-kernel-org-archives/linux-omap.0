From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 4/4] omap clean-up for v3.18 merge window
Date: Fri, 26 Sep 2014 00:10:38 +0200
Message-ID: <201409260010.38431.arnd@arndb.de>
References: <pull-1411070912-460910> <pull-1411070912-460910-4>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53907 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaIYWLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2014 18:11:07 -0400
In-Reply-To: <pull-1411070912-460910-4>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 18 September 2014, Tony Lindgren wrote:
> Clean-up for omaps for v3.18 merge window:
> 
> - Remove unused pieces of the legacy DMA API as we're moving to
>   dmaengine API
> 
> - Search and replace to standardize on pr_warn instead of pr_warning
> 

Nice cleanup!

Merged into next/cleanup, thanks!

	Arnd
