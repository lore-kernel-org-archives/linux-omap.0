From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Wed, 11 Jan 2012 08:22:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110809530.31702@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com> <4EEB086A.2050607@ti.com> <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
 <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com> <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com> <4F0D9B70.3000309@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54171 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab2AKPWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 10:22:53 -0500
In-Reply-To: <4F0D9B70.3000309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

On Wed, 11 Jan 2012, Cousson, Benoit wrote:

> Something that puzzle me on that point is most architecture does not use
> plateform_device and thus does not have any pdata to hack some custom function
> pointers here an there.
> It means that there is probably some better solution to handle that.

PCI and USB have their own bus-level device reset functions that are 
exported from bus code that lives under drivers/.  In a similar fashion, 
we could export omap_device_reset() from our arch/arm/plat-omap code.  
But that would require that arch/arm/plat-omap and arch/arm/mach-omap2 
code to be compiled for any ARM build that includes i2c-omap.c.  This 
would be good to avoid, under the principle that drivers should be 
buildable for any architecture.  (This is also why we wish to remove 
omap_{read,write}*() and cpu_is_omap() from any drivers which contain 
those.)

The intention a few years ago was to eventually create a a real omap_bus 
and omap_device, with the bus/device integration code living under 
drivers.  In such a situation, we'd be able to use something like the 
PCI/USB approach cleanly, since there wouldn't be dependencies to arch/ 
code.

> AFAIU, the way PPC is handling that is by splitting the driver in a generic
> part and in a platform specific part.
>
> You can then add any OMAP specific hacks in the OMAP specific part while 
> keeping most of generic code in a generic driver.
> 
> In this case, we just have to implement a small shim that will handle the OMAP
> specific code for the reset. The generic driver will handle the rest.
> 
> Maybe I'm missing some important details, but that does seems easily doable
> for the i2c case.

Hmm.  How do those drivers call the platform-specific code in a way that 
allows those drivers to be built for non-PPC platforms?


- Paul
