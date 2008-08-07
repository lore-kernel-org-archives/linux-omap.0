From: David Brownell <david-b@pacbell.net>
Subject: Re: HS USB errors on OMAP3530
Date: Thu, 7 Aug 2008 12:38:30 -0700
Message-ID: <200808071238.30983.david-b@pacbell.net>
References: <1f11a5490808071135i3ac8e5dfl4076c21c5296d254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:25401 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751476AbYHGTic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 15:38:32 -0400
In-Reply-To: <1f11a5490808071135i3ac8e5dfl4076c21c5296d254@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thursday 07 August 2008, Ashwin Bihari wrote:

> sd 0:0:0:0: [sda] Attached SCSI removable disk
> usb 1-2: reset high speed USB device using ehci-omap and address 2
> usb 1-2: device descriptor read/64, error -110
> usb 1-2: device descriptor read/64, error -110
> usb 1-2: reset high speed USB device using ehci-omap and address 2
> usb 1-2: device descriptor read/64, error -110
> usb 1-2: device descriptor read/64, error -110
> usb 1-2: reset high speed USB device using ehci-omap and address 2
> usb 1-2: device not accepting address 2, error -110
> usb 1-2: reset high speed USB device using ehci-omap and address 2
> usb 1-2: device not accepting address 2, error -110
> usb 1-2: USB disconnect, address 2
> sd 0:0:0:0: Device offlined - not ready after error recovery
> Result: hostbyte=0x01 driverbyte=0x00
> end_request: I/O error, dev sda, sector 775288
> end_request: I/O error, dev sda, sector 775288
> ...

I wouldn't assume this is specifically an OMAP issue -- though
it might be in this case.  If you could throw a USB sniffer at
the problem and report what that shows, it may be enlightening...

Folk have been reporting these symptoms for some time, but
nobody can quite track it down.  I think one person who was
able to observe the problem (I've never seen it) reported that
switching disk, USB cable, *OR* PC host made the problem go
away ... but MS-Windows didn't see it on the same hardware.

As I recall, one person had some recent success shrinking the
"let SET_ADDRESS settle" mdelay in drivers/usb/hub.c (near
line 2535).  Strictly speaking, that shouldn't be needed.

- Dave
