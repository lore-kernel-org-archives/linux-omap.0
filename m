From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: don't build hwspinlock in vain
Date: Mon, 5 Mar 2012 14:23:38 -0800
Message-ID: <20120305222337.GD12083@atomide.com>
References: <1330859129-354-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2CEWXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:23:40 -0500
Content-Disposition: inline
In-Reply-To: <1330859129-354-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [120304 02:34]:
> Cleanup: don't build mach-omap2/hwspinlock.c if the OMAP hwspinlock
> driver isn't configured.
> 
> This will both shorten build time and avoid registering a device
> which isn't needed.

Thanks applying into fixes-non-critical-part2.

Tony
