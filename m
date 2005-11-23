From: Brian Swetland <swetland@google.com>
Subject: Re: usb gadget driver on 730?
Date: Wed, 23 Nov 2005 14:10:19 -0800
Message-ID: <20051123221019.GB9523@localhost.localdomain>
References: <20051122224435.GA21970@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051122224435.GA21970@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[Brian Swetland <swetland@google.com>]
> 
> Is there any documentation on how to set up some of the simple gadget
> drivers (like g_zero or the ethernet interface)?  In particular, can
> it be done without using external modules and mod_probe?  

I can confirm that the omap_udc driver is init()ing, but the probe
function never gets called, so the udc* is null when things like the
zero driver try to register.

Does anyone know what needs to happen for the omap_udc driver to
initialize?  It does have a bind and unbind published under
/bus/platform/drivers/omap_udc/...

Any suggestions would be appreciated (or pointers to existing docs or
the like).

Brian
