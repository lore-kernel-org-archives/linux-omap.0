From: Charles Manning <cdhmanning@gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Fri, 7 Aug 2015 12:41:51 +1200
Message-ID: <CAE21AQoATGZQHUUd3=+A1GZ2wt2vgJSmAUO=MQcnUP5cGK9g6g@mail.gmail.com>
References: <87egjp2r4a.fsf@linutronix.de>
	<55BAC67E.1010400@hurleysoftware.com>
	<20150803160937.GA26497@linutronix.de>
	<55BF980E.20908@hurleysoftware.com>
	<55BF9CE0.4080107@linutronix.de>
	<55BFC1BA.5020605@hurleysoftware.com>
	<55C0A8F4.4010204@linutronix.de>
	<55C352A8.3070102@hurleysoftware.com>
	<55C3539F.4070403@linutronix.de>
	<55C36846.8010104@linutronix.de>
	<55C3A5E8.4030506@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C3A5E8.4030506@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 7, 2015 at 6:22 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> I agree; this is what we should do first because someone might want it
> for backports.

Got an idea how far this can be ported back?

I'm being hampered by severe performance issues on a
beagleboneblack-like device (am335x) running on 3.18 kernel.

I have a 1Mbaud link that is getting packets of about 22 bytes @800 Hz
and old omap-serial is keeping up, but killing the CPU.

I'm considering backporting 8250_omap as a get out of jail.

Opinions appreciated.

Thanks.
