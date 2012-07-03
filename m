From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 6/6] am33xx changes for v3.6 merge window
Date: Tue, 3 Jul 2012 04:48:56 -0700
Message-ID: <20120703114856.GL1122@atomide.com>
References: <E1SlGLI-0004Vt-0L@merlin.infradead.org>
 <4FF2D83C.7060409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14405 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab2GCLtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 07:49:01 -0400
Content-Disposition: inline
In-Reply-To: <4FF2D83C.7060409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120703 04:37]:
> 
> Few patches got missed in this pull request,
> 
> ARM: OMAP2+: am33xx: Make am33xx as a separate class
> ARM: OMAP2+: am33xx: Change cpu_is_am33xx to soc_is_am33xx

OK, at least the first needs to be rebased to apply.

Can you please refresh those against current devel-am33xx
branch at commit 6fd8246b1c1167c983b089f9eaafa13ef9ca7adf and
repost?

I'll do a separate pull request for those once they are
ready.

Regards,

Tony
