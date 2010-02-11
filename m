From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: Re: USB lockup on OMAP3530
Date: Thu, 11 Feb 2010 19:57:21 +0100
Message-ID: <4B745311.4000708@panicking.kicks-ass.org>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com> <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com> <201001272046.42946.ahartmetz@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E80D1A1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ms01.sssup.it ([193.205.80.99]:60544 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756487Ab0BKS5a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Feb 2010 13:57:30 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D1A1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Andreas Hartmetz <ahartmetz@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

Gadiyar, Anand wrote:
> <snip>
> 
>>>> So far I have tried many versions of the linux-omap and linux-omap-pm
>>>> kernel, from about 2.6.30 to the latest git version. They all exhibit
>>>> the USB OTG death bug.
>>>> I've used kernels with openembedded patches and without, currently
>>>> without. Yesterday I discovered the musb_hdrc.fifo_mode parameter and
>>>> played around with it. I also modified the given configurations. Result:
>>>> - FIFO configurations including .mode = BUF_DOUBLE don't work at all - no
>>>>  devices work.
>>>> - the USB death bug is not fixed by:
>>>>  - using only one endpoint
>>>>  - using no TXRX entries but only separate RX and TX
>>>>    (every endpoint gets a TX and an RX entry though)
>>>>  - using a large number of endpoints with same maxpacket value
>>>> ... still no solution.
>>>>
>>>> Enabling debug output of the musb_hdrc driver (yes I've also compiled in
>>>> debug messages) is not very practical due to the high volume of
>>>> messages; also, when the bug occurs nothing special is printed. The
>>>> first error usually comes from the memory manager / filesystem
>>>> complaining that it can't do "IO to offline device", i.e. the
>>>> disappeared external harddisk (which contains the swapfile).
>>>>
>>>> I would *really* appreciate somebody looking into this because this
>>>> currently makes the hardware as useful as a brick for me. I can supply
>>>> debug output and test patches.
> 
> Would you care to try these two patches please?
> 
> http://marc.info/?l=linux-usb&m=125957336716915&w=2
> 
> And
> 
> The dependency patch:
> http://marc.info/?l=linux-usb&m=125879861004131&w=2
> 
> 
> Let me know if these fix the bug for you.
> 

Use an hub with external power and connect the hub to the OTG and the device to the HUB.
Is it the same?


> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

