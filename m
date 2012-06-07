From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 14:30:50 +0200
Message-ID: <4FD09EFA.20304@ti.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2FGMa7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 08:30:59 -0400
In-Reply-To: <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

+ Ohad

On 6/7/2012 12:52 PM, Paul Walmsley wrote:
> On Thu, 7 Jun 2012, Cousson, Benoit wrote:
>
>> In fact we should delay the reset to the very last moment and
>> potentially reset the IPs not under driver control later after a couple
>> of second for example. It will avoid reseting every IP that will be
>> handled properly by drivers.
>
> We discussed this a couple of years ago on the list and aligned on late
> and lazy resets, from my recollection.

Indeed, what I did not mention is that potentially the whole device init 
should be done ondemand as well. Meaning the whole hwmod setup phase 
should be done only when the driver will probe the device.

> The main reason why it wasn't
> implemented was because there were some drivers that were not yet PM
> runtime-converted.  This would have caused crashes, since the core code
> would have no idea that the non-PM-runtime drivers had initialized their
> devices, and so the core just went ahead and reset those anyway.
>
> It might actually be safe now to switch to the late reset arrangement,
> depending on whether the rest of the drivers have been PM
> runtime-converted by now.
>
> Of course, it would all be moot if the reset is moved away from the hwmod
> code into the drivers.

I do think that moving that to driver code seems much better since all 
these customs reset code (I2C, DSS, USB...) does anyway require access 
to the device itself. The is driver responsibility to do that.

So ideally it should not be in OMAP architecture code.

Regards,
Benoit
