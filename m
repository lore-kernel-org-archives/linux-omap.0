From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
 to platform drivers
Date: Thu, 8 Sep 2011 16:59:04 -0700
Message-ID: <20110908235903.GA6370@opensource.wolfsonmicro.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<3110288.bQbb0H2ME1@wuerfel>
	<1315520956.4126.3.camel@finisterre.wolfsonmicro.main>
	<20110908223720.GA21469@n2100.arm.linux.org.uk>
	<20110908224731.GB5201@opensource.wolfsonmicro.com>
	<20110908230102.GB21469@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20110908230102.GB21469@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 09, 2011 at 12:01:02AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 08, 2011 at 03:47:31PM -0700, Mark Brown wrote:

> > What will happen for device tree is that there will be a device in the
> > device tree for the ASoC board.

> Sounds like you just solved the machine_is_xxx() problem in ASoC land too
> there.  If you're _already_ going for separate devices to describe the
> ASoC stuff on the board, then there's no reason that couldn't have already
> been done to eliminate the machine_is_xxx() usage in ASoC - rather than
> complaining about machine_is_xxx() not being a very good solution.

The problem is that someone has to manually go and add the device to
every board that needs one and people find that tedious and slightly
inelegant (especially for device tree where not everyone is entirely
happy that it's a good idea to have the node for the board when we
already have the top level machine information saying what board we're
running on).   Jassi's suggestion was that we should have some magic to
automatically generate defaults for the relevant device registrations to
sidestep these issues.
