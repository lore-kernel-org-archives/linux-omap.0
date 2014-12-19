From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: add the omap-pending tree
Date: Fri, 19 Dec 2014 12:02:30 -0800
Message-ID: <20141219200230.GJ23854@atomide.com>
References: <alpine.DEB.2.02.1412191715230.3102@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34590 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaLSUFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2014 15:05:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1412191715230.3102@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: sfr@canb.auug.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [141219 11:30]:
> 
> Hi Stephen,
> 
> Might you be willing to include this branch in your linux-next builds?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git#for-next
> 
> It will include OMAP clock, bus architecture, and low-level power 
> management patches that are planned to be included in pull requests to the 
> OMAP upstream maintainer, Tony Lindgren.  He in turn will submit pull 
> requests to the arm-soc tree.  The objective in including this branch is 
> to get these patches integration-tested earlier than they would be 
> otherwise.

Makes sense to me. The delay in getting omap stuff into Linux next
via arm-soc for-next is just too long because of the large number
of pending pull requests for various ARM SoCs.

While at it, can you please also (re-)add omap for-next too:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git#for-next

Regards,

Tony
