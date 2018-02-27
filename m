From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] clocksource: timer-ti-dm: Make unexported functions
 static
Date: Tue, 27 Feb 2018 10:06:41 -0800
Message-ID: <20180227180641.GE5448@atomide.com>
References: <20180223101254.GA5746@lenoch>
 <20180223101346.GB5746@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180223101346.GB5746@lenoch>
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

* Ladislav Michl <ladis@linux-mips.org> [180223 10:14]:
> As dmtimer no longer exports functions, make those previously
> exported static (this requires few functions to be moved around
> as their prototypes were deleted).

Looks like this one fails to build with omap1_defconfig:

drivers/clocksource/timer-ti-dm.c:935:14: error:
'omap_dm_timer_get_fclk' undeclared here 

Other than that the first three patches seem like nice
clean-up :)

Regards,

Tony
