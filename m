From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Sat, 11 Oct 2014 15:14:10 +0100
Message-ID: <20141011141410.GM12379@n2100.arm.linux.org.uk>
References: <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman> <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54388B81.5020306-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nathan Lynch <Nathan_Lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 10, 2014 at 08:44:33PM -0500, Nathan Lynch wrote:
> On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
> > We can blacklist these GCC versions quite easily.  We already have GCC
> > 3.3 blacklisted, and it's trivial to add others.  I would want to include
> > some proper details about the bug, just like the other existing entries
> > we already have in asm-offsets.c, where we name the functions that the
> > compiler is known to break where appropriate.
> 
> Before blacklisting anything, it's worth considering that simple version
> checks would break existing pre-4.8.3 compilers that have been patched
> for PR58854.  It looks like Yocto and Buildroot issued releases with
> patched 4.8.2 compilers well before the (fixed) 4.8.3 release.  I think
> the most we can reasonably do without breaking some correctly-behaving
> toolchains is to emit a warning.

I wish that it was possible to just do the warning thing, but unfortunately
evidence is that many people ignore compiler warnings, because they see
them appearing from the kernel soo often they have become de-sensitised
to them.

This is pretty obvious from the various nightly build systems which produce
the same warnings for months without any progress on them - some of them
can be quite serious (oops-able) where printf format strings are concerned.

> > for some time that GCC 4.8.1 and GCC 4.8.2 _can_ lead to filesystem
> > corruption, and have sat on their backsides doing nothing about getting
> > it blacklisted for something like a year.
> 
> Mea culpa, although I hadn't drawn the connection to FS corruption
> reports until now.  I have known about the issue for some time, but
> figured the prevalence of the fix in downstream projects largely
> mitigated the issue.

It's the FS corruption which swings it in favour of a #error - even if
we have a bunch of compilers around with that version which have the
problem fixed, it's /far/ better to #error out.  Those people who know
definitely that they have a fixed compiler can comment out the test
after checking that they do indeed have a fixed version, or are willing
to take the risk.

What we can't do is have kernels built by people who then run into FS
corruption because of this known issue.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
