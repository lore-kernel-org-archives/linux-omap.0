From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Sun, 19 Dec 2010 17:15:09 +0100
Message-ID: <19726.12173.600912.202134@pilspetsen.it.uu.se>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
	<20101219125508.GG3047@n2100.arm.linux.org.uk>
	<19726.4420.289089.490319@pilspetsen.it.uu.se>
	<20101219144950.GH3047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101219144950.GH3047@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Mikael Pettersson <mikpe@it.uu.se>, Kevin Hilman <khilman@deeprootsystems.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, "Hans J. Koch" <hjk@linutronix.de>, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Sascha Hauer <kernel@pengutronix.de>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@code>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux writes:
 > >  >  Does trr need to be written in
 > >  > ->set_mode (if so that's another bug in this code)?
 > > 
 > > trr{0,1} need not and should not be changed after iop_time_init().
 > 
 > It sounds like trr0 needs to be written in ->set_mode's
 > CLOCK_EVT_MODE_PERIODIC path then, because with my patch, we never set
 > this register.

Hmm, yes, your patch does cause that. I think it's better to keep the
write_trr0() in iop_init_time(), but move it ahead of the
clockevents_register_device() call; this avoids a needless reinitialization
of trr0 in ->set_mode's CLOCK_EVT_MODE_PERIODIC case. Writing to trr0 is safe,
it's only the early write to tmr0 that's dangerous.

My kernel survived that bug because I have CONFIG_NO_HZ=y so the clockevents
timer is always(?) reprogrammed into oneshot-mode, which doesn't use trr0.

 >  Or will trr0 be updated when we write tcr0 ?
 
No, only explicit write_trr0() calls can update trr0.
