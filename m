From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] ARM: OMAP: Add core fsample support
Date: Mon, 15 May 2006 06:37:27 -0700
Message-ID: <20060515133727.GB31834@localhost.localdomain>
References: <20060428182353.GA9571@localhost.localdomain>
	<4452651C.1000407@mvista.com> <20060515095624.GJ8368@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060515095624.GJ8368@atomide.com>
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
> > Hi Brian,
> > 
> > Seems like you should add a separate CPU: OMAP850 at the same time.  
> > Shouldn't be too much more work.
> > 
> > Is the OMAP850 currently detected exactly like the 730 via the JTAG ID (see 
> > arch/arm/mach-omap1/id.c)
> > 
> > Sorry I couldn't comment on this sooner.
> 
> This would be a nice patch to have.

Shouldn't be hard to do.  A few cpu_is_omap730()s will have to become
cpu_is_omap_7xx()s, I supppose (for behaviour common to 730 and 850).

Brian
