From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: OTG MUSB driver issue?
Date: Mon, 2 Mar 2009 14:04:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03AF5@dbde02.ent.ti.com>
References: <ac9c93b10902280246j39b37adcx5c9abd5c6dd6a444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33685 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756216AbZCBIej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 03:34:39 -0500
In-Reply-To: <ac9c93b10902280246j39b37adcx5c9abd5c6dd6a444@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

> 2009/2/27 Felipe Balbi <me@felipebalbi.com>:
> > On Fri, Feb 27, 2009 at 06:52:38PM +0100, Frans Meulenbroeks wrote:
> >> Hi,
> >>
> >> Several times I encountered issues with devices connected to the
> >> beagle board's OTG port (through a powered hub). (kernel 2.6.28-omap1).
> >> Today this happened again and I was lucky enough to be able to find
> >> the symptoms.
> >>
> >> Scenario: I had a file on a USB hard disk. This file was copied to an
> >> SD card. After copying the file was corrupted.
> >> Removing the card and hard disk and connecting them to my linux box
> >> allowed me to compare the SD and hard disk version (using cmp -l).
> >> There were differences on four places. Each difference was 4 bytes (32
> >> bits) and occurred on a 4 byte boundary.
> >>
> >> I have no idea what causes it, but I strongly suspect the MUSB driver.
> >> A hauppauge usb tv card also does not work when connected to the hub,
> >> whereas the same card works without problem on a linksys NSLU2 (which
> >> also has an arm processor).
> >>
> >> Anyone suggestions? Patches ??
> >
> > I guess that should be already fixed with patches queued up in Greg's
> > queue, but then again, let me check more. Could you:
> >
> > # echo 5 > /sys/modules/musb_hdrc/parameters/debug
> > # echo 8 > /proc/sysrq-trigger
> >
> > then connect device and send me log output ?
> >
> > --
> > balbi
> >
> 
> Hi Balbi,
> 
> Thanks for your help.
> It was echo 5 > /sys/module/musb_hdrc/parameters/musb_debug
> 
> Also beforestarting the system I removed all other usb devices from
> the hub (I have to use a hub to get enough power for the hard disk).
> 
> After connecting the disk it took about two seconds before the system
> started to generate log data.
> The system kept on generating debug info so after about two minutes I
> decided that it was enough and switched off the beagle and saved the
> log file. If  this is too short let me know and I'll repeat the
> experiment.
> The last 30 lines or so are probably caused by the device loosing
> power. At that point it was still very busy generating messages
> 
> The log file is attached: 54 k gizpped 1.2M unzipped.
> 
> If you happen to have a patch that would be great.
> 
> Best regards, Frans


I tried this on the current linux-omap codebase (as of today). I
transferred a 1 GB file back-and-forth a couple of times between
a flash drive and an SD card on a USB card reader (both connected
through a USB hub to the MUSB port). There was no data corruption.

How big was your file? Any chance the card reader or the hard drive
is bad?

What kind of corruption do you see? (You mentioned 4 bytes were different
in 4 places. How different?)

- Anand

P.S. I tested this on the 3430 SDP. Only changes I made from the
defconfig were to remove CONFIG_USB_STORAGE_DEBUG and CONFIG_DEBUG_LL.
