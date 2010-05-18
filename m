From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Tue, 18 May 2010 16:42:23 -0700
Message-ID: <20100518234222.GV5818@atomide.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60805 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0ERXm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 19:42:28 -0400
Content-Disposition: inline
In-Reply-To: <1274194260-16401-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Charulatha V <charu@ti.com> [100518 07:44]:
> This patch series implements GPIO module in platform device model.
> It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
> 
> This patch series is created on "origin/pm-wip/runtime".
> 
> This patch series is tested on OMAP3430 SDP board. It would be of
> great help if someone could test the same on OMAP1 and OMAP2 boards.

Great, thanks. Let's give review these, and then if no more comments,
let's test them in the linux-omap master branch. Too late to get
these merged for this merge window for sure.

Regards,

Tony
