From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sun, 19 Dec 2010 10:52:09 +0000
Message-ID: <20101219105209.GN9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19725.57447.256528.883703@pilspetsen.it.uu.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Viresh Kumar <viresh.kumar@st.com>, Kevin Hilman <khilman@deeprootsystems.com>, Lennert Buytenhek <kernel@wantstofly.org>, linux-samsung-soc@vger.kernel.org, "Hans J. Koch" <hjk@linutronix.de>, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@codeaurora.org>Sascha Hauer <kernel@>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 19, 2010 at 11:37:27AM +0100, Mikael Pettersson wrote:
> Russell King - ARM Linux writes:
>  > Here is the entire set of clocksource and sched_clock patches which
>  > have been previously posted.  There's a couple of small tweaks in a
>  > few of the patches (such as adding notrace to OMAP clocksource read
>  > functions), and this also shows the proper ordering of these patches.
>  > 
>  > Still looking for acks or tested-by's for these patches.
> 
> Which tree is this based on? Is this scheduled for 2.6.37 or .38?

It's based on the point where the ftrace updates were merged into my
tree.  I can't produce all the patches that lead up to this set because
there's just too many.

However, it probably applies cleanly on top of the devel-stable stuff.

It's scheduled for the next merge window.

> On n2100 (plat-iop) a missing #include <asm/sched_clock.h> in
> plat-iop/time.c caused a compile error. With that added the kernel
> built w/o warnings but hung immediately after being decompressed.

Will add the missing include.

Normally, this is because sched_clock() is called prior to the mapping
for reading the counter being available, but this is no different from
what was already there.  So, I suspect that n2100 doesn't boot without
these patches applied either.

Any chance of an boot log using the early printk or debug_ll stuff?

> On mach-ixp4xx the kernel built and booted fine, and the interactivity
> problems were gone.
> 
> Tested-by: Mikael Pettersson <mikpe@it.uu.se> (IXP4xx only)

Thanks - will add that to the IXP4xx specific parts.
