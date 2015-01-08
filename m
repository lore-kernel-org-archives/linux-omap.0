From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: Make ISA ports optional
Date: Thu, 8 Jan 2015 22:36:26 +0000
Message-ID: <20150108223626.43fd93d5@lxorguk.ukuu.org.uk>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
	<20150108131008.16c9a31c@lxorguk.ukuu.org.uk>
	<54AEAC47.1040403@hurleysoftware.com>
	<1896224.oMI8M6J5T7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1896224.oMI8M6J5T7@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-omap@vger.kernel.org

> One idea that has come up in the past but never saw an implementation
> is to make the ttyS namespace and minor numbers completely generic and
> let any serial port driver use it. This would be a major rework, but
> have the added advantage of cleaning up a number of other namespace
> issues as well. There also lots of open question, in particular how
> to maintain compatibility with existing drivers. One could imagine
> that each uart always gets a ttyS device and optionally also gets
> a device node for the same port with a driver specific chardev as
> most of them do today. Or it could be an either/or decision that is
> made at compile time or as a module parameter.

I'm not sure we should use ttyS for it. ttyS means 8250, a lot of
existing code knows what ttyS is and what sort of ioctls and the like are
assumed. A generic namespace needs not to be attached to a legacy naming 

(eg also put all serial ports in /dev/serial/0 /dev/serial/1 etc either
via the tty layer or via systemd/udev)

Alan
