From: Felipe Balbi <balbi@ti.com>
Subject: Re: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 15:10:17 +0200
Message-ID: <20110107131017.GE9592@legolas.emea.dhcp.ti.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
 <8663c7bb00ba574693af177a10e24043@mail.gmail.com>
 <20110107125929.GD9592@legolas.emea.dhcp.ti.com>
 <48d62e319848b713fc70a8298c32710d@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:56952 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899Ab1AGNKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:10:22 -0500
Received: by mail-ew0-f44.google.com with SMTP id 8so7913725ewy.31
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:10:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <48d62e319848b713fc70a8298c32710d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, Jan 07, 2011 at 06:35:39PM +0530, Santosh Shilimkar wrote:
> This patch is good but it does tell you that if
> you will V6 and v7 together, the feature can't be used.
> 
> Like omap2plus_defconfig, and if booted on
> say omap3 or omap4(v7), swp emulation can't be used
> even though its supported.

Sure, I got that from the patch, but we don't have any other simpler
solution currently. And it's indeed a shame we can't support multi-omap
anymore :-(

-- 
balbi
