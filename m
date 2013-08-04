From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod fixes for v3.11-rc
Date: Sun, 4 Aug 2013 13:36:53 -0700
Message-ID: <20130804203653.GF15602@quad.lixom.net>
References: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
 <20130730133336.GL7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34586 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab3HDUgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Aug 2013 16:36:46 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2491491pde.37
        for <linux-omap@vger.kernel.org>; Sun, 04 Aug 2013 13:36:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130730133336.GL7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Tue, Jul 30, 2013 at 06:33:36AM -0700, Tony Lindgren wrote:
> Arnd & Olof,
> 
> Can you please take this pull request directly? Other than the
> omap5 regulator dts changes I just posted I don't yet have
> anything else queued up right now.


Pulled. But Paul, if you don't mind, please base your fixes on older -rcs
unless there's a reason to go with the latest-and-greatest.

I had to rebase our fixes branch since this pulled in a newer -rc than
ours and I didn't want to have a back-merge in the history.


Thanks,

-Olof
