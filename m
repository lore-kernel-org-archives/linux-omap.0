From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: HS USB errors on OMAP3530
Date: Thu, 7 Aug 2008 21:23:08 -0400
Message-ID: <1f11a5490808071823w49964e5l3be66767a8383228@mail.gmail.com>
References: <1f11a5490808071135i3ac8e5dfl4076c21c5296d254@mail.gmail.com>
	 <200808071238.30983.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:35931 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbYHHBXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 21:23:09 -0400
Received: by wx-out-0506.google.com with SMTP id h29so344982wxd.4
        for <linux-omap@vger.kernel.org>; Thu, 07 Aug 2008 18:23:08 -0700 (PDT)
In-Reply-To: <200808071238.30983.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, Aug 7, 2008 at 3:38 PM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 07 August 2008, Ashwin Bihari wrote:
>
>> sd 0:0:0:0: [sda] Attached SCSI removable disk
>> usb 1-2: reset high speed USB device using ehci-omap and address 2
>> usb 1-2: device descriptor read/64, error -110
>> usb 1-2: device descriptor read/64, error -110
>> usb 1-2: reset high speed USB device using ehci-omap and address 2
>> usb 1-2: device descriptor read/64, error -110
>> usb 1-2: device descriptor read/64, error -110
>> usb 1-2: reset high speed USB device using ehci-omap and address 2
>> usb 1-2: device not accepting address 2, error -110
>> usb 1-2: reset high speed USB device using ehci-omap and address 2
>> usb 1-2: device not accepting address 2, error -110
>> usb 1-2: USB disconnect, address 2
>> sd 0:0:0:0: Device offlined - not ready after error recovery
>> Result: hostbyte=0x01 driverbyte=0x00
>> end_request: I/O error, dev sda, sector 775288
>> end_request: I/O error, dev sda, sector 775288
>> ...
>
> I wouldn't assume this is specifically an OMAP issue -- though
> it might be in this case.  If you could throw a USB sniffer at
> the problem and report what that shows, it may be enlightening...
>
> Folk have been reporting these symptoms for some time, but
> nobody can quite track it down.  I think one person who was
> able to observe the problem (I've never seen it) reported that
> switching disk, USB cable, *OR* PC host made the problem go
> away ... but MS-Windows didn't see it on the same hardware.
>
> As I recall, one person had some recent success shrinking the
> "let SET_ADDRESS settle" mdelay in drivers/usb/hub.c (near
> line 2535).  Strictly speaking, that shouldn't be needed.
>
> - Dave
>

Dave,

I did use a Total Phase Beagle 480USB protocol analyzer when this
issue first manifested, but there is nothing that jumped out at me as
a possible error or glitch. It just looks like the transactions just
stopped mid-way without any rhyme or reason.

I've noticed this issue with a couple of HS flash drives, as well as,
a FS CD-ROM drive.

Would the "let SET_ADDRESS settle" change only affect the initial
detection? My initial insertion of device works great, the errors I
showed are after I do a read of a large amount of data from the Flash
drive and essentially wedge something in the USB stream.

Regards
~ Ashwin
