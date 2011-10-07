From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for -rc series and merge window
Date: Fri, 7 Oct 2011 22:12:50 +0200
Message-ID: <201110072212.50552.arnd@arndb.de>
References: <20111003185237.GI6324@atomide.com> <201110072111.35418.arnd@arndb.de> <20111007192041.GN6324@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59364 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1JGUNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 16:13:16 -0400
In-Reply-To: <20111007192041.GN6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 07 October 2011, Tony Lindgren wrote:
> Then merge all the -rc fixes for various ARM platforms with:
> 
> $ git checkout fixes-for-rc
> $ git reset --hard v3.1-rc9
> $ git merge omap/fixes-for-rc soc foo/fixes-for-rc bar/fixes-for-rc
> 
> And then no rebasing is needed. Of course I could also set up
> a separate fixes-for-rc for that if you prefrer that :)

Right, that works. I normally have a 'fixes' branch for the current
release and a 'next/fixes' branch for stuff that should wait for the
merge window.

Unfortunately, some of the stuff I already merged into 'fixes' turned
out not to be 3.1 material after all. Adding a third branch of course
works, so I can do that tomorrow.

Thanks for the suggestion.

	Arnd
