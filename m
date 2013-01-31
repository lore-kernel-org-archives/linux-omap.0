From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 15:40:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52422 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3AaPka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 10:40:30 -0500
In-Reply-To: <510A54F8.4090609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: t-kristo@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi,

On Thu, 31 Jan 2013, Rajendra Nayak wrote:

> Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
> that it isn't enabled by default in omap2plus_defconfig. Also
> throw one when a suspend fails, saying bootloader *could be* a possible
> cause specifying the right version to be used.

In my view, these steps aren't sufficient, for the reasons described in 

http://marc.info/?l=linux-omap&m=135964568904053&w=2

Even with CONFIG_CPU_IDLE=n, it's still possible to attempt to enter 
full-chip retention idle on OMAP4 via 'echo mem > /sys/power/state', so it 
doesn't seem right to restrict a solution to that case.

regards,


- Paul
