From: Tony Lindgren <tony@atomide.com>
Subject: Re: build error on Linux-2.6.15-rc4-omap1
Date: Tue, 3 Jan 2006 11:04:07 -0800
Message-ID: <20060103190406.GP6034@atomide.com>
References: <20051221.102534.78702175.kaminaga@sm.sony.co.jp>
	<43A8B894.3060204@mvista.com>
	<20051221.112803.112628154.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051221.112803.112628154.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroki Kaminaga <kaminaga@sm.sony.co.jp> [051220 18:34]:
> > > make[2]: *** No rule to make target `arch/arm/mach-omap1/pm.o', needed by `arch/arm/mach-omap1/built-in.o'.  Stop.
> > > make[1]: *** [arch/arm/mach-omap1] Error 2
> > >..
> > > I'm currently doing work-around by making symbolic link from plat-omap/pm.c.
> > > 
> > > Anyone have same build error?
> > 
> > Yes, I now remember I just worked around it and forgot to send a patch 
> > here.  I assume pm.c is being moved from plat-omap to mach-omap1 (and a 
> > future version is destined for mach-omap2), so a patch to move the 
> > current file to mach-omap1 is needed?

Yes, the pm.c is working for omap1 but not for omap2. And they will be
somewhat different.
 
> I'm assuming pm.c (and sleep.S) is same file, and I'm using symbolic link
> to work around, so patch just for moving is not necessary. (at least for me...)
> I hope it'll be fixed in rc6 (or later) in omap big patch.

Hmmm, this should be fixed in the current git tree. At least omap1 with
CONFIG_PM builds fine for me.

Regards,

Tony
