From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] OMAP clock: use debugfs_remove_recursive() for
 rewinding
Date: Sun, 16 Aug 2009 07:47:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908160746390.31720@utopia.booyaka.com>
References: <1250418107-22835-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbZHPNr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 09:47:26 -0400
In-Reply-To: <1250418107-22835-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com

On Sun, 16 Aug 2009, Hiroshi DOYU wrote:

> Rewinding each debugfs entries to unregister if an error happens.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Queued for RMK along with the other 2.6.32 merge window patches from me.



- Paul
