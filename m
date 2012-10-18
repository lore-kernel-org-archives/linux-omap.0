From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: IS_ERR_OR_NULL - please STOP telling people to use this on a
 whim
Date: Thu, 18 Oct 2012 09:22:58 +0200
Message-ID: <507FAE52.6060305@atmel.com>
References: <20121017194157.GM21164@n2100.arm.linux.org.uk> <20121017202848.GF22812@fatphil.org> <20121017213342.GA28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:41316 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2JRHW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 03:22:59 -0400
In-Reply-To: <20121017213342.GA28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Phil Carmody <pc+lkml@asdf.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/17/2012 11:33 PM, Russell King - ARM Linux :
> On Wed, Oct 17, 2012 at 11:28:48PM +0300, Phil Carmody wrote:
>> So, what to do? It can and has been used sensibly, so I don't think removing
>> it is the best option.
> 
> Well, the first thing that needs to be done is a full review of every user
> and fixes applied.
> 
> The second thing is that we need eyes on code _and_ review comments, and
> educate those who are telling people to use IS_ERR_OR_NULL() whenever they
> see an IS_ERR() to think about the code a little more - that's kind of the
> purpose of my email.
> 
> Unfortunately, it's going to take time to achieve a change, and if I end
> up being the only one who's spotting these errors, I'm going to get
> incredibly pissed off at doing so (because it will feel like I'm being
> ignored when there's a constant stream of it.)
> 
> Another thing would be to work out whether we can get checkpatch to
> detect usage of IS_ERR_OR_NULL(p) followed by PTR_ERR(p) without any
> explicit NULL checks against p in the same block.  That's probably
> going to be interesting to code up in perl.

True that it would make sense to include in checkpatch to be able to
block code beforehand.
But for sure correction of existing code seems to be a work for Coccinelle.

Best regards,
-- 
Nicolas Ferre
