From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: USB charging over TPS65950 BCI
Date: Sun, 2 Aug 2009 18:44:49 +0300
Message-ID: <6ed0b2680908020844s493648ebq11e8afabcf44eddb@mail.gmail.com>
References: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:58361 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZHBPov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Aug 2009 11:44:51 -0400
Received: by fg-out-1718.google.com with SMTP id e12so361242fga.17
        for <linux-omap@vger.kernel.org>; Sun, 02 Aug 2009 08:44:50 -0700 (PDT)
In-Reply-To: <f502236f0907310649t148117f6l8a5a06cb651dca6d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jul 31, 2009 at 4:49 PM, pramod gurav<pramodforum@gmail.com> wrote:
> Hi All,
> I was trying to get the USB battery charging working over TPS65950 BCI
> on the OMAP3430 custom board. I am working with linux-omap-2.6
> v2.6.28-omap1 tag. I enabled the TWL4030 MADC and TWL4030 BCI drivers.
> I passed interrupt details to these drivers from platform_device
> structure from my board file. I could get the AC charging working. The
> AC and USB detection worked. However the USB charging is not
> happening.
> I read through the TPS TRM and took the dumps of the registers from
> BCI and some from TWL USB module and BOOT_BCI whenever I plug in the
> USB charger between host and the board. The register settings seem to
> be fine. But the battery is not charging. I am using BQ27000 chip for
> battery monitoring and I can see the battery voltage is decreasing.

There seem to be USB related changes in Zoom git, you can try and see
if it helps:
http://git.omapzoom.org/?p=repo/omapkernel.git;a=blob;f=drivers/power/twl4030_bci_battery.c;hb=refs/heads/ti-2.6.27-omap3

Let us know if it helps.
