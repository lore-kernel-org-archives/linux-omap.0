From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
Date: Fri, 10 Jun 2016 06:01:15 -0700
Message-ID: <20160610130114.GP22406@atomide.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-6-git-send-email-fcooper@ti.com>
 <20160610103423.GT22406@atomide.com>
 <20160610120142.GK22406@atomide.com>
 <20160610124022.GD27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160610124022.GD27142@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, robh+dt@kernel.org, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@gmail.com> [160610 05:42]:
> On Fri, Jun 10, 2016 at 05:01:43AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [160610 03:37]:
> > > * Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> > > > Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> > > > provide the various required clocks.
> > > > 
> > > > For AM437 and AM335x, add the required clocks explicitly to DT. The
> > > > hwmod entries for ECAP and EPWM will be removed and this will prevent
> > > > anything from breaking.
> > > 
> > > I've applying the first patch into omap-for-v4.8/soc, the rest into
> > > omap-for-v4.8/dt. Note that this patch did not apply against d850.dtsi
> > > so please resend that change as a separate patch to the davinci
> > > maintainer.
> > 
> > And I did not apply patch "pwms: pwm-ti*: Get the clock from the PWMSS
> > parent when using old bindings", Thierry should take that one.
> 
> Tony, did you take patches 3 and 4 already? It's fine if yo have, just
> wanted to know whether I should pick those up as well.

Yes looks like I also took the binding documentation patches too.

Regards,

Tony
