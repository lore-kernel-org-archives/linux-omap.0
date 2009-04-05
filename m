From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH] drivers/mmc/core/core.c: extend limit
Date: Sun, 5 Apr 2009 20:57:27 +0200
Message-ID: <20090405205727.7a86d61b@mjolnir.ossman.eu>
References: <alpine.LNX.2.00.0903252248430.32070@linux-suse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:50426 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbZDES5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Apr 2009 14:57:31 -0400
In-Reply-To: <alpine.LNX.2.00.0903252248430.32070@linux-suse.site>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Cc: linux-kernel@vger.kernel.org, beagleboard@googlegroups.com, openembedded-devel@lists.openembedded.org, linux-omap@vger.kernel.org

On Wed, 25 Mar 2009 23:03:28 +0100 (CET)
Frans Meulenbroeks <fransmeulenbroeks@gmail.com> wrote:

> 
> This did not help me as the limit was already at 300000. However, I 
> decided to raise the limit to 500000. Still no go so I also doubled the 
> read limit from 100000 to 200000. After that the cards work without 
> problem. Changing the write timing back to 300000 brought the problem back 
> so apparently both timings need to be extended. Attached is the patch I 
> used for this. As it is a timeout limit value, it should not harm anyone, 
> and a longer timeout at least allows more cards to be used.
> 

Unfortunately some controllers cannot cope with huge timeouts and will
complain. And such a huge timeout shouldn't be needed (and they weren't
any larger in .27).

> 
> What somewhat troubles me is that this worked in .27, so it might be this 
> patch does not address the root cause. Then again this is the best I can 
> do. If someone has a better solution, I am more than happy to test it.
> 

Indeed. Have you enabled MMC_DEBUG and checked that the controller
actually follows the configured timeouts?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
