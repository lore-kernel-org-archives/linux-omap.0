From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: omap: fix buffer overruns during RX/TX data processing
Date: Fri, 5 Dec 2014 20:18:53 +0300
Message-ID: <46D905A0-2E71-4490-84BD-4D2467E13899@gmail.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com> <1417294803-14729-2-git-send-email-al.kochet@gmail.com> <20141201195841.GD2817@atomide.com> <B3F4FEFF-2333-473D-8A35-7D4EF1C44D90@gmail.com> <20141204180946.GG2817@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141204180946.GG2817-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello, Tony!

> The issue I'm seeing on 2430sdp is some earlier regression that
> has started happening over the past year or so. 

I don't have 2430sdp. And I couldn't  find 2430sdp schematics.
Looks, like this is NDA stuff.

> Of course the issue I'm seeing could be caused by hung twl4030
> PMIC too.

This could be switching twl4030 into inappropriate for 2430sdp mode.

For example, SMARTREFLEX_ENABLE bit is dangerous, because
it switch twl-pads from VMODE to i2c.
And when you set SMARTREFLEX_ENABLE, twl automatically drop
VDD1 and VDD2 to 1.2V (if VDD1_SR_CONTROL was not initialized through
BYPASS register early in the boot loader).

What mode is used in the 2430sdp? VMODE or Smartreflex?

And, that is my assumption, may be it wrong again.

I'd added trace in the twl_i2c_read_u8/twl_i2c_write_u8 functions to
easy find concrete line of code, what cause problem (by register address).

Hang happens on access to 0x004b address group.
That could be: BACKUP_REG, INT, PM_MASTER, PM_RECEIVER, RTC or
SECURED_REG. It hard to tell which one cause hang without trace.

Hope this helps.

Regards,
Alexander.
