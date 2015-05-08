From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Fri, 08 May 2015 13:24:46 -0500
Message-ID: <554CFF6E.9020208@logicpd.com>
References: <554AA11B.9040909@logicpd.com>	<20150507160606.GB15563@atomide.com>	<20150507161656.GB29183@saruman.tx.rr.com>	<554BAC48.2050406@logicpd.com>	<CAPM0aKVSJfyBj-FzdTDC+PFmHOmch39F26OF_0CzK5a704AVpA@mail.gmail.com> <CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw@mail.gmail.com> <554BD878.7090907@logicpd.com> <554BDC0D.7010401@logicpd.com> <554BE351.7070908@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32897 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbbEHSZK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2015 14:25:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1YqmxM-0006Me-Iu
	for linux-omap@vger.kernel.org; Fri, 08 May 2015 20:25:04 +0200
Received: from 66-162-60-14.static.twtelecom.net ([66.162.60.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2015 20:25:04 +0200
Received: from tim.nordell by 66-162-60-14.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2015 20:25:04 +0200
In-Reply-To: <554BE351.7070908@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

On 05/07/15 17:12, Tim Nordell wrote:
> On 05/07/15 16:41, Tim Nordell wrote:
>> I'm going to try another test which limits the TX or RX activity to PIO
>> mode only just to see what happens if I avoid the trigger listed in that
>> specific errata (despite the workaround for the errata being present).
>
> The system survives this.  I'm not sure if it's just because of
> different usages of the system, or if because there is still an issue
> with TX/RX DMA at the same time despite the advisory for the hardware
> still being followed.
>

I was wrong about the MUSB code implementing the advisory correctly.  I 
misread the advisory as saying 32-bit aligned when in fact it says 
32-byte aligned.  The additional constraints for the DMA advisory on the 
DM37x states that for Tx DMA packets, the data should be 32-byte aligned 
(Rx can go to any alignment still).  It also has payload size 
constraints for both Rx and Tx which aren't checked in the existing MUSB 
driver.

Doing some testing, the USB networking stack isn't sending 32-byte 
aligned buffers so I can't double check to see if this completely fixes 
it or if it's just masking it by adding some additional checks.  For our 
system, we're going to leave the Tx DMAs completely disabled.

At some point a patch should be developed which follows Advisory 1.81 
for the DM3730 part.

- Tim


