From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: isp1301-omap: Convert timers to use timer_setup()
Date: Tue, 17 Oct 2017 10:52:43 +0200
Message-ID: <20171017085243.GA9776@kroah.com>
References: <20171016232923.GA101254@beast>
 <87376ikxez.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87376ikxez.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 17, 2017 at 11:09:56AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Kees Cook <keescook@chromium.org> writes:
> > In preparation for unconditionally passing the struct timer_list pointer to
> > all timer callbacks, switch to using the new timer_setup() and from_timer()
> > to pass the timer pointer explicitly.
> >
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> do you want me to take this through my tree?
> 
> If you wanna take through yours, here's my ack:
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

I'll just take it through mine, thanks :)

greg k-h
