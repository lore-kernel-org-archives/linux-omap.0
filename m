From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 16:56:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311656230.32145@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>  <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com> <1359622829.10415.40.camel@sokoban> <510A54F8.4090609@ti.com> <alpine.DEB.2.00.1301311537530.23099@utopia.booyaka.com>
 <510A9BFB.5070802@ti.com> <alpine.DEB.2.00.1301311630090.32145@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52992 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3AaQ4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:56:55 -0500
In-Reply-To: <alpine.DEB.2.00.1301311630090.32145@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

On Thu, 31 Jan 2013, Paul Walmsley wrote:

> Right.  I don't have any problem with adding a message to the suspend path 
> also.  But I'd like to see a boot-time message added even if 
> CONFIG_CPU_IDLE=n, since it's still possible to enter full-chip retention 
> idle with dynamic idle.  In other words, not everyone might use 'echo mem 
> > /sys/power/state'.

(and re-reading my original E-mail to Rajendra, I can see that it was 
nuclear, so I'm sorry about that.)


- Paul
