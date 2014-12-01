From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] tty: serial: serial-omap: depend on !8250_omap
Date: Tue, 2 Dec 2014 01:13:38 +0200
Message-ID: <20141201231338.GA14524@fuloong-minipc.musicnaut.iki.fi>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
 <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:43038 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbaLAXNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2014 18:13:53 -0500
Content-Disposition: inline
In-Reply-To: <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, uwe@kleine-koenig.org

Hi,

On Mon, Dec 01, 2014 at 02:09:14PM +0000, One Thousand Gnomes wrote:
> > Well the nightmare userspace switch from ttyS to ttyO few years ago is
> > something we want to avoid.. I think the best solution would be to make
> > serial-omap.c transparently provide support for ttyO using the new 8250
> > code so both ttyS and ttyO devices would just work. Otherwise it will
> > be years of "my serial port stopped working" questions again.
> 
> Thata a udev problem not a kernel one surely.

People also use serial console to observe the early kernel boot before
the userspace is started.

A.
