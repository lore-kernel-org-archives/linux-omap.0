From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
Date: Fri, 22 Nov 2013 09:14:21 -0800
Message-ID: <20131122171421.GI10023@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
 <20131121231751.GA9772@earth.universe>
 <20131121235729.GD10023@atomide.com>
 <20131122163532.GA32331@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36274 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab3KVROY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Nov 2013 12:14:24 -0500
Content-Disposition: inline
In-Reply-To: <20131122163532.GA32331@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>

* Sebastian Reichel <sre@ring0.de> [131122 08:38]:
> On Thu, Nov 21, 2013 at 03:57:29PM -0800, Tony Lindgren wrote:
> > Well let's use just vaux3 then with a comment to the .dts file if that
> > works also on your 0x2204. It works on my 0x0010 too.
> > 
> > I folded in your changes to the updated patch below. Care to reply with
> > your Signed-off-by too assuming it works also on your 0x2204 n900?
> 
> It does work with the 0x2204 phone.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

OK good to hear. I'll update the patch with that.

Thanks,

Tony
