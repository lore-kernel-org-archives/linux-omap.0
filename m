From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: musb crash on suspend
Date: Thu, 28 Jul 2011 17:13:01 -0400
Message-ID: <CAOd_LFwAej8uJxk4aN0r1r5seODuCwE=H3yfjfDnZpcS2SzmTQ@mail.gmail.com>
References: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65203 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab1G1VNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 17:13:02 -0400
Received: by gyh3 with SMTP id 3so2140773gyh.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 14:13:01 -0700 (PDT)
In-Reply-To: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Jul 28, 2011 at 5:05 PM, Cliff Brake <cliff.brake@gmail.com> wrote:

My kernel config is:

CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_TUSB6010 is not set
CONFIG_USB_MUSB_OMAP2PLUS=y
# CONFIG_USB_MUSB_AM35X is not set
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_PERIPHERAL is not set
CONFIG_USB_MUSB_OTG=y
CONFIG_USB_GADGET_MUSB_HDRC=y
CONFIG_USB_MUSB_HDRC_HCD=y
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_INVENTRA_DMA=y

Its interesting that if I plug a host cable into the port, then it
seems to suspend.  Its only when a host cable is not plugged in (ID
pin is not grounded) that I get this crash.

Cliff

-- 
=================
http://bec-systems.com
