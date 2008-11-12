From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [rft/rfc/patch-2.6.28-rc3+ 00/59] namespace cleanup patches
Date: Wed, 12 Nov 2008 18:06:16 +0800
Message-ID: <1226484376.24669.47.camel@localhost>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44559 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbYKLKAb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 05:00:31 -0500
In-Reply-To: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

If you are using git-send-email, please provide the --no-chain-reply-to
option to avoid creating exceptionally deep nesting.

Stanley.

On Wed, 2008-11-12 at 00:56 +0200, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Get rid of omap_{read,write}[bsl] defines.
> Virtual and physical addresses usage was fixed by Russel King and
> there's no need anymore for keeping a define to a standard kernel
> function. Get rid of those to keep the namespace cleaner.
> 
> Build tested with all omap defconfigs.
> Depends on my previous "make clk fwk build again on omap1" patch.

