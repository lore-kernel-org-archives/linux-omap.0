From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Wed, 24 Mar 2010 14:29:21 -0700
Message-ID: <201003241429.21578.dmitry.torokhov@gmail.com>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <20100324161604.GA6338@core.coreip.homeip.net> <201003242221.24551.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201003242221.24551.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 March 2010 02:21:22 pm Janusz Krzysztofik wrote:
> Hi Dmitry,
> 
> Wednesday 24 March 2010 17:16:04 Dmitry Torokhov wrote:
> > On Mon, Mar 22, 2010 at 10:07:47PM +0100, Janusz Krzysztofik wrote:
> > > Meanwhile, I've connected the Amstrad Delta keyboard to a PC. I can
> > > confirm it speaks PS/2 protocol and is automatically detected by
> > > atkbd/i8042 drivers. The initial handshake sequence actually looks
> > > exactly the same as that of a standard AT keyboard.
> > 
> > OK, since the device really speaks PS/2 protocol I withdraw my objection
> > of using serio + atkbd combo, however we should not be doing translation
> > in serio.
> 
> Sure, thank you.
> 
> > > The problem persists about different scancodes, giving
> > > wrong keystrokes.
> > 
> > This can be dealt with from userspace by loading correct keymap.
> 
> Sounds acceptable. I hope the machine's built-in matrix keypad won't be
> affected.
> 

The scan code to key code mapping is per-device so it should not. 

> > > Resuming, if there were a boot/module option to atkbd allowing for
> > > non-default scancode table, or another similiar possibility, both
> > > devices would work with a PC using exsisting drivers.
> > 
> > You can train UDEV to load proper keymap. What does teh device report as
> > 'version' in sysfs (output of 'cat
> > /sys/bus/serio/devices/serio0/input/input3/id/bustype', please adjust
> > serioX and inputX to match yours)?
> 
> When connected to a PC over a real 2-way i8042 port, the device identifies
> itself as:
> 
> # grep '' /sys/bus/serio/devices/serio0/input/input2/id/*
> /sys/bus/serio/devices/serio0/input/input2/id/bustype:0011
> /sys/bus/serio/devices/serio0/input/input2/id/product:0001
> /sys/bus/serio/devices/serio0/input/input2/id/vendor:0001
> /sys/bus/serio/devices/serio0/input/input2/id/version:ab41
> #
> 
> Unfortunatelly, it looks exactly the same as my standard AT keyboard.
>

:(
 
> Can you imagine any other possible way of distinguishing them?

Not automatically. I mean we could assume that if we see AT keyboard on
E3 we'd need special keymap but user would have to override if he
connects a regular one.


-- 
Dmitry
