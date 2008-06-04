From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: remove unnecessary locking in
 clk_get_rate()
Date: Wed, 4 Jun 2008 01:01:07 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com> <1211323550-5318-2-git-send-email-khilman@mvista.com> <1211323550-5318-3-git-send-email-khilman@mvista.com> <1211323550-5318-4-git-send-email-khilman@mvista.com> <1211323550-5318-5-git-send-email-khilman@mvista.com>
 <1211323550-5318-6-git-send-email-khilman@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYFDHBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 03:01:08 -0400
In-Reply-To: <1211323550-5318-6-git-send-email-khilman@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-omap@vger.kernel.org


Hi Kevin,

On Tue, 20 May 2008, Kevin Hilman wrote:

> The locking in the get_rate() hook is unnecessary, and causes problems
> when used with the -rt patch, since it may be called recursively.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

BTW, looks like we could probably get rid of some of the other spinlocking 
in plat-omap/clock.c also -- clk_get_usecount() ?

- Paul
