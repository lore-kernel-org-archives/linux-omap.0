From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Buffer overrun in the TWL4030 keypad driver with Nokia RX51
Date: Tue, 20 Jul 2010 11:07:45 -0700
Message-ID: <201007201107.46003.dmitry.torokhov@gmail.com>
References: <201007161728.44227.laurent.pinchart@ideasonboard.com> <20100717213705.GA22477@core.coreip.homeip.net> <201007201306.10505.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201007201306.10505.laurent.pinchart@ideasonboard.com>
Sender: linux-input-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, July 20, 2010 04:06:08 am Laurent Pinchart wrote:
> Hi Dmitry,
> 
> On Saturday 17 July 2010 23:37:05 Dmitry Torokhov wrote:
> > On Fri, Jul 16, 2010 at 05:28:43PM +0200, Laurent Pinchart wrote:
> > > I've spent the day debugging a kernel crash in the USB networking code
> > > to find out the problem was caused by a buffer overrun in the TWL4030
> > > keypad driver.
> > > 
> > > The Nokia RX51 board code
> > > (arch/arm/mach-omap2/board-rx51-peripherals.c) defines a key map for
> > > the matrix keypad keyboard. The hardware seems to use all of the 8
> > > rows and 8 columns of the keypad, although not all possible locations
> > > are used.
> > > 
> > > The TWL4030 supports keypads with at most 8 rows and 8 columns. Most
> > > keys are defined with a row and column number between 0 and 7, except
> > > 
> > >         KEY(0xff, 2, KEY_F9),
> > >         KEY(0xff, 4, KEY_F10),
> > >         KEY(0xff, 5, KEY_F11),
> > > 
> > > The row number is set to 0xff. As the generic matrix keypad support
> > > (include/linux/input/matrix_keypad.h) supports at most 16 rows and 16
> > > columns, it masks all but the lower 4 bits of the row and column
> > > numbers in the KEY macro.
> > 
> > [..snipped..]
> > 
> > Thanks for the report. Could yo uplease try the patch below and let me
> > know if it works.
> 
> The patch fixes the crash at startup,

Great.

> but the F9, F10 and F11 key events
> are never reported. That might be because those keys are not wired up to
> anything though.

I would not know... If you see all keys on the device being handled then I 
guess it's the case... Tony, Amit, any ideas?

> All keys on the keyboard, as well as the F7 and F8 keys
> (volume up and down on the of the case)

I guess we need to remap them to KEY_VOLUMEUP and KEY_VOLUMEDOWN then. So is 
F7 == Up and F8 == Down?

> generate the proper events. All
> other "keys" (keyboard slider switch, power button, focus button, lock
> switch, proximity sensor) report events through other devices.
> 
> > I have some concerns with the keymap assignments, I see that Amit
> > changed them during KEY(col, row) -> KEY(row, col) conversion. I marked
> > the entries I am concerned with with XXX.
> 
> F7, F8, right alt and left shift are properly mapped. I don't know what F9,
> F10 and F11 are supposed to be.

OK, thanks. Since you don't crash anymore I think it is worth pushing
it out.

-- 
Dmitry
