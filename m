From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] serial: omap: fix wrong context restoration on init
Date: Fri, 26 Jul 2013 16:00:51 -0700
Message-ID: <20130726230051.GA25990@kroah.com>
References: <1373630142-21765-1-git-send-email-grygorii.strashko@ti.com>
 <1373630142-21765-2-git-send-email-grygorii.strashko@ti.com>
 <20130712121146.GC17053@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130712121146.GC17053@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 12, 2013 at 03:11:46PM +0300, Felipe Balbi wrote:
> hi,
> 
> On Fri, Jul 12, 2013 at 02:55:42PM +0300, Grygorii Strashko wrote:
> > Since commit a630fbf "serial: omap: Fix device tree based PM runtime"
> > the OMAP serial driver will always try to restore its context in
> > serial_omap_runtime_resume(). But the problem is that during driver
> > initialization the UART context is not ready yet and, as result, first
> > call to pm_runtime_get*() will cause UART register overwriting by all
> > zeros. This causes Kernel boot hang in case if "earlyprintk" feature is
> > enabled at least [1].
> > 
> > Unfortunately, there is no exact place in driver now where we can
> > determine that UART context is ready - most of registers configured in
> > serial_omap_set_termios(), but some of them in other places.
> > More over, even if PM runtime will be disabled (blocked) during OMAP
> > serial driver probe() execution [2],[3] it will fix only console UART,
> > but context of other UARTs will be overwriting by all zeros during first
> > access to the corresponding UART.
> > 
> > To fix this issue:
> > - introduce additional "initialized" flag and update PM runtime callback
> > to do nothing if its not set. Set "initialized" at the end of probe().
> > - read current UART registers configuration in probe and use it by
> > default.
> > 
> > [1] http://www.spinics.net/lists/arm-kernel/msg256828.html
> > [2] http://www.spinics.net/lists/arm-kernel/msg258062.html
> > [3] http://www.spinics.net/lists/arm-kernel/msg258040.html
> > 
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Rajendra Nayak <rnayak@ti.com>
> > CC: Felipe Balbi <balbi@ti.com>
> > CC: Kevin Hilman <khilman@linaro.org>
> > 
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > ---
> > tested on OMAP4 SDP with and without earlyprintk enabled.
> >  drivers/tty/serial/omap-serial.c |   27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index f39bf0c..e1e9667 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -162,6 +162,7 @@ struct uart_omap_port {
> >  	struct work_struct	qos_work;
> >  	struct pinctrl		*pins;
> >  	bool			is_suspending;
> > +	bool			initialized;
> 
> you really think adding this sort of bool flag is the best thing we can
> do ? Something which will, quite likely, spread through every single
> driver ?

I agree, that's not ok, please fix this up "properly" somehow.

thanks,

greg k-h
