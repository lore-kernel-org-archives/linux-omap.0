From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 5/5] minimal omap5 support for v3.6 merge window
Date: Tue, 10 Jul 2012 15:53:00 +0000
Message-ID: <201207101553.01188.arnd@arndb.de>
References: <pull-1341925556-888624> <E1SoaE5-0001gM-89@merlin.infradead.org> <20120710134235.GY1122@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55790 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2GJPxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 11:53:07 -0400
In-Reply-To: <20120710134235.GY1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 10 July 2012, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120710 06:21]:
> > The following changes since commit fb584511c4664573097ece7df0de06ad00b713a2:
> > 
> >   ARM: OMAP: sdrc: Fix the build break for OMAP4 only builds (2012-07-09 01:44:11 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap devel-omap5
> 
> FYI, I got some merge conflicts with the am33xx and PM/smartreflex
> changes, here's how I resolved them.
> 

Pulled all five branches now.

I put the am33xx clk data into the next/clk branch, as that seemed convenient.
The omap5 branch is in the next/newsoc branch, together with the new Marvell
ArmadaXP port.

I'm not extremely happy with the multi-level dependencies, but it's still
manageable at the moment, especially since I have a relatively large number
of next/* branches.

If others submit pull requests that create additional dependencies I might
have to reject them if that gets too complex.

	Arnd
