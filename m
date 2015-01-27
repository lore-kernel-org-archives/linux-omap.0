From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] omap changes to make dm816x usable
Date: Mon, 26 Jan 2015 20:30:33 -0800
Message-ID: <20150127043033.GK22154@quad.lixom.net>
References: <pull-1422306429-777451>
 <54c6ad94.8182440a.13ff.1604SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50187 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbA0Eac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 23:30:32 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so16439782pde.3
        for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2015 20:30:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54c6ad94.8182440a.13ff.1604SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 26, 2015 at 01:08:19PM -0800, Tony Lindgren wrote:
> The following changes since commit 13efcb188984f69e1f97b4d9e7d3663fb782946f:
> 
>   ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dm816x-data
> 
> for you to fetch changes up to 4d38bd1237f5bb67c3d5d183fc41db4bf4dbfb6b:
> 
>   ARM: OMAP2+: Add dm816x hwmod support (2015-01-26 09:26:32 -0800)
> 
> ----------------------------------------------------------------
> Patches to add necessary SoC related clockdomain and interconnect
> data  to make dm816x boot with basic devices. This finally gets
> dm816x into a usable shape for further work to happen after a few
> years of stalled effort of making this SoC to work with the mainline
> kernel.
> 
> As most of the devices are similar to the other omap variants, we
> get at least serial, MMC, Ethernet, I2C, EDMA, pinctrl, SPI and GPMC
> working for these SoCs with the related device tree changes.

Merged into next/soc.

Thanks,


-Olof
