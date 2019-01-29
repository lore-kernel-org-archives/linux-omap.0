From: Tony Lindgren <tony@atomide.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 09:27:06 -0800
Message-ID: <20190129172706.GE5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <20190129171844.n6wflw4ehfdy3izs@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [190129 17:18]:
> Hi,
> 
> On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:
> > Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers") started showing new warnings with v5.0-rc cycle:
> > 
> > regulator-dummy: Underflow of regulator enable count
> > 
> > I'm seeing this at least with my pwm-vibra test case:
> > 
> > # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> > pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> > input: pwm-vibrator as /devices/platform/vibrator/input/input4
> > regulator-dummy: Underflow of regulator enable count
> > Upload rumble effect... id=0
> > regulator-dummy: Underflow of regulator enable count
> > 
> > Are these bogus warnings for dummy regulator or do we have
> > real unpaired regulator calls or somewhere?
> 
> There are real unpaired regulator calls in the pwm-vibrator driver,
> that I did not notice when I wrote the driver :(. Good news is, that
> Paweł Chmiel and Jonathan Bakker are already working on fixing my mess:
> 
> https://lore.kernel.org/patchwork/patch/1032759/

OK good to hear.

> On Droid 4 it's a dummy regulator, since I did not know what
> regulator is being used to supply the vibrator. Probably directly
> from the battery.

Yeah no idea.. Hmm maybe it's actually using the VVIB on the pmic?

Regards,

Tony
