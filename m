From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: reset handling in am335x hwmod data
Date: Mon, 20 May 2013 06:38:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8E827@DBDE04.ent.ti.com>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
 <20130517135022.GH14133@arwen.pp.htv.fi> <877gixsfdz.fsf@linaro.org>
 <87vc6hlbnz.fsf@dell.be.48ers.dk> <20130517181922.GA4439@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54729 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab3ETGjB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 02:39:01 -0400
In-Reply-To: <20130517181922.GA4439@kahuna>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>
Cc: Kevin Hilman <khilman@linaro.org>, "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Friday, May 17, 2013 11:49 PM
> To: Peter Korsgaard
> Cc: Kevin Hilman; Balbi, Felipe; Paul Walmsley; linux-
> omap@vger.kernel.org; Tony Lindgren
> Subject: Re: reset handling in am335x hwmod data
> 
> On 20:10-20130517, Peter Korsgaard wrote:
> > >>>>> "Kevin" == Kevin Hilman <khilman@linaro.org> writes:
> >
> >  >> In this case, we cannot reset that bank, otherwise Starter Kit
> will
> >  >> never boot in mainline. Bad PCB design, I know, but it's not
> something
> >  >> we can change now :-)
> >
> >  Kevin> FWIW, we've seen this before (GPIO connected to PMIC reset is
> a
> >  Kevin> fun one), and this is why we have
> omap_hwmod_no_setup_reset().
> >
> > Yes, but there's no dts bindings for this, and from a quick test the
> > reset handling happens before the device tree is probed.
> I have the same issue with TPS62361 on Palmas -> GPIO controls the
> voltage register supplying MPU, without any driver setting things up,
> GPIO gets reset and obviously voltage value switches to an voltage
> where
> device does not function.
> 
> Solution I am working on to solve this is [1]: snippet is part of a
> patch that I am working on atm.
> 
> This is the right way to do it IMHO. Will allow the driver to exist
> when
> HWMOD will be eventually replaced by some other framework.
> 
> 
> [1]: http://pastebin.com/XPmAB1Zb
> 
> 

Both seems to be different to me. What we need is to
Avoid reset of whole GPIO bank during kernel boot. 

Ideally, it would have been much better if drivers starts handling
Idle, ocp reset and standby on their own (killing dependency on hwmod 
init layer).

But looking at current state,
I agree we need to use DT property here, so how about 
Adding DT property  to GPIO node itself. But we have to parse
It early during hwmod init stage. We should read all DT nodes 
Inside function __setup() function, that way can get rid of
HWMOD_INIT_NO_RESET flag completely. Also, this will handle
Both ocp_reset and domain reset.

Thanks,
Vaibhav
