From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 3/4] tty: serial: 8250 core: add runtime pm
Date: Mon, 7 Jul 2014 14:20:56 +0100
Message-ID: <20140707142056.46f61cf9@alan.etchedpixels.co.uk>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>
	<1404491651-1388-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1404491651-1388-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Fri,  4 Jul 2014 18:34:10 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> While comparing the OMAP-serial and the 8250 part of this I noticed that
> the the latter does not use runtime-pm.

Yes it does, but 8250 parts (generally - omap presumably is special
here ?) need to be powered on to transmit/receive not just for register
access. The core uart layer implements a "pm" operation for this.

As 8250_dw uses runtime pm to implement the pm operation it's not as
simple as assumign it won't get triggered.

I *think* this is ok because the designware and other cases would take a
reference on open and drop it on close, so avoiding any confusion, but
for the register accesses on a closed port it would benefit from a
further double check with Mika especially as the suspend/resume on the
LPSS block on some Intel devices is a little bit too "interesting" for
comfort.

Otherwise however I think this is good.

Alan


