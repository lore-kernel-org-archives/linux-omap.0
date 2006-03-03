From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: camera core : Use platform driver structure
Date: Fri, 3 Mar 2006 11:52:34 -0800
Message-ID: <20060303195234.GM4398@atomide.com>
References: <304D2A85A9643F4A991BDDF8D297BBA602645AE0@dlee05.ent.ti.com>
	<20060224103550.28867.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060224103550.28867.qmail@web32915.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060224 02:36]:
> --- "Zhang, Jian" <jzhang@ti.com> wrote:
> 
> > Komal,
> > 
> > Is there any guideline on the way a driver is registered with LDM?
> > e.g.
> > via driver_register() or platform_driver_register()? We are now
> > always
> > using omap_driver_register() which is a wrapper to driver_register().
> > 
> > Again, is this the trend to move the bulk of init code to probe()
> > function?
> 
> This one is very tricky question :) May be GregKH and RMK can do better
> justice :) 

Board specific init code should be in board-*.c files, and the rest in
probe(). The bus just matches the driver with the board specific code.

Regards,

Tony
