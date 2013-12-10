From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 19:36:54 +0100
Message-ID: <201312101936.54483.arnd@arndb.de>
References: <pull-1386643347-596413> <20131210143547.GA32243@n2100.arm.linux.org.uk> <20131210160144.GG13171@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3LJShb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 13:37:31 -0500
In-Reply-To: <20131210160144.GG13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 10 December 2013, Tony Lindgren wrote:
> The crappy part here is the fact that we need to build the kernel with
> appended DTB. Maybe there's something more we can do to make it easier.
> 

You are aware of the impedence matcher project [1], right?

	Arnd

[1] https://github.com/zonque/pxa-impedance-matcher
