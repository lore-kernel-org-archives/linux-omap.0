From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 11 Aug 2011 09:38:22 -0700
Message-ID: <1313080702.2214.69.camel@groeck-laptop>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, "b-cousson@ti.com" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, "balbi@ti.com" <balbi@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "vishwanath.bs@ti.com" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-08-11 at 09:00 -0400, J, KEERTHY wrote:
> On Thu, Aug 11, 2011 at 4:06 PM, Felipe Balbi <balbi@ti.com> wrote:

[ ... ]

> >> >> +     temp = omap_temp_sensor_readl(temp_sensor,
> >> >> +                     temp_sensor->registers->bgap_counter);
> >> >> +     temp = (temp & temp_sensor->registers->counter_mask) >>
> >> >> +                     __ffs(temp_sensor->registers->counter_mask);
> >> >
> >> >        temp &= ??
> >> >
> >> >> +     temp = temp * 1000 / (temp_sensor->clk_rate);
> >> >
> >> >        temp *= ??
> >>
> >> Need to multiply the temp with 1000 before dividing.
> >> temp *= evaluates the RHS first and then multiplies LHS.
> >
> > temp *= 1000;
> > temp /= clk_rate;
> >
> 
> Different coding style. I preferred to do it in a single line.
> 
Me too.

Guenter
