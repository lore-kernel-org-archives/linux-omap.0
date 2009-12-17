From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP: McBSP: Fix possible port lockout
Date: Thu, 17 Dec 2009 11:06:10 +0200
Message-ID: <200912171106.10084.peter.ujfalusi@nokia.com>
References: <200912161716.30041.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61709 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbZLQJIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 04:08:13 -0500
In-Reply-To: <200912161716.30041.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Wednesday 16 December 2009 18:16:28 ext Janusz Krzysztofik wrote:
> In its current form, the omap_mcbsp_request() function can return after
> irq_request() failure without any cleanups, effectively locking out the
>  port forever with clocks left running. Fix it.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Good catch,

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
