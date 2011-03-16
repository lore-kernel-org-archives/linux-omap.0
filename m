From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 19:10:28 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161903250.2634@esdhcp041196.research.nokia.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com> <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com> <4D80CA2F.8060300@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:16925 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab1CPRMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 13:12:43 -0400
In-Reply-To: <4D80CA2F.8060300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hi,

On Wed, 16 Mar 2011, Cousson, Benoit wrote:
> On 3/16/2011 2:49 PM, Aaro Koskinen wrote:
>> On Tue, 15 Mar 2011, Cousson, Benoit wrote:
>>> Mmm, that looks like an access to a secure timer from hwmod code on a HS
>>> device. Could you comment out the timer12 entry (&omap3xxx_timer12_hwmod) 
>>> in
>>> the omap3 hwmod list at the end of omap_hwmod_3xxx_data.c to check that?
>> 
>> With timer12 entry commented out and omap_hwmod debugs enabled, it now
>> hangs here:
>
> Do you need that timer BTW?

Probably no at the moment. :-)

>> [    4.347015] OMAP GPIO hardware version 2.5
>
> GPIO are now initialized during postcore_initcall, so it is hard to know what 
> will happen after that:-(
>
> Could you try with initcall_debug in your command line?

Somehow I figured this out, the patch "arm: mach-omap2: omap_l3_smx:
fix irq handler setup" fixes the hang for me (and of course I still need
to comment out timer 12).

A.
