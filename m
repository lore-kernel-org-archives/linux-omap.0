From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sun, 19 Dec 2010 14:49:50 +0000
Message-ID: <20101219144950.GH3047@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
	<20101219125508.GG3047@n2100.arm.linux.org.uk>
	<19726.4420.289089.490319@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19726.4420.289089.490319@pilspetsen.it.uu.se>
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

On Sun, Dec 19, 2010 at 03:05:56PM +0100, Mikael Pettersson wrote:
> tmr = timer mode register
> tcr = timer counter register
> trr = timer reload register
> 
> When a timer is in periodic mode it reloads itself from its reload
> register when the counter register decrements to zero.

Ok.

>  >  Does trr need to be written in
>  > ->set_mode (if so that's another bug in this code)?
> 
> trr{0,1} need not and should not be changed after iop_time_init().

It sounds like trr0 needs to be written in ->set_mode's
CLOCK_EVT_MODE_PERIODIC path then, because with my patch, we never set
this register.  Or will trr0 be updated when we write tcr0 ?
