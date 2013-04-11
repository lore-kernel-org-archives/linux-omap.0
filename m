From: Tony Lindgren <tony@atomide.com>
Subject: Section mismatch warning with linux next in usbhs_init_phys()
Date: Thu, 11 Apr 2013 11:32:01 -0700
Message-ID: <20130411183201.GB10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61714 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752179Ab3DKScD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Apr 2013 14:32:03 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

Hi Roger,

Looks like there's a section mismatch issue in linux next:

WARNING: vmlinux.o(.text+0x2a7b4): Section mismatch in reference from the function usbhs_init_phys() to the function .init.text:usb_bind_phy()
The function usbhs_init_phys() references
the function __init usb_bind_phy().
This is often because usbhs_init_phys lacks a __init 
annotation or the annotation of usb_bind_phy is wrong.

Can you please take a look?

Also, is the auxclk related patch the only patch missing
for USB to work on panda with DT in linux next?

Or are some .dts or .config updates needed also? So far
no luck here.

Regards,

Tony
