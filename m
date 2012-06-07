From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 10:02:51 +0200
Message-ID: <4FD0602B.9070704@ti.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454Ab2FGIC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 04:02:59 -0400
In-Reply-To: <20120607075541.GF16342@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 6/7/2012 9:55 AM, Felipe Balbi wrote:
> On Thu, Jun 07, 2012 at 12:51:58AM -0700, Tony Lindgren wrote:
>> * Paul Walmsley<paul@pwsan.com>  [120607 00:44]:
>>> On Thu, 7 Jun 2012, Tony Lindgren wrote:
>>>
>>>> Here too I think driver like features like this should live in the
>>>> driver init for omap OHCI driver. In the likely case that FS OHCI is
>>>> not in use on the board, the OHCI glue can just reset it.
>>>
>>> What if the driver is not compiled into the kernel, but instead is built
>>> as a loadable module?
>>
>> You can still have a core piece of the driver that's always built in, such
>> as omap-ohci-common. But it should live under drivers, not in the bus level
>> code. Or you can insmod/rmmod it to reset things properly.
>
> that's such a hack... both solutions are quite hacky. The only problem
> here is because some bootloaders are leaving controller in an unknown
> state and I guess to be completely safe, resets should be done before
> any driver kicks in.
>
> But, driver will probably reset again the IP block during probe...

Ideally it should be done only in the probe if needed. In the case of 
the DSS, the bootloader can init it with a splash screen and we do not 
want to blindly reset it and thus produce some ugly artifact on the screen.

In fact we should delay the reset to the very last moment and 
potentially reset the IPs not under driver control later after a couple 
of second for example.
It will avoid reseting every IP that will be handled properly by drivers.

Regards,
Benoit
