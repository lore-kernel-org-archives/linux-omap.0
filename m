From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: help: BeagleBoard xM RevC ethernet port
Date: Wed, 7 Mar 2012 14:56:44 -0600
Message-ID: <alpine.DEB.2.02.1203071456040.3784@heelrod.ad.cirrus.com>
References: <4F3E0EB7.9060803@ti.com> <874nuizfyf.fsf@ti.com> <4F4613B7.8010601@kynesim.co.uk> <4F4B9405.9070702@ti.com> <CAAL8m4x=6--5irPBPdW4n0dtYuMm_UThqWEuCSyTtsm+cEx4jQ@mail.gmail.com> <CAOCHtYjVhbmi1=S6TZLQTUAb=cf0e5xSzZWyt3sSd0=ANhh_LA@mail.gmail.com>
 <alpine.DEB.2.02.1202291205270.18906@heelrod.ad.cirrus.com> <CAAL8m4yDQRdp5Ar+GoNHsD1_pmBGToF9qbapAhWAvHnOM0Dg9w@mail.gmail.com> <alpine.DEB.2.02.1203071437480.3784@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:16267
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887Ab2CGU5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 15:57:37 -0500
In-Reply-To: <alpine.DEB.2.02.1203071437480.3784@heelrod.ad.cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com

On Wed, 7 Mar 2012, Brian Austin wrote:

> On Thu, 1 Mar 2012, Govindraj wrote:
>
>> On Wed, Feb 29, 2012 at 11:36 PM, Brian Austin <brian.austin@cirrus.com> 
>> wrote:
>>> Applying this patch gives this on my beagleboard xM revC
>>> 
>>> Linux debian 3.3.0-rc4
>>> 
>>> Unable to set up timer: unexpected error
>>> Failed to bring up eth0.
>> 
>> Works for me on 3.3-rc4 + sent patch on beagle xm revc
>> 
>> here this the log [1]
>> 
>> Ensure you have selected following for ehci
>> and usb Ethernet adapter support.
>> 
>> CONFIG_USB_EHCI_HCD
>> CONFIG_USB_EHCI_HCD_OMAP
>> CONFIG_USB_NET_SMSC95XX
>> 
> Thanks for the config.
>
> Unfortunately this does nothing for Debian Unstable on the beagleboard Xm 
> RevC

I should rephrase this.  It does actually show up in the kernel log so the 
kernel sees the device.  My bad.  It just wont grab an IP from Debian.


>
> DHCPREQUEST on eth0 to 255.255.255.255 port 67
> Unable to set up timer: unexpected error
> Failed to bring up eth0.
> root@debian:~# [  310.470581] smsc95xx 1-2.1:1.0: eth0: link up, 100Mbps, 
> full-duplex, lpa 0x45E1
>
> Kernel log shows the device getting registered.
>
> [    4.768096] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at 
> usb-ehci-omap.0-2.1, smsc95xx USB 2.0 Ethernet, 76:22:51:1f:d9:b6
>
>
> I'm guessing this is a Debian problem.  The Debian kernel binary 3.2.7-x5 
> works fine.
>
> I'm building from 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> with tag v3.3-rc4.
>
> Thanks,
> Brian
>

