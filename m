From: Kevin Hilman <khilman@ti.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 30 Mar 2011 08:23:47 -0700
Message-ID: <87lizwskcc.fsf@ti.com>
References: <20110314192538.GH7258@atomide.com>
	<alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
	<4D7FC70D.7050508@ti.com>
	<alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
	<4D80CA2F.8060300@ti.com>
	<alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
	<20110329233243.GR4016@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40005 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754659Ab1C3PYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 11:24:00 -0400
Received: by mail-iy0-f178.google.com with SMTP id 12so1354980iyi.9
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 08:23:59 -0700 (PDT)
In-Reply-To: <20110329233243.GR4016@atomide.com> (Tony Lindgren's message of
	"Tue, 29 Mar 2011 16:32:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Aaro Koskinen <aaro.koskinen@nokia.com> [110316 10:10]:
>> 
>> Somehow I figured this out, the patch "arm: mach-omap2: omap_l3_smx:
>> fix irq handler setup" fixes the hang for me (and of course I still need
>> to comment out timer 12).
>
> FYI, looks like we've started hitting some booter -l kernel size limit
> in addition to booter -f size limit.. Now kernels built with
> omap2plus_defconfig won't boot on n900 any longer.
>
> I guess the way around that is to install the u-boot loader package.

Alternatively CONFIG_KERNEL_LZMA=y will get the kernel zImage size back
within size limits that will boot on n900.

Kevin
