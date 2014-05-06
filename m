From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/4] ARM: dts: Add ctrl-core DT node for DRA7
Date: Tue, 6 May 2014 07:26:07 -0700
Message-ID: <20140506142606.GA18474@atomide.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1397654063-8055-2-git-send-email-archit@ti.com>
 <20140418171854.GJ5354@atomide.com> <5354A970.8040605@ti.com>
 <20140421151034.GA23945@atomide.com> <53687198.60405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53687198.60405@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

* Archit Taneja <archit@ti.com> [140505 22:24]:
> Hi,
> 
> On Monday 21 April 2014 08:40 PM, Tony Lindgren wrote:
> >* Archit Taneja <archit@ti.com> [140420 22:16]:
> >>Hi,
> >>
> >>On Friday 18 April 2014 10:48 PM, Tony Lindgren wrote:
> >>>* Archit Taneja <archit@ti.com> [140416 06:20]:
> >>>>Add DT node for the ctrl-core sub module of the DRA7 control module. We map the
> >>>>CTRL_MODULE_CORE address region up to 0x4a002d60, this region contains register
> >>>>fields which configure clocks. The remainder of the registers are related to
> >>>>pad configurations or cross-bar configurations, and therefore aren't mapped.
> >>>
> >>>Can you please check if this can just use the existing
> >>>regmap syscon mapping:
> >>>
> >>>syscon = <&dra7_ctrl_general>;
> >>>
> >>>See how the drivers/regulator/pbias-regulator.c is using the
> >>>syscon to initialize a regulator and then omap_hsmmc.c just does
> >>>the standard regulator calls.
> >>
> >>The thing is that this bit needs to be set before the the DSS hwmods are
> >>reset, and that happens very early. If we don't do this, DSS won't reset
> >>properly, and not get back to an idle state.
> >>
> >>I am not sure where I can configure the syscon register early enough that it
> >>happens before the hwmods are reset. With a syscon mapping, I guess we would
> >>access the register when the DSS driver is probed. But that's too late for
> >>us.
> >>
> >>Ideally, it would be much better to have a syscon mapping. Do you have any
> >>suggestions how this can be achieved very early in boot?
> >
> >It's best to move the reset and initialization of DSS happen later. I believe
> >we already are resetting only some of the hwmods early on.
> >
> 
> I looked at this in some more detail. With the current hwmod
> flags(HWMOD_INIT_NO_RESET/NO_IDLE), we still try to enable the IP, it's just
> the reset part(ocp reset/custom reset and sysc register) or the disable part
> that is skipped. hwmod still tries to enable the IP.
> 
> This again results in the same issue.
> 
> One thing which wasn't clear was that why do we enable a hwmod in the first
> place, if we know that we are going to skip reset?

Probably to configure the idle bits. In general, we should configure the
modules lazily as the driver probes as requested, and then idle the
unused modules with a late_initcall.

Regards,

Tony
