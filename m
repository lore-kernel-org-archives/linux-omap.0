From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
Date: Mon, 6 May 2013 18:36:51 -0600
Message-ID: <20130507003651.GA26035@obsidianresearch.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com>
 <51884971.9050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51884971.9050508@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 06, 2013 at 08:23:13PM -0400, Eduardo Valentin wrote:

> > I get the impression it is desired to minimize driver kconfig
> > dependencies to the minimum required to compile to increase build
> > testing coverage, so maybe it would be appropriate to drop this
> > entirely?

> Well, it is also desired to compile things to the correct target
> right?

There is some of that too..

But broadly the direction seems that drivers should have minimal
dependencies so, eg, the thermal maintainer compiling for x86 should
be able to compile test/static analyze your driver..

> Thats the idea behind this config option. It follows the same design as
> CONFIG_ARCH_HAS_CPUFREQ, for instance.

That is entirely contained inside arch/arm and doesn't involve
drivers.

Jason
