From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] ARM: OMAP4: USB: power down MUSB PHY during boot
Date: Tue, 13 Nov 2012 16:03:14 -0800
Message-ID: <874nktgif1.fsf@deeprootsystems.com>
References: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
	<20121109143033.GB10718@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55502 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035Ab2KNADH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 19:03:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so5395218pad.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Nov 2012 16:03:07 -0800 (PST)
In-Reply-To: <20121109143033.GB10718@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Fri, 9 Nov 2012 16:30:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>

Felipe Balbi <balbi@ti.com> writes:

> HI,
>
> On Fri, Nov 09, 2012 at 04:30:35PM +0200, Tero Kristo wrote:
>> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
>> PHY functions for OMAP4, but this causes a problem with core retention
>> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
>> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
>> 
>> Fixed by adding a minimal function back that disables the USB PHY during
>> boot.
>> 
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> looks good to me. I would still suggest adding a REVISIT or FIXME note
> stating that this should be moved to SCM driver eventually ;-)
>
> Other than that:
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks will try to get this in for v3.8 along with the original patch
4/9 which gets full-chip retention working on OMAP4.

Kevin
