From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Fri, 25 Apr 2008 21:47:09 +0300
Message-ID: <1209149229.30582.243.camel@mort>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	 <48116F5C.9040009@googlemail.com>
	 <20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	 <1209148302.30582.234.camel@mort>
	 <20080425185241.GC27479@kedavra.cpe.vivax.com.br>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17297 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764390AbYDYTBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 15:01:37 -0400
In-Reply-To: <20080425185241.GC27479@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

On Fri, 2008-04-25 at 21:52 +0300, ext Felipe Balbi wrote:
> On Fri, Apr 25, 2008 at 09:31:42PM +0300, Igor Stoppa wrote:
> 
> > You forget power management. It should partially be redone together with
> > the omap3 work, but stuff like DVFS has a quite different implementation
> > due to the different capabilities of the implementations.
> 
> no comments.

since you have a both TRMs, you can check it by yourself: DMA stalling
is not available in 2420

> > > Maybe it's easier to get android's patches on top of current linux-omap
> > > ?
> > 
> > For any practical case where the device has to be used as mobile
> > platform I think it's not an option to use the current l-o.
> 
> For some experiments with android is good enough.

maybe ... i'm not the one experimenting, i'm just saying that it's
better to get a bunch of charged batteries, in case one wants to carry
the tablet around.

> > Hopefully it will be in the future.
> 
> as soon as people start releasing code...

in case you haven't noticed, there's some major rework ongoing for power
management

as i said, hopefully in the future also n810 will benefit from it

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
