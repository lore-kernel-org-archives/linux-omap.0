From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: Make ISA ports optional
Date: Thu, 08 Jan 2015 23:05:12 +0100
Message-ID: <1896224.oMI8M6J5T7@wuerfel>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com> <20150108131008.16c9a31c@lxorguk.ukuu.org.uk> <54AEAC47.1040403@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54AEAC47.1040403@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 08 January 2015 11:11:51 Peter Hurley wrote:
> 
> This interface is just storage and minor allocation, since the
> port-reuse behavior will be limited to the "universal" driver.
> From a sub-driver perspective, the shared storage is actually
> a hindrance, so that reduces the requirement to minor allocation.
> 
> And that's where I'm stuck at the moment -- how to share ttyS
> minor allocation. ttyS console is a related problem.

One idea that has come up in the past but never saw an implementation
is to make the ttyS namespace and minor numbers completely generic and
let any serial port driver use it. This would be a major rework, but
have the added advantage of cleaning up a number of other namespace
issues as well. There also lots of open question, in particular how
to maintain compatibility with existing drivers. One could imagine
that each uart always gets a ttyS device and optionally also gets
a device node for the same port with a driver specific chardev as
most of them do today. Or it could be an either/or decision that is
made at compile time or as a module parameter.

	Arnd
