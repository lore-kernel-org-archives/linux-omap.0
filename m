From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 1/2] tty: omap-serial: fix division by zero
Date: Wed, 24 Sep 2014 11:09:50 +0200
Message-ID: <20140924090950.GB22872@ci00147.xsens-tech.local>
References: <1411545322-22940-1-git-send-email-frans.klaver@xsens.com>
 <1411545322-22940-2-git-send-email-frans.klaver@xsens.com>
 <20140924080852.GA28215@kroah.com>
 <20140924084111.GA22872@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140924084111.GA22872@ci00147.xsens-tech.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 24, 2014 at 10:41:11AM +0200, Frans Klaver wrote:
> On Wed, Sep 24, 2014 at 01:08:52AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Sep 24, 2014 at 09:55:21AM +0200, Frans Klaver wrote:
> > > If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
> > > calculated n values in serial_omap_is_baud_mode16() may become 0. This
> > > causes a division by zero when calculating the difference between
> > > calculated and desired baud rates. To prevent this, cap the n13 and n16
> > > values on 1.
> > > 
> > > Division by zero in kernel.
> > > [<c00132e0>] (unwind_backtrace) from [<c00112ec>] (show_stack+0x10/0x14)
> > > [<c00112ec>] (show_stack) from [<c01ed7bc>] (Ldiv0+0x8/0x10)
> > > [<c01ed7bc>] (Ldiv0) from [<c023805c>] (serial_omap_baud_is_mode16+0x4c/0x68)
> > > [<c023805c>] (serial_omap_baud_is_mode16) from [<c02396b4>] (serial_omap_set_termios+0x90/0x8d8)
> > > [<c02396b4>] (serial_omap_set_termios) from [<c0230a0c>] (uart_change_speed+0xa4/0xa8)
> > > [<c0230a0c>] (uart_change_speed) from [<c0231798>] (uart_set_termios+0xa0/0x1fc)
> > > [<c0231798>] (uart_set_termios) from [<c022bb44>] (tty_set_termios+0x248/0x2c0)
> > > [<c022bb44>] (tty_set_termios) from [<c022c17c>] (set_termios+0x248/0x29c)
> > > [<c022c17c>] (set_termios) from [<c022c3e4>] (tty_mode_ioctl+0x1c8/0x4e8)
> > > [<c022c3e4>] (tty_mode_ioctl) from [<c0227e70>] (tty_ioctl+0xa94/0xb18)
> > > [<c0227e70>] (tty_ioctl) from [<c00cf45c>] (do_vfs_ioctl+0x4a0/0x560)
> > > [<c00cf45c>] (do_vfs_ioctl) from [<c00cf568>] (SyS_ioctl+0x4c/0x74)
> > > [<c00cf568>] (SyS_ioctl) from [<c000e480>] (ret_fast_syscall+0x0/0x30)
> > > 
> > > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> > > ---
> > >  drivers/tty/serial/omap-serial.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > Should this go to the stable kernel trees as well?
> 
> It's been there for a while. Introduced in 5fe2123647c1508 "OMAP/serial:
> Support 1Mbaud and similar baudrates that require Mode16 instead of
> Mode13" (v3.9). It's probably a good idea to do so. stable@... needs a
> cc?

And would it be enough to just resend this particular patch in that
case?
