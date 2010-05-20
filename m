From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Thu, 20 May 2010 21:51:34 +0100
Message-ID: <20100520215134.6c172752@lxorguk.ukuu.org.uk>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
	<1274090554-19420-2-git-send-email-felipe.balbi@nokia.com>
	<20100520110600.be702f58.akpm@linux-foundation.org>
	<20100520200417.5ec99735@lxorguk.ukuu.org.uk>
	<20100520121652.cbcbb8b4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100520121652.cbcbb8b4.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

> I'm still wobbling on the 35-vs-36 line.  Is that a big need or a
> little need?  What user-visible problem does it solve, etc?
> 
> Did anyone test it on the MID boxes?

Yes and no - our code is subtly different but we'll just adapt to the
Nokia patch.

The MID bits are heading for .36 I hope so I can't help on the "when"
choice other than to note that it doesn't touch seem to change any code
other than the new functions...

Alan
