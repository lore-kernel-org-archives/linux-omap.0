From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu: fixes for 2.6.35-rc1
Date: Mon, 7 Jun 2010 14:17:48 +0300
Message-ID: <20100607111748.GM15515@atomide.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
 <20100531122703.GD30216@atomide.com>
 <20100602.105046.39180136.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59567 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab0FGLRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 07:17:46 -0400
Content-Disposition: inline
In-Reply-To: <20100602.105046.39180136.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x0124230@ti.com

Hi,

Since Linus only wants regression fixes nowadays during the -rc
cycle, few more questions below.

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100602 10:45]:
> Hi Tony,
> 
> Patches only for fixes for omap iommu module during -rc cycle.
> 
> The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> 
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu-fixes
> 
> Hiroshi DOYU (1):
>       omap iommu: Make omap-iommu.o built-in

Does the above actually fix some problem? If it fixes some problem,
it should be in the description. If not, maybe move this one for
the next merge window?
 
> Kanigeri, Hari (1):
>       omap iommu: update ducati mmu irq define name

This description does not seem to make sense as the ducati irq
define was added with e927f8d04ec8aff249beab2f7e1832c67623d0f5
and has not changed. The description is for some non-mainline
tree talking about 2.6.34-rc6 so it should be updated.
 
> Satish (1):
>       omap iommu: Fix Memory leak

This one looks like a genuine fix :)

Regards,

Tony
