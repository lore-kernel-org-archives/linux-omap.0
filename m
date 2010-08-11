From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCHv2] mailbox: change full flag per mailbox queue instead
 of global
Date: Wed, 11 Aug 2010 08:43:05 +0300 (EEST)
Message-ID: <20100811.084305.149819136.Hiroshi.DOYU@nokia.com>
References: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:54672 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0HKFnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 01:43:14 -0400
In-Reply-To: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ohad@wizery.com

From: ext Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead of global
Date: Wed, 11 Aug 2010 03:12:49 +0200

> As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
> global variable, so if there are multiple mailbox users
> there will be conflics. Now there is a full flag per
> mailbox queue.
> 
> Version 2:
> - Rebase to the latest.
> 
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Ok for me.
Tony, could you take this in? since it's a single patch for fix.
