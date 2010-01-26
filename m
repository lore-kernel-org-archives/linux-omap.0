From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Mon, 25 Jan 2010 23:06:55 -0800
Message-ID: <201001252306.55625.david-b@pacbell.net>
References: <20091212183410.GF3092@sirena.org.uk> <1260786654-13294-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260786654-13294-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Samuel Ortiz <sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 14 December 2009, Felipe Balbi wrote:
> move twl4030 children to threaded irq.
> 
> Felipe Balbi (4):
>   input: keyboard: twl4030: move to request_threaded_irq
>   input: misc: twl4030: move to request_threaded_irq
>   rtc: twl4030: move to request_threaded_irq
>   usb: otg: twl4030: move to request_threaded_irq

But nothing in drivers/mfd ... the entry to the whole stack?

Did the threaded IRQ stuff ever get set up so that the top
level IRQ thread didn't have to hand off to another thread
each time?  (That's how the current stuff works.  One thread
calling out to each handler.)

If so, I'd like to see that be used here, rather than needlessly
spend all those pages on mostly-unused stacks.  


> 
>  drivers/input/keyboard/twl4030_keypad.c |   11 ++---------
>  drivers/input/misc/twl4030-pwrbutton.c  |   12 +-----------
>  drivers/rtc/rtc-twl4030.c               |   10 +---------
>  drivers/usb/otg/twl4030-usb.c           |   10 +---------
>  4 files changed, 5 insertions(+), 38 deletions(-)
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
