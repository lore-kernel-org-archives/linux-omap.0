From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/2] OMAP2+: PANDA: Provide unique-ish MAC addresses
 for Ethernet and WLAN interfaces
Date: Thu, 28 Jun 2012 10:45:07 -0400
Message-ID: <1340894707.16702.76.camel@gandalf.stny.rr.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
	 <201206281418.16854.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16730 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2F1OpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:45:12 -0400
In-Reply-To: <201206281418.16854.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On Thu, 2012-06-28 at 14:18 +0000, Arnd Bergmann wrote:

> It's been a while since we discussed these patches, but Steven Rostedt
> just tripped over the same problem and the patches work for
> him, so he says "Tested-by: Steven Rostedt <rostedt@goodmis.org>".
> 
> Can we get the patches into linux-3.6 please?

Yes please.

Right now I have my ktest.pl setup adding these patches before running
tests. I really dislike having to modify a kernel that I'm testing,
because I'm not really testing that said kernel, but a modified version
of it.

-- Steve


