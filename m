From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 5 Aug 2008 12:35:44 +0300
Message-ID: <20080805093544.GU30539@gandalf.research.nokia.com>
References: <488F48E3.2060504@indt.org.br> <20080729183717.GB7275@frodo> <fb249edb0807291157v40f4c0e0vf0e35b1beb39cd3b@mail.gmail.com> <13B9B4C6EF24D648824FF11BE89671620361D432D8@dlee02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E5@dbde02.ent.ti.com> <20080805085752.GE7193@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32258 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbYHEJfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:35:01 -0400
Content-Disposition: inline
In-Reply-To: <20080805085752.GE7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, andrzej zaborowski <balrogg@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 05, 2008 at 11:57:53AM +0300, Tony Lindgren wrote:
> Yeah, let's rename it as it's not in mainline yet. I'll apply this
> series, then the next set of patches can take care of the renaming.

It it in mainline actually, check your drivers/i2c/chips and it was
added by you :-p

commit 0c4a59fed41bdd4c30ce0999a87f30a812f29ee2
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Jul 17 04:06:09 2007 -0700

    OMAP: add TI TWL92330/Menelaus Power Management chip driver
    
    Add Texas Instruments TWL92330/Menelaus Power Management chip driver.  This
    includes voltage regulators, Dual slot memory card tranceivers and
    real-time clock(RTC).
    
    The support for RTC is integrated with this driver only; it is not separate
    module.  Passes 'rtctest' on OMAP H4 EVM, other than lack of "periodic"
    (1/N second) IRQs.  System wakeup alarms (from suspend-to-RAM) work too.
    
    The battery keeps the RTC active over power off, so once you set clock
    (rdate/ntpdate/etc, then "hwclock -w") then RTC_HCTOSYS at boot time will
    behave as expected.
    
    Cc: "Jean Delvare" <khali@linux-fr.org>
    Cc: "Tony Lindgren" <tony@atomide.com>
    Cc: "David Brownell" <david-b@pacbell.net>
    Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
    Acked-by: Alessandro Zummo <alessandro.zummo@towertech.it>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Maybe someone sent that patch for you ?

-- 
balbi
