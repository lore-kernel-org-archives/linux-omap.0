From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Sat, 11 Oct 2014 15:16:38 +0100
Message-ID: <20141011141638.GN12379@n2100.arm.linux.org.uk>
References: <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman> <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com> <20141011035431.GK3756@peterchendt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141011035431.GK3756@peterchendt>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Nathan Lynch <Nathan_Lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 11, 2014 at 11:54:32AM +0800, Peter Chen wrote:
> On Fri, Oct 10, 2014 at 08:44:33PM -0500, Nathan Lynch wrote:
> > On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
> > > 
> > > Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
> > > it seems that this has been known about for some time.)
> > 
> > Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
> > are affected, as well as 4.9.0.
> > 
> > > We can blacklist these GCC versions quite easily.  We already have GCC
> > > 3.3 blacklisted, and it's trivial to add others.  I would want to include
> > > some proper details about the bug, just like the other existing entries
> > > we already have in asm-offsets.c, where we name the functions that the
> > > compiler is known to break where appropriate.
> > 
> > Before blacklisting anything, it's worth considering that simple version
> > checks would break existing pre-4.8.3 compilers that have been patched
> > for PR58854.  It looks like Yocto and Buildroot issued releases with
> > patched 4.8.2 compilers well before the (fixed) 4.8.3 release.  I think
> > the most we can reasonably do without breaking some correctly-behaving
> > toolchains is to emit a warning.
> 
> Yocto has PR58854 problem patch.
> 
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-devtools/gcc/gcc-4.8/0048-PR58854_fix_arm_apcs_epilogue.patch?h=daisy

Right, and we can provide links to these in the comments above the #error
so people have the right places to do a bit of research into whether their
compiler is safe.

It is unfortunate that they are indistinguishable from the broken versions,
but that's really a distro problem for causing that issue themselves -
especially given how serious this bug is.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
