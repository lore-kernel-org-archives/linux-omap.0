From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Add PRM warm reset/reboot support
Date: Tue, 30 Oct 2012 14:42:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210301440250.12697@utopia.booyaka.com>
References: <1351504747-10554-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48347 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348Ab2J3OmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 10:42:22 -0400
In-Reply-To: <1351504747-10554-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

On Mon, 29 Oct 2012, Vaibhav Hiremath wrote:

> This patch adds reboot capability to all AM33XX based boards/EVM's,
> by asserting PRM warm reset bit on 'reboot' command.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Daniel Mack <zonque@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Afzal Mohammed <afzal@ti.com>

Sounds like you're already planning to do this - but could you rebase this 
on the 3.8 PRCM cleanup branch that was sent in a separate mail?  

thanks,

- Paul
