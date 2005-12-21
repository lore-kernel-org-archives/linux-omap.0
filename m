From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: build error on Linux-2.6.15-rc4-omap1
Date: Wed, 21 Dec 2005 11:28:03 +0900 (JST)
Message-ID: <20051221.112803.112628154.kaminaga@sm.sony.co.jp>
References: <20051221.102534.78702175.kaminaga@sm.sony.co.jp>
	<43A8B894.3060204@mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43A8B894.3060204@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tpoynor@mvista.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > make[2]: *** No rule to make target `arch/arm/mach-omap1/pm.o', needed by `arch/arm/mach-omap1/built-in.o'.  Stop.
> > make[1]: *** [arch/arm/mach-omap1] Error 2
> >..
> > I'm currently doing work-around by making symbolic link from plat-omap/pm.c.
> > 
> > Anyone have same build error?
> 
> Yes, I now remember I just worked around it and forgot to send a patch 
> here.  I assume pm.c is being moved from plat-omap to mach-omap1 (and a 
> future version is destined for mach-omap2), so a patch to move the 
> current file to mach-omap1 is needed?

I'm assuming pm.c (and sleep.S) is same file, and I'm using symbolic link
to work around, so patch just for moving is not necessary. (at least for me...)
I hope it'll be fixed in rc6 (or later) in omap big patch.

Best Regards,


HK.
--
