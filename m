From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP1/2+: 32k-timer: Add hwmod lookup for
 32k-timer
Date: Mon, 5 Mar 2012 14:57:52 -0800
Message-ID: <20120305225751.GL12083@atomide.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14666 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab2CEW5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:57:53 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317AF2D2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120123 00:16]:
> On Thu, Jan 19, 2012 at 19:58:21, Hiremath, Vaibhav wrote:
> > This patch series cleans up the existing 32k-sync timer implementation
> > without any major code change and adds hwmod lookup for omap2+ devices,
> > if lookup fails then fall back to gp-timer.
...
 
> Tony,
> 
> If there are no review comments, can this be merged?

Made a minor comment on the first patch, it would be nice to get
that clean-up merged. The other two depend on some some hwmod
data shrinkage by Paul..

Regards,

Tony
