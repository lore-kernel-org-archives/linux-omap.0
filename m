From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP: Add debugfs node to show the summary of all
 clocks
Date: Fri, 15 Jul 2011 02:15:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107150214090.16606@utopia.booyaka.com>
References: <1310685908-3434-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46379 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964935Ab1GOIPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 04:15:03 -0400
In-Reply-To: <1310685908-3434-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

On Thu, 14 Jul 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> Add a debugfs node called "summary" to /sys/kernel/debug/clock/
> that displays a quick summary of all clocks registered in the
> "clocks" structure. The format of the output from this node is:
> 
> <clock-name> <parent-name> <rate> <usecount>
> 
> This debugfs node was very helpful for taking a quick snapshot of
> the linux clock tree for OMAP and ensuring clock frequencies
> calculated by the kernel were indeed correct. This patch helped
> uncover some bugs in the linux clock tree for OMAP4.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

this patch was queued for 3.1 at git://git.pwsan.com/linux-2.6 in the 
'prcm-devel-3.1' branch, so no need to resend this one.


- Paul
