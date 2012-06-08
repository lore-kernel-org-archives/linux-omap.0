From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Fri, 8 Jun 2012 15:13:48 +0200
Message-ID: <4FD1FA8C.1080600@ti.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54502 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600Ab2FHNN4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 09:13:56 -0400
In-Reply-To: <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On 6/8/2012 3:11 AM, Paul Walmsley wrote:
> On Thu, 7 Jun 2012, Cousson, Benoit wrote:
>
>> Indeed, what I did not mention is that potentially the whole device init
>> should be done ondemand as well. Meaning the whole hwmod setup phase should be
>> done only when the driver will probe the device.
>
> That means if no driver exists for an IP block, or if the driver isn't
> using PM runtime, the IP block won't be reset.  And somehow we still are
> missing drivers in mainline.  We also still have drivers that aren't yet
> PM runtime converted.

No the point is still the same as before. You let the drivers do the job 
if they are there, and then do a pass at very late time during the boot 
process to handle the ones that were not probed by any driver.

At least you will avoid the enable -> reset -> idle -> enable sequence 
we are doing right now for most of the active drivers when it is not 
necessary.

Regards,
Benoit
