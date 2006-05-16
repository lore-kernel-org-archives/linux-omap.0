From: Brian Swetland <swetland@google.com>
Subject: Re: Linux On TI Omap850
Date: Tue, 16 May 2006 07:11:27 -0700
Message-ID: <20060516141127.GA29719@localhost.localdomain>
References: <200605121905.13405.david-b@pacbell.net>
	<20060514104911.GB4715@atomide.com>
	<200605140919.09540.david-b@pacbell.net>
	<20060515092601.GE8368@atomide.com> <4468BB63.9030206@hotmail.fr>
	<20060516065256.GE3413@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060516065256.GE3413@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[Tony Lindgren <tony@atomide.com>]
> * Vince <v.richomme@hotmail.fr> [060515 10:32]:
> > I would like to know if someone has information about running linux on 
> > TI omap850 platform.
> > I have searched on google and I only found one or two posts regarding 
> > this topic.
> > I would like to have maximum information on this processor.
> 
> Try going to linux.omap.com, go to the mailing lists. Then select April
> 2006 archives by thread. There you see all the current 850 fsample
> patches. We integrated the core 850 fsample support patch yesterday, so
> the device driver patches are still missing.

Speaking of the device driver patches, I still need to figure out how
to have lcd_p2.c included for perseus2 or fsample, but not twice if you
build a kernel for both...

obviously, something like this in drivers/video/Makefile is wrong:

objs-y$(CONFIG_MACH_OMAP_PERSEUS2) += lcd_p2.o
objs-y$(CONFIG_MACH_OMAP_FSAMPLE) += lcd_p2.o

Is the solution to have a CONFIG_FB_OMAP_LCD_P2?

Brian, unwise in the ways of kconfig 
