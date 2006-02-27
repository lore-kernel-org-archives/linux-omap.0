From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] omapfb vsync support
Date: Mon, 27 Feb 2006 14:30:19 -0800
Message-ID: <20060227223019.GA29436@localhost.localdomain>
References: <EA12F909C0431D458B9D18A176BEE4A50481E3A8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50481E3A8@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

["Woodruff, Richard" <r-woodruff2@ti.com>]
> How come there is no disable of the interrupt?
> 
> Seems like at ioctrl the caller needs to be tracked so when he does a
> close the interrupt can be disabled.
> 
> This will cause a VST enabled kernel to wake up for no good reason if
> there is no application requesting it anymore.  Someone pointed out this
> fact to me recently while doing power measurements.  If you have a low
> power screen saver mode this can mess up expected power savings.

Hmm.  I wonder if there's some happy medium between disabling the 
interrupt every time the ioctl returns and having to close and reopen
the driver when going into and returning from low power mode.

Brian
