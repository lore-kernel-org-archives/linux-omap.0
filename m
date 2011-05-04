From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
	usage.
Date: Wed, 4 May 2011 11:09:14 +0100
Message-ID: <20110504100914.GA25495@n2100.arm.linux.org.uk>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com> <1304080796-625-6-git-send-email-govindraj.raja@ti.com> <20110504100232.GA2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110504100232.GA2092@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 04, 2011 at 03:02:33AM -0700, Tony Lindgren wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> >
> > Also during bootup console_lock is not available.
> >        --> uart_add_one_port
> > 	   --> console_register
> > 	       --> console_lock
> > 	        --> console_unlock
> > 	             --> call_console_drivers (here yet console_lock is not released)
> > 		          --> uart_console_write
> > 
> > Hence convert prints from omap_device_enable/disable to pr_debug.
> 
> This sounds like a hack considering we have things working with
> pr_debug currently.

It also highlights a different problem: stuffing subsystems full of
debug, and keeping it way after the subsystem has been brought to a
working state not only adds code bloat but also can cause additional
bugs.
