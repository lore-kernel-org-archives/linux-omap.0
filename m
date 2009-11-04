From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Wed, 04 Nov 2009 00:36:07 +0000
Message-ID: <4AF0CC77.9080005@blueyonder.co.uk>
References: <4AEC544A.4000304@blueyonder.co.uk>	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>	 <4AECCB34.9010003@blueyonder.co.uk>	 <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>	 <4AEE19F4.70000@blueyonder.co.uk> <20091102070409.GA17351@nokia.com>	 <4AEF8294.4000108@blueyonder.co.uk> <4551feaf0911021728s6587dffchd716ff1241b0373b@mail.gmail.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:43186 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbZKDAgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 19:36:08 -0500
In-Reply-To: <4551feaf0911021728s6587dffchd716ff1241b0373b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/11/09 01:28, Robert Nelson wrote:
>> I tried that and various others to get other than the hub enumerated, no
>> luck so far with kernels I have built - no lights on the hub. I am now
>> rebuilding after following the config for the working narcissus build,
>> EHCI looks much the same, so here's hoping.
>> I have another 16G MMC card I am trying on after cross compiling on a
>> Fedora 12 VirtualBox VM.
>> Regards
>> Sid.
> 
> Hi Sid
> 
> I eventually got ehci working today on my tree on launchpad.  But it's
> not that small of a patch once i added all the mach to plat changes...
> 
> However, this commit made all the difference for me, it's currently
> missing from tmlind's tree, the beagleboard needs it to enable power
> to the ehci..
> 
> http://patchwork.kernel.org/patch/55703/
> 
> Regards,

Thanks, the patch worked and all the EHCI devices are enumerated. There
are other issues like no output to the LCD and I don't have a FB_OMAP2
option, so trying to rebuild with FB_OMAP=y. The configuration setup
seems to be very particular and easily upset by certain changes. I guess
the right patches have to be installed or build failures result.

Lowlevel video output switch controls (VIDEO_OUTPUT_CONTROL) [N/m/y/?] n
E-Ink Broadsheet/Epson S1D13521 controller support (FB_BROADSHEET)
[N/m/y/?] n
OMAP frame buffer support (EXPERIMENTAL) (FB_OMAP) [Y/n/m/?] y
External LCD controller support (FB_OMAP_LCDC_EXTERNAL) [N/y/?] (NEW)
MIPI DBI-C/DCS compatible LCD support (FB_OMAP_LCD_MIPID) [N/y/?] (NEW)
Check bootloader initialization (FB_OMAP_BOOTLOADER_INIT) [N/y/?] (NEW)
Consistent DMA memory size (MB) (FB_OMAP_CONSISTENT_DMA_SIZE) [2] (NEW)

# l -R 2.6.32-rc5/kernel/drivers/video/
2.6.32-rc5/kernel/drivers/video/:
total 0
drwxr-xr-x  3 root root  72 Nov  3 21:58 ./
drwxr-xr-x 16 root root 392 Nov  3 21:58 ../
drwxr-xr-x  2 root root 160 Nov  3 21:58 console/

2.6.32-rc5/kernel/drivers/video/console:
total 68
drwxr-xr-x 2 root root   160 Nov  3 21:58 ./
drwxr-xr-x 3 root root    72 Nov  3 21:58 ../
-rw-r--r-- 1 root root  7647 Nov  3 21:58 bitblit.ko
-rw-r--r-- 1 root root 43880 Nov  3 21:58 fbcon.ko
-rw-r--r-- 1 root root 10743 Nov  3 21:58 font.ko
-rw-r--r-- 1 root root  3984 Nov  3 21:58 softcursor.ko

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

