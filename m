From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] clocksource: timer-ti-dm: Make unexported functions
 static
Date: Wed, 28 Feb 2018 14:11:15 -0800
Message-ID: <20180228221115.GL5448@atomide.com>
References: <20180223101254.GA5746@lenoch> <20180223101346.GB5746@lenoch>
 <20180227180641.GE5448@atomide.com> <20180227190752.GC1961@lenoch>
 <20180227192354.GG5448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180227192354.GG5448@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pwm@vger.kernel.org, aaro.koskinen@iki.fi, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, t-kristo@ti.com, robh+dt@kernel.org, narmstrong@baylibre.com, thierry.reding@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Brecht Neyrinck <brechtneyrinck@gmail.com>, sebastian.reichel@collabora.co.uk, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180227 19:24]:
> * Ladislav Michl <ladis@linux-mips.org> [180227 19:09]:
> > On Tue, Feb 27, 2018 at 10:06:41AM -0800, Tony Lindgren wrote:
> > > * Ladislav Michl <ladis@linux-mips.org> [180223 10:14]:
> > > > As dmtimer no longer exports functions, make those previously
> > > > exported static (this requires few functions to be moved around
> > > > as their prototypes were deleted).
> > > 
> > > Looks like this one fails to build with omap1_defconfig:
> > > 
> > > drivers/clocksource/timer-ti-dm.c:935:14: error:
> > > 'omap_dm_timer_get_fclk' undeclared here 
> > 
> > Umm, it compiled fine on top of previous versions, so I didn't bother
> > to retest. I'm sorry about it.
> > 
> > > Other than that the first three patches seem like nice
> > > clean-up :)
> > 
> > So are you okay with sending those separately as cleanup with above
> > issue fixed?
> 
> Yeah seems like those first three are suitable for applying
> on top of the patches in omap-for-v4.17/timer :)

I've now applied your v2 of patch 1 and patches 2 and 3 of
this series into omap-for-v4.17/timer.

Thanks,

Tony
