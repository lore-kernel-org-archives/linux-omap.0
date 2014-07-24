From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Few regression fixes for omaps for v3.16-rc series
Date: Thu, 24 Jul 2014 14:07:43 +0200
Message-ID: <5087610.iA71nMtfdT@wuerfel>
References: <20140724114348.GA29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56737 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015AbaGXMHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 08:07:48 -0400
In-Reply-To: <20140724114348.GA29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Thursday 24 July 2014 04:43:49 Tony Lindgren wrote:
> Two regression fixes for omaps and one fix for device signaling:
> 
> - L2 cache regression fix for a warning about trying to access
>   a read-only register
> 
> - GPMC ECC software fallback regression fix for omap3
> 
> - Fix for dra7 pinctrl pull-up direction that causes signal issues
>   for anybody trying to use the internal pull up or down
> 

Merged into the fixes branch, thanks!

	Arnd
