From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: OMAP2+: more fixes intended for 3.5-rc
Date: Thu, 5 Jul 2012 08:36:11 +0000
Message-ID: <201207050836.12180.arnd@arndb.de>
References: <alpine.DEB.2.00.1207040806270.6760@utopia.booyaka.com> <20120705081520.GT1122@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61604 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab2GEIgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 04:36:48 -0400
In-Reply-To: <20120705081520.GT1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Thursday 05 July 2012, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120704 07:13]:
> > Hi Tony
> > 
> > The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:
> > 
> >   Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.5rc
> > 
> > for you to fetch changes up to d7a0b5133f6b1d53d693b9b9873e64e3c8f0db0e:
> > 
> >   ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on OMAP4 (2012-07-04 06:55:29 -0600)
> > 
> Thanks pulling into fixes.

I'm planning to send a set of fixes upstream to Linus today. Should I
pull your fixes branch before that?

	Arnd
