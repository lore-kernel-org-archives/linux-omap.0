From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][Patch V1] OMAP3: Mux Changes.
Date: Fri, 16 Oct 2009 10:03:56 -0500
Message-ID: <4AD88B5C.3020609@ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAFFA9@dbde02.ent.ti.com> 	<4AD7FC40.406@ti.com> <6cb013310910160715qb8a93b5y1c34781ee565dc32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48942 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759378AbZJPPEq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Oct 2009 11:04:46 -0400
In-Reply-To: <6cb013310910160715qb8a93b5y1c34781ee565dc32@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: "Pais, Allen" <allen.pais@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Cory Maccarrone had written, on 10/16/2009 09:15 AM, the following:
> On Thu, Oct 15, 2009 at 9:53 PM, Nishanth Menon <nm@ti.com 
> <mailto:nm@ti.com>> wrote:
> 
>     Pais, Allen had written, on 10/15/2009 11:53 PM, the following:
> 
>         a) A simple comment to all my comments: why cant we have these
>         in bootloader and just simply leave the mux file alone?
>         [Allen] Yes Nishanth, this would be a much cleaner approach.
>         Even Santosh had suggested
>         The same, if we can conclude on a approach here, I can go ahead
>         and do the Mux Change it accordingly.
> 
>     Then lets please fix the bootloader and drop this patch.
> 
> 
[...]
> Maybe I'm missing something, but why is it more desirable to add the mux 
> code to the bootloader instead of the kernel?  Wouldn't adding it to the 
> kernel guarantee it works regardless of the bootloader?
adding mux in kernel guarentees that it is independent of the bootloader 
- yes - no questions on that. There are two strategies that can be taken:

A) Ensure that kernel is independent from bootloader variances
   - this is desirable and would adhere to the rules of an entity uses 
the resources(muxes) ONLY what it is required for itself to work -> e.g. 
bootloader would use the minimal set that is required for itself to 
function.

B) Divide the load -> always assume that kernel and bootloaders work 
together.
    - Do all the static muxes in u-boot -> since the u-boot dies off 
once the kernel starts up, the memory is completely freed up.
    - Only the dynamic muxes (e.g. pins being used in two modes by two 
drivers) are handled by the kernel.

The current strategy that is implemented for OMAP3 is (B), but once the 
kernel infrastructure for mux handling improves we should be able to 
arrive at a compromise between A and B as far as execution latencies Vs 
memory usage Vs independence issues are concerned. we are not there yet 
unfortunately.


-- 
Regards,
Nishanth Menon
