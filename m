From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap board updates for v3.1 merge window
Date: Fri, 8 Jul 2011 13:11:15 +0200
Message-ID: <201107081311.15280.arnd@arndb.de>
References: <20110707162911.GL5783@atomide.com> <201107081054.01295.arnd@arndb.de> <20110708102521.GS5783@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59143 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1GHLLU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 07:11:20 -0400
In-Reply-To: <20110708102521.GS5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

On Friday 08 July 2011, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [110708 01:49]:
> > On Friday 08 July 2011 10:30:42 Tony Lindgren wrote:
> > 
> > Sorry for being unclear, I forgot to say that I did in fact pull your tree
> > already.
> 
> OK no problem that's fine with me.
> 
> BTW, looks like your tree is no longer showing up on kernel.org?
>  

The URL has changed (from linux-2.6-arm-soc.git), it's now
git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git

We figured that there would never be a 2.6 release in there, so the
original name was a bit silly. It won't change again, and if you
just change the URL in your remotes list, it should still fast-forward.

	Arnd
