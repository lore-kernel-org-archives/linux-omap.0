From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP2430 build breakage and git bisect issues
Date: Tue, 8 Apr 2008 21:15:41 +0000
Message-ID: <20080408211541.GD31071@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08805C3073E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61475 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYDHVPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 17:15:43 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805C3073E@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [080408 14:20]:
> Hi all,
> 
> omap_2430sdp_defconfig and omap_2430osk_defconfig builds seem to be broken. (also reported at [1])
> 
> I tried to use git bisect to narrow down the exact patch that caused this and it looks like some patches that got merged don't compile individually. This causes the git bisect process to fail.
> 
> For instance, this happens when git bisect lands me in the middle of a mainline merge. Then I can't do a make omap_*_defconfig.
> 
> In other cases than a mainline merge, some patches are not individually compilable.
> For instance commit [2b2d5f705f1f5fad4275401d695697c06ad1e886] ARM: OMAP: More fixes for cm and prm assembly access
> 
> How do I recover from this? Or move to a compilable patch near to the bisect point?

You can mark mark the next commit with git-bisect bad and then continue.

But in general, we should have compiling and booting commits. While
doing merge things can break if the commit is created automatically.

I'll try to remember to test build the merge before commit next time :)

Tony



> [1] http://opensource.indt.org/omapbuilds/

