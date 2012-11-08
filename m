From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 12:08:37 -0600
Message-ID: <509BF525.80309@ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BDAF5.1010703@ti.com> <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com> <509BEE6D.9000902@ti.com> <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756593Ab2KHSIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 13:08:44 -0500
In-Reply-To: <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


On 11/08/2012 11:58 AM, Paul Walmsley wrote:
> On Thu, 8 Nov 2012, Jon Hunter wrote:
> 
>> Igor was mentioning a h/w scenario where the 32kHz source is not
>> present. However, I am not sure which devices support this and is
>> applicable too.
> 
> Pretty sure Igor is referring to the AM3517/3505.  This is very poorly 
> documented, but can be observed in the AM3517 TRM Rev B (SPRUGR0B) Figure 
> 4-23 "PRM Clock Generator" and the AM3517 DM Rev C (SPRS550C) Section 4 
> "Clock Specifications".

Thanks Paul. But AFAICT, even in that h/w configuration the internal 32k
oscillator will be used and so the gptimer will still have a 32k clock
source.

So I still don't see a use-case where the gptimer would not have a 32k
source available. Admittedly, I could be missing one somewhere or I am
just plain old wrong ...

Cheers
Jon
