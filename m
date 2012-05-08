From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: usb: Warnings with the make randconfig && make
Date: Tue, 8 May 2012 06:22:14 -0700
Message-ID: <20120508132214.GA5569@kroah.com>
References: <CAFDqYy3tyDBLPFmGOSj_y92Tagsta21T=yLhkCft7GVj9a53Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45281 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab2EHNWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:22:21 -0400
Received: by pbbrp8 with SMTP id rp8so8038175pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 06:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFDqYy3tyDBLPFmGOSj_y92Tagsta21T=yLhkCft7GVj9a53Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: joseph daniel <josephdanielwalter@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 08, 2012 at 04:19:46PM +0600, joseph daniel wrote:
> Hi all,
> 
> I am getting the following warnings while compiling the 3.4-rc6 kernel
> with the .config attached.
> 
> warning: (MOUSE_APPLETOUCH && MOUSE_BCM5974 && MOUSE_SYNAPTICS_USB &&
> JOYSTICK_XPAD && TABLET_USB_ACECAD && TABLET_USB_AIPTEK &&
> TABLET_USB_HANWANG && TABLET_USB_KBTAB && TABLET_USB_WACOM &&
> TOUCHSCREEN_USB_COMPOSITE && INPUT_ATI_REMOTE2 && INPUT_KEYSPAN_REMOTE
> && INPUT_POWERMATE && INPUT_YEALINK && INPUT_CM109 && RC_ATI_REMOTE &&
> IR_IMON && IR_MCEUSB && IR_REDRAT3 && IR_STREAMZAP && DRM_USB) selects
> USB which has unmet direct dependencies (USB_SUPPORT &&
> USB_ARCH_HAS_HCD)

This is a known problem, patches gladly accepted to try to resolve it
(hint, it's due to DRM_USB)

good luck,

greg k-h
