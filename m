From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: omap: repair building without PM_SLEEP
Date: Mon, 3 Jun 2013 10:07:30 -0700
Message-ID: <20130603170730.GA30767@kroah.com>
References: <1844339.mxci2DdvBF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1844339.mxci2DdvBF@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 01, 2013 at 11:18:13AM +0200, Arnd Bergmann wrote:
> A recent bug fix in 3.10, ddd85e225c "serial: omap: prevent runtime PM for
> "no_console_suspend"", introduced a regression from an obvious typo:

I don't see that commit id, or commit, in Linus's tree at all.  Where do
you see it?

> drivers/tty/serial/omap-serial.c:1677:14: error: 'serial_omap_complete' 
> 	undeclared here (not in a function)
> 
> This changes the incorrectly added macro to the one that we need instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please apply for 3.10-rc

Really?  It doesn't apply to 3.10-rc3 or -rc4 from what I can tell.

confused,

greg k-h
