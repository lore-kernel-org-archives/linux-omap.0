From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for -rc series and merge window
Date: Fri, 7 Oct 2011 21:11:35 +0200
Message-ID: <201110072111.35418.arnd@arndb.de>
References: <20111003185237.GI6324@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51062 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab1JGTLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:11:41 -0400
In-Reply-To: <20111003185237.GI6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 03 October 2011, Tony Lindgren wrote:
> Please pull omap fixes from:
> 
> git://github.com/tmlind/linux.git fixes
> 
> Out of these the first three commits would be nice to get
> into the -rc series with the first two causing boot issues
> and the musb fixing an ugly warning.
> 
> Note however the recent commit message update on the third patch.
> I added Bjarne's SOB to the third patch because of the earlier
> reference.
> 
> The last two are mostly cosmetic and not so urgent.

Hi Tony,

I've pulled them all into the fixes branch for now, but I'm not sure
if I still want to send another pull request. If I do, I'll have to
rebase that branch and put some into the next/fixes branch instead
as I already have patches that I don't want to send for 3.1 any
more. Are the patches all fixes against 3.1 only or do some of them
also apply to older releases?

	Arnd
