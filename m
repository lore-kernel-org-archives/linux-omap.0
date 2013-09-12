From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH RFC 0/6] ARM: OMAP2+: AM43x/AM335x prcm reset driver
Date: Thu, 12 Sep 2013 17:39:34 +0530
Message-ID: <5231AEFE.5000206@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
 <1378375634.3948.10.camel@pizza.hi.pengutronix.de> <5228A99D.4020702@ti.com>
 <1378717612.4151.6.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378717612.4151.6.camel@pizza.hi.pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Philipp,

On Monday 09 September 2013 02:36 PM, Philipp Zabel wrote:

> So if I understand correctly, the only problem is that on OMAP the clock
> needs to be enabled to deassert the reset, but as long as the clock
> domain is in hardware supervised mode, it won't be enabled?

Yes, enabling clock with reset deassertion might not reset the module if
the clock domain is in hardware supervised mode.

> Would it be possible to create an internal API to switch the clock
> domain to software supervised mode, which can be used both by the code
> behind pm_runtime_get_sync and reset_control_deassert?

I will see if that is acceptable.

Another option that would have to be explored is invoking device_reset()
(taking care of clear, deassert & status checking as you suggested)
midway through pm_run_time_get_sync(), when the clockdomain is in
software supervised mode with reset driver taking care of any particular
sequence in the case of multiple reset signals, instead of the IP driver
requiring to take care of it.

Regards
Afzal
