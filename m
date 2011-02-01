From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc
 regulator constraints
Date: Tue, 1 Feb 2011 15:52:38 -0800
Message-ID: <20110201235238.GK3358@atomide.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
 <20110201202725.804aa011.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11362 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1BAXwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 18:52:54 -0500
Content-Disposition: inline
In-Reply-To: <20110201202725.804aa011.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110201 10:26]:
> On Tue,  1 Feb 2011 17:36:28 +0200
> Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> 
> > With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage
> > regulator setup will fail if there are voltage constraints defined. This
> > made MMC unusable on this board. Fix by just deleting those redundant
> > constraints.
> > 
> True. Before there were a test min_uV == max_uV && ops->set_voltage and
> now min_uV == max_uV followed by test for ops->set_voltage that returns
> EINVAL if not set (NULL for fixed voltage regulator obviously).
> 
> Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks adding into devel-fixes.

Tony
