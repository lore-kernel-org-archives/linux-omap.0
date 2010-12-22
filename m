From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Wed, 22 Dec 2010 10:59:18 +0000
Message-ID: <20101222105918.GA2838@pulham.picochip.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
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
Cc: Viresh Kumar <viresh.kumar@st.com>, Kevin Hilman <khilman@deeprootsystems.com>, Lennert Buytenhek <kernel@wantstofly.org>, linux-samsung-soc@vger.kernel.org, "Hans J. Koch" <hjk@linutronix.de>, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Walker <dwalker@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Bryan Huntsman <bryanh@codeaurora.org>Sascha Hauer <kernel@>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 17, 2010 at 11:32:23AM +0000, Russell King - ARM Linux wrote:
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
> 
> Still looking for acks or tested-by's for these patches.

Don't know if it helps, but I've tested the core patches on my picoxcell 
series with the fixed versions and it works nicely.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
