From: Michael Welling <mwelling@emacinc.com>
Subject: Re: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Fri, 18 Jul 2014 11:13:02 -0500
Message-ID: <20140718161302.GA14154@sysresccd>
References: <20140717234037.GA9660@sysresccd>
 <20140718063806.GK18374@atomide.com>
 <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55111 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbaGRQNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2014 12:13:05 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so772080igq.1
        for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2014 09:13:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com

On Fri, Jul 18, 2014 at 09:40:48AM -0500, Michael Welling wrote:
> On Fri, Jul 18, 2014 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * mwelling <mwelling@emacinc.com> [140717 16:42]:
> >> I am in the process of porting a device tree compatible version of the
> >> linux kernel to a AM3517 based device.
> >>
> >> First I tried 3.10.x and the device tree port appeared to be incomplete.
> >> Neither the LCD or Ethernet were supported.
> >>
> >> Next I tried 3.14.x and the Ethernet driver appeared to work but still
> >> no LCD support.
> >>
> >> Lastly I tried 3.16-rc5 and found that the kernel hangs in early boot
> >> without any messages from the serial COM.
> >
> > For device tree based booting on omap3 I would user v.16-rc4 or later.
> > There have been multiple issues fixed over past year and PM is working
> > finally at least for 36xx/37xx. And we do have the DSS panels finally
> > working too.
> >
> >> I was using the omap2plus_defconfig and the am3517-evm.dtb from each
> >> kernel build. Is there any reason why the kernel would start hanging
> >> with the newest release?
> >
> > No reason that I can think of. AFAIK 3517 has been booting in the test
> > farms just fine?
> >
> > Can you please enable debug_ll + earlyprintk and pass also earlyprintk
> > in the kernel cmdline?
> I will try this.
> >
> >> Are there any versions where the LCD output works?
> >
> > Starting with v3.16-rc1 you should get the LCD working for panel-dpi
> > based devices. Most of them actually are actually ls037v3dw01, so
> > see omap3-panel-sharp-ls037v7dw01.dtsi and omap3-evm-common.dtsi
> > variants if you have similar setup.
> >
> >> Looking at the 3.16-rc5 test results just posted it is supposed to be working
> >> but I have not been able to replicate this.
> >>
> >> Any suggestions would be greatly appreciated.
> >
> > Hmm maybe double check your're booting device tree based kernel
> > instead of legacy machine ID based kernel? The legacy booting should
> > still work just fine and no changes has been made to it, but it will
> > get removed shortly.
> I downloaded the version from the test results and it did boot.
> These are combining the uImage and dtb. How do you accomplish this?

It should be noted that when you try to boot the seperate zImage and dtb from
the test build it fails. This replicates my issue.

Here are the two binaries that I used:
http://www.pwsan.com/omap/testlogs/test_v3.16-rc5/20140716140950/build_z/omap2plus_defconfig/zImage
http://www.pwsan.com/omap/testlogs/test_v3.16-rc5/20140716140950/dtbs/am3517-evm.dtb

Here is the boot attempt:
U-Boot> dhcp;set serverip 10.0.2.168;tftp 0x82000000 zImage; tftp 0x80000000 am3517-evm.dtb;bootz 0x82000000 - 0x80000000
BOOTP broadcast 1
DHCP client bound to address 10.0.3.33
Using DaVinci-EMAC device
TFTP from server 10.0.2.168; our IP address is 10.0.3.33
Filename 'zImage'.
Load address: 0x82000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ######################################
         2 MiB/s
done
Bytes transferred = 4360800 (428a60 hex)
Using DaVinci-EMAC device
TFTP from server 10.0.2.168; our IP address is 10.0.3.33
Filename 'am3517-evm.dtb'.
Load address: 0x80000000
Loading: ####
         1.8 MiB/s
done
Bytes transferred = 50145 (c3e1 hex)
Kernel image @ 0x82000000 [ 0x000000 - 0x428a60 ]
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Device Tree to 9ff05000, end 9ff143e0 ... OK

Starting kernel ...

Using the exact same boot sequence worked for 3.10 and 3.14.

> >
> > Regards,
> >
> > Tony
