From: Archit Taneja <archit@ti.com>
Subject: Re: conflicts between omap/cleanup branch and omap_dss2 tree
Date: Tue, 19 Jul 2011 17:57:57 +0530
Message-ID: <4E25784D.8070300@ti.com>
References: <201107172339.32516.arnd@arndb.de> <20110718080856.GW5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58923 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1GSMSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 08:18:24 -0400
In-Reply-To: <20110718080856.GW5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi,

On Monday 18 July 2011 01:38 PM, Tony Lindgren wrote:
> * Arnd Bergmann<arnd@arndb.de>  [110717 14:36]:
>> Hi Paul and Tomi,
>>
>> I'm trying to get the arm-soc tree integrated into linux-next, but right
>> now that fails because of lots of conflicts in the arch/arm/mach-omap2/clock44xx_data.c
>> and arch/arm/mach-omap2/omap_hwmod_44xx_data.c files.
>>
>> I've done a dumb resolution by pulling in the omap_dss2/for_next tree as a
>> depedency and taking Tomi's version of the files, which is probably wrong
>> but lets Stephen at least take the arm-soc tree.
>
> Yes that's the wrong way around for these files..
>
>> Please fix this properly in either the omap or the omap_dss2 trees.
>
> The clock and hwmod data patches should get queued by Benoit and Paul,
> so I'm suspecting these are some of Tomi's patches still in development.
>
> Tomi can you please check what you have in for-next?

Tomi is on vacation right now, but he checks his mail once in a while, 
so we may get a response soon.

Tomi's for-next branch is not up to date yet. So it shouldn't be 
considered for now. The HWMOD patches in Tomi's for-next branch will be 
pushed by Paul as 3.1-rc fixes.

We will make a temporary branch which will contain all the DSS2 patches 
which Tomi intended to push for this merge window, once he gets a 
chance, he can quickly update his for-next branch with it.

Archit

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

