From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Wed, 16 Mar 2011 15:33:19 +0100
Message-ID: <4D80CA2F.8060300@ti.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com> <4D7FC70D.7050508@ti.com> <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58413 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078Ab1CPOd1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 10:33:27 -0400
In-Reply-To: <alpine.DEB.1.10.1103161533470.2634@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hi Aaro,

On 3/16/2011 2:49 PM, Aaro Koskinen wrote:
> Hi,
>
> On Tue, 15 Mar 2011, Cousson, Benoit wrote:
>> Mmm, that looks like an access to a secure timer from hwmod code on a HS
>> device. Could you comment out the timer12 entry (&omap3xxx_timer12_hwmod) in
>> the omap3 hwmod list at the end of omap_hwmod_3xxx_data.c to check that?
>
> With timer12 entry commented out and omap_hwmod debugs enabled, it now
> hangs here:

Do you need that timer BTW?

>
> [...]
>
> [    4.306549] OMAP GPIO hardware version 2.5
> [    4.310913] omap_hwmod: gpio4: enabling
> [    4.314971] omap_hwmod: gpio4: enabling clocks
> [    4.320037] OMAP GPIO hardware version 2.5
> [    4.324401] omap_hwmod: gpio5: enabling
> [    4.328460] omap_hwmod: gpio5: enabling clocks
> [    4.333526] OMAP GPIO hardware version 2.5
> [    4.337921] omap_hwmod: gpio6: enabling
> [    4.341949] omap_hwmod: gpio6: enabling clocks
> [    4.347015] OMAP GPIO hardware version 2.5

GPIO are now initialized during postcore_initcall, so it is hard to know 
what will happen after that:-(

Could you try with initcall_debug in your command line?

Regards,
Benoit
