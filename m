From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Wed, 24 Mar 2010 22:21:22 +0100
Message-ID: <201003242221.24551.jkrzyszt@tis.icnet.pl>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <201003222207.48707.jkrzyszt@tis.icnet.pl> <20100324161604.GA6338@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53529 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab0CXVVg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Mar 2010 17:21:36 -0400
In-Reply-To: <20100324161604.GA6338@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Dmitry,

Wednesday 24 March 2010 17:16:04 Dmitry Torokhov wrote:
> On Mon, Mar 22, 2010 at 10:07:47PM +0100, Janusz Krzysztofik wrote:
> >
> > Meanwhile, I've connected the Amstrad Delta keyboard to a PC. I can
> > confirm it speaks PS/2 protocol and is automatically detected by
> > atkbd/i8042 drivers. The initial handshake sequence actually looks
> > exactly the same as that of a standard AT keyboard.
>
> OK, since the device really speaks PS/2 protocol I withdraw my objection
> of using serio + atkbd combo, however we should not be doing translation
> in serio.

Sure, thank you.

> > The problem persists about different scancodes, giving
> > wrong keystrokes.
>
> This can be dealt with from userspace by loading correct keymap.

Sounds acceptable. I hope the machine's built-in matrix keypad won't be 
affected.

> > Resuming, if there were a boot/module option to atkbd allowing for
> > non-default scancode table, or another similiar possibility, both devices
> > would work with a PC using exsisting drivers.
>
> You can train UDEV to load proper keymap. What does teh device report as
> 'version' in sysfs (output of 'cat
> /sys/bus/serio/devices/serio0/input/input3/id/bustype', please adjust
> serioX and inputX to match yours)?

When connected to a PC over a real 2-way i8042 port, the device identifies 
itself as:

# grep '' /sys/bus/serio/devices/serio0/input/input2/id/*
/sys/bus/serio/devices/serio0/input/input2/id/bustype:0011
/sys/bus/serio/devices/serio0/input/input2/id/product:0001
/sys/bus/serio/devices/serio0/input/input2/id/vendor:0001
/sys/bus/serio/devices/serio0/input/input2/id/version:ab41
#

Unfortunatelly, it looks exactly the same as my standard AT keyboard.

Can you imagine any other possible way of distinguishing them?

Thanks,
Janusz
