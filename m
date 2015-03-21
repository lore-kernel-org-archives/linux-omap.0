From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] Couple of DRA7 hwmod patches on Timers
Date: Sat, 21 Mar 2015 19:42:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503211939340.2512@utopia.booyaka.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57885 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbCUTmC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2015 15:42:02 -0400
In-Reply-To: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Suman,

On Mon, 16 Mar 2015, Suman Anna wrote:

> Following are couple of DRA7 hwmod patches for the GPTimers.
> Patches based on 4.0-rc1.
> 
> The first patch adds the data for timers 13 through 16, the DT
> nodes are already present, and when enabled without the hwmod
> data triggers a l3_noc interrupt and hangs the kernel boot [1].
> The boot hang can also be fixed by checking the return status
> of pm_runtime_get_sync() in the OMAP dmtimer probe, I will post
> a separate fix for that.
> 
> Second patch is a minor fix.

Thanks.  Sounds like the first one should go in for v4.0-rc fixes, and the 
second one can wait for v4.1?  

If so then could you repost the first fix to include the description of 
why it should go in early in the patch description ("the DT nodes are 
already present, and when enabled without the hwmod data triggers a l3_noc 
interrupt and hangs the kernel boot").  That should avoid anyone 
questioning why it would go in as a v4.0-rc fix at this point, and should 
help the -stable crew out.


- Paul
