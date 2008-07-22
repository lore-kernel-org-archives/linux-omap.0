From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Tue, 22 Jul 2008 07:52:44 -0500
Message-ID: <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com>
References: <20080722124743.GA5820@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38132 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYGVMwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2008 08:52:46 -0400
In-Reply-To: <20080722124743.GA5820@kos.to>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>
Cc: linux-omap@vger.kernel.org



On Tue, 22 Jul 2008 15:47:43 +0300, Riku Voipio <riku.voipio@iki.fi> wrote:

> Hmm. I think it would be better to avoid calling the probe
> in first place. git diff made the attached patch look more
> confusing than it actually is. Personally I'd eliminate
> all ifdefs from those i2c_board_info structs.

I did the same thing before, but then we're gonna start adding
several i2c_board_info for different hw. I mean, we should
just reuse the code and the driver should know when the device
is not present and stop probing without any problems to the rest
of the system.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

