From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console
 usage.
Date: Wed, 4 May 2011 03:02:33 -0700
Message-ID: <20110504100232.GA2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-6-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304080796-625-6-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

* Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>
> Also during bootup console_lock is not available.
>        --> uart_add_one_port
> 	   --> console_register
> 	       --> console_lock
> 	        --> console_unlock
> 	             --> call_console_drivers (here yet console_lock is not released)
> 		          --> uart_console_write
> 
> Hence convert prints from omap_device_enable/disable to pr_debug.

This sounds like a hack considering we have things working with
pr_debug currently.

Tony
