From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: RX-51: Platform support for lp5523
Date: Tue, 5 Apr 2011 15:59:32 +0300
Message-ID: <4D9B1234.7040605@nokia.com>
References: <20110329172922.GA19494@earth.universe> <20110329173647.GK4016@atomide.com> <20110329181615.GA20371@earth.universe> <20110329193301.GP4016@atomide.com> <4D9B06C1.1080306@nokia.com> <20110405121911.GJ30505@legolas.emea.dhcp.ti.com> <4D9B09B0.9020806@nokia.com> <20110405123015.GM30505@legolas.emea.dhcp.ti.com> <4D9B0C40.8080705@nokia.com> <20110405123841.GN30505@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:58828 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab1DEM7z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 08:59:55 -0400
In-Reply-To: <20110405123841.GN30505@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: ext Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org

Hi Felipe,

On 04/05/2011 03:38 PM, ext Felipe Balbi wrote:
> Hi,
>
> On Tue, Apr 05, 2011 at 03:34:08PM +0300, Ameya Palande wrote:
>>> Exactly, adding a new feature. Let me put it this way: which bug or
>>> regression are you fixing with this patch ?
>>
>> I never claimed that it is fixing a bug/regression ;)
>
> but you want this go into the RC cycle, which is strictly bug fixing and
> regression fixing :-)

How about following commits since v2.6.39-rc1?

54a93b6 ARM: pxa: PalmZ72: Add OV9640 camera support
54d5710 ARM: PXA: Z2: Add default triggers for LEDs
7780c80 arm: mach-kirkwood: add led in sheevaplug-setup.c
14fb20c ARM: mx53_loco: Add GPIO Keypad support
1b6f1e8 ARM: mxs/mx23evk: add mmc device
4b2a58a libceph: Create a new key type "ceph"
6090912 powerpc: Implement dma_mmap_coherent()
57bd35d microblaze: Wire up new syscalls
beb4727 drm/radeon/kms: Add support for tv-out dongle on G5 9600
758f231 drm/radeon/kms: add some new ontario pci ids
41c5789 kernel/signal.c: add kernel-doc notation to syscalls
9a684e1 Documentation: consolidate leds files to leds/ subdir

I agree that rc cycle is mostly about bug/regression fixing but there 
are definitely exceptions for borderline cases and I am trying to check 
if this patch is such a case ;)

Cheers,
Ameya.
