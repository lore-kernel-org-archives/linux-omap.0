From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Update USBHOST pinmux settings
Date: Fri, 26 Sep 2008 21:14:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC9596@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC958E@dbde02.ent.ti.com>
 <1f11a5490809260840w2b04d06ds69e993c4ffd10b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52719 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbYIZPol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 11:44:41 -0400
In-Reply-To: <1f11a5490809260840w2b04d06ds69e993c4ffd10b2e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Ashwin Bihari [mailto:abihari@gmail.com] 

<snip>
> 
> Anand,
> 
> Can you configure the USBHOST to just use the OHCI controller with a
> Phy and not use the EHCI controller at all?
> 
> Regards
> ~ Ashwin

Hi Ashwin,

Yes, you can configure USBHOST to just use the OHCI controller
with a PHY and not use EHCI at all.

Patches coming up on this as soon as I can find the time. This
one was the first in the series - it'll take a little bit of
time to add all the pieces, so I'm sending out the patches as
I generate them.

Regards,
Anand