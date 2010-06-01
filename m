From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: pandora: add support for wl1251 wifi chip
Date: Tue, 1 Jun 2010 12:11:34 +0300
Message-ID: <20100601091132.GG841@atomide.com>
References: <1274953363-1985-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60489 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0FAJLh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 05:11:37 -0400
Content-Disposition: inline
In-Reply-To: <1274953363-1985-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [100527 12:37]:
> Define platform data and setup GPIOs so that TI wl1251 wifi chip
> and it's driver can function.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> I could have sent this earlier but it depended on the wifi tree,
> hope this can still go in for -rc2, it's just platform data anyway.

Sorry, we have to add this into for-next for 2.6.36 merge window,
see the comments at:

http://lwn.net/Articles/389982/

Regards,

Tony 
