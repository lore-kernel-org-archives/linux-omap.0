From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Thu, 10 Mar 2011 08:20:57 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B065C38@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
 <87bp1lv8uc.fsf@ti.com>
 <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
 <alpine.DEB.2.00.1103081605460.15132@utopia.booyaka.com>
 <9D0D31AA57AAF5499AFDC63D6472631B0652E1@008-AM1MPN1-036.mgdnok.nokia.com>
 <4D775041.9030606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:65292 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab1CJIWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:22:14 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, khilman@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, ilkka.koskinen@nokia.com, charu@ti.com, wim@iguana.be

Hi,

> -----Original Message-----
> From: Jokiniemi Kalle (Nokia-MS/Tampere)
>
>
> Well, the difference is that the iclk enable bit is toggled to disabled, but now
> I'm very puzzled why I still see it as enabled in the PRCM register dump...
> One last lead is that the reverted pm-runtime patch actually puts the
> WDTIMER2 into force idle mode rather than smart idle mode. Have to try this
> one, maybe that helps.
> 

That was it. Patch coming soon, requires some changes on the way idle mode is set in the hd_mod code.

- Kalle
