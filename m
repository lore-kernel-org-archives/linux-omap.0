From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] cbus: tahvo: Fix build breakage caused by
 deprecated initializer removal
Date: Tue, 19 Apr 2011 10:53:13 +0300
Message-ID: <20110419105313.4c03f30d.jhnikula@gmail.com>
References: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
	<20110419070724.GB477@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40960 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab1DSHvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 03:51:15 -0400
Received: by eyx24 with SMTP id 24so1614344eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 00:51:14 -0700 (PDT)
In-Reply-To: <20110419070724.GB477@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Tue, 19 Apr 2011 00:07:24 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jarkko Nikula <jhnikula@gmail.com> [110418 12:18]:
> > Use DEFINE_SPINLOCK() for static spinlock initialization as the commit
> > d04fa5a "locking: Remove deprecated lock initializers" removes the
> > deprecated SPIN_LOCK_UNLOCKED. Since tahvo_lock is not used elsewhere than
> > tahvo.c it can be removed from tahvo.h too.
> 
> Thanks pushed all three. Looks like TAHVO_USB still fails
> to compile as the otg_set_transceiver may not be compiled.
> 
True, it fails if CONFIG_OTG_UTILS is not set and it was selected
by musb in my config. I'll send a Kconfig fix for that.


-- 
Jarkko
