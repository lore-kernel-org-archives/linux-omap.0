From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: AM35xx: fix some boot warnings with
 AM3505/3517
Date: Thu, 10 May 2012 12:46:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205101242470.32719@utopia.booyaka.com>
References: <20120510172449.13418.66815.stgit@dusk> <20120510184103.GB20494@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37303 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760304Ab2EJSqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 14:46:24 -0400
In-Reply-To: <20120510184103.GB20494@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>

Hi Mark

On Thu, 10 May 2012, Mark A. Greer wrote:

> On Thu, May 10, 2012 at 11:29:13AM -0600, Paul Walmsley wrote:
> > Hello,
> > 
> > this series fixes some of the warnings observed at boot with the AM35xx
> > boards.  Intended for either the 3.5 or 3.5-rc merge windows.
> > 
> > Particularly appreciated would be some feedback on the "ARM: OMAP:
> > AM35xx: fix UART4 softreset" patch from people who know the AM35xx SoC
> > hardware.
> 
> What repo/branch are these patches based on?

They are based on the 'omap-devel-b-for-3.5' tag in my omap-pending tree 
on kernel.org:

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=tag;h=8b14f48f6a985a71e250feb3e8595d9400829a18

The series is also available via git from git://git.pwsan.com/linux-2.6 in 
the branch "am35xx_hwmod_data_fixes_a_3.5".


- Paul
