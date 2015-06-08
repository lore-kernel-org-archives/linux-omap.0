From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 8 Jun 2015 02:38:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506080234271.15153@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
 <5571576E.6020207@myspectrum.nl> <557157FA.7080305@myspectrum.nl> <557411DC.9020109@myspectrum.nl> <alpine.DEB.2.02.1506071952490.15153@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37487 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbFHCis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Jun 2015 22:38:48 -0400
In-Reply-To: <alpine.DEB.2.02.1506071952490.15153@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeroen Hofstee <linux-arm@myspectrum.nl>
Cc: Jeroen Hofstee <jeroen@myspectrum.nl>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jeroen,

On Sun, 7 Jun 2015, Paul Walmsley wrote:

> On Sun, 7 Jun 2015, Jeroen Hofstee wrote:
> 
> > On 05-06-15 10:04, Jeroen Hofstee wrote:
> > > 
> > > On 05-06-15 10:01, Jeroen Hofstee wrote:
> > > > 
> > > > On 01-06-15 19:44, Paul Walmsley wrote:
> > > > > The best way to make this work IMHO would be for us not to accept any
> > > > > new
> > > > > feature addition patches as long as there are warnings reported in the
> > > > > test results.  The only real exception that I would foresee is if those
> > > > > warnings are due to something outside of our control, e.g., a crappy
> > > > > bootloader, as I suspect the USB_OTG initiator warnings are for the
> > > > > CM-T3517.
> > > > > 
> > > > 
> > > > I doubt this is related to the bootloader. I have the suspicion that is
> > > > actually
> > > > a bug in linux but only triggered depending on whether the ROMcode setup
> > > > the USB OTG or not. Here is some data to backup my statement:
> > > > 
> > 
> > Turns out my suspicion was wrong. This is what I know at the moment,
> > depending on the bootpins, u-boot will trigger a bad access when loading
> > a file over ethernet, but only the first time. Clearing the pending interrupt
> > before booting linux make the "USB_OTG address hole seen" go away.
> 
> Oh, too bad.  I had been hoping that you were right and that I was wrong 
> ;-)  I'll try this on the CM-T3517 here.

I used your debugging technique here and was able to reproduce your 
results - with one difference:

http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150607194102/boot/cmt3517/cmt3517_log.txt

The interconnect error was logged upon the first interaction with the 
network.  In my case this was with the U-boot 'dhcp' command.  The pending 
interrupt bit was cleared before loading the kernel via tftp, and the 
interrupt bit was not set again, even after a tftp load.


regards,

- Paul
