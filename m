From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/3] ARM: omap: fix 4.7 gpmc networking regression
Date: Wed, 3 Aug 2016 10:01:49 +0200
Message-ID: <20160803080149.GB15860@localhost>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
 <20160802103505.GD28140@atomide.com>
 <9cf04231-091c-4ac3-bfb8-8d8be3d591eb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9cf04231-091c-4ac3-bfb8-8d8be3d591eb@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 03, 2016 at 10:46:24AM +0300, Roger Quadros wrote:
> On 02/08/16 13:35, Tony Lindgren wrote:
> > * Johan Hovold <johan@kernel.org> [160724 05:11]:
> >> Networking is currently broken for Overo boards due to a regression in
> >> 4.7. I bisected it down to
> >>
> >> 	d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
> >> 	for WAITPINs")
> > ...
> > 
> >> Note that simply fixing the Overo NAND issue would fix the Overo
> >> networking regression, but by restoring the 4.6 gpmc-probe behaviour
> >> similar regressions on other OMAP systems are also avoided.
> > 
> > Roger, got a better fix in mind?
> > 
> 
> Nope. I'll take patch 1 in my omap-gpmc queue for v4.8.
> Thanks for the fixes Johan.

Now that 4.7 has been released, you may want to consider adding a stable
tag also for the first patch to avoid similar issues on other systems
when they get updated to 4.7-stable.

Thanks,
Johan
