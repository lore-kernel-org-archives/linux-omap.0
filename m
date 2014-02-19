From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP
 Support (fwd)
Date: Wed, 19 Feb 2014 20:13:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402192005080.8777@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402191824260.8777@utopia.booyaka.com> <CANacCWy10TTJenrZ6hdTN8bCpAQQjRa5MOBPde7bnn-LM+VFbw@mail.gmail.com> <alpine.DEB.2.02.1402191920040.8777@utopia.booyaka.com>
 <CANacCWxZ8bfXvMed8Qk93n81uEb9YBtHK-Pe_EtJSAUYzrfL-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43582 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbaBSUNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 15:13:04 -0500
In-Reply-To: <CANacCWxZ8bfXvMed8Qk93n81uEb9YBtHK-Pe_EtJSAUYzrfL-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>

On Wed, 19 Feb 2014, Vaibhav Bedia wrote:

> After spending a lot of time looking at the code and PRCM specs for the
> different chips i had come to the conclusion that in reality the Catalog
> parts had the same hardware minus intelligence ;)

Did you look at the RTL?

> The control bits are the same with just the AUTO modes in the PWRDM,
> CLKDM, CLKCTRL never being supported.

I'm not sure it's that simple.  For example PWRSTCTRL/PWRSTST offsets are 
handled very differently between AM335x and the other OMAPs.  Also the 
LOGICRETSTATE mask bits are different.  These unnecessary deltas suggest 
to me that the underlying hardware implementation is different.

I spent some time a few years ago trying to find some hardware guy to give 
some straight answers about the implementation history for the underlying 
blocks, but was never able to find that person.


- Paul
