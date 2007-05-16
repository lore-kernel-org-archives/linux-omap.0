From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP Backlight driver
Date: Wed, 16 May 2007 10:56:00 -0700
Message-ID: <20070516175559.GJ20297@atomide.com>
References: <200705161728.09017.stefano.babic@babic.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200705161728.09017.stefano.babic@babic.homelinux.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: stefano babic <stefano.babic@babic.homelinux.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* stefano babic <stefano.babic@babic.homelinux.org> [070516 08:30]:
> Hi all,
> 
> in the actual repository the video backlight API is already updated to the new 
> one in kernel 2.6.22-rc1 (include/linux/backlight.h).
> Some drivers are updated,too.
> However, the backlight driver for Omap (drivers/video/backlight/omap_bl.c) ist 
> not yet updated to the new API and for this reason cannot be compiled.
> 
> I changed the file according to the new interface :

Great, can you please reply with your Signed-off-by so I can apply this
to linux-omap tree?

Regards,

Tony
