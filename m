From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.38-rc6
Date: Tue, 1 Mar 2011 19:39:01 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103011931380.27610@esdhcp041196.research.nokia.com>
References: <20110228194151.GJ20560@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:54677 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab1CARlG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:41:06 -0500
In-Reply-To: <20110228194151.GJ20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, 28 Feb 2011, Tony Lindgren wrote:
> Please pull omap fixes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus
>
> This contains one more timer regression fix, a DPLL rate fix,
> and a mailbox NULL pointer fix that would be good to get
> in for 2.6.38. The series also removes world-writable flag for
> some debugfs entries.
>
> Other than I believe that's it for omap fixes for v2.6.38.

I wonder what happened to this patch:

 	http://marc.info/?l=linux-omap&m=129772313519005&w=2

A.
