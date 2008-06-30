From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 20:49:00 +0300
Message-ID: <20080630174859.GC4877@kedavra.cpe.vivax.com.br>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com> <E4E2FDD8-E1E5-4601-A0B0-D2FC7B27C7C3@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39119 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYF3RtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 13:49:16 -0400
Content-Disposition: inline
In-Reply-To: <E4E2FDD8-E1E5-4601-A0B0-D2FC7B27C7C3@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgre <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

On Mon, Jun 30, 2008 at 07:29:28PM +0200, Koen Kooi wrote:
>
> Op 30 jun 2008, om 13:50 heeft Felipe Balbi het volgende geschreven:
>
>> Use platform_data to pass musb configuration-specific
>> details to musb driver.
>>
>> It's easier to maintain in the sense that neither board
>> will affect the other.
>>
>> For now tested on n800 only, wanna hear from everybody what
>> guys think before test on omap3430sdp
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> Cc: Tony Lindgre <tony@atomide.com>
>> Cc: David Brownell <david-b@pacbell.net>
>> Cc: Anand Gadiyar <gadiyar@ti.com>
>> Cc: Kevin Hilman <khilman@mvista.com>
>> Cc: Bryan Wu <cooloney@kernel.org>
>> ---
>> arch/arm/mach-omap2/board-3430sdp.c  |   75 ++++++++++++++-
>> arch/arm/mach-omap2/board-n800-usb.c |   46 +++++++++-
>> arch/arm/mach-omap2/usb-musb.c       |   55 +++--------
>> arch/arm/mach-omap2/usb-tusb6010.c   |    1 -
>> drivers/usb/musb/musb_core.c         |   37 +++----
>> drivers/usb/musb/musb_core.h         |   14 +---
>> drivers/usb/musb/tusb6010.h          |  169  
>> --------------------------------
>> include/asm-arm/arch-omap/hdrc_cnf.h |  177  
>> ----------------------------------
>> include/asm-arm/arch-omap/usb-musb.h |    6 +-
>> include/linux/usb/musb.h             |   38 +++++++-
>> 10 files changed, 189 insertions(+), 429 deletions(-)
>> delete mode 100644 include/asm-arm/arch-omap/hdrc_cnf.h
>
>
> Wouldn't omap3-beagleboard.c  and omap3-evm.c need a similar change?

Yeah :-)

but for now I only played with omap2. Omap3-based boards I'm still doing
;-)

That's why the patch is marked RFC.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
