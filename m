From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap wake-up regression fix for v3.17
Date: Mon, 22 Sep 2014 21:58:56 -0700
Message-ID: <20140923045856.GE7487@localhost>
References: <20140917145906.GA14505@atomide.com>
 <20140918201708.GP14505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42123 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaIWFDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2014 01:03:55 -0400
Received: by mail-pa0-f42.google.com with SMTP id et14so5866918pad.1
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 22:03:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918201708.GP14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 18, 2014 at 01:17:08PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140917 08:00]:
> > The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> > 
> >   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fix-v3.17-io-chain-v3
> > 
> > for you to fetch changes up to 7db143b89137de06ed289cf8b302f3bbbc5baa1f:
> > 
> >   ARM: OMAP3: Fix I/O chain clock line assertion timed out error (2014-09-16 15:09:44 -0700)
> > 
> > ----------------------------------------------------------------
> > Regression fix for early omap3 revisions for wake-up events that
> > too some time to narrow down. Although a bit intrusive, this would
> > be good to get into the -rc cycle as there are quite a few boards
> > out there with omap3 es2.1 and es3.0, and we have those in at least
> > three boot test systems too that show errors without this patch.
> 
> This can also cause a merge conflict for linux next,
> here's the merge resolution for reference.

Merged, thanks.


-Olof
