From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
Date: Wed, 28 Mar 2018 02:34:25 +0200
Message-ID: <20180328003425.GA8707@lenoch>
References: <20180223101254.GA5746@lenoch> <20180223101553.GE5746@lenoch>
 <20180327215332.GC28163@mithrandir>
 <20180327221401.GD28163@mithrandir>
 <20180327222349.GK5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180327222349.GK5700@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pwm@vger.kernel.org, aaro.koskinen@iki.fi, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, t-kristo@ti.com, robh+dt@kernel.org, narmstrong@baylibre.com, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Brecht Neyrinck <brechtneyrinck@gmail.com>, sebastian.reichel@collabora.co.uk, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 27, 2018 at 03:23:49PM -0700, Tony Lindgren wrote:
> * Thierry Reding <thierry.reding@gmail.com> [180327 22:15]:
> > On Tue, Mar 27, 2018 at 11:53:33PM +0200, Thierry Reding wrote:
> > > On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> > > > Prescaler setting is currently not taken into account.
> > > > Fix that by introducing freq member variable and initialize
> > > > it at device probe time. This also avoids frequency
> > > > recomputing at each pwm configure time.
> > > > 
> > > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > > > ---
> > > >  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++-----------------
> > > >  1 file changed, 55 insertions(+), 38 deletions(-)
> > > 
> > > Applied, thanks.
> > 
> > Actually, that was a little premature. It seems like this conflicts with
> > a patch series by Keerthy that Tony merged into his tree and that you've
> > based this on.
> > 
> > I think it'd be easiest if Tony merged this through the TI tree, or we
> > wait until v4.17-rc1 to resolve the dependency. Given how late we are in
> > the release cycle, I think it'd have to be the latter.
> 
> Sorry about the extra hassle caused by the timer move to drivers.
> 
> > Tony, if you think you can find a way to still take this in for
> > v4.17-rc1, feel free to do so:
> > 
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> 
> I pretty much only apply fixes after -rc6. So let's wait for the
> dependencies to clear at this point. This seems like a "fix for
> a feature that never worked" so might be hard to justify it as
> a fix :)

Well, DT bindings already contain prescaler, so technically it is
a fix which also optimizes code a bit ;-) But of course, I can keep
this patch localy and resend for 4.18 merge window.

> Ladis, can you please resend the pending patches again to
> Thierry after v4.17-rc? Then Thierry can queue it as a fix or
> for v4.18.

In fact, there is the only one patch ready to be applied - this one - and
The others (event capture) needs to be yet sorted out. Unfortunately I do
not have time for that at the moment.

Best regards,
	ladis
