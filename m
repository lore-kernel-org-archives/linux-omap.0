From: Felipe Balbi <balbi@ti.com>
Subject: Re: twl4030_usb porting advice
Date: Wed, 15 Dec 2010 14:10:23 +0200
Message-ID: <20101215121023.GN2997@legolas.emea.dhcp.ti.com>
References: <4D08ACAC.8070900@xlogic.pl>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53363 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752839Ab0LOMKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:10:34 -0500
Received: by mail-gy0-f169.google.com with SMTP id 10so943045gyg.28
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 04:10:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D08ACAC.8070900@xlogic.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Cc: linux-omap@vger.kernel.org

On Wed, Dec 15, 2010 at 11:55:24AM +0000, Tomasz Mloduchowski wrote:
>Hi!
>
>I'm trying to port the support patches for an OMAP3530 based 
>development kit by Technexion.
>Technexion provides patches for PSP kernel trees, I need to use a 
>kernel with modern IR stack, so I'm developing against 
>linux-omap-2.6.git
>
>
>I'm mostly done with the initial port, however, I'm stuck with the 
>following issue:
>
>[    2.991973] ehci-omap ehci-omap.0: port 2 full speed --> companion
>[    2.992034] ehci-omap ehci-omap.0: GetStatus port:2 status 003801 0 
>ACK POWER OWNER sig=j CONNECT
>[    2.992095] hub 1-0:1.0: port 2 not reset yet, waiting 50ms
>[    3.055511] asoc: twl4030-hifi <-> omap-mcbsp-dai.1 mapping ok
>[    3.061920] ehci-omap ehci-omap.0: GetStatus port:2 status 003002 0 
>ACK POWER OWNER sig=se0 CSC
>[    3.061981] hub 1-0:1.0: unable to enumerate USB device on port 2
>[    3.068389] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004
>
>
>I would gladly welcome any pointers that could help me solve this issue.

you're connecting a FS/LS device to EHCI port, that doesn't work. OMAP
can't handle port handoff to companion OHCI controller, then it fails
not being able to enumerate the device. Try remuxing your port to OHCI
controller and disabling EHCI from Kconfig.

You should be using ohci-omap3.c driver.

-- 
balbi
