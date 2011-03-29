From: Tony Lindgren <tony@atomide.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 29 Mar 2011 16:32:43 -0700
Message-ID: <20110329233243.GR4016@atomide.com>
References: <20110314192538.GH7258@atomide.com>
 <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
 <4D7FC70D.7050508@ti.com>
 <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
 <4D80CA2F.8060300@ti.com>
 <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20917 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1C2Xcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 19:32:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

* Aaro Koskinen <aaro.koskinen@nokia.com> [110316 10:10]:
> 
> Somehow I figured this out, the patch "arm: mach-omap2: omap_l3_smx:
> fix irq handler setup" fixes the hang for me (and of course I still need
> to comment out timer 12).

FYI, looks like we've started hitting some booter -l kernel size limit
in addition to booter -f size limit.. Now kernels built with
omap2plus_defconfig won't boot on n900 any longer.

I guess the way around that is to install the u-boot loader package.

Regards,

Tony
