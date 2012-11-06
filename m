From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/3] omap prcm cleanup for v3.8 merge window, part1
Date: Tue, 6 Nov 2012 09:59:59 -0800
Message-ID: <20121106175959.GC6801@atomide.com>
References: <pull-1351286620-406688>
 <E1TRrO0-00087R-UM@merlin.infradead.org>
 <20121105185133.GC22301@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58271 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750989Ab2KFSAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 13:00:05 -0500
Content-Disposition: inline
In-Reply-To: <20121105185133.GC22301@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [121105 10:53]:
> 
> The history of this branch looks a little odd. Did you mean to merge in
> cleanup-headers on top of Paul's branch in it? It seems to add no value -- all
> that code is already in our branch and it resolves no conflicts, etc.

Oh that was because I wanted to keep the header clean up separate
and Paul needed some base for further PRCM work that would not
conflict with the header changes. And I wanted to get the first
set of Paul's changes into linux next early to avoid a big pile
of pull requests later on.
 
> That being said, it causes no harm, and I've pulled it in as is.

OK thanks.

Regards,

Tony
