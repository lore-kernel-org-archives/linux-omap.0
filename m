From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
 to set the RTC
Date: Thu, 09 Jun 2011 11:23:14 +0200
Message-ID: <4DF09102.9080503@ahsoftware.de>
References: <4D9AEB76.2060509@ahsoftware.de> <1302010808-3065-1-git-send-email-holler@ahsoftware.de> <20110531102903.GU11352@atomide.com> <4DEDDAF6.2070505@ahsoftware.de> <4DEDF451.1080604@compulab.co.il> <4DEE0858.2020308@ahsoftware.de> <4DEFF035.4070004@compulab.co.il> <4DF0120E.5030204@ahsoftware.de> <4DF078E4.8040903@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:54004 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1FIJXX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 05:23:23 -0400
Received: from eiche.ahsoftware (p57B215CC.dip0.t-ipconnect.de [87.178.21.204])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 6A1774345A9
	for <linux-omap@vger.kernel.org>; Thu,  9 Jun 2011 11:23:21 +0200 (CEST)
In-Reply-To: <4DF078E4.8040903@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello,

Am 09.06.2011 09:40, schrieb Igor Grinberg:
> On 06/09/11 03:21, Alexander Holler wrote:

> I see. Is the new patch version somehow provides better functionality?
> You configure the gpio for output, this means that the pin is actually driven
> and not just relies on internal pullup (which can vary from chip to chip).
> I know nothing about that msecure stuff, but may be it is better to drive the pin,
> then just configuring the mux (enabling internal pullup)...

Just using the internal pullup was enough with my BeagleBoard C4.

>> Below is an updated version. The gpio_export() might be removed too.
>
> The original patch version is already in Linus' tree, so this one will not apply as it is.
> If you decide it is better then the original one, then it must be rebased.
> Otherwise, looks OK.

I'm fine with either version, so no new patch is necessary. ;)

Regards,

Alexander
