From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] cbus: tahvo: Fix build breakage caused by
 deprecated initializer removal
Date: Tue, 19 Apr 2011 00:07:24 -0700
Message-ID: <20110419070724.GB477@atomide.com>
References: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58911 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1DSHH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 03:07:27 -0400
Content-Disposition: inline
In-Reply-To: <1303154492-13520-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110418 12:18]:
> Use DEFINE_SPINLOCK() for static spinlock initialization as the commit
> d04fa5a "locking: Remove deprecated lock initializers" removes the
> deprecated SPIN_LOCK_UNLOCKED. Since tahvo_lock is not used elsewhere than
> tahvo.c it can be removed from tahvo.h too.

Thanks pushed all three. Looks like TAHVO_USB still fails
to compile as the otg_set_transceiver may not be compiled.

Tony
