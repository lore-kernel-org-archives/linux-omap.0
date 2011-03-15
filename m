From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3 00/18] I2C: OMAP1: OMAP2+: I2C fixes, removal of
 cpu_is... from driver
Date: Tue, 15 Mar 2011 15:28:13 -0700
Message-ID: <20110315222813.GL7258@atomide.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49158 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab1COW2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 18:28:36 -0400
Content-Disposition: inline
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

* Andy Green <andy@warmcat.com> [110315 12:53]:
> The following series removes cpu_...() usage completely from the
> omap-i2c driver by having decisions about functional implementation
> choices in the SoC held in cpu-specific hwmod tables that are
> already established, or for OMAP1 where there is no hwmod, set at
> OMAP1-specific i2c bus addition time.

You should send this to the i2c list with Ben Cc'd.

Tony
