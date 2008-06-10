From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] PRCM: OMAP3: Fix to wrongly modified
 omap2_clk_wait_ready
Date: Mon, 9 Jun 2008 18:11:31 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806091810350.13214@utopia.booyaka.com>
References: <1213003960-900-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36983 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYFJALc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 20:11:32 -0400
In-Reply-To: <1213003960-900-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Mon, 9 Jun 2008, Jouni Hogander wrote:

> omap2_clk_wait_ready was wrongly modified to check
> registers contents. This fix changes it back to check
> addresses.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>



- Paul
