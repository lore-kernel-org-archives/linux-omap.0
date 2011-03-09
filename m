From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Wed, 9 Mar 2011 10:40:07 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B0653D2@008-AM1MPN1-036.mgdnok.nokia.com>
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
Received: from smtp.nokia.com ([147.243.128.26]:42679 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1CIKkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 05:40:33 -0500
In-Reply-To: <4D775041.9030606@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, ilkka.koskinen@nokia.com, charu@ti.com, wim@iguana.be



> -----Original Message-----
> From: ext Cousson, Benoit [mailto:b-cousson@ti.com]
> 
> In theory, you should not have to disable the interface clock at all.
> Assuming that the smartidle is working properly, the iclk should be gated
> during clock domain transition automagically.
> The only thing that can prevent that is potentially a wrong setting in the
> clockactivity bits? It should be 0x2, meaning fclk is active but iclk can be gated.

Just trying that out now :)

- Kalle

> 
> Regards,
> Benoit
