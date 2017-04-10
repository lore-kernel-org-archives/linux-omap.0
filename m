From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] serial: omap: suspend device on probe errors
Date: Mon, 10 Apr 2017 09:15:59 -0700
Message-ID: <20170410161559.GB5339@atomide.com>
References: <20170410092139.11441-1-johan@kernel.org>
 <20170410092139.11441-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170410092139.11441-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan@kernel.org> [170410 02:27]:
> Make sure to actually suspend the device before returning after a failed
> (or deferred) probe.
> 
> Note that autosuspend must be disabled before runtime pm is disabled in
> order to balance the usage count due to a negative autosuspend delay as
> well as to make the final put suspend the device synchronously.
> 
> Fixes: 388bc2622680 ("omap-serial: Fix the error handling in the omap_serial probe")
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tony Lindgren <tony@atomide.com>
