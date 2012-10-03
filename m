From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/17] serial/8250: Limit the omap workarounds to omap1
Date: Wed, 3 Oct 2012 15:26:22 -0700
Message-ID: <20121003222622.GK4840@atomide.com>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053104.29637.95283.stgit@muffinssi.local>
 <20120911174234.45919fd3@bob.linux.org.uk>
 <20120911164023.GE23092@atomide.com>
 <20120911201919.58d44dcb@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120911201919.58d44dcb@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Alan Cox <alan@linux.intel.com> [120911 12:02]:
> > > Even better would be if for other cases is_omap_port and friends
> > > returned 0...
> > 
> > Yes it seems that those macros could be moved from plat-omap/serial.h
> > to live in drivers/tty/serial/8250/8250.h? Or do you have some better
> > place in mind?
> 
> I've not looked at it enough to decide if it's doable or not. I'm happy
> either way - both patches are progress the right way!

FYI, I'll send something along these lines as a separate patch as
"[PATCH] tty/serial/8250: Make omap hardware workarounds local to 8250.h"

Regards,

Tony
