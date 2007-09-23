From: Tony Lindgren <tony@atomide.com>
Subject: Re: RMKs comments on latest OMAP upstream patches
Date: Sun, 23 Sep 2007 14:21:49 -0700
Message-ID: <20070923212149.GB10076@atomide.com>
References: <46F29DB0.9060203@googlemail.com>
	<20070921015935.GA26096@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901F3ED6C@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901F3ED6C@dlee13.ent.ti.com>
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
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070921 01:31]:
> > > OMAP1:
> > > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4570/1
> > >
> > > OMAP2:
> > > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4571/1

Looks like Russell has applied these two patch series above!

> Hum, I should Russell's comment reference.  Yes there is a clock register function, however, there is no, command to create a new node.  Further you are not supposed to know what the node structure is.  In the TI tree variant I did add a node create and destroy function.  However, it does cheat and exports some parameters which imply internal knowledge of the clock structure.
> 
> It would seem the best you could do was to pre-install some dummy nodes.  However, you still need a way to fill in the function pointers... Again, need check his pointer.

For board specific GPIO clock control clk_register() with custom
enable/disable functions should work just fine though.

Tony
