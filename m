From: Peter Chen <peter.chen@freescale.com>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Sat, 11 Oct 2014 11:54:32 +0800
Message-ID: <20141011035431.GK3756@peterchendt>
References: <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman>
 <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman>
 <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54388B81.5020306@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, josh@joshtriplett.org, Rabin Vincent <rabin@rab.in>, Alan Stern <stern@rowland.harvard.edu>, Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 10, 2014 at 08:44:33PM -0500, Nathan Lynch wrote:
> On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
> > 
> > Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
> > it seems that this has been known about for some time.)
> 
> Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
> are affected, as well as 4.9.0.
> 
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

Yocto has PR58854 problem patch.

http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-devtools/gcc/gcc-4.8/0048-PR58854_fix_arm_apcs_epilogue.patch?h=daisy

> 
> Hopefully nobody's still using gcc 4.8 from the Linaro 2013.11 toolchain
> release -- since it's a 4.8.3 prerelease from before the fix was
> committed you'll get GCC_VERSION == 40803 but still generate bad code.
> 
> > However, I'm rather annoyed that there are people here who have known
> > for some time that GCC 4.8.1 and GCC 4.8.2 _can_ lead to filesystem
> > corruption, and have sat on their backsides doing nothing about getting
> > it blacklisted for something like a year.
> 
> Mea culpa, although I hadn't drawn the connection to FS corruption
> reports until now.  I have known about the issue for some time, but
> figured the prevalence of the fix in downstream projects largely
> mitigated the issue.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,
Peter Chen
