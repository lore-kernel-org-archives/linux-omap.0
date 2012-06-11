From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Mon, 11 Jun 2012 11:24:33 +0200
Message-ID: <4FD5B951.7010607@ti.com>
References: <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi> <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com> <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com> <20120611061546.GQ12766@atomide.com> <alpine.DEB.2.00.1206110154170.16974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2FKJYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 05:24:40 -0400
In-Reply-To: <alpine.DEB.2.00.1206110154170.16974@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Paul,

On 6/11/2012 10:04 AM, Paul Walmsley wrote:
> On Sun, 10 Jun 2012, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [120608 06:33]:
>>
>>> I don't really have a huge problem with switching to a late reset,
>>> but there are disadvantages to it.
>>
>> I think the early reset actually has more disadvantages to it compared
>> to driver reset. We don't see any errors when things go wrong, and we
>> may even kill the only debug console in the reset process.
>>
>> We are already doing what Benoit describes with clocks where we only
>> reset the unclaimed ones at late_initcall level, and that has proven
>> to work well.
>
> The difference though between the clock and the IP block init is that
> leaving the clocks on until later has no effect on system stability.  The
> chip simply consumes more energy.
>
> But if the IP blocks are reset later, and the bootloader or previous OS
> gets some register settings wrong, there's a greater risk of system
> instability or unpredictable behavior during the boot process.

Mmm, I'm not convince by that. If we delay the PM init at the very last 
time, at least after the modules are properly reset and init, I do not 
think we will have more issues than today.

Regards,
Benoit

