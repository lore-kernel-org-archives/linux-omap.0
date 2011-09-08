From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
 to platform drivers
Date: Thu, 08 Sep 2011 15:29:11 -0700
Message-ID: <1315520956.4126.3.camel@finisterre.wolfsonmicro.main>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<3110288.bQbb0H2ME1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3110288.bQbb0H2ME1@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, King <linux@arm.linux.org.uk>, Russell@alsa-project.org, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Takashi@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-09-08 at 22:28 +0200, Arnd Bergmann wrote:
> On Thursday 08 September 2011 20:05:48 Mans Rullgard wrote:

> > I had the same thought, but I couldn't find a suitable string anywhere.
> > Are you suggesting an if(machine_is_foo()) cascade in omap_init_audio()?

> > I'll be the first to agree this patch is not particularly pretty.

> My general feeling is that practically every time someone writes
> machine_is_*(), they are doing it wrong. There are of course exceptions,
> but I would strongly recommend to have the initialization calling up
> from the board file into more general functions instead of having all
> boards calling the same function which then goes to board specific
> code again.

I have to agree, that seems tasteless. I'd expect something like
triggering registration of devices based off walking down a table of
machine IDs or something. One other issue to consider here is that we
don't want to discourage people from sharing machine drivers while we
can so it can't be completely automatic, it 

Perhaps some sort of generic machine type based mechanism for
instantiating drivers a bit like what's done with DMI might be useful,
video will have a similar issue I guess.
