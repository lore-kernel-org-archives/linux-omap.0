From: Nathan Lynch <Nathan_Lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Fri, 10 Oct 2014 20:44:33 -0500
Message-ID: <54388B81.5020306@mentor.com>
References: <20140905213216.GD5001@linux.vnet.ibm.com> <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman> <20141010162531.GL12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141010162531.GL12379-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
> 
> Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
> it seems that this has been known about for some time.)

Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
are affected, as well as 4.9.0.

> We can blacklist these GCC versions quite easily.  We already have GCC
> 3.3 blacklisted, and it's trivial to add others.  I would want to include
> some proper details about the bug, just like the other existing entries
> we already have in asm-offsets.c, where we name the functions that the
> compiler is known to break where appropriate.

Before blacklisting anything, it's worth considering that simple version
checks would break existing pre-4.8.3 compilers that have been patched
for PR58854.  It looks like Yocto and Buildroot issued releases with
patched 4.8.2 compilers well before the (fixed) 4.8.3 release.  I think
the most we can reasonably do without breaking some correctly-behaving
toolchains is to emit a warning.

Hopefully nobody's still using gcc 4.8 from the Linaro 2013.11 toolchain
release -- since it's a 4.8.3 prerelease from before the fix was
committed you'll get GCC_VERSION == 40803 but still generate bad code.

> However, I'm rather annoyed that there are people here who have known
> for some time that GCC 4.8.1 and GCC 4.8.2 _can_ lead to filesystem
> corruption, and have sat on their backsides doing nothing about getting
> it blacklisted for something like a year.

Mea culpa, although I hadn't drawn the connection to FS corruption
reports until now.  I have known about the issue for some time, but
figured the prevalence of the fix in downstream projects largely
mitigated the issue.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
