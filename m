From: Nishanth Menon <nm@ti.com>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 17 May 2013 13:19:23 -0500
Message-ID: <20130517181922.GA4439@kahuna>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
 <20130517135022.GH14133@arwen.pp.htv.fi>
 <877gixsfdz.fsf@linaro.org>
 <87vc6hlbnz.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50495 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3EQSTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 14:19:35 -0400
Content-Disposition: inline
In-Reply-To: <87vc6hlbnz.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Kevin Hilman <khilman@linaro.org>, balbi@ti.com, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 20:10-20130517, Peter Korsgaard wrote:
> >>>>> "Kevin" == Kevin Hilman <khilman@linaro.org> writes:
> 
>  >> In this case, we cannot reset that bank, otherwise Starter Kit will
>  >> never boot in mainline. Bad PCB design, I know, but it's not something
>  >> we can change now :-)
> 
>  Kevin> FWIW, we've seen this before (GPIO connected to PMIC reset is a
>  Kevin> fun one), and this is why we have omap_hwmod_no_setup_reset().
> 
> Yes, but there's no dts bindings for this, and from a quick test the
> reset handling happens before the device tree is probed.
I have the same issue with TPS62361 on Palmas -> GPIO controls the
voltage register supplying MPU, without any driver setting things up,
GPIO gets reset and obviously voltage value switches to an voltage where
device does not function.

Solution I am working on to solve this is [1]: snippet is part of a
patch that I am working on atm.

This is the right way to do it IMHO. Will allow the driver to exist when
HWMOD will be eventually replaced by some other framework.


[1]: http://pastebin.com/XPmAB1Zb

 
-- 
Regards,
Nishanth Menon
