From: "Lennart Sorensen" <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Tue, 4 Nov 2014 20:15:06 -0500
Message-ID: <20141105011506.GG24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141104210315.GF24112-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 04, 2014 at 04:03:15PM -0500, Lennart Sorensen wrote:
> So it seems to be working on our board so far.  Will stress test it
> some more.  No DMA of course for now, but oh well.

Well 4 hours running with multiple reboots (our testsuite reboots every
30 minutes to test the watchdog).  So far it has only lost 70 bytes out
of 40MB of data sent between uart7 and uart8 (and we are pretty sure
the serial test has a small bug that causes a few bytes to be lost right
after a reboot sometimes).

The reason I am even trying the new driver today is that we were seeing
soft lockups on the CPU whenever the serial ports were being tested,
usually in less than 5 minutes, so 4 hours without a lockup is a good
sign.  No idea what might be wrong with the old omap serial driver, but
it seems something is (unless of course we managed to break it somehow
when we tried to solve its habit of dropping characters).

I think I will stick with this new driver.  Better long term future
anyhow.

-- 
Len Sorensen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
