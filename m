From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH] ARM: omap2plus_defconfig: Switch over to using 8250
 driver
Date: Fri, 10 Apr 2015 15:40:39 -0400
Message-ID: <55282737.8060407@hurleysoftware.com>
References: <1428689893-14605-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vn0-f46.google.com ([209.85.216.46]:45633 "EHLO
	mail-vn0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbDJTkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2015 15:40:41 -0400
Received: by vnbg190 with SMTP id g190so8018855vnb.12
        for <linux-omap@vger.kernel.org>; Fri, 10 Apr 2015 12:40:40 -0700 (PDT)
In-Reply-To: <1428689893-14605-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>

[ +Sebastian, +Tony ]

On 04/10/2015 02:18 PM, Nishanth Menon wrote:
> 8250 driver should be relatively feature complete. It can co-exist
> with omap-serial driver

Not really; if the omap_8250 is selected then it is probed first
and will be the only driver claiming omap UART ports.

omap-serial would just be dead-weight.

> , so just enable 8250 OMAP layer driver and
> route all ttyOx references to ttySx through the standard 8250 driver
> to ensure no breakage of userspace occurs.

Not quite; the only automatic handling is for console only, not for
userspace. Expect lots of userspace breakage.

Regards,
Peter Hurley

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Current upstream next-20150410 status: (all boards pass without this patch)
> Test is a basic boot test (using omap2plus_defconfig ofcourse)..
> 
> Ofcourse:
> [    0.001035] WARNING: Your 'console=ttyO0' has been replaced by 'ttyS0'
> does not help userspace when they are not able to dynamically handle switch.
> 
> Just curious if folks feel we are ready for this switch yet...
> 
> ttyS-change
>  1:                     am335x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2551733
>  2:                      am335x-sk: BOOT: FAIL: http://paste.ubuntu.org.cn/2551734
>  3:                     am3517-evm: BOOT: FAIL: http://paste.ubuntu.org.cn/2551735
>  4:                      am37x-evm: BOOT: FAIL: http://paste.ubuntu.org.cn/2551736
>  5:                      am437x-sk: BOOT: FAIL: http://paste.ubuntu.org.cn/2551737
>  6:                    am43xx-epos: BOOT: FAIL: http://paste.ubuntu.org.cn/2551738
>  7:                   am43xx-gpevm: BOOT: PASS: http://paste.ubuntu.org.cn/2551739
>  8:                 BeagleBoard-XM: BOOT: FAIL: http://paste.ubuntu.org.cn/2551740
>  9:            beagleboard-vanilla: BOOT: FAIL: http://paste.ubuntu.org.cn/2551741
> 10:               beaglebone-black: BOOT: PASS: http://paste.ubuntu.org.cn/2551742
> 11:                     beaglebone: BOOT: FAIL: http://paste.ubuntu.org.cn/2551743
> 12:                     craneboard: BOOT: FAIL: http://paste.ubuntu.org.cn/2551744
> 13:                     dra72x-evm: BOOT: FAIL: http://paste.ubuntu.org.cn/2551745
> 14:                     dra7xx-evm: BOOT: FAIL: http://paste.ubuntu.org.cn/2551746
> 15:         OMAP3430-Labrador(LDP): BOOT: FAIL: http://paste.ubuntu.org.cn/2551747
> 16:                           n900: BOOT: FAIL: http://paste.ubuntu.org.cn/2551748
> 17:                      omap5-evm: BOOT: FAIL: http://paste.ubuntu.org.cn/2551749
> 18:                  pandaboard-es: BOOT: FAIL: http://paste.ubuntu.org.cn/2551750
> 19:             pandaboard-vanilla: BOOT: FAIL: http://paste.ubuntu.org.cn/2551751
> 20:                        sdp2430: BOOT: FAIL: http://paste.ubuntu.org.cn/2551752
> 21:                        sdp3430: BOOT: FAIL: http://paste.ubuntu.org.cn/2551753
> 22:                        sdp4430: BOOT: FAIL: http://paste.ubuntu.org.cn/2551754
> TOTAL = 22 boards, Booted Boards = 3, No Boot boards = 19
> 
>  arc/arm/configs/omap2plus_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9ff7b54b2a83..6ef76856ac8e 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -220,6 +220,8 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_8250_DETECT_IRQ=y
>  CONFIG_SERIAL_8250_RSA=y
> +CONFIG_SERIAL_8250_OMAP=y
> +CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_OMAP=y
>  CONFIG_SERIAL_OMAP_CONSOLE=y
> 

