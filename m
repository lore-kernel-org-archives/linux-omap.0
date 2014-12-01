From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: serial: serial-omap: depend on !8250_omap
Date: Mon, 1 Dec 2014 14:09:14 +0000
Message-ID: <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
	<20141129094823.GA10840@linutronix.de>
	<20141129173418.GY2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141129173418.GY2817@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, uwe@kleine-koenig.org
List-Id: linux-omap@vger.kernel.org

> Well the nightmare userspace switch from ttyS to ttyO few years ago is
> something we want to avoid.. I think the best solution would be to make
> serial-omap.c transparently provide support for ttyO using the new 8250
> code so both ttyS and ttyO devices would just work. Otherwise it will
> be years of "my serial port stopped working" questions again.

Thata a udev problem not a kernel one surely.

Alan
