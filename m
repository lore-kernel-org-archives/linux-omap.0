From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ASoC: omap: convert per-board modules
	to platform drivers
Date: Thu, 08 Sep 2011 22:28:50 +0200
Message-ID: <3110288.bQbb0H2ME1@wuerfel>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linaro-dev@lists.linaro.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 08 September 2011 20:05:48 Mans Rullgard wrote:
> >
> > Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
> > generate a platform device of name depending upon machine_is_* ?
> 
> I had the same thought, but I couldn't find a suitable string anywhere.
> Are you suggesting an if(machine_is_foo()) cascade in omap_init_audio()?
> 
> I'll be the first to agree this patch is not particularly pretty.

My general feeling is that practically every time someone writes
machine_is_*(), they are doing it wrong. There are of course exceptions,
but I would strongly recommend to have the initialization calling up
from the board file into more general functions instead of having all
boards calling the same function which then goes to board specific
code again.

	Arnd
