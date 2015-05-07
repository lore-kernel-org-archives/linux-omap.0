From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 7 May 2015 16:41:33 -0500
Message-ID: <554BDC0D.7010401@logicpd.com>
References: <554AA11B.9040909@logicpd.com>	<20150507160606.GB15563@atomide.com>	<20150507161656.GB29183@saruman.tx.rr.com>	<554BAC48.2050406@logicpd.com>	<CAPM0aKVSJfyBj-FzdTDC+PFmHOmch39F26OF_0CzK5a704AVpA@mail.gmail.com> <CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw@mail.gmail.com> <554BD878.7090907@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57344 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbbEGVl4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2015 17:41:56 -0400
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1YqTYG-000753-Q6
	for linux-omap@vger.kernel.org; Thu, 07 May 2015 23:41:52 +0200
In-Reply-To: <554BD878.7090907@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Nordell <public-tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@plane.gmane.org>, public-linux-usb-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Cc: public-linux-omap-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org, public-balbi-l0cyMroinI0@plane.gmane.org



On 05/07/15 16:26, Tim Nordell wrote:
> Hi Felipe -
>
> On 05/07/15 16:21, Bin Liu wrote:
>>> I'm sorry if you are already aware of this information.
>>> Just wanted to share my experience.
>>>
>>> AFAIK, there is a hardware bug with MUSB Host controller.
>>> See ARM_MPU.KERNEL.39 at
>>> http://processors.wiki.ti.com/index.php/Sitara_SDK_6.00.00_Release_Notes
>>> I assume it is common across AM335x and DM3730.
>>
>> No, it is not.
>
> One thing I just found errata advisory 1.81 for the DM37x indicating
> that "USB OTG DMA May Stall Under Specific Configuration".  Does the
> MUSB driver account for this advisory?  If not, maybe all DMA requests
> for the MUSB port could be queued for the DM37x so that they're
> guaranteed to be one at a time?  If double buffering enabled in the
> FIFO, it should permit fast bursts of data in and out of the MUSB driver.
>

Comparing the errata to the code, it appears to be utilizing the 
workarounds listed in the errata.  It looks like commit c0f1f8e38f 
committed the larger burst rates, and it also checks for addresses being 
aligned to 4-bytes wide already.  So that errata probably isn't 
applicable (or at least, the given errata workarounds are definitely in 
the current kernel).

I'm going to try another test which limits the TX or RX activity to PIO 
mode only just to see what happens if I avoid the trigger listed in that 
specific errata (despite the workaround for the errata being present).

- Tim


